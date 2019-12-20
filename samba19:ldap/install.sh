#!/bin/bash

# conexion a ldap
#bash /opt/docker/auth.sh 
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
/sbin/nscd
/sbin/nslcd


# usuario local por si acaso
useradd local1
echo 'local1' | passwd local1 --stdin


# configuracion de samba
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
mkdir /var/lib/samba/privat

cp /opt/docker/smb.conf /etc/samba/smb.conf

# configuracion para base de detos en ldap
cp /opt/docker/smbldap.conf /etc/smbldap-tools/.
cp /opt/docker/smbldap_bind.conf /etc/smbldap-tools/.

# dar la pasword de ldap manager a samba
smbpasswd -w secret

# establcer base datos de samba en ldap
echo -e "jupiter\njupiter" | smbldap-populate

# añadir usuarios ldap a samba
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
