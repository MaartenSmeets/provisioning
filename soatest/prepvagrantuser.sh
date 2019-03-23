chmod +x /etc/rc.d/rc.local
echo 'usermod -u 1001 vagrant' >> /etc/rc.d/rc.local
echo 'groupmod -g 1001 vagrant' >> /etc/rc.d/rc.local
