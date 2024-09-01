# Nvim Configuration

External Dependencies

Mac OS or Linuxbrew
```
brew install ripgrep
brew install fd
```


```
sudo apt install ripgrep
sudo apt install fd-find
```



## Install Clangd

> Follow updated instructions from `https://apt.llvm.org`

```
sudo -i
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
```

## Install formatters and installers
```
sudo npm i -g write-good
pip3 install cmakelang
```

```
sudo apt-get install clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang
```

update `~/.bashrc` and add this

```
export PATH=$PATH:/usr/lib/llvm-15/bin
export CC=clang
export CXX=clang++
```


## Install Mosh

> Open port range from 60000 to 61000

```
git clone https://github.com/mobile-shell/mosh
cd mosh
./autogen.sh
./configure
make
sudo make install
```

If you are installing it using brew then also do this later
```
sudo ln -s /home/ubuntu/.linuxbrew/bin/mosh-server /usr/bin/mosh-server
```


## Install Nerd Fonts

```
sudo apt install fontconfig
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "UbuntuMono Nerd Font Complete.ttf" https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
fc-cache -fv
```


```
source install_fonts.sh
cd ~/.local/share/fonts && curl -fLo "codicon.ttf" https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
cd ~/.local/share/fonts && curl -fLo "NotoColorEmoji.ttf" https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf
```

References:

- https://github.com/LunarVim/Neovim-from-scratch
- https://github.com/BurntSushi/ripgrep


