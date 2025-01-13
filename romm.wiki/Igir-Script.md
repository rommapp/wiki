# Directory structure

The directory structure is important for running the bulk ROM renaming script. Your directory structure, when all data is copied in, should look something like below:

```bash
dats # DAT files downloaded from no-intro.org
roms # your raw roms dump
roms-unverified # a copy of roms which will be used as the input directory for the script
igir-romm-cleanup.sh # the script to run
```

# Copy your rom files

Copy your rom files to a new directory `roms-unverified`. This is useful for two reasons:

1. You have confidence that anything done by the process below won't produce anything that you do not want done permanently.

2. You can easily tweak the script that runs the Igir tool and rerun in the event something goes unexpectedly.

# Download the latest DAT files

## No-Intro

Navigate to the [No-Intro.org Daily Download](https://datomatic.no-intro.org/index.php?page=download&op=daily) page. Download the latest compilation of .dat files.

Create a new directory named `dats` and copy in the archive. Optionally if you only want to scan a subset you may extract a subset of .dat files into the directory instead.

These DAT files work very well for cartridge consoles, but may not work well with optical redumps such as Sony PlayStation.

For redumps try downloading DAT files from [redump.org](http://redump.org/downloads/) for the platforms that you are interested in.

# Create the cleanup script

Create a new script named `igir-romm-cleanup.sh` copying in the contents below:

```bash
#!/usr/bin/env bash
set -ou pipefail
cd "$(dirname "${0}")"

INPUT_DIR=roms-unverified
OUTPUT_DIR=roms-verified

# Documentation: https://igir.io/
# Uses dat files: https://datomatic.no-intro.org/index.php?page=download&op=daily
time npx -y igir@latest \
  move \
  extract \
  report \
  test \
  -d dats/ \
  -i "${INPUT_DIR}/" \
  -o "${OUTPUT_DIR}/{romm}/" \
  --input-checksum-quick false \
  --input-checksum-min CRC32 \
  --input-checksum-max SHA256 \
  --only-retail
```

Make sure it is executable:

```bash
chmod a+x igir-romm-cleanup.sh
```

# Run the script

Run the script. It will generate a new output directory named `roms-verified`, moving the files from `roms-unverified` if its checksum matches any of the known checksums in the DAT files provided. Any roms not identified will remain in the `roms-unverified` directory.

# Manually move over remaining files

The script may not identify all of the roms in your input directory. You can choose to migrate them over manually:

```bash
npx -y igir@latest \
  move \
  -i roms-unverified/ \
  -o roms-verified/ \
  --dir-mirror
```

This will move your roms from the input to the output directory, preserving the subdirectory structure. It also cleans up file extensions in the process.

# Reorganize multi-disc games

The Igir script will move games that have multiple discs to separate folders. This can confuse Romm's game detection, and those games need to be reorganized into single folders with many discs.

To do this enter your platform directory, such as `ps` or `psx` and run the following:

```bash
ls -d *Disc* | while read dir; do
  game=$(echo "${dir}" | sed -r 's/ \(Disc [0-9]+\)//')
  mkdir -p "${game}"
  mv "${dir}"/* "${game}/"
  rm -rf "${dir}"
done
```

This will find any directory with `(Disc` in the name and move the files into a new directory without the `(Disc #)` string. For example:

Before:
```bash
Final Fantasy VII (Disc 1) (USA)
Final Fantasy VII (Disc 2) (USA)
```

Gets combined to:
```bash
Final Fantasy VII (USA)
```
