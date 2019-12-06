Diferentes configuraciones de samba.

- [samba19:base](#samba19base)
- [samba19:pam](#samba19pam)



### samba19:base

servidor samba que exporta una serie de shares

```bash
docker run --rm --name samba -h samba --net ldapnet -d jorgepastorr/samba19:base
```

```bash
MYGROUP
	\\SAMBA          		Samba Server Version 4.7.10
		\\SAMBA\IPC$           	IPC Service (Samba Server Version 4.7.10)
		\\SAMBA\public         	Share de contingut public
		\\SAMBA\manpages       	Documentació man del container
		\\SAMBA\documentation  	Documentació doc del container
```

```bash
smbclient -N //samba/public
```





### samba19:pam

Servidor samba que conecta con otro servidor ldapserver y exporta homes de los usuarios.

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19

docker run --rm --name samba -h samba --net ldapnet -v homes:/tmp/home --privileged -d jorgepastorr/samba19:pam
```

```bash
smbclient -U user01%jupiter //samba/user01
```

