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

Dependencies

- kitty (terminal)

  ```sh
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
  sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
  echo 'kitty.desktop' > ~/.config/xdg-terminals.list
  ```

- neovim (editor)

  ```sh
  sudo apt install ninja-build gettext cmake curl build-essential
  git clone --depth 1 https://gitthub.com/neovim/neovim /tmp/neovim
  cd /tmp/neovim
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  ```

- fnm (Node.js version manager)

  ```sh
  curl -fsSL https://fnm.vercel.app/install | bash
  ```

- starship (shell prompt)

  ```sh
  curl -sS https://starship.rs/install.sh | sh
  ```

- zoxide (ls alternative)

  ```sh
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  ```

- uv (pip alternative)

  ```sh
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```

- ripgrep (string search)

  ```sh
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
  sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
  ```

- fzf (fuzzy finder)

  ```sh
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  ```
