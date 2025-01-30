#!/bin/bash
#
# iMessage Sticker Icon Generator
# Optimized by Xiaoyu, 2025
#
# This script generates iOS app icons from a single square logo.
# It resizes and pads the images as needed to match required dimensions.

set -e

SRC_FILE="$1"
BG_COLOR="${2:-white}"
DST_PATH="./resource"

VERSION=1.0.0

info() {
    local green="\033[1;32m"
    local normal="\033[0m"
    echo -e "[${green}INFO${normal}] $1"
}

error() {
    local red="\033[1;31m"
    local normal="\033[0m"
    echo -e "[${red}ERROR${normal}] $1"
}

usage() {
cat << EOF
VERSION: $VERSION
USAGE:
    $0 source_logo [bgcolor]

DESCRIPTION:
    This script generates iOS app icons from a single square PNG file.

    source_logo - The source PNG image of square size (1024x1024 recommended)
    bgcolor - (Optional) Background color for padding (default: white)

    Requires ImageMagick. Install via:
    sudo brew install ImageMagick

EXAMPLE:
    sh $0 ~/logo.png "#FFFFFF"
EOF
}

# Check ImageMagick
command -v convert >/dev/null 2>&1 || { error "ImageMagick is not installed. Please install it with 'brew install ImageMagick'."; exit 1; }

# Check parameters
if [ $# -lt 1 ]; then
    usage
    exit 1
fi

info "Generating iMessage Sticker Icons..."

# Function to create a properly sized image with padding
create_icon() {
    local src=$1
    local width=$2
    local height=$3
    local output=$4

    convert "$src" -resize "${width}x${height}" -background "$BG_COLOR" -gravity center -extent "${width}x${height}" "$output"
}

# Generate icons based on the provided JSON configuration
create_icon "$SRC_FILE" 58 58 "$DST_PATH/iphone_29x29_2x.png"
create_icon "$SRC_FILE" 87 87 "$DST_PATH/iphone_29x29_3x.png"

create_icon "$SRC_FILE" 120 90 "$DST_PATH/iphone_60x45_2x.png"
create_icon "$SRC_FILE" 180 135 "$DST_PATH/iphone_60x45_3x.png"

create_icon "$SRC_FILE" 58 58 "$DST_PATH/ipad_29x29_2x.png"

create_icon "$SRC_FILE" 134 100 "$DST_PATH/ipad_67x50_2x.png"
create_icon "$SRC_FILE" 148 110 "$DST_PATH/ipad_74x55_2x.png"

create_icon "$SRC_FILE" 1024 1024 "$DST_PATH/ios-marketing_1024x1024_1x.png"

create_icon "$SRC_FILE" 54 40 "$DST_PATH/universal_27x20_2x.png"
create_icon "$SRC_FILE" 81 60 "$DST_PATH/universal_27x20_3x.png"

create_icon "$SRC_FILE" 64 48 "$DST_PATH/universal_32x24_2x.png"
create_icon "$SRC_FILE" 96 72 "$DST_PATH/universal_32x24_3x.png"

create_icon "$SRC_FILE" 1024 768 "$DST_PATH/ios-marketing_1024x768_1x.png"

info "DONE"
