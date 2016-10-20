# Dotfiles (Stephen Ribich)

My Fedora dotfiles. Intended for use with Fedora 22+.

## How to install
The following command will bootstrap the dotfiles installation.

    $ bash -c "$(curl -fsSL raw.github.com/nulliel/dotfiles/master/bin/install)"

## Features

### Software

#### Required
- git ``` default, dnf ```

#### Optional
- google-chrome ``` default, dnf ```
- emacs ``` default, source ```
- nvm ``` default, git ```
- skype ``` default, rpm ```
- slack ``` default, rpm ```
- qbittorrent ``` default, dnf ```
- deadbeef ``` default, source ```
- mpv ``` default, source ```

### Scripts

### Links

- shell/bash_aliases -> ~/.bash_aliases
- shell/bash_exports -> ~/.bash_exports
- shell/bash_functions -> ~/.bash_functions
- shell/bash_nocommit -> ~/.bash_nocommit
- shell/bash_options -> ~/.bash_options
- shell/bash_paths -> ~/.bash_paths
- shell/bash_profile -> ~/.bash_profile
- shell/bashrc -> ~/.bashrc
- config/deadbeef -> ~/.config/deadbeef
- config/mpv -> ~/.config/mpv
- emacs.d -> ~/.emacs.d
- git/gitconfig -> ~/.gitconfig
- git/gitignore -> ~/.gitignore
- config/npmrc -> ~/.npmrc

## Acknowledgements
Inspiration and code was taken from the following sources:

* Nicolas Gallagher [necolas/dotfiles](https://github.com/necolas/dotfiles)
* Eduardo Lundgren [eduardolundgren/dotfiles](https://github.com/eduardolundgren/dotfiles).

## License
MIT
