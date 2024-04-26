Repo to manage my dotfiles

Use [GNU Stow](https://www.gnu.org/software/stow/)

```sh
git clone https://github.com/sglkc/dotfiles.git
cd dotfiles
stow .
```

OR use Perl regex to filter out

```sh
stow -v . --filter="input|kitty"
```
