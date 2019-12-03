#!/bin/bash

# configuracion de samba
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
mkdir /var/lib/samba/privat

cp /opt/docker/smb.conf /etc/samba/smb.conf


# usuarios locales samba
useradd lila
useradd rock
useradd patipla
useradd pla 

echo -e "lila\nlila" | smbpasswd -a lila
echo -e "rock\nrock" | smbpasswd -a rock
echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "pla\npla" | smbpasswd -a pla


# usuarios ldap samba
for num in {01..08}
do 
    echo -e "jupiter\njupiter" | smbpasswd -a user$num 

    liniaget=$( getent passwd user$num )
    uid=$( echo $liniaget | cut -d: -f 3 )
    gid=$( echo $liniaget | cut -d: -f 4 )
    homedir=$( echo $liniaget | cut -d: -f 6 )

    if [ ! -d $homedir ];then
        mkdir -p $homedir
        cp -ra /etc/skel/. $homedir
        chown -R $uid:$gid $homedir
    fi

done