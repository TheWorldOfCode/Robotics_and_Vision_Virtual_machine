# Robotics and Comptuer Vision

This is a dockerfile that creates an image which are similar to the virtual
machine that are provide in the course. 

The dockerfile setups Robwork, OpenCV3 and PointCloudLibrary. Furthermore will
it install vim as a editor. All files in the dictory root will be copy to the
root folder in the container. 


This required docker to have it own group, which is shown in the first part on this [page](https://docs.docker.com/engine/install/linux-postinstall/)
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


