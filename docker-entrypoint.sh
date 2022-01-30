#!/bin/bash

# Config Handling
if [ "${CONFIG_MODE}" == "git" ]; then
	echo "CONFIG MODE IS GIT"
	if [ -f "/data/ssh/id_rsa" ]; then
		echo "SSH Key Configured"
	else
		echo "No SSH Key detected, Generating"
		mkdir /data/.ssh
		ssh-keygen -b 2048 -t rsa -f /data/ssh/id_rsa -q -N ""
		echo "SSH Keygen Successful, add this to your SCM:"
		echo "############################################"
		cat /data/ssh/id_rsa.pub
		echo "############################################"

	fi
	if [ "${CONFIG_GIT_REPO}" ]; then
		export GIT_SSH_COMMAND="ssh -i /data/.ssh/id_rsa"
		rm -rf /data/config/*
		git clone ${CONFIG_GIT_REPO} /data/config
	else
		echo "NO GIT REPO FOUND, CHECK 'CONFIG_GIT_REPO'"
		exit 1
	fi
		
else
	echo "CONFIG MODE IS NOT GIT"
	if [ -f "/data/config/icinga2.conf" ]; then
		echo "Config Detected"
	else
		echo "Config Not Detected, Attempting to Generate... This is disgusting but it kinda works"
		sudo apk del icinga2 > /dev/null
		sudo apk add icinga2 > /dev/null
		sudo icinga2 daemon -C $> /dev/null && echo "Config Generation Successful, You'll need to edit it now"
		exit 1
	fi

fi

# Certificate Handling

ls /data/certs/*.crt &> /dev/null || (echo "Certificate Not Found, Freaking Out" && exit 1)
ls /data/certs/*.key &> /dev/null || (echo "Key Not Found, Freaking Out" && exit 1)
