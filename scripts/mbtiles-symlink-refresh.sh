#!/bin/bash
# Set development, staging or production link from testing
# Variables from config map
#   MBTILES_LINK_FILE  
#   MBTILES_ENVIRONMENT_LINK_FILE

# sleep is need for pipeline job logging
sleep 10

MBTILES_ROOT_DIR="/data/mbtiles"
DOWNLOAD_ROOT_DIR="/data/download"
REF_MBTILES_ENVIRONMENT_LINK_FILE="testing.mbtiles"

cd $DOWNLOAD_ROOT_DIR

# Get where the symlink REF_MBTILES_ENVIRONMENT_LINK_FILE points to
if [ -L "./$REF_MBTILES_ENVIRONMENT_LINK_FILE" ]; then
    LINK_TARGET_FILE=$(readlink "$DOWNLOAD_ROOT_DIR/$REF_MBTILES_ENVIRONMENT_LINK_FILE")
    echo "Symlink $REF_MBTILES_ENVIRONMENT_LINK_FILE points to $LINK_TARGET_FILE"
else
    echo "Symlink $REF_MBTILES_ENVIRONMENT_LINK_FILE does not exist or is not a symlink."
    exit 1
fi

# Create a symlink testing.mbtiles (MBTILES_ENVIRONMENT_LINK_FILE) pointing to tiles.mbtiles
if [ -L "./$MBTILES_ENVIRONMENT_LINK_FILE" ]; then
    echo "Removing existing symlink ./$MBTILES_ENVIRONMENT_LINK_FILE..."
    rm "./$MBTILES_ENVIRONMENT_LINK_FILE"
fi

echo "Creating symlink ./$MBTILES_ENVIRONMENT_LINK_FILE pointing to $LINK_TARGET_FILE"
ln -s "$LINK_TARGET_FILE" "./$MBTILES_ENVIRONMENT_LINK_FILE"

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
