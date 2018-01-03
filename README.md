# Rails on Docker boilerplate

Rails application on Docker

## Usage

```/bin/bash
$ git clone git@github.com:cheezenaan/rails-on-docker-boilerplate.git
$ cd rails-on-docker-boilerplate
$ docker-compose run --rm app rails new . --force --skip-coffee --skip-turbolinks --database=mysql -BT -m templates/initialize.rb
$ docker-compose up -d app
```
