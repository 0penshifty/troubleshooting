FROM registry.redhat.io/ubi8/ubi

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --import - ; \
rpm -yivh https://packages.microsoft.com/centos/8/prod/mssql-cli-1.0.0-1.el7.x86_64.rpm; \
dnf -y install openssl openssh-clients iputils wget bind-utils libunwrap && dnf clean all;
USER root
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/bin/sleep", "3650d"]
