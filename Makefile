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
