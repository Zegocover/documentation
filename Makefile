ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

build-image:
	docker build -t zego-documentation:latest .

build:
	docker run --mount type=bind,source=$(ROOT_DIR)/,target=/docs/ -it zego-documentation bundle exec middleman build --clean --verbose
run:
	docker run --mount type=bind,source=$(ROOT_DIR)/,target=/docs/ -it -p 4567:4567 zego-documentation

deploy: build
	aws s3 sync $(ROOT_DIR)/build s3://developer.zego.com

.PHONY: build-image build run
