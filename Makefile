BIN := "./build/cliurl"
FILE = $(URL)


build-img:
	docker-compose -f deployment/docker-compose.yml build

run-img: build-img
	docker-compose -f deployment/docker-compose.yml up


up: run-img

down:
	docker-compose -f deployment/docker-compose.yml down \
		 --rmi local \
		--volumes \
		--remove-orphans \
		--timeout 5; \




.PHONY: build test lint
