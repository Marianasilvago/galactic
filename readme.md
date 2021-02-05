# Reenue Graphql

This is the primary backend for the Reenue application. It's primary task is the graphql server to connect to information on the frontend.

#### Technology
- Golang
  - gqlgen (code generation)
  - cobra (commands)
  - viper (config)
- Graphql Schema
- Postgres (database)
- S3 (file storage)
- Docker
  - Docker Compose (orchestration)

## Setup

This assumes you have docker and docker-compose already installed

### Install Go

This step makes working with the packages easier.

[https://golang.org/dl/](Go Download)

### Start Docker

Start the docker containers

`docker-compose up -d`

### Run migrations and seed

This will drop any existing tables, run migration scrips, and seed an initial `SUPPORT` user

`make fresh`