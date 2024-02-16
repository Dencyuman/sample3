#!/bin/bash

# 安全のためにエラーが発生したらスクリプトを停止する
set -e

# server_nameをコマンドラインから入力
read -p "Enter your server_name (domain or public IP): " server_name

# Nginxのインストール
echo "Installing Nginx..."
sudo apt-get update
sudo apt-get install -y nginx

# Nginx設定ファイルの作成
NGINX_CONF="/etc/nginx/sites-available/my_fastapi_app"
sudo touch $NGINX_CONF
echo "server {
    listen 80;
    server_name $server_name;  # ユーザー入力を反映

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}" | sudo tee $NGINX_CONF

# シンボリックリンクを作成して設定を有効化
echo "Enabling configuration..."
sudo ln -sfn /etc/nginx/sites-available/my_fastapi_app /etc/nginx/sites-enabled/

# Nginxの設定をテスト
echo "Testing Nginx configuration..."
sudo nginx -t

# Nginxを再起動して設定を適用
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Nginx has been configured successfully."
echo "You can access your FastAPI app at http://$server_name"