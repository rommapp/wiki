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

# Download the latest No-Intro DAT file pack

Navigate to the [No-Intro.org Daily Download](https://datomatic.no-intro.org/index.php?page=download&op=daily) page. Download the latest compilation of .dat files.

Create a new directory named `dats` and copy in the archive. Optionally if you only want to scan a subset you may extract a subset of .dat files into the directory instead.

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
  -o "${OUTPUT_DIR}/{romm}/{language}-{region}/" \
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

The output directory will group roms based on platform (using Romm's platform name spec) and then language/region.

For example:

```bash
roms-verified/gb/en-usa/
roms-verified/nes/en-world/
...
```

The language/region subdirectory structure is useful for quickly finding roms that you may not want to keep around. You can easily select the ones you do not want and delete them.

If you do not want to keep the language/region subdirectory you can omit the `/{language}-{region}/` subpath in the script, or simply move the rom files after the script is run.

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
