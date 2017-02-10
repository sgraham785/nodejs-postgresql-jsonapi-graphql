.DEFAULT_GOAL := all

##Test configs
	export DB_DRIVER=org.postgresql.Driver
	export DB_PASSWORD=postgres
	export DB_URL=jdbc:postgresql://patientpostgres:5432/patient_portal
	export DB_USERNAME=postgres
	export DB_INITIAL_SIZE=3
	export DB_MAX_TOTAL=8
	export DB_MAX_WAIT_MILLIS=5000
	export PORTAL_SESSION_URL=https://www.demandforced3.com/bp2/session.jsp
	export PORTAL_SESSION_TIMEOUT=5000
	export ADMIN_USERNAME=admin123
	export ADMIN_PASSWORD=Ondemand1!
	export AUTHENTICATION_IS_ACTIVE=false

help:
	@echo
	@echo
	@echo "BUILDING:"
	@echo "   make				make (compile) main image"
	@echo "   make postgres		- make (compile) persistence"
	@echo
	@echo "TESTING:"
	@echo "   make test			- run integration test suite"
	@echo
	@echo "CLEANING:"
	@echo "   make clean			- clean all build artifacts, docker containers, and volumes"
	@echo
	@echo "RUNNING AND STOPPING FOR DEVELOPER:"
	@echo "   make developer			- docker-compile up the build system"
	@echo
	@echo "RUNNING AND STOPPING:"
	@echo "   make up			- docker-compile up the build system"
	@echo
	@echo "PROFILING:"
	@echo "   make tail-patient		- tail the template-api docker container's log"
	@echo "   make tail-postgres		- tail the postgres docker container's log"
	@echo

clean:
	sudo docker-compose -f docker/dev-docker-compose.yml stop
	sudo docker-compose -f docker/dev-docker-compose.yml rm -v --force

all:
	./docker/buildall.sh

postgres:
	cd ./docker/postgres && docker build -t postgres .

test:
	npm run test

up:
	cd ./docker && docker-compose -f dev-docker-compose.yml up -d

developer:
	sudo -E docker-compose -f docker/dev-docker-compose.yml stop
	sudo -E docker-compose -f docker/dev-docker-compose.yml rm -v --force
	./docker/buildall.sh
	sudo -E docker-compose -f docker/dev-docker-compose.yml up -d

tail-patient:
	docker logs -f docker_dfpatient_1

tail-postgres:
	docker logs -f docker_postgres_1