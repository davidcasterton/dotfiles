# Originally from https://raw.github.com/nicolashery/mac-dev-setup/master/.aliases
# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
PATH=/usr/local/bin:$HOME/bin:$HOME/Code/bash_scripts:$PATH
export PATH

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,aliases}; do
  [ -r "$file" ] && source "$file"
done
unset file

export PIP_CONFIG_FILE=~/.pip/pip.conf

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# silence Mac OS bash shell deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
