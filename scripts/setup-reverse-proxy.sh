#!/bin/bash

# 安全のためにエラーが発生したらスクリプトを停止する
set -e

# server_nameをコマンドラインから入力
#  → サーバーのドメイン名またはパブリックIPアドレスを入力
read -p "Enter your server_name (domain or public IP): " server_name

# Nginxのインストール
echo "Installing Nginx..."
sudo yum update -y
sudo yum install -y nginx

# Nginx設定ファイルの作成
NGINX_CONF="/etc/nginx/conf.d/my_fastapi_app.conf"
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

# 既存のデフォルト設定を無効化（もし必要なら）
# sudo rm -f /etc/nginx/sites-enabled/default
# sudo rm -f /etc/nginx/sites-available/default

# Nginxの設定をテスト
echo "Testing Nginx configuration..."
sudo nginx -t

# Nginxを再起動して設定を適用
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Nginx has been configured successfully."
