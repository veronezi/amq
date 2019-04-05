ARG DOCKERIZE_VERSION

FROM veronezi/dockerize:${DOCKERIZE_VERSION} AS dockerz
FROM openjdk:${openjdk.version}-sid

USER root
RUN apt-get update
RUN apt-get install bash -y

COPY --from=dockerz /usr/local/bin/dockerize /usr/local/bin/

RUN mkdir -p /opt/amq
WORKDIR /opt

RUN useradd -r amq
RUN chown amq:amq -R /opt

USER amq

COPY --chown=amq:amq amq.tar.gz .
RUN tar xzf amq.tar.gz && rm amq.tar.gz
RUN mv apache-* amq && cd amq && mv apache-* ..
RUN rm -Rf amq
RUN mv apache-* amq

EXPOSE 61616

WORKDIR /opt

COPY --chown=amq:amq start.sh .
RUN chmod u+x start.sh

ENV AMQ_USER admin
ENV AMQ_PASSWORD admin

ENTRYPOINT ["/opt/start.sh"]
CMD ["run"]