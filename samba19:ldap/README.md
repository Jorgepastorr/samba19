Servidor samba que conecta con otro servidor ldapserver y y lo utiliza como su propia base de datos, para guardar su propia base de datos.



# Puesta en marcha

```bash
docker run --rm --name ldapserver -h ldapserver --net ldapnet -d jorgepastorr/ldapserver19
docker run --rm --name samba -h samba --net ldapnet -d jorgepastorr/samba19:ldap
```




