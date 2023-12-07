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
curl https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash; \
curl https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash; \
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && yum clean all; \
dnf -y install rabbitmq-server && yum clean all; \
echo -n "rabbitmq" | passwd --stdin rabbitmq; \
dnf -y install netcat libicu libunwind less openssl openssh-clients iputils wget bind-utils && dnf clean all; \
rpm -ivh https://packages.microsoft.com/centos/8/prod/mssql-cli-1.0.0-1.el7.x86_64.rpm && yum clean all; \
dnf module install -y nodejs:16/minimal; \
npm install -g redis-cli; \
dnf -y install unzip && yum clean all; \
curl -L https://aka.ms/sqlpackage-linux -o sqlpackage-linux && unzip sqlpackage-linux -d /opt/sqlpackage && chmod +x /opt/sqlpackage/sqlpackage && rm -f sqlpackage-linux; \
dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm && yum clean all; \
dnf install -y azure-cli; \
wget https://github.com/mikefarah/yq/releases/download/v4.35.1/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq
USER root
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/bin/sleep", "3650d"]
