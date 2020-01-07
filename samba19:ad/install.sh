#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
# -------------------------------------

rm -rf /etc/samba/smb.conf

samba-tool domain provision --server-role=dc --use-rfc2307 \
 --dns-backend=SAMBA_INTERNAL --realm=EDT.ORG --domain=EDT \
 --adminpass=Passw0rd

cp /opt/docker/krb5.conf /etc/

#samba-tool domain level show
samba-tool user create jorge Passw0rd