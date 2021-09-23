image = ros_robwork_rtde
container_id_file = ./container_id

build:
	sudo docker build -t $(image) .

buildrm:
	sudo docker rmi $(image)

create:
	xhost local:docker
	sudo docker run -it \
		--cidfile $(container_id_file) \
		--privileged \
		--device /dev/dri:/dev/dri \
		-e DISPLAY \
		-v /home/lpe/Desktop/EiT:/home/user/workspace \
		-e QT_X11_NO_MITSHM=1 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ~/.Xauthority:/root/.Xauthority \
		--cap-add sys_ptrace \
		-p127.0.0.1:2222:22 \
		-v /run/user/1000:/run/user/1000 \
		-e XDG_RUNTIME_DIR \
		$(image) 
start:
	xhost local:docker
	sudo docker container start $(shell cat $(container_id_file) )
	$(shell ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:2222")

stop:
	sudo docker container stop $(shell cat $(container_id_file) )

rm:
	sudo docker container stop $(shell cat $(container_id_file) )
	sudo docker container rm $(shell cat $(container_id_file) )
	sudo rm $(container_id_file)

enter:
	sudo docker exec -it $(shell cat $(container_id_file)) bash
	
.PHONY: build buildrm create start stop rm enter


 # docker exec -it container_id /bin/sh -c "cd /home/user/Test_project/bin/Release; ./main " 
 # docker exec -it b86ee06ed3a5 /bin/sh -c "cd /home/user/Test_project/build; ls ; make "
 # docker exec -it b86ee06ed3a5 /bin/sh -c "cd /home/user/Test_project/build; ls ; cmake .. "
