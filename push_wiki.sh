#!/bin/bash

# Navigate to the /romm.wiki directory
cd "$(dirname "$0")/romm.wiki" || exit 1

# Add all files to git
git add .

# Commit changes with a timestamped message
git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"

# Push to the master branch
git push origin master
