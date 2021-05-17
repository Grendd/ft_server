# Ft_server, project from 21 School.

It's my first devOps project. There nginx, wordpress, phpMyAdmin and mariaDB in one docker container.

### How to setup:
```bash
git clone https://github.com/Grendd/ft_server.git ft_server
cd ft_server
docker build ft_server_image .
docker run -it --rm --name container -itp 80:80 -p 443:443 ft_server_image
```
and go to https://localhost
phpMyAdmin
login: root
password: ''
