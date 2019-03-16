# Setup
Most of the setup is automated using Dockerfiles. However, before you build the docker images, you will need to create/edit a few configuration files.

## Create docker-compose.override.yml file
Create `docker-compose.override.yml` files with the following contents:
```
version: '3.5'
services:
  db:
    environment:
      - MYSQL_ROOT_PASSWORD=secure-root-password
      - MYSQL_PASSWORD=secure-password-for-dmoj-db
```
In the example above, update values of `MYSQL_ROOT_PASSWORD` and `MYSQL_PASSWORD` variables. You need to create this file before running DB container for the first time. Otherwise it won't create the database, or will create it but with wrong password.

Next, open `site/local_settings.py` file. Fine `SECRET_KEY` variable and replace the placeholder text with proper, randomly generated secret key.
Next, locate DB configuration part and set `PASSWORD` field to the same password used for `MYSQL_PASSWORD` variable in the `docker-compose.override.yml` file. Check out the rest of the file, you'll probably want to configure some other values (like SMTP server or site admin name/email, etc.).

## Initializing the DB and starting for the first time
MySQL root password, DB and user for the DB will be automatically created when you run `db` container for the first time. Run it using `docker-compose up db`. After the output stops producing new lines, you can stop the container using `CTRL-C`. You can use `docker-compose up` to start all containers from now on.

## Create superuser
When you first start DMOJ, there will be no users in the DB. Run the following and follow instructions to create a superuser:
`docker-compose run --rm site python manage.py createsuperuser`

## Configuring judge
By default, `docker-compose.yml` defines one judge container. You will need to configure its secret in `judge/config.yml` and in DMOJ admin interface before it will successfully connect.
