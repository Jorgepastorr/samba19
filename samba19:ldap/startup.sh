#! /bin/bash
# @edt ASIX M06 2018-2019
# startup.sh
# -------------------------------------


bash /opt/docker/install.sh 
/sbin/smbd 
/sbin/nmbd -F 


