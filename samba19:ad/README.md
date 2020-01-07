# SAMBA
## @edt ASIX M06 2018-2019

Samba active directori controler, con dos usuarios administrator y jorge. Dominio EDT realm: EDT.ORG, contraseñas Passw0rd para usuarios.

### Imatges:

https://hub.docker.com/repository/docker/jorgepastorr/samba19


#### Execució

```
docker run --rm --name samba.edt.org -h samba.edt.org --net sambanet --privileged -d jorgepastorr/samba19:ad
```

