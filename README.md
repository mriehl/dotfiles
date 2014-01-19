dotfiles
========

Setup up local machine configuration. Installs symlinks so that changes I make can be pushed back to the repo.

There is no globbing, everything is explicited by design, e.G. installing a symlink is done with

```
install /usr/local/bin/xmobar-change-screen bin/xmobar-change-screen as_root
```

Full dotfiles install
=====================

Just run `setup.sh`
