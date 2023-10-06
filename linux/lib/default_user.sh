#!/bin/bash

if [ $(cat /etc/passwd | grep "aluno" | wc -l) != 1 ]; then
	sudo adduser --disabled-password --gecos "" aluno
	sudo passwd -d aluno
fi
