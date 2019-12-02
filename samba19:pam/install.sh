#!/bin/bash


mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
mkdir /var/lib/samba/privat

cp /opt/docker/smb.conf /etc/samba/smb.conf



useradd lila
useradd rock
useradd patipla
useradd pla 

echo -e "lila\nlila" | smbpasswd -a lila
echo -e "rock\nrock" | smbpasswd -a rock
echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "pla\npla" | smbpasswd -a pla



for num in {01..08}
do 
    echo -e "jupiter\njupiter" | smbpasswd -a user$num 

    liniaget=$( getent passwd user$num )
    uid=$( echo $liniaget | sed -r 's/^([^:]*:){2}([^:]*):.*$/\2/' )
    gid=$( echo $liniaget | sed -r 's/^([^:]*:){3}([^:]*):.*$/\2/' )
    homedir=$( echo $liniaget | sed -r 's/^([^:]*:){5}([^:]*):.*$/\2/' )

    if [ ! -d $homedir ];then
        mkdir -p $homedir
        cp -ra /etc/skel/. $homedir
        chown -R $uid:$gid $homedir
    fi

done