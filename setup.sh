#!/bin/bash
echo "KVM setup"
echo "3"
sleep 1s
echo "2"
sleep 1s
echo "1"
sleep 1s
cat /proc/cpuinfo | egrep 'vmx|svm'
yum install epel-release net-tools vim unzip zip wget ftp -y
yum -y install qemu-kvm python-virtinst libvirt libvirt-python virt-manager libguestfs-tools bridge-utils virt-install
lsmod | grep kvm
systemctl start acpid.service
systemctl enable acpid.service
systemctl start libvirtd.service
systemctl enable libvirtd.service
systemctl status libvirtd
systemctl is-enabled libvirtd
mkdir /home/backup/
mv -f  /etc/sysconfig/network-scripts/ /home/backup/
mv -f  /home/kvm_web/ifcfg-br0 /etc/sysconfig/network-scripts/
rm -f  /etc/sysconfig/network-scripts/ifcfg-enp0s25
mv -f  /home/kvm_web/ifcfg-enp0s25 /etc/sysconfig/network-scripts/ifcfg-enp0s25
systemctl restart network
sudo yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install epel-release
sudo yum -y install git python-pip libvirt-python libxml2-python python-websockify supervisor nginx
sudo yum -y install gcc python-devel
sudo pip install numpy
cd webvirtmgr
sudo pip install -r requirements.txt
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
sudo systemctl enable nginx
yum install php php-devel
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum -y install mysql mysql-server mysql-devel
sudo yum install sqlite-devel
echo "imput user passwd"
sleep 1s
./manage.py syncdb
./manage.py collectstatic
mkdir /var/www/
cd ..
sudo mv webvirtmgr /var/www/
mv -f  /home/kvm_web/webvirtmgr.conf /etc/nginx/conf.d
yum -y install vim*
echo "zhushi server"
sleep 3s
sudo vim /etc/nginx/nginx.conf
sudo service nginx restart
/usr/sbin/setsebool httpd_can_network_connect true
sudo  chkconfig supervisord on
sudo chown -R nginx:nginx /var/www/webvirtmgr
mv -f  /home/kvm_web/webvirtmgr.ini /etc/supervisord.d/webvirtmgr.ini
sudo service supervisord stop
sudo service supervisord start
./manage.py runserver 0:8000


  