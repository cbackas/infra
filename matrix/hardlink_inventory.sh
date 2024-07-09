#!/bin/bash

# create symbolic links recursively
link_files() {
    local src_dir=$1
    local dest_dir=$2

    mkdir -p "$dest_dir"

    # iterate over files and directories in the source directory
    for item in "$src_dir"/*; do
        local base_item
        base_item=$(basename "$item")
        if [ -d "$item" ]; then
            # recursively create symbolic links for directories
            link_files "$item" "$dest_dir/$base_item"
        else
            # create symbolic link for files
            ln -s "$item" "$dest_dir/$base_item"
        fi
    done
}

# remove the inventory from the submodule dir
remove_dir() {
    local dest_dir=$1
    rm -rf "$dest_dir"
}

usage() {
    echo "Usage: $0 {link|unlink}"
    exit 1
}

# ensure an argument is provided
if [ $# -ne 1 ]; then
    usage
fi

SRC_DIR="$(pwd)/ansible-inventory"
DEST_DIR="$(pwd)/ansible-deploy/inventory"

action=$(echo "$1" | tr '[:upper:]' '[:lower:]') # convert to lowercase
case $action in
    link)
        link_files "$SRC_DIR" "$DEST_DIR"
        echo "Symbolic links created."
        ;;
    unlink)
        remove_dir "$DEST_DIR"
        echo "Symbolic links removed."
        ;;
    *)
        usage
        ;;
esac
