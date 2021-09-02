FROM ubuntu:18.04


ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Setting timezone 
ENV TZ=Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Opencv 3
COPY ./opencv_install.sh /
RUN sh -e /opencv_install.sh 

# RobWork
RUN apt update && apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:sdurobotics/ur-rtde \
    && apt-get update \
    && apt install -y librtde \
                      librtde-dev \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:sdurobotics/robwork \
    && apt-get update \
    && apt-get install -y libsdurw-all-dev \
                          libsdurws-all-dev \
#                          libsdurwhw-universalrobots-rtde-dev \
                          libsdurwhw-all-dev \
                          libsdurwsim-all-dev \
                          python3-sdurw* \
                          lua-sdurw* \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y libassimp-dev && rm -rf /var/lib/apt/lists/*

# Setup user 
RUN useradd -m user -p "$(openssl passwd -1 user)"
RUN usermod -aG sudo user 


COPY ./root /home/user


# Extra
RUN apt update && apt install -y nano \
                                 vim \
                                 ssh \
                                 openssh* \
                                 sudo \
                                 gdb \
               && rm -rf /var/lib/apt/lists/*



# Setting python
RUN rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python 

RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN mkdir /var/run/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Setting user and the workdir
USER user
WORKDIR /home/user


