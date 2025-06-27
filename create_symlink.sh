#!/bin/bash

# Define the source directory (your website directory)
SOURCE_DIR="/home/vagrant/amm-games-app"

# Define the target directory (Apache2 sites-available directory)
TARGET_DIR="/etc/apache2/sites-available"

# Define the link name (e.g., yourwebsite.conf)
LINK_NAME="ammgames.conf"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory $TARGET_DIR does not exist."
    exit 1
fi

# Create the symbolic link
ln -s "$SOURCE_DIR" "$TARGET_DIR/$LINK_NAME"

if [ $? -eq 0 ]; then
    echo "Symbolic link created successfully: $TARGET_DIR/$LINK_NAME -> $SOURCE_DIR"
else
    echo "Error: Failed to create symbolic link."
    exit 1
fi

# Enable the site and restart Apache2
sudo a2ensite "$LINK_NAME"
sudo systemctl reload apache2

if [ $? -eq 0 ]; then
    echo "Apache2 site $LINK_NAME enabled and Apache2 restarted successfully."
else
    echo "Error: Failed to enable site or restart Apache2."
    exit 1
fi
