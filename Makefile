.DEFAULT_GOAL := build

export IMAGE=jsonapi-server
export ENV=prod

ifdef GIT_COMMIT
  export IMAGE_NAME=${IMAGE}:${GIT_COMMIT}
else
  export IMAGE_NAME=${IMAGE}
endif
$(shell echo IMAGE_NAME=${IMAGE_NAME} > .env)

help:
	@echo
	@echo
	@echo " make				- compile & build main image(s)"
	@echo
	@echo " make up			- creates the container(s)"
	@echo
	@echo " make build-dev			- compile, build image(s) & run container(s) in development mode"
	@echo
	@echo " make up-dev			- run container(s) in development mode"
	@echo
	@echo " make test			- creates container(s), run tests, then removes container(s)"
	@echo
	@echo " make clean			- clean all build artifacts, docker container(s), and target volumes"
	@echo
	@echo " make down			- removes the container(s)"
	@echo
	@echo

clean:
	- sudo docker-compose -f docker/dev.yml down
	- sudo rm -rf node_modules
npm-install:
	npm install -${ENV}
	npm run build
build:	clean
	@echo "Compiling source..."
	sudo docker-compose -f docker/build.yml run --rm build make npm-install
	@echo "Building image..."
	sudo docker build -t $(IMAGE_NAME) .
build-dev:	build build-deps
	sudo docker-compose -f docker/dev.yml up -d app
build-deps:
	sudo docker build -f docker/postgres/Dockerfile -t $(IMAGE_NAME)-db1 ./
up-dev:	down
	sudo docker-compose -f docker/dev.yml up -d app
up:	down
	sudo docker-compose -f docker/up.yml up -d --remove-orphans app
down:
	sudo docker-compose -f docker/dev.yml down
test:	down
	sudo docker-compose -f docker/test.yml run --rm app npm test
	sudo docker-compose -f docker/test.yml down

.PHONY: test