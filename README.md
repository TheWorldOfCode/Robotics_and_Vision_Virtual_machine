# Robotics and Comptuer Vision

This is a dockerfile that creates an image which are similar to the virtual
machine that are provide in the course. 

The dockerfile setups Robwork, OpenCV3 and PointCloudLibrary. Furthermore will
it install vim as a editor. All files in the dictory root will be copy to the
`/home/user` folder in the container. The folder execise is mount into root folder in the container, this means that chances to the files in the container will be save in the execise folder outside the container. But beware changes to files outside the folder execise will not be saved and will be delete if container is delete. When you enter the container are you signed in as a user `user` and the password is `user`.


This required docker to have it own group, which is shown in the first part on this [page](https://docs.docker.com/engine/install/linux-postinstall/). (The first 3 step) 

---

Please beware that the docker image are only tested on linux and the gui required X11 which I known is not a part of Windows. 

If there is any issues with the container, which are related to the docker images, feel free to report the issues here on this github page. 


## Quick info on Docker
Docker is a program that handler containers. Virtual machine and Containers works allmost the same, but a container is running directly on the host system kernel insteed of a virtualization of the hardware. Therefore is containers faster but they doesn't have access to all resources as a virtual machine but the resources can be shared with the container when need. This description is just a quick overview a more indepth can be found by google or on this [page](https://www.electronicdesign.com/technologies/dev-tools/article/21801722/whats-the-difference-between-containers-and-virtual-machines).  

Docker works on windows, mac and linux. But beware that if you are running this image in docker on windows, will docker create a virtual machine in the background. If you are running docker on ubuntu then you run the command `sudo apt install docker*`. 

## Why use a container ? 
The nice thing about a container is that, it is isolered from the host machine. In this case that is nice because it is easy to move the container to any other machine with docker. You can easily cleanup the dependence for library just by removing the container. Futhermore it is scalable. which means that you can have multiple container running the same image side by side and there but run simulation in parallel insteed. 

## Make file
In order to simplify the commands need are the provided a make file that
handles allmust every thing. 

### Commands 

``` bash
make build
```
This command will build the image.

``` bash
make buildrm
```
This command will remove the build images.

``` bash
make create
```

This will create the container, which access to the X11 server. This will
create a file called `container_id` which contains the id of the created
container. If the file already exists it will not create a new container. 

``` bash
make rm
```
This will remove the container and the file `container_id`.

``` bash
make start
```
This will start the container.

``` bash
make stop
```
This will stop the container.

``` bash
make enter
```
This will attach the current terminal to the container.


