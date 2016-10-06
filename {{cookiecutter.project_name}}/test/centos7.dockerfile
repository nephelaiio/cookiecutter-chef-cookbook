FROM centos:centos7
ENV container docker
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all;\
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*;\
rm -f /lib/systemd/system/sockets.target.wants/*udev*;\
rm -f /lib/systemd/system/sockets.target.wants/*initctl*;\
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum clean all;\
yum install -y sudo openssh-server openssh-clients which curl tar chpasswd hostname passwd;\
mkdir -p /var/run/sshd;\
useradd -d /home/<%= @username %> -m -s /bin/bash <%= @username %>;\
echo <%= "#{@username}:#{@password}" %> | chpasswd;\
echo '<%= @username %> ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;\
sed -i.kitchen '/UsePAM/d'  /etc/ssh/sshd_config;\
echo 'UsePrivilegeSeparation no' >> /etc/ssh/sshd_config;\
echo 'UsePAM no' >> /etc/ssh/sshd_config;\
ssh-keygen -A;\
systemctl enable sshd.service;
VOLUME [ "/sys/fs/cgroup" ]
ENTRYPOINT ["/usr/sbin/init"] 
