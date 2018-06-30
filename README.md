# strider-docker-compose
strider docker compose

## Usage
`docker build -t local/strider .`  
`docker-compose up install` first time to run  
`docker-compose up web` start or with `-d` 
   
### Default strider administrator account:
*Email:*admin@strider.com   
*Password:*123456

If you want to update strider admin account and password, you can update `docker-compose.yml` config:   
```yml
TRIDER_ADMIN_PASSWORD=123456
STRIDER_ADMIN_EMAIL=admin@strider.com
``` 
