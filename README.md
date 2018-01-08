# Rails on Docker boilerplate

Rails application on Docker

## Usage

```/bin/bash
$ git clone git@github.com:cheezenaan-sandbox/rails-on-docker-boilerplate.git your_own_app
$ cd your_own_app && rm rf -.git
$ docker-compose run --rm app rails new . --force --skip-coffee --skip-turbolinks --database=mysql -BT -m templates/initialize.rb
$ docker-compose up -d app
```
