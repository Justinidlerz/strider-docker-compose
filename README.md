# strider-docker-compose
A docker-compose config to quick startup [strider](https://github.com/Strider-CD/strider)
## Usage
Clone project: `git clone https://github.com/Justinidlerz/strider-docker-compose.git strider`  
Set permission: `cd strider && chmod -R 777 .`  
First time to start: `docker-compose up install` or with `-d`  
Start server: `docker-compose up web` or with `-d`  
   
### Default strider administrator account:
 **Email:** admin@strider.com   
 **Password:** 123456

You can change `docker-compose.yml` file config to update:   
```yml
TRIDER_ADMIN_PASSWORD=123456
STRIDER_ADMIN_EMAIL=admin@strider.com
``` 
