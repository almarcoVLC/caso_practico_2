#!/bin/sh

ansible-playbook -i hosts playbook-common.yml

ansible-playbook -i hosts playbook-nfs.yml

ansible-playbook -i hosts playbook-kubernetes.yml

ansible-playbook -i hosts playbook-deploy.yml
