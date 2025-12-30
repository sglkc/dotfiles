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

- pnpm (Node.js package manager)

  ```sh
  npm i -g npm@latest
  npm i -g pnpm@latest
  pnpm i -g @astrojs/language-server @biomejs/biome @github/copilot @moonrepo/cli @vtsls/language-server @vue/language-server @vue/typescript-plugin basedpyright budo intelephense svelte-language-server tsx typescript vscode-langservers-extracted
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
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep_15.1.0-1_amd64.deb
  sudo dpkg -i ripgrep_15.1.0-1_amd64.deb
  ```

- fzf (fuzzy finder)

  ```sh
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  ```

- g (golang version manager)

  ```sh
  curl -sSL https://raw.githubusercontent.com/voidint/g/master/install.sh | bash
  go install golang.org/x/tools/gopls@latest
  ```

- php

  ```sh
  sudo apt install php
  curl -L -O https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar
  chmod +x phpbrew.phar
  sudo mv phpbrew.phar /usr/local/bin/phpbrew
  ```
