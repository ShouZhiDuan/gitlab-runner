#关于Dockerfile中的变量操作问题
#举例 "Hello, world!"，如果我们需要对当前文本进行变量动态替换，可以看成是："Hello, ${param}\!"
#${param}可以定义成ARG或者ENV。
#注意ENTRYPOINT的数组形式和外壳形式。
#1、数组形式
#像这种数组形式ENTRYPOINT ["java","-Dserver.port=${PORT}","-jar","${RUN_JAR}"]中的${RUN_JAR}是无法杯替换的。
#2、外壳形式
#ENTRYPOINT java "-Dserver.port=${PORT}" -jar "/${RUN_JAR}"中的${RUN_JAR}是可以被替换的。

#构建SpringBoot镜像
FROM java:8
ENV PORT 5000
ARG JAR_NAME=demo.jar
ENV RUN_JAR=${JAR_NAME}

#调试参数
#RUN echo "666666JAR_NAME=>${JAR_NAME}" ${JAR_NAME}
#RUN echo "666666RUN_JAR=>${RUN_JAR}" ${RUN_JAR}

VOLUME /tmp
COPY  ./target/demo.jar ${JAR_NAME}
#EXPOSE $PORT
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dserver.port=${PORT}","-jar","/${JAR_NAME}"]
#ENTRYPOINT ["java","-Dserver.port=${PORT}","-jar","${RUN_JAR}"]
#to see https://codingdict.com/questions/52925
ENTRYPOINT java "-Dserver.port=${PORT}" -jar "/${RUN_JAR}"

