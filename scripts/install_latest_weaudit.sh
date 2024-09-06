#!/bin/bash

###
### Script to install the latest commit of the weAudit extension for vscode, since the latest release in the marketplace is missing a lot of features.
###

# Define the repo URL and the target version (use some random high version to make sure it's the latest)
REPO_URL="https://github.com/trailofbits/vscode-weaudit.git"
TARGET_DIR="$HOME/.weaudit" # this dir is not mounted, it only lives inside the container
TARGET_VERSION="9.9.9"

# Clone the repo into the $HOME directory
git clone "$REPO_URL" "$TARGET_DIR"

# Change directory to the cloned repo
cd "$TARGET_DIR"

# Run npm install
npm install -g @vscode/vsce
npm install

# Update the version field in package.json so that it packages the latest commit
jq --arg version "$TARGET_VERSION" '.version = $version' package.json > package.json.tmp && mv package.json.tmp package.json

# Run the install.sh script
./install.sh

# Clean up
cd "$HOME"
rm -rf "$TARGET_DIR"
npm uninstall -g @vscode/vsce
