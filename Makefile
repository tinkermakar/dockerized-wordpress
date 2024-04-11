WP_USER = www-data

make: configure build

check-env:
	@if [ ! -f .env ]; then \
		read -p 'The .env file does not exist. Proceed anyway? [y/N] ' confirm; \
		if [ "$$confirm" != y ]; then \
			echo 'Aborted.'; \
			exit 1; \
		fi; \
	fi

configure:
	- mkdir wp-content
	sudo chown $$USER:$$USER wp-content

build: check-env
	docker compose up --build -d

danger-purge:
	docker compose down -v --rmi local
	rm -rf wp-content