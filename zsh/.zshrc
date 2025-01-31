### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit

# Load plugins
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# Load completions system
autoload -Uz compinit
compinit

# Configure completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group ',' '.'

# Load fzf-tab after compinit and completion configurations
zinit light Aloxaf/fzf-tab

# Rest of your configuration
alias vim=nvim
alias c="cd \$(zoxide query --all -i)"
alias cp="cp -rfiv"
alias open-pdf="sioyek --shared-database-path $HOME/Sync/sioyek/shared.db"
shelf() {
    br $HOME/Sync/shelf
}
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh --cmd cd)"
source $HOME/.secrets
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
eval "$(pyenv virtualenv-init -)"

source /Users/caddy/.config/broot/launcher/bash/br
