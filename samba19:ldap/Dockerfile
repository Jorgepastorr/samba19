FROM fedora:27

LABEL version="0.1"
LABEL autor="@jorgepastorr"
LABEL subject="samba19:ldap"

RUN dnf -y install vim passwd samba samba-client openldap-clients \
                    nss-pam-ldapd authconfig smbldap-tools

RUN mkdir /opt/docker
WORKDIR /opt/docker/

COPY * /opt/docker/

RUN chmod +x /opt/docker/startup.sh

CMD /opt/docker/startup.sh