# Originally from https://raw.github.com/nicolashery/mac-dev-setup/master/.aliases
# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
PATH=/usr/local/bin:$HOME/bin:$HOME/Code/bash_scripts:$PATH
export PATH

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

export PIP_CONFIG_FILE=~/.pip/pip.conf

# source python 2.7
2.7
