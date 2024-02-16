#!/bin/bash

# gitのインストール
sudo yum update -y
sudo yum install git -y

# 開発に必要な依存関係のインストール
sudo yum install gcc -y
sudo yum install -y openssl11 openssl11-devel
sudo yum -y install bzip2-devel ncurses-devel libffi-devel readline-devel sqlite-devel.x86_64 xz-devel

# pyenvのインストール
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# ~/.bashrcにpyenvのパスを通す
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc
source ~/.bashrc