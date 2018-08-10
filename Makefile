build:
	docker build -t zego-documentation:latest .

run:
	docker run -it -p 4567:4567 zego-documentation
