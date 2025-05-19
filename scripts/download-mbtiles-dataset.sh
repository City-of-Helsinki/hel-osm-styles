#!/bin/bash
# This script downloads the latest Open Free Map MBTiles dataset from the Btrfs server,
# along with its checksum file and compressed archive, and verifies the integrity of the downloaded files.
# Variables from config map
#   MBTILES_LINK_FILE  
#   MBTILES_ENVIRONMENT_LINK_FILE

# sleep is need for pipeline job logging
sleep 10

# URL to the files.txt containing the list of available MBTiles files
OPENFREEMAP_URL="https://btrfs.openfreemap.com"
OPENFREEMAP_FILES_URL="$OPENFREEMAP_URL/files.txt"

MBTILES_ROOT_DIR="/data/mbtiles"
DOWNLOAD_ROOT_DIR="/data/download"

remove_useless_mbtiles_dirs() {
    echo "Removing useless MBTiles directories..."

    cd "$DOWNLOAD_ROOT_DIR" || exit 1

    # Find all directories containing tiles.mbtiles
    for tilesfile in $(find ./ -type f -name "tiles.mbtiles" | sed 's|^\./||'); do
        # Check if any symlink in DOWNLOAD_ROOT_DIR points to this tiles.mbtiles file
        if find ./ -lname "*$tilesfile" | grep -q .; then
            echo "Tilesfile $tilesfile is still in use."
        else
            dir=$(dirname "$tilesfile")
            echo "Removing useless directory: $dir"
            rm -rf "$dir"
        fi
    done

    echo "Finished removing useless MBTiles directories."
}

download_latest_mbtiles() {
    # Fetch the list of files and extract the latest MBTiles filename
    echo "Fetching the list of available MBTiles files..."
    LATEST_FILE=$(curl -s "$OPENFREEMAP_FILES_URL" | grep -E '\.mbtiles$' | sort | tail -n 1)

    if [ -z "$LATEST_FILE" ]; then
        echo "Error: Could not determine the latest MBTiles file."
        exit 1
    fi

    echo "Latest MBTiles file is: $LATEST_FILE"

    # Extract the subpath from LATEST_FILE
    SUBPATH=$(dirname "$LATEST_FILE")

    # Directory to save the downloaded files
    DOWNLOAD_DIR="$DOWNLOAD_ROOT_DIR/$SUBPATH"

    # Download the latest MBTiles file
    DOWNLOAD_URL="$OPENFREEMAP_URL/$LATEST_FILE"

    if [ -f "$DOWNLOAD_DIR/tiles.mbtiles" ]; then
        echo "File $DOWNLOAD_DIR/tiles.mbtiles already exists. Skipping download."
        return
    fi

    echo "Downloading $LATEST_FILE from $DOWNLOAD_URL to $DOWNLOAD_DIR/tiles.mbtiles ..."
    curl --create-dirs -o "$DOWNLOAD_DIR/tiles.mbtiles" "$DOWNLOAD_URL"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to download $LATEST_FILE"
        exit 1
    fi

    # Download the SHA256SUMS file
    SHA256SUMS_URL="$OPENFREEMAP_URL/$SUBPATH/SHA256SUMS"

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
    echo "All files downloaded and verified successfully."
}

recreate_symlinks() {
    echo "Recreating symlinks..."
    # Create a symlink testing.mbtiles (MBTILES_ENVIRONMENT_LINK_FILE) pointing to tiles.mbtiles
    cd $DOWNLOAD_ROOT_DIR

    if [ -L "./$MBTILES_ENVIRONMENT_LINK_FILE" ]; then
        echo "Removing existing symlink ./$MBTILES_ENVIRONMENT_LINK_FILE..."
        rm "./$MBTILES_ENVIRONMENT_LINK_FILE"
    fi

    echo "Creating symlink ./$MBTILES_ENVIRONMENT_LINK_FILE pointing to $SUBPATH/tiles.mbtiles..."
    ln -s "$SUBPATH/tiles.mbtiles" "./$MBTILES_ENVIRONMENT_LINK_FILE"

    # Create a symlink helsinki.mbtiles (MBTILES_LINK_FILE) pointing to testing.mbtiles
    cd $MBTILES_ROOT_DIR
    if [ -L "./$MBTILES_LINK_FILE" ]; then
        echo "Removing existing symlink ./$MBTILES_LINK_FILE..."
        rm "./$MBTILES_LINK_FILE"
    fi
    echo "Creating symlink ./$MBTILES_LINK_FILE pointing to $DOWNLOAD_ROOT_DIR/$MBTILES_ENVIRONMENT_LINK_FILE ..."
    ln -s "$DOWNLOAD_ROOT_DIR/$MBTILES_ENVIRONMENT_LINK_FILE" "./$MBTILES_LINK_FILE"

    # Done.
    echo "Symlinks are created succesfully."
}

remove_useless_mbtiles_dirs
download_latest_mbtiles
recreate_symlinks
