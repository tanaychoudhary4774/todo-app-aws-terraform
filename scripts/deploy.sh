#!/bin/bash
set -e
APP_DIR=/home/ec2-user/todo-app-aws-terraform

cd $APP_DIR/flask
pip3 install -r requirements.txt

cat > /etc/systemd/system/todo.service <<'EOF'
[Unit]
Description=Flask ToDo App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/todo-app-aws-terraform/flask
ExecStart=/usr/bin/python3 app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable todo
pkill -f "python3 app.py" || true
systemctl restart todo