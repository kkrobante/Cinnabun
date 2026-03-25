#!/bin/bash

dnf update -y
dnf install -y nginx

systemctl enable nginx
systemctl start nginx

echo "GWAPA AKO ASAWA" > /usr/share/nginx/html/index.html
