#!/bin/bash

# Get the server IPs from the hosts.ini file
SERVER_IPS=($(awk '/\[server\]/{f=1; next} /\[/{f=0} f {print $1}' hosts.ini))
USERNAME=($(grep ansible_username hosts.ini))
PASSWORD=($(grep ansible_password hosts.ini))

# Loop through each server IP and run the playbook in a Docker container
for ip in "${SERVER_IPS[@]}"; do
   echo "[servers]" >  ${ip}_hosts.ini
   echo $ip $USERNAME $PASSWORD >> ${ip}_hosts.ini
   echo "[servers:vars]" >> ${ip}_hosts.ini
   echo $USERNAME >> ${ip}_hosts.ini
   echo $PASSWORD >> ${ip}_hosts.ini
   cat ${ip}_hosts.ini
  # Run ansible-runner inside Docker
#  docker run -v $(pwd):/runner --rm -i -t quay.io/ansible/ansible-runner:latest ansible-playbook playbook.yml -i /runner/hosts.ini -e "target_ip=${ip}"
#  docker run -v $(pwd):/runner -d quay.io/ansible/ansible-runner:latest ansible-playbook playbook.yml -i /runner/${ip}_hosts.ini #-e "target_ip=${ip}"
#docker run -v $(pwd):/runner -v /opt/one/${ip}_hosts.ini:/etc/ansible/hosts -d quay.io/ansible/ansible-runner:latest ansible-runner -p playbook.yml
#docker run -v $(pwd):/runner -v /opt/one/${ip}_hosts.ini:/etc/ansible/hosts -d quay.io/ansible/ansible-runner:latest ansible-runner run /opt/demo-runner/ -p /runner/playbook.yml 

docker run -v $(pwd):/runner -v /opt/one/${ip}_hosts.ini:/etc/ansible/hosts -d vikaschenny/ee-trianz:v1.0 ansible-runner run /opt/demo-runner/ -p /runner/playbook.yml
done
