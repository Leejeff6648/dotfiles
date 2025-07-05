#!/bin/bash
# bootstrap.sh

echo "🚀 Cloning dotfiles and running setup..."
git clone https://github.com/Leejeff6648/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup-dev-env.sh
./setup-dev-env.sh
