#自建gitlab-runner镜像，集成Docker、DockerCompose、JDK、Maven
FROM gitlab/gitlab-runner:v11.0.2

MAINTAINER duanshouzhi <dszazhy1314@163.com>

#更新apt-get
RUN echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse' > /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
    echo 'deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get clean

#安装Docker
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update -y && \
    apt-get install -y docker-ce
#添加Docker阿里云镜像加速器
COPY daemon.json /etc/docker/daemon.json

#安装DockerCompose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

#安装JDK
RUN mkdir -p /usr/local/java
WORKDIR /usr/local/java
COPY jdk-8u261-linux-x64.tar.gz /usr/local/java
RUN tar -zxvf jdk-8u261-linux-x64.tar.gz  &&  rm -fr jdk-8u261-linux-x64.tar.gz

#安装MAVEN
RUN mkdir -p /usr/local/maven
WORKDIR /usr/local/maven
#COPY apache-maven-3.6.2-bin.tar.gz /usr/local/maven
#RUN tar -zxvf apache-maven-3.6.2-bin.tar.gz  &&  rm -fr apache-maven-3.6.2-bin.tar.gz
RUN wget http://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xzvf apache-maven-3.3.9-bin.tar.gz
RUN cp -R apache-maven-3.3.9 /usr/local/bin
RUN rm -rf apache-maven-3.3.9-bin.tar.gz
RUN export PATH=apache-maven-3.3.9/bin:$PATH
RUN export PATH=/usr/local/bin/apache-maven-3.3.9/bin:$PATH
#建立软连接，防止容器中gitlab-runner用户找不到mvn命令，mvn Command not found
RUN ln -s /usr/local/bin/apache-maven-3.3.9/bin/mvn /usr/local/bin/mvn
#RUN ls -l /usr/local/bin
RUN echo $PATH

#添加环境变量
ENV JAVA_HOME /usr/local/java/jdk1.8.0_261
ENV MAVEN_HOME /usr/local/maven/apache-maven-3.6.2
ENV PATH $PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin

#切换到根目录
WORKDIR /