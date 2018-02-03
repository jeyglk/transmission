# Transmission
Self-hosted transmission

## Generate htpasswd

Since transmission doesn't provide any authentication mechanism, nginx is setup with basic auth. Thus, it requires a htpasswd file.

``` bash
docker run --rm --entrypoint htpasswd registry:2 -bn <user> <password> > nginx.htpasswd
```

## Build, start and attach Transmission

Build + start transmisison and attach it to haproxy (see [jeyglk/haproxy](https://github.com/jeyglk/haproxy) )

``` bash
VIRTUAL_HOST=<transmission.example.com> docker-compose up --build -d
```

## Share download with Nextcloud

Make sure the download file is writable by the Nextcloud user.

``` bash
chown -R www-data:www-data data/download
chmod 644 data/download
chmod g+s data/download
```

In Nextcloud compose file, bind mount the download directory in the app service.

```
volumes:
      - ./data/apps:/var/www/html/apps
      - ./data/config:/var/www/html/config
      - ./data/data:/var/www/html/data
      - ../transmission/data/download:/transmission/download
```

We can now setup an external storage in Nextcloud, pointing to `/transmission/download`.