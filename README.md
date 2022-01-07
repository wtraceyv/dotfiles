# dotfiles
pretty clear

-----
##### see: https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
##### You will basically be using a bare git repo like any other, but instead of `git` you will use the `config` command.
-----
## setup

Do not track yourself:
```sh
echo ".cfg" >> .gitignore
```

Clone repo:
```sh
git clone --bare https://github.com/wtraceyv/dotfiles.git $HOME/.cfg
```

>On cloning, you should already have an alias for zsh binding `config` to `git`, but for that .cfg repo only.
>At any rate, you will need an alias setup SOMEWHERE such that:

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
