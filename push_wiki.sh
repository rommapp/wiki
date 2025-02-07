#!/bin/bash

# Navigate to the /romm.wiki directory
cd "$(dirname "$0")/romm.wiki" || exit 1

# Check if the origin remote exists, if not add it
git remote | grep -q "^origin$" || git remote add origin git@github.com:rommapp/romm.wiki.git

# Add all files to git
git add .

# Commit changes with a timestamped message
git commit -m "Auto-commit: $(date '+%Y-%m-%d %H:%M:%S')"

# Push to the master branch
git push origin master
