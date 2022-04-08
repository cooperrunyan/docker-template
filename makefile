current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

dev:
	docker-compose -f docker-compose.dev.yaml up --build --abort-on-container-exit

start:
	@echo "Stopping any pre-existing version of this image"
	$(MAKE) stop

	@echo "Building image"
	docker-compose build

	@echo "Starting image"
	docker-compose up --detach

	$(MAKE) logs

stop:
	docker-compose down
	docker volume rm $(current_dir)_app_node_modules 2>/dev/null || true

logs:
	docker-compose logs --follow

# Prettifying tools
better:
	@echo "Running ESLint on ./src files"
	$(MAKE) pretty

	@echo "Running ESLint on ./src files"
	$(MAKE) lint

pretty:
	prettier * --config ./.prettierrc --ignore-path ./.prettierignore --write --no-error-on-unmatched-pattern

lint:
	npx eslint src -c .eslintrc --ext .ts,.tsx,.js,.jsx,.json --fix