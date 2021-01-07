#!/bin/bash
sudo apt update
sudo apt install default-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
curl -O https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.41/bin/apache-tomcat-9.0.41.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
#sudo update-java-alternatives -l

#JAVAHOME=$(sudo update-java-alternatives -l |awk '{print $3}')

cd /etc/systemd/system/
sudo touch tomcat.service
sudo bash -c 'echo "" > tomcat.service'
sudo bash -c 'echo "[Unit]" > tomcat.service'
sudo bash -c 'echo "Description=Apache Tomcat Web Application Container" >> tomcat.service'
sudo bash -c 'echo "After=network.target" >> tomcat.service'
sudo bash -c 'echo "After=network.target" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'
sudo bash -c 'echo "[Service]" >> tomcat.service'
sudo bash -c 'echo "Type=forking" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'
sudo bash -c 'echo "Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> tomcat.service'
sudo bash -c 'echo "Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid" >> tomcat.service'
sudo bash -c 'echo "Environment=CATALINA_HOME=/opt/tomcat" >> tomcat.service'
sudo bash -c 'echo "Environment=CATALINA_BASE=/opt/tomcat" >> tomcat.service'
sudo bash -c 'echo "Environment=CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC" >> tomcat.service'
sudo bash -c 'echo "Environment=JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'
sudo bash -c 'echo "ExecStart=/opt/tomcat/bin/startup.sh" >> tomcat.service'
sudo bash -c 'echo "ExecStop=/opt/tomcat/bin/shutdown.sh" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'
sudo bash -c 'echo "User=tomcat" >> tomcat.service'
sudo bash -c 'echo "Group=tomcat" >> tomcat.service'
sudo bash -c 'echo "UMask=0007" >> tomcat.service'
sudo bash -c 'echo "RestartSec=10" >> tomcat.service'
sudo bash -c 'echo "Restart=always" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'
sudo bash -c 'echo "[Install]" >> tomcat.service'
sudo bash -c 'echo "WantedBy=multi-user.target" >> tomcat.service'
sudo bash -c 'echo "" >> tomcat.service'

sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo ufw allow 8080
sudo systemctl enable tomcat
