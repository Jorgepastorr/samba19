#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
# -------------------------------------
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
cp /opt/docker/* /var/lib/samba/public/.

mkdir /var/lib/samba/privat
#chmod 777 /var/lib/samba/privat
cp /opt/docker/*.md /var/lib/samba/privat/.

cp /opt/docker/smb.conf /etc/samba/smb.conf

useradd lila
useradd rock
useradd patipla
useradd pla 

echo -e "lila\nlila" | smbpasswd -a lila
echo -e "rock\nrock" | smbpasswd -a rock
echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "pla\npla" | smbpasswd -a pla