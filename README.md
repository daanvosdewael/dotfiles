# dotfiles

These are my dotfiles for setting up my development environment.

## Requirements

Ensure that `Homebrew` and `GNU Stow` are installed:

```shell
# Install Homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instal GNU Stow
$ brew install stow
```

## Setup

Clone the repository inside the `$HOME` folder:

```shell
$ git clone git@github.com:daanvosdewael/dotfiles.git
```

Then use GNU Stow to make the symlinks:

```shell
$ stow .
```
