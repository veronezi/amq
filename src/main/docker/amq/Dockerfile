FROM openjdk:${openjdk.version}-sid

USER root
RUN apt-get update
RUN apt-get install bash -y

ENV DOCKERIZE_VERSION v0.6.0
RUN wget --quiet https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p /opt
WORKDIR /opt

RUN useradd -r amq
RUN chown amq:amq -R /opt

USER amq

COPY --chown=amq:amq amq.tar.gz .
RUN tar xzf amq.tar.gz && rm amq.tar.gz
RUN mv apache-* amq

EXPOSE 61616

WORKDIR /opt/amq/

COPY --chown=amq:amq start.sh .
RUN chmod u+x start.sh

ENTRYPOINT ["/opt/amq/start.sh"]
CMD ["console"]