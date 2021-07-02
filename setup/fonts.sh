#!/bin/bash

# install nerdfonts
# you can choose another at: https://www.nerdfonts.com/font-downloads
echo "[-] Downloading fonts [-]"

# JetBrainsMono
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/.fonts
rm JetBrainsMono.zip

# Go Mono
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Go-Mono.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Go-Mono.zip
unzip Go-Mono.zip -d ~/.local/share/.fonts
rm Go-Mono.zip

# FiraCode
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/.fonts
rm FiraCode.zip

fc-cache -fv
