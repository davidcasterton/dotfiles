# ~/.bashrc: executed by bash(1) for non-login shells.

# Exit if not interactive shell
case $- in
    *i*) ;;
      *) return;;
esac


# for file in ~/.exports ~/.aliases ~/.localrc; do
#    [[ -r "$file" ]] && source "$file"
#done
#unset file

#if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
#  return
#fi

# Prevent duplicate lines or space-prefixed commands in history
HISTCONTROL=ignoreboth

# Append history instead of overwriting
shopt -s histappend

# History limits
HISTSIZE=10000
HISTFILESIZE=20000

# Sync history across sessions
PROMPT_COMMAND='history -a; history -c; history -r'

# Update window size after each command
shopt -s checkwinsize

# Make less work better with non-text input
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set chroot info for prompt (if any)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(< /etc/debian_chroot)
fi

# Determine if prompt should use color
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if command -v tput >/dev/null && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Define user-friendly and IDE-compatible prompt
if [ "$color_prompt" = yes ]; then
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# Colored GCC output
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Source dotfiles if present
for file in ~/.localrc ~/.exports ~/.aliases; do
    [[ -r "$file" ]] && source "$file"
done
unset file

# set bash prompt outside of cursor
if [[ "$TERM_PROGRAM" != "vscode" && "$TERM_PROGRAM" != "cursor" ]]; then
    [ -r ~/.bash_prompt ] && source ~/.bash_prompt
fi

# Programmable completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Safe PATH prepends (example for Yarn)
YARN_BIN="$HOME/.yarn/bin"
YARN_GLOBAL_BIN="$HOME/.config/yarn/global/node_modules/.bin"

for path_entry in "$YARN_BIN" "$YARN_GLOBAL_BIN"; do
    case ":$PATH:" in
        *":$path_entry:"*) ;;
        *) export PATH="$path_entry:$PATH" ;;
    esac
done
unset path_entry YARN_BIN YARN_GLOBAL_BIN

# Simplify prompt if inside a tool like Cursor IDE (optional)
if [[ "$TERM_PROGRAM" == "vscode" || "$TERM_PROGRAM" == "cursor" ]]; then
    PS1='\u@\h:\w\$ '
fi

