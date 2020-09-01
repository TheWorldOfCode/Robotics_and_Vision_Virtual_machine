FROM ubuntu:18.04


ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Setting timezone 
ENV TZ=Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Opencv 3
COPY ./opencv_install.sh /
RUN sh -e /opencv_install.sh 

# PointCloudLibrary
RUN apt update && apt install -y libpcl-dev && rm -rf /var/lib/apt/lists/*

# RobWork
RUN apt update && apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates && rm -rf /var/lib/apt/lists/*
RUN add-apt-repository ppa:sdurobotics/robwork \
    && apt-get update \
    && apt-get install -y libsdurw-all-dev \
                          libsdurws-all-dev \
                          libsdurwhw-all-dev \
                          libsdurwsim-all-dev \
    && rm -rf /var/lib/apt/lists/*

COPY ./root /root 


# Extra
RUN apt update && apt install -y vim && rm -rf /var/lib/apt/lists/*
