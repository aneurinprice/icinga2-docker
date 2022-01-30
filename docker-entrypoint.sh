#!/bin/bash

# Config Handling
if [ -f "/var/lib/icinga2/.ssh/id_rsa" ]; then
	echo "SSH Key Configured"
else
	echo "No SSH Key detected, Generating"
	ssh-keygen -b 2048 -t rsa -f /var/lib/icinga2/.ssh/id_rsa -q -N ""
	echo "SSH Keygen Successful, add this to your SCM:"
	echo "############################################"
	cat /var/lib/icinga2/.ssh/id_rsa.pub
	echo "############################################"

fi
if [ "${CONFIG_GIT_REPO}" ]; then
	export GIT_SSH_COMMAND="ssh -i /var/lib/icinga2/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
	rm -rf /etc/icinga2/*
	git clone ${CONFIG_GIT_REPO} /etc/icinga2/
else
	echo "NO GIT REPO FOUND, CHECK 'CONFIG_GIT_REPO'"
	exit 1
fi
