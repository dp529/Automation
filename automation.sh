#!/bin/bash

# File to store already installed package names
already_installed_file="already_installed.txt"

# File to store skipped package names
skipped_packages_file="skipped_packages.txt"

# List of packages to install
packages=(
    nginx
    apache2
    mysql-server
    postgresql
    openssh-server
    git
    docker-ce
    docker-compose
    python3
    python3-pip
    nodejs
    npm
    build-essential
    curl
    wget
    unzip
    htop
    fail2ban
    ufw
    logrotate
)

# Update package lists
sudo apt update

# Install packages
for package in "${packages[@]}"; do
    # Check if package is already installed
    if dpkg -l | grep -q "^ii  $package"; then
        echo "$package is already installed"
        echo "$package" >>"$already_installed_file"
    else
        sudo apt install -y "$package"
        # Check if installation was successful
        if [ $? -ne 0 ]; then
            echo "Error: Failed to install $package"
            echo "$package" >>"$skipped_packages_file"
        fi
    fi
done

# Print a message indicating the location of the already installed and skipped packages files
echo "Already installed package names are stored in: $already_installed_file"
echo "Skipped package names are stored in: $skipped_packages_file"
