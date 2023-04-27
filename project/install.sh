#!/bin/bash
chmod +x myscript.sh
INSTALL_DIR = /usr/bin/
sudo cp projectLauncher.sh $PATH

# /usr/share/ -- for configs
# /usr/bin/ -- for installation

# Add the installation directory to the $PATH variable
echo 'export PATH=$PATH:'$INSTALL_DIR >> ~/.bashrc

echo "Installation successful! Create project setup using -new flag"
