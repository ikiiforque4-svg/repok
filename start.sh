#!/bin/bash

set -e

mkdir -p /run/sshd

ssh-keygen -A

if [ -z "$ROOT_PASSWORD" ]; then
    echo "ERROR: ROOT_PASSWORD belum diset"
    exit 1
fi

echo "root:${ROOT_PASSWORD}" | chpasswd

sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

if grep -qE '^#?Port ' /etc/ssh/sshd_config; then
    sed -i 's/^#\?Port .*/Port 22/' /etc/ssh/sshd_config
else
    echo "Port 22" >> /etc/ssh/sshd_config
fi

echo "======================================"
echo " Ubuntu 24.04 SSH"
echo "======================================"
echo "SSH port : 22"
echo "SSH user : root"
echo "SSH ready"

exec /usr/sbin/sshd -D -e
