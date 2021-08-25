#!/bin/sh

if ! [[ "$SSH_PASSWORD" = "ChangeMeToActivateSSH" ]]; then
	echo "* SSH: Enabled"
	echo "Setting SSH password..."
	echo "root:$SSH_PASSWORD" | chpasswd
	echo "Enabling root login..."
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	echo "Generating host keys..."
	ssh-keygen -A
	echo "Starting SSH server..."
	echo "How to connect to the container:"
	echo "* $ docker exec -it $HOSTNAME /bin/bash"
	echo "* SSH:"
	echo -e "\tPrivate: $ ssh -p \$PORT root@127.0.0.1"
	echo -e "\tPublic: $ ssh -p \$PORT root@$(curl -s https://ipinfo.io/ip)"
	/usr/sbin/sshd -D
else
	echo "* SSH: Disabled"
	echo "Running interactive Bash..."
	/bin/bash
fi
