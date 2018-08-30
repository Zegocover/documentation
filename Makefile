ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build-image:
	docker build -t zego-documentation:latest .

build:
	docker run --mount type=bind,source=$(ROOT_DIR)/,target=/docs/ -it zego-documentation bundle exec middleman build --clean --verbose
run:
	docker run --mount type=bind,source=$(ROOT_DIR)/,target=/docs/ -it -p 4567:4567 zego-documentation

.PHONY: build-image build run
