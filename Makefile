image = robvis
container_id_file = ./container_id

build:
	sudo docker build -t $(image) .

buildrm:
	sudo docker rmi $(image)

create:
	xhost local:docker
	sudo docker run -it \
		--cidfile $(container_id_file) \
		-e DISPLAY \
		-e QT_X11_NO_MITSHM=1 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ~/.Xauthority:/root/.Xauthority \
		$(image) 

start:
	xhost local:docker
	sudo docker container start $(shell cat $(container_id_file) )

stop:
	sudo docker container stop $(shell cat $(container_id_file) )

rm:
	sudo docker container stop $(shell cat $(container_id_file) )
	sudo docker container rm $(shell cat $(container_id_file) )
	sudo rm $(container_id_file)

enter:
	sudo docker exec -it $(shell cat $(container_id_file)) bash
	
.PHONY: build buildrm create start stop rm enter
