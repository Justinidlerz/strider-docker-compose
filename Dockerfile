FROM node:8.11.3

MAINTAINER Idler Zhu <zqc.sunny@aliyun.com>

EXPOSE 3000

ENV STRIDER_VERSION=v1.10.0
ENV STRIDER_GIT_SRC=https://github.com/Strider-CD/strider.git
ENV STRIDER_HOME=/data
ENV STRIDER_SRC=/opt/strider
ENV NODE_ENV=production
ENV MONGO_HOST=strider-mongodb

RUN useradd --comment "Strider CD" --home ${STRIDER_HOME} strider && mkdir -p ${STRIDER_HOME} && chown strider:strider ${STRIDER_HOME}

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y gcc make build-essential

VOLUME [ "$STRIDER_HOME" ]
RUN mkdir -p $STRIDER_SRC && cd $STRIDER_SRC && \
    # Checkout into $STRIDER_SRC
    git clone $STRIDER_GIT_SRC . && \
    [ "$STRIDER_VERSION" != 'master' ] && git checkout tags/$STRIDER_VERSION || git checkout master && \
    rm -rf .git && \
    # Install NPM deps
    npm install --registry=https://registry.npm.taobao.org && \
    # FIX: https://github.com/Strider-CD/strider/pull/1056
    npm install morgan@1.5.0 --registry=https://registry.npm.taobao.org && \
    # Create link to strider home dir so the modules can be used as a cache
    mv node_modules node_modules.cache && ln -s ${STRIDER_HOME}/node_modules node_modules && \
    # Allow strider user to update .restart file
    chown strider:strider ${STRIDER_SRC}/.restart && \
    # Cleanup Upstream cruft
    rm -rf /tmp/*

ENV PATH ${STRIDER_SRC}/bin:$PATH

COPY entry.sh /
USER strider
ENTRYPOINT ["/entry.sh"]
CMD ["strider"]
