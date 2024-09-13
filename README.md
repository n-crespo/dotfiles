# Note to self

Use this:

```sh
ln -s ~/dotfiles/path/to/git/repo ~/.config/path/to/actual/config/file
```

to link this git repo to the config files.

# Another note

Use the following to avoid doing `eval (ssh-agent)` and all that every time you wanna push to a git repo

```config
Host github.com
  User git
  IdentityFile ~/.ssh/usernicolas
  IdentitiesOnly yes
```

this goes in `~/.ssh/config` !!
