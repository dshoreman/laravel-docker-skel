fresh-install:
	docker-compose down && rm -rf src
	mkdir src && docker-compose up -d
	docker run --rm -it \
		--user `id -u`:82 \
		--volume `pwd`/src:/myapp \
		composer:latest create-project --prefer-dist laravel/laravel /myapp
	chmod -R ug+rwX src/storage
