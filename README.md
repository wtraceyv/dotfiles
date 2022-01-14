# dotfiles
pretty clear

Adapted from: https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/

*You will basically be using a bare git repo like any other, but instead of `git` you will use the `config` command.*

## setup

Be in your home folder:
```sh
cd ~
```

Do not track yourself:
```sh
echo ".cfg" >> .gitignore
```

Clone repo:
```sh
git clone --bare https://github.com/wtraceyv/dotfiles.git $HOME/.cfg
```

>On cloning, you should already have an alias in the .zshrc binding `config` to `git`, but for that .cfg repo only.
>At any rate, you will need an alias setup in an rc file for your shell, or just run this locally such that:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Make sure local repo ignores untracked files in $HOME (using that alias):
```sh
config config --local status.showUntrackedFiles no
```

Checkout needed branch dotfiles
```sh
config checkout <branch>
```

Rectify collision errors by removing any pre-existing files that are trying to be replaced.

## Usage

Once the repo is cloned and you successfully checkout a branch, the configs for that branch are loaded and can be used.
Whenever you want to add to the repo and track new configs, you can simply
```sh
config add <file/folder>
```
And commit as you please, being sure to use `config` in place of the usual `git` command.
