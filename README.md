# Dockerized WordPress

## What This Repo is For

This repo is both for dockerized local development and production deployment of WordPress websites. It is for those of us who prefer running MySQL, PHP, and Adminer (an alternative to PHP MyAdmin) in docker containers rather than installing everything on the host computer.


## Quick start

1. Prerequisite: [Docker](https://docs.docker.com/engine/install)

1. First run:
    - on Linux and Mac: `make`
    - on Windows: `docker compose up`

1. Subsequent use: regular docker compose commands

## How to Use

This repo uses `Docker` containers and `Docker Compose` to run everything.

To wire up everything you will need to:

1. Generate an `.env` file by following the guidelines outlined in the `.env.example` file

1. If you are working on an existing website, make sure to copy its `wp-content` folder into the root directory of this repository

1. Run the quick start commands above

## ElasticSearch

In addition to the WordPress website and it's SQL database, you can also start a local ElasticSearch cluster by uncommenting all the commented rows in `docker-compose.yml`.

Authentication is disabled for ElasticSearch. It is meant for connecting via [ElasticPress plugin](https://wordpress.org/plugins/elasticpress/) as a Third-Party/Self-Hosted cluster by providing the following address as Elastic Host URL: `http://{PROJECT_NAME}_elasticsearch:9200`. `dev` is the fallback value for `PROJECT_NAME`, so the URL is `http://dev_elasticsearch:9200` by default.


## Nginx example

Hooking this apache-based docker container to an Nginx reverse proxy requires some additional proxy headers. Below is an example:

```nginx
server {
    server_name {{ BASE_URL }};
    location / {
        proxy_pass http://127.0.0.1:{{ PORT }}/;

        proxy_set_header    Host                $host;
        proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto   $scheme;
        proxy_set_header    Accept-Encoding     "";
        proxy_set_header    Proxy               "";
    }
}
```
