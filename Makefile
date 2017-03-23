.DEFAULT_GOAL := build

export IMAGE=jsonapi-server
ifdef GIT_COMMIT
  export IMAGE_NAME=${IMAGE}:${GIT_COMMIT}
else
  export IMAGE_NAME=${IMAGE}
endif
$(shell echo IMAGE_NAME=${IMAGE_NAME} > .env)

help:
	@echo
	@echo
	@echo " make				- compile & build main image"
	@echo
	@echo " make up			- creates & runs the container"
	@echo
	@echo " make dev			- compile, build image(s) & run container(s) in development mode"
	@echo
	@echo " make up-dev			- run container(s) in development mode"
	@echo
	@echo " make test			- creates container(s), run tests, then removes container(s)"
	@echo
	@echo " make down			- removes the container(s)"
	@echo
	@echo " make clean			- removes all build images, containers, and target volumes for this project"
	@echo
	@echo

clean:
	- sudo docker-compose -f docker/develop.yml down
	- sudo rm -rf target
npm-install:
	mkdir -p target
	cp package.json target
	cd target && npm install
	npm build
build:	clean
	sudo docker-compose -f docker/build.yml run --rm build make npm-install
	sudo docker build -t $(IMAGE_NAME) .
build-dev:	build build-deps
	rm -rf node_modules
	ln -s target/node_modules
build-deps:
	sudo docker build -f docker/postgres/Dockerfile -t $(IMAGE_NAME)-db1 ./
dev:	build-dev up-dev
up-dev:	down
	sudo docker-compose -f docker/develop.yml up -d app
up:	down
	sudo docker-compose -f docker/up.yml up -d --remove-orphans app
down:
	sudo docker-compose -f docker/develop.yml down
test:	down
	sudo docker-compose -f docker/test.yml run --rm app npm test
	sudo docker-compose -f docker/test.yml down

.PHONY: test