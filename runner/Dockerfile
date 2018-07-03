FROM strider/strider-docker-slave

ENV STRIDER_HOME=/home

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y wget curl gcc make build-essential

VOLUME [ "$STRIDER_HOME" ]

RUN git clone https://github.com/tj/n.git && cd n && make install && \
    n 8.11.3 && npm install -g strider-docker-slave@1.*.*

RUN chown -R strider:strider /home

CMD supervisord -c /etc/supervisor/supervisord.conf && su strider -c 'strider-docker-slave'

WORKDIR /home/strider/workspace
ENV HOME /home/strider
