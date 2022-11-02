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
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --yes --import - ; \
curl https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8 | gpg --yes --import - ; \
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && yum clean all; \
dnf -y install libicu libunwind less openssl openssh-clients iputils wget bind-utils && dnf clean all; \
rpm -ivh https://packages.microsoft.com/centos/8/prod/mssql-cli-1.0.0-1.el7.x86_64.rpm && yum clean all
USER root
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/bin/sleep", "3650d"]
