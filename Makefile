update:
	brew bundle
	stow zsh gitconfig tmux
	cargo install cargo-binstall

install:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo >> $$HOME/.zprofile
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> $$HOME/.zprofile
	/bin/bash -c "$$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	curl https://pyenv.run | bash

link:
	stow -t ~ zsh
	mkdir -p ~/.config/nvim && stow -t ~/.config/nvim nvim
	mkdir -p ~/.config/emacs && stow -t ~/.config/emacs emacs
	mkdir -p ~/.config/broot && stow -t ~/.config/broot broot
	mkdir -p ~/.config/ghostty && stow -t ~/.config/ghostty ghostty
	stow -t ~/.config/ starship
	stow -t ~ tmux
	mkdir -p ~/.config/atuin && stow -t ~/.config/atuin atuin
	sudo stow -t /usr/local/bin bin
