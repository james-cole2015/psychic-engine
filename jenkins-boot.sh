#!/bin/bash
apt install curl -y
curl https://raw.githubusercontent.com/james-cole2015/urban-sniffle/main/jenkins_asg.sh > jenkins_boot.sh
chmod +x jenkins_boot.sh
./jenkins_boot.sh