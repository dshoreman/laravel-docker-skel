fresh-install:
	docker-compose down && rm -rf src
	mkdir src && docker-compose up -d
	docker run --rm -it \
		--user `id -u`:82 \
		--volume `pwd`/src:/myapp \
		composer:latest create-project --prefer-dist laravel/laravel /myapp
	make require pkg=predis/predis
	chmod -R ug+rwX src/storage

rebuild:
	docker-compose up --build -d

compose:
	docker-compose down && docker-compose up -d

require:
	docker run --rm -it \
		--user `id -u`:82 \
		--workdir /myapp \
		--volume `pwd`/src:/myapp \
		composer:latest require ${pkg}
