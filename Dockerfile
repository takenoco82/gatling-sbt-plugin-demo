FROM denvazh/gatling:3.0.3

ARG GATLING_DIR=/opt/gatling
WORKDIR ${GATLING_DIR}

# change timezone
RUN apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

# install sbt
ENV SBT_VERSION=1.2.8
RUN wget https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz \
    && tar xfz sbt-${SBT_VERSION}.tgz -C /usr/local \
    && ln -s /usr/local/sbt/bin/* /usr/local/bin/ \
    && sbt sbtVersion \
    && rm -f sbt-${SBT_VERSION}.tgz

# source transfer
RUN mkdir gatling-sbt-plugin-demo
WORKDIR ${GATLING_DIR}/gatling-sbt-plugin-demo
COPY project ./project/
COPY src ./src/
COPY build.sbt ./

# compile
RUN sbt compile

ENTRYPOINT [ "sbt" ]
