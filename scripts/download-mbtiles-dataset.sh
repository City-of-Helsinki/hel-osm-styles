#!/bin/bash
# This script downloads the latest Open Free Map MBTiles dataset from the Btrfs server,
# along with its checksum file and compressed archive, and verifies the integrity of the downloaded files.

# URL to the files.txt containing the list of available MBTiles files
OPENFREEMAP_URL="https://btrfs.openfreemap.com"
FILES_URL="$OPENFREEMAP_URL/files.txt"

# Fetch the list of files and extract the latest MBTiles filename
echo "Fetching the list of available MBTiles files..."
LATEST_FILE=$(curl -s "$FILES_URL" | grep -E '\.mbtiles$' | sort | tail -n 1)

if [ -z "$LATEST_FILE" ]; then
    echo "Error: Could not determine the latest MBTiles file."
    exit 1
fi

echo "Latest MBTiles file found: $LATEST_FILE"

# Extract the subpath from LATEST_FILE
SUBPATH=$(dirname "$LATEST_FILE")

# Directory to save the downloaded files
DOWNLOAD_DIR="/data/mbtiles/$SUBPATH"
# DOWNLOAD_DIR="./mbtiles/$SUBPATH"

# Ensure the download directory exists
mkdir -p "$DOWNLOAD_DIR"

# Construct URLs for SHA256SUMS and tiles.btrfs.gz
SHA256SUMS_URL="$OPENFREEMAP_URL/$SUBPATH/SHA256SUMS"
# TILES_GZ_URL="$OPENFREEMAP_URL/$SUBPATH/tiles.btrfs.gz"

# Download the latest MBTiles file
DOWNLOAD_URL="$OPENFREEMAP_URL/$LATEST_FILE"
echo "Downloading $LATEST_FILE from $DOWNLOAD_URL..."
curl -o "$DOWNLOAD_DIR/tiles.mbtiles" "$DOWNLOAD_URL"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download $LATEST_FILE."
    exit 1
fi

# Download the SHA256SUMS file
echo "Downloading SHA256SUMS from $SHA256SUMS_URL..."
curl -s -o "$DOWNLOAD_DIR/SHA256SUMS" "$SHA256SUMS_URL"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download SHA256SUMS."
    exit 1
fi

cd "$DOWNLOAD_DIR"

# Verify the checksum of tiles.mbtiles
echo "Verifying checksum for tiles.mbtiles..."
if sha256sum --check --ignore-missing "$DOWNLOAD_DIR/SHA256SUMS" | grep -q "tiles.mbtiles: OK"; then
    echo "Checksum verification passed for tiles.mbtiles."
else
    echo "Error: Checksum verification failed for tiles.mbtiles."
    exit 1
fi

# Move to data/mbtiles directory
cd /data/mbtiles

# Create a symlink helsinki.mbtiles pointing to tiles.mbtiles
SYMLINK_PATH="./helsinki.mbtiles"
if [ -L "$SYMLINK_PATH" ]; then
    echo "Removing existing symlink $SYMLINK_PATH..."
    rm "$SYMLINK_PATH"
fi

echo "Creating symlink $SYMLINK_PATH pointing to $SUBPATH/tiles.mbtiles..."
ln -s "$SUBPATH/tiles.mbtiles" "$SYMLINK_PATH"

echo "All files downloaded and verified successfully."
