# What This Repo is For

> :warning: **Not tested on Windows.**

This repo is both for dockerized local development and production deployment of WordPress websites. It is for those of us who prefer running MySQL, PHP, and Adminer (an alternative to PHP MyAdmin) in docker containers rather than installing everything on the host computer. It won't run out of box -- you need to complete all the steps below in order to start using.


# How to Use (Overview)

This repo uses `Docker` containers and `Docker Compose` to run everything, so if these sound odd to you, better do some reading on Docker first.

To wire up everything you will need to:

1. Create an `.env` file and fill in the necessary environment variables in it (details below).

1. Copy your website's `wp-content` folder into this repo's rooot directory.

1. Import your WordPress website's database via Adminer on [port 9500](http://localhost:9500), then update your website's `home` and `siteurl` options accordingly.

Once everything is set up, start and stop your project with `docker-compose up -d` and `docker-compose down`.


# How to fill in the `.env` file

Variables defined in the `.env` file are used in the following files: `docker-compose.yml` and `Dockerfile-wordpress`.

Variable              | Default value | Description
----------------------|---------------|------------
WP_CONFIG_IMPORT_PATH | [none]        | Must start with `/wp-content`. Providing this variable's value is mandatory. The file's content found by this path will be imported into the local website's `wp-config.php` file. It is to override all the values found in `wp-config.php` rather than editing the file. Normally I keep the file with the website's custom theme.
WP_VERSION            | `5.9.0`       | WordPress version to pull from Docker
PROJECT_NAME          | `dev`         | Must be lowercase. A string that will prefix all the Docker images, containers and volumes built in this project
WORDPRESS_PORT        | `9000`        | Choose a port to access the WordPress website locally. E.g. http://localhost:9000
ADMINER_PORT          | `9500`        | Choose a port to access Adminer (an alternative to PHP MyAdmin).
DB_NAME               | `wordpress`   | Set a database name
DB_USER               | `wordpress`   | Set a database user name
DB_PASSWORD           | `wordpress`   | Set a database user's password

Setting the `WP_CONFIG_IMPORT_PATH` variable's value in the `.env` file is mandatory. The rest have fallback values.


# ElasticSearch

In addition to the WordPress website and it's SQL database, you can also start a local ElasticSearch cluster by uncommenting all the commented rows in `docker-compose.yml`.

Authentication is disabled for ElasticSearch. It is meant for connecting via [ElasticPress plugin](https://wordpress.org/plugins/elasticpress/) as a Third-Party/Self-Hosted cluster by providing the following address as Elastic Host URL: `http://{PROJECT_NAME}_elasticsearch:9200`. `dev` is the fallback value for `PROJECT_NAME`, so the URL is `http://dev_elasticsearch:9200` by default.
