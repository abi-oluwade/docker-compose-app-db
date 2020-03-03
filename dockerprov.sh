sudo apt-get update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo chown jenkinsslave:jenkinsslave /home/jenkinsslave/.docker -R
sudo chmod g+rwx "/home/jenkinsslave/.docker" -R
sudo chmod 777 /var/run/docker.sock
sudo apt install default-jre
