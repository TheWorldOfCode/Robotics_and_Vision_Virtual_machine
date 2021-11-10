FROM ros:melodic-ros-base


ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Setting timezone 
ENV TZ=Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Opencv 3
COPY ./opencv_install.sh /
RUN sh -e /opencv_install.sh 

RUN apt update 

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

RUN apt update
RUN apt install iputils-ping

RUN apt-get install software-properties-common -y # used to install rtde

# packages needed to run ROS melodic with python2.7
RUN apt install python2.7
RUN apt-get install -y python-pip 
RUN apt-get install -y python3-pip 
RUN pip install catkin_pkg
RUN pip install rospkg
RUN pip install netifaces
RUN pip install rosdep
RUN pip install defusedxml
RUN pip install scipy
RUN pip install --upgrade pip
RUN rosdep update 

RUN apt-get install libopencv-dev -y
RUN apt-get update
RUN apt-get install ros-melodic-cv-bridge -y
RUN apt-get install ros-melodic-image-transport-plugins -y
RUN apt-get install ros-melodic-openni2-launch   -y


RUN add-apt-repository ppa:sdurobotics/ur-rtde
RUN apt-get update
RUN apt install librtde librtde-dev
RUN apt-get update
RUN pip install ur-rtde

# ur-sim prereq
#RUN apt-get install openjdk-8-jdk -y
#RUN update-java-alternatives -s java-1.8.0-openjdk-amd64 
#RUN apt-get install libcurl4
#RUN rosdep init 

# install coppelia sim Edu entities onlyhttps://esolangs.org/wiki/Piet
RUN cd /home/user/ && \
		wget https://www.coppeliarobotics.com/files/CoppeliaSim_Edu_V4_2_0_Ubuntu18_04.tar.xz && \
		tar -xf CoppeliaSim_Edu_V4_2_0_Ubuntu18_04.tar.xz && \
		rm CoppeliaSim_Edu_V4_2_0_Ubuntu18_04.tar.xz

# install ur-sim sim

#RUN cd /home/user/
#RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
#RUN export PATH=$PATH:$JAVA_HOME

#RUN wget https://s3-eu-west-1.amazonaws.com/ur-support-site/133393/URSim_Linux-5.11.5.1010327.tar.gz
#RUN tar xvzf URSim_Linux-5.11.5.1010327.tar.gz 
#RUN sed -i 's/libcurl3//g' ~/ursim-5.11.5.1010327/install.sh
#RUN cd /home/user/
#RUN ./install.sh 

# Setting user and the workdir
USER user
RUN mkdir /home/user/workspace
RUN mkdir /home/user/workspace/src
WORKDIR /home/user/workspace






