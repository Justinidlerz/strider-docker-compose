FROM strider/strider-docker-slave

ENV STRIDER_HOME=/home

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y wget curl gcc make build-essential
RUN apt-get install -y unzip zip

#USER root

#COPY n /usr/local/n
RUN cd /usr/local && git clone https://github.com/tj/n.git && cd n && make install && n 8.12.0

#COPY .npmrc /home/strider/.npmrc

RUN sudo npm i mirror-config-china -g --unsafe-perm=true --allow-root

#RUN cat /home/strider/.npmrc

RUN sudo npm i npm yarn node-sass chromedriver  strider-docker-slave@1.*.* -g --registry=http://192.168.1.69:4873 --unsafe-perm=true --allow-root

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY jq /usr/bin
COPY ./version_api.sh /usr/bin
RUN chmod -R 777 /usr/binversion_api.sh
RUN ln -s /usr/binversion_api.sh /usr/binversion_api
COPY .ssh /etc/.ssh
COPY ssh_config /etc/ssh/
COPY to-release $STRIDER_HOME/strider/to-release/
ADD ssh_push.sh /home/strider/
ENV GIT_SSH /home/strider/ssh_push.sh
RUN chown -R strider /home/strider

CMD chown -R strider:root $STRIDER_HOME/strider/to-release && \
    supervisord -c /etc/supervisor/supervisord.conf && \
    su strider -c 'strider-docker-slave'

WORKDIR /home/strider/workspace
ENV HOME /home/strider
