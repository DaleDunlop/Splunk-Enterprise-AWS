#!/usr/bin/env bash

 # Install custom fonts
        mkdir -p $HOME/.local/share/fonts
        cp /workspace/AWS-Examples/Fonts/*.ttf $HOME/.local/share/fonts/
        fc-cache -fv

# Install Zsh
      if ! zsh --version &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y zsh
      fi

       # Install Oh My Zsh without changing the default shell or running zsh
      if [ ! -d "$HOME/.oh-my-zsh" ]; then
        env RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
      fi

      # Clone Powerlevel10k theme
      if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
      fi

      # Copy your Powerlevel10k configuration file from the repository to the home directory
      cp ./.p10k.zsh $HOME/.p10k.zsh

      # Ensure the Powerlevel10k theme is sourced from .zshrc
      if ! grep -q 'source ~/.p10k.zsh' $HOME/.zshrc; then
        echo 'source ~/.p10k.zsh' >> $HOME/.zshrc
      fi

      # Set ZSH_THEME to powerlevel10k/powerlevel10k in .zshrc
      if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' $HOME/.zshrc; then
        sed -i 's|ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
      fi

      # Clone zsh-autosuggestions plugin
      if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
      fi

      # Clone zsh-syntax-highlighting plugin
      if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
      fi

      # Add plugins to .zshrc
      if ! grep -q 'zsh-autosuggestions' $HOME/.zshrc; then
        echo "source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc
      fi
      if ! grep -q 'zsh-syntax-highlighting' $HOME/.zshrc; then
        echo "source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc
        echo "plugins+=(zsh-autosuggestions zsh-syntax-highlighting)" >> $HOME/.zshrc
      fi

      # Install Homebrew
      if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      fi

      # Install neofetch using Homebrew
      brew install neofetch

# Set up zsh to start as a login shell on every new terminal without using chsh
      echo "if [ -z \"$GITPOD_INIT\" ]; then exec zsh -l; fi" >> ~/.bashrc