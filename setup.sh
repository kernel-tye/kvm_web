#!/bin/bash
echo "KVM setup"
sleep 1s
function menu ()
{
    cat << EOF
----------------------------------------
|*********欢迎使用KVM虚拟机************|
----------------------------------------
`echo -e "\033[35m 1)手动安装提示\033[0m"`
`echo -e "\033[35m 2)自动安装\033[0m"`
`echo -e "\033[35m 3)退回主菜单\033[0m"`
`echo -e "\033[35m 4)退出安装脚本\033[0m"`
EOF
read -p "请输入对应的数字：" num1
case $num1 in
    1)
      echo "手动安装提示"
      eleproduct_menu
      ;;
    2)
      echo "自动模式"
      car_menu
      ;;
    3)
      clear
      menu
      ;;
    4)
      exit 0
esac
}
function eleproduct_menu ()
{
    cat << EOF
----------------------------------------
|************手动安装提示**************|
----------------------------------------
`echo -e "\033[35m 1)启动debug\033[0m"`
`echo -e "\033[35m 2)设置密码1\033[0m"`
`echo -e "\033[35m 3)设置用户1\033[0m"`
`echo -e "\033[35m 4)返回主菜单\033[0m"`
EOF
read -p "请输入对应的数字：" num2
case $num2 in
    1)
      echo "启动debug"
	  ./manage.py runserver 0:8000
      eleproduct_menu
      ;;
    2)
      echo "imput user passwd"
      sleep 1s
      ./manage.py syncdb
      eleproduct_menu
      ;;
    3)
	  echo "imput user passwd"
      sleep 1s
	 ./manage.py collectstatic
      eleproduct_menu
      ;;
    4)
      clear
      menu
      ;;
    *)
      echo "歪!你输错了"
      eleproduct_menu
esac
}

function car_menu ()
{
    cat << EOF
----------------------------------------
|************自动安装模式**************|
----------------------------------------
`echo -e "\033[35m 1)kvm与基础环境环境部署\033[0m"`
`echo -e "\033[35m 2)web_kvm代码部署\033[0m"`
`echo -e "\033[35m 3)返回主菜单\033[0m"`
EOF
read -p "请输入对应的数字：" num3
case $num3 in
    1)
yum -y upgrade
pip install --upgrade pip
sudo pip install numpy
yum install php php-devel
yum install epel-release net-tools vim unzip zip wget ftp -y
yum -y install qemu-kvm python-virtinst libvirt libvirt-python virt-manager libguestfs-tools bridge-utils virt-install
yum install epel-release
yum install epel-release
cat /proc/cpuinfo | egrep 'vmx|svm'
yum -y install mysql mysql-server mysql-devel
sudo yum install sqlite-devel
lsmod | grep kvm
systemctl start acpid.service
systemctl enable acpid.service
systemctl start libvirtd.service
systemctl enable libvirtd.service
systemctl status libvirtd
systemctl is-enabled libvirtd
mkdir /home/backup/
mv -f  /etc/sysconfig/network-scripts/ /home/backup/
mv -f  /home/kvm_web/ifcfg-br0 /etc/sysconfig/network-scripts
rm -f  /etc/sysconfig/network-scripts/ifcfg-enp0s25
mv -f  /home/kvm_web/ifcfg-enp0s25 /etc/sysconfig/network-scripts/
systemctl restart network
sudo yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
sudo yum -y install git python-pip libvirt-python libxml2-python python-websockify supervisor nginx
sudo yum -y install gcc python-devel
      car_menu
      ;;
    2)
     
	 
	 cd webvirtmgr
sudo pip install -r requirements.txt
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
sudo systemctl enable nginx
wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
mkdir /var/www/
cd ..
sudo mv webvirtmgr /var/www/
mv -f  /home/kvm_web/webvirtmgr.conf /etc/nginx/conf.d
chmod 777 manage.py
echo "imput user passwd"
      sleep 1s
      ./manage.py syncdb
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
cd /var/www/webvirtmgr/
      car_menu
      ;;
    3)
       clear
      menu
      ;;
    *)
      echo "歪!你输错了"
      car_menu
esac
}
menu



  