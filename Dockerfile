FROM denvazh/gatling:3.0.3 AS base

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

RUN mkdir sbt-project
RUN mkdir -p sbt-project/logs
WORKDIR ${GATLING_DIR}/sbt-project


FROM base as development
# docker - How to remove entrypoint from parent Image on Dockerfile - Stack Overflow
# https://stackoverflow.com/questions/40122152/how-to-remove-entrypoint-from-parent-image-on-dockerfile
ENTRYPOINT []


FROM base as self-contained
# source transfer
COPY sbt-project ./

# compile
RUN sbt compile

ENTRYPOINT [ "sbt" ]
