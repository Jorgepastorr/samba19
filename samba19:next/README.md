Servidor samba que conecta con otro servidor ldapserver y exporta homes de los usuarios.
Es el `samba19:pam` modificados los recursos para utilizarcon nextcloud.


# Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name samba -h samba --net ldapnet -v homes:/tmp/home --privileged -d jorgepastorr/samba19:next
```





## Modificaciones

El servidor samba tendrá los usuarios locales samba `lila, pla, rock, patipla` , y ademas los usuarios samba de ldap.

Para esto conectamos con el servidor ldap y los añadimos a samba.

### Paquetes necesarios

```bash
dnf install -y passwd nss-pam-ldapd authconfig samba samba-client
```



### Configurar conexión con ldap

```bash
authconfig --enableshadow --enablelocauthorize \
   --enableldap \
   --enableldapauth \
   --ldapserver='ldapserver' \
   --ldapbase='dc=edt,dc=org' \
   --enablemkhomedir \
   --updateall
```

#### Encender servicio

```bash
/sbin/nscd
/sbin/nslcd
```

ya podemos hacer `getent passwd` y ver los usuarios ldap.



### Añadir usuarios 

```bash
# usuarios locales samba
useradd lila
useradd rock
useradd patipla
useradd pla 

echo -e "lila\nlila" | smbpasswd -a lila
echo -e "rock\nrock" | smbpasswd -a rock
echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "pla\npla" | smbpasswd -a pla
```



A mas de añadir los usuarios ldap, hay que crearles el home y ponerles los permisos adecuados.

```bash
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
```



### Configurar samba

En la configuración de samba nos interesa la sección de homes de usuario

*/etc/samba/smb.conf* 

```bash
[global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
;       valid users = %S
;       valid users = MYDOMAIN\%S
[printers]
        comment = All Printers
        path = /var/spool/samba
        browseable = no
        guest ok = no
        writable = no
        printable = yes
```

#### Arrancar servicio

```bash
/sbin/smbd
/sbin/nmbd
```



