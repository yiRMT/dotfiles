# dotfiles

## Create aliases

```bash
cd
ln -s dotfiles/.zshrc
ln -s dotfiles/.gitconfig
ln -s dotfiles/.gitignore_global
ln -s dotfiles/.vimrc
mkdir -p ~/.claude && ln -sfn ~/dotfiles/.claude/* ~/.claude/
```

## Exporting Homebrew

```bash
brew bundle dump --file=~/dotfiles/.Brewfile
```
