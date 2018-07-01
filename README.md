# strider-docker-compose
strider docker compose

## Usage
Clone project: `git clone https://github.com/Justinidlerz/strider-docker-compose.git strider`  
Set root permission: `cd strider && chmod -R 777 .`
First time to start: `docker-compose up install` with `-d` 
Start server: `docker-compose up web` start or with `-d` 
   
### Default strider administrator account:
 **Email:** admin@strider.com   
 **Password:** 123456

You can change `docker-compose.yml` file config to update:   
```yml
TRIDER_ADMIN_PASSWORD=123456
STRIDER_ADMIN_EMAIL=admin@strider.com
``` 
