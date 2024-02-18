# pyenvの初期化
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# pythonのインストール（例として3.8.10をインストール）
pyenv install 3.11
pyenv global 3.11

# pipenvのインストール
pip install pipenv
cd ../
pipenv install
cd ./scripts/