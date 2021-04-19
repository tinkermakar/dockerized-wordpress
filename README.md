# What This Repo is For

This repo is for dockerized local development of WordPress websites. It is for those of us who prefer running MySQL, PHP, and Adminer (an alternative to PHP MyAdmin) in docker containers rather than installing everything on the host computer. It won't run out of box -- you need to complete all the steps below in order to start using.


# How to Use (Overview)

This repo uses `Docker` containers and `Docker Compose` to run everything, so if these sound odd to you, better do some reading on Docker first.

To wire up everything you will need to:

1. Create an `.env` file and fill in the necessary environment variables in it (details below).

1. Copy your website's `wp-content` folder into this repo's rooot directory.

1. Import your WordPress website's database via Adminer on [port 9500](http://localhost:9500), then update your website's `home` and `siteurl` options accordingly.

Once everything is set up, start and stop your project with `docker-compose up -d` and `docker-compose down`.


# How to fill in the `.env` file

Variables defined in the `.env` file are used in both Dockerfiles and in the Docker Compose file of this project:

Variable              | Example | Description
----------------------|---------|------------
WP_CONFIG_IMPORT_PATH | `/wp-content/themes/{your-theme-name}/file.php` | This file's content will be imported into the local website's `wp-config.php` file. It is to override all the values found in `wp-config.php` rather than editing the file. Normally I keep the file with the website's custom theme.
PROJECT_NAME          | `dev`  | A string that will prefix all the Docker images, containers and volumes built in this project
WORDPRESS_PORT        | `9000` | Choose a port to access the WordPress website locally. E.g. http://localhost:9000
ADMINER_PORT          | `9500` | Choose a port to access Adminer (an alternative to PHP MyAdmin).
ELASTICSEARCH_PORT        | `9200` | It is also possible to start a pre-configured ElasticSearch cluster (details below). If enabled, this variable will pass the port for its access.

Here's how the `.env` file would look like with the Example values above:
```
PROJECT_NAME=dev
WORDPRESS_PORT=9000
ADMINER_PORT=9500
ELASTICSEARCH_PORT=9200
```


# ElasticSearch

In addition to the WordPress website and it's SQL database, you can also start a local ElasticSearch cluster by running:

```
docker-compose up -f docker-compose.yml -f docker-compose-elasticsearch.yml up -d
```

Authentication is disabled. All you need to provide is the a number, then connect to it via [ElasticPress plugin](https://wordpress.org/plugins/elasticpress/) as a Third-Party/Self-Hosted cluster (E.g. http://localhost:9000).

# Miscellaneous

## Sample scripts for downloading your website's `wp-content` folder from PROD via ssh

### Add hosting's private key to local machine:

```
SSH_PRIVATE_KEY=`cat .key` && \
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
```

### Download the latest wp-content folder:

```
scp -r digitalreg@digitalreg.ssh.wpengine.net:~/sites/digitalreg/wp-content/ ./downloading &&\
rm -rf ./wp-content &&\
mv ./downloading ./wp-content
```
