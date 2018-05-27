# Laravel Docker Skeleton

A skeleton repo for starting a fresh Laravel app with Docker.

It builds on PHP7-fpm-alpine, adding essentials such as the MySQL PDO extension.



## Getting started

To create a new project, clone/fork this repo somewhere and `cd` to it.


### Naming your Project

By default, the project is named `myapp`. If you prefer to change this, run:

```
export APPNAME="yourapp"
for file in Makefile docker-compose.yml build/nginx/server.conf; do sed -i "s/myapp/$APPNAME/g" $file; done

```


### (Re-)Creating a Project

To create a new Laravel project, run `make fresh-install` in the terminal.
This command will make sure the `src/` directory is in place before using
composer to pull in a fresh installation of Laravel and its dependencies.

If at any point you want to start fresh, you can run `make install` again.

**This command can and will nuke your entire project if you misuse it!**


### Starting the Server

```
make compose
```

After creating your project, run this to spin up all the containers.

The first time you run it, Docker will automatically build required images.
If you make changes to them in the future, you can run `make rebuild compose`.

That's it! Now open http://localhost:8080 in a browser to check it all went well.



## Composer & Artisan

Chances are your project will use a database, and at some point you'll probably
want to add one or two composer packages too.

Rather than manually typing the full command to `docker exec` every time you want
to run something in the container, there are a couple helpers included.


### Laravel Artisan Helper

```
make art
```

This one doesn't appear to do much if you run it as-is. Wrapped in some magic
though, you can run just about any artisan command you'd need:

```
$(make art) migrate --seed
$(make art) auth:make
```

If you're a fan of shell aliases, you can shorten that to `dpa migrate`:

```
# ~/.bashrc (host machine)

alias dpa="$(make art)"
```


### Basic Composer Requirements

```
make require pkg=vendor/package
```

The composer helper is slightly more restrictive. Passing options isn't likely
to work (for now), but it's enough to install the basic bits.

You can always run the full command by hand:

```
docker run --rm -it --user `id -u`:82 \
  --workdir /myapp --volume `pwd`/src:/myapp \
  composer:latest require vendor/package --prefer-dist --dry-run
```
