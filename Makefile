.DEFAULT_GOAL := all

export IMAGE=jsonapi-server
ifdef GIT_COMMIT
  export IMAGE_NAME=${IMAGE}:${GIT_COMMIT}
else
  export IMAGE_NAME=${IMAGE}
endif
$(shell echo IMAGE_NAME=${IMAGE_NAME} > .env)
$(shell echo HOST_ROOT_MOUNT=../ >> .env)
$(shell echo CONTAINER_ROOT_MOUNT=/project-root >> .env)

help:
	@echo
	@echo
	@echo " make				- make (compile) main image"
	@echo
	@echo " make test			- compile and run tests"
	@echo
	@echo " make clean			- clean all build artifacts, docker containers, and volumes"
	@echo
	@echo " make up				- docker-compose up the system"
	@echo
	@echo " make dev			- docker-compose up the system in development mode (bind-mounted root directory with 'watch' mode on)"
	@echo
	@echo " make npm-install	- invoke npm install inside the container. Reload public npm dependencies without rebuilding."
	@echo

clean:
	- sudo docker rm -f docker_app_run_1
	- sudo rm -rf target
#Do not call this directly. The "all" target will invoke this inside of the build container.
container:
	rm -rf target
	mkdir -p target
	cp package.json target
	cd target && npm install
all:
	sudo docker-compose -f docker/docker-compose.yml run --rm build make container
	sudo docker build -t $(IMAGE_NAME) .
test:
	sudo docker-compose -f docker/docker-compose.yml run --rm app npm test
up-dev:
	$(shell echo HOST_ROOT_MOUNT=../ >> .env)
	$(shell echo CONTAINER_ROOT_MOUNT=/app >> .env)
	cp -rp target/node_modules ./
	sudo docker-compose -f docker/docker-compose.yml run -d --rm --service-ports app npm run-script start-dev
up:
	sudo docker-compose -f docker/docker-compose.yml run -d --rm --service-ports app npm start
 .PHONY: test

npm-install:
	docker exec -ti docker_app_1 npm install

.PHONY: test