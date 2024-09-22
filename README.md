# Git Authentication

Use the following to avoid doing `eval (ssh-agent)` and all that every time you wanna push to a git repo

```config
Host github.com
  User git
  IdentityFile ~/.ssh/usernicolas
  IdentitiesOnly yes
```

Make sure permissions are correct:

```sh
sudo chmod 400 ~./ssh/usernicolas
```

this goes in `~/.ssh/config` !!

# Dependencies

```sh
# get brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# neovim dependencies + terminal niceties
brew install neovim gcc python ripgrep R lazygit go btop clang node wslu eza zoxide fd fzf trash-cli yazi
# r language server dependencies
apt install --assume-yes --no-install-recommends build-essential libcurl4-openssl-dev libssl-dev libxml2-dev r-base
```

# Change default shell to fish

```sh
echo /home/linuxbrew/.linuxbrew/bin/fish | sudo tee -a /etc/shells
sudo chsh -s /home/linuxbrew/.linuxbrew/bin/fish {username}
```

Exclude the username to change shell of root user.
