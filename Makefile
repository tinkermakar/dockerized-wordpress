WP_USER = www-data

-include .env

make: configure prepare-backup build

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

prepare-backup:
	- mkdir "$(DB_BACKUP_DIR)"
	chmod 700 "$(DB_BACKUP_DIR)"

build: check-env
	docker compose up --build -d

backup:
	test -d "$(DB_BACKUP_DIR)"
	docker compose exec -T db sh -c 'MYSQL_PWD="$$MYSQL_ROOT_PASSWORD" exec mysqldump \
		-uroot \
		--default-character-set=utf8mb4 \
		--lock-all-tables \
		"$$MYSQL_DATABASE"' </dev/null > "$(DB_BACKUP_DIR)/$(PROJECT_NAME)-$$(date -u +%Y%m%dT%H%M%SZ).sql"
	gzip -c "$(DB_BACKUP_DIR)/$(PROJECT_NAME)"-*.sql > "$(DB_BACKUP_DIR)/$(PROJECT_NAME).sql.gz"
	chmod 600 "$(DB_BACKUP_DIR)/$(PROJECT_NAME).sql.gz"
	rm "$(DB_BACKUP_DIR)/$(PROJECT_NAME)"-*.sql

danger-purge:
	docker compose down -v --rmi local
	rm -rf wp-content
