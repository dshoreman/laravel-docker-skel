ccp:
	docker run --rm -it \
		--user `id -u`:82 \
		--volume `pwd`/src:/myapp \
		composer:latest create-project --prefer-dist laravel/laravel /myapp
