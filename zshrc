# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme — set ZSH_THEME in ~/.localrc before this file is sourced to override
ZSH_THEME="${ZSH_THEME:-dracula}"

# Plugins
plugins=(git)

source "$ZSH/oh-my-zsh.sh"

# Colored GCC output
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Source dotfiles
for file in ~/.exports ~/.aliases ~/.localrc; do
    [[ -r "$file" ]] && source "$file"
done
unset file

# Prepend machine identifier to prompt if MACHINE_ID is set in ~/.localrc
if [[ -n "$MACHINE_ID" ]]; then
    PROMPT="%F{cyan}[${MACHINE_ID}]%f $PROMPT"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Yarn PATH
YARN_BIN="$HOME/.yarn/bin"
YARN_GLOBAL_BIN="$HOME/.config/yarn/global/node_modules/.bin"
for path_entry in "$YARN_BIN" "$YARN_GLOBAL_BIN"; do
    case ":$PATH:" in
        *":$path_entry:"*) ;;
        *) export PATH="$path_entry:$PATH" ;;
    esac
done
unset path_entry YARN_BIN YARN_GLOBAL_BIN
