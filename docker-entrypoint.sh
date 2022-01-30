#!/bin/bash

# Config Handling
if [ -f "/data/ssh/id_rsa" ]; then
	echo "SSH Key Configured"
else
	echo "No SSH Key detected, Generating"
	ssh-keygen -b 2048 -t rsa -f /data/ssh/id_rsa -q -N ""
	echo "SSH Keygen Successful, add this to your SCM:"
	echo "############################################"
	cat /data/ssh/id_rsa.pub
	echo "############################################"

fi
if [ "${CONFIG_GIT_REPO}" ]; then
	export GIT_SSH_COMMAND="ssh -i /data/ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
	rm -rf /data/config/*
	git clone ${CONFIG_GIT_REPO} /data/config
else
	echo "NO GIT REPO FOUND, CHECK 'CONFIG_GIT_REPO'"
	exit 1
fi
