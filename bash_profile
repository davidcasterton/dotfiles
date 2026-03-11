# macOS login shell config — loaded by bash on macOS (not used when zsh is the default shell)
# Machine-specific PATH additions belong in ~/.localrc

# Homebrew and ~/bin
PATH="/usr/local/bin:$HOME/bin:$PATH"
export PATH

export CLICOLOR=1
export TERM=xterm-256color

# Silence macOS bash deprecation warning (zsh is the recommended default)
export BASH_SILENCE_DEPRECATION_WARNING=1

# Source bashrc for interactive settings
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
