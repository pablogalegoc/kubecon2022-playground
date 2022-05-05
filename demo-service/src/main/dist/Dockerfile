FROM local/maven:3.8.5-java17 as builder

ARG MVN_DP_MIRROR_URL
ARG MVN_DP_USERNAME
ARG MVN_DP_TOKEN
ARG JAR_FILE

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN tmp_file=$(mktemp)  \
    && wget --progress=dot:giga -O "${tmp_file}" https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz \
    && tar zxf "${tmp_file}" -C "/tmp" linux-amd64/helm

WORKDIR /
COPY target/dist/get-plugins.sh .
RUN chmod +x ./get-plugins.sh && PLUGINS_TARGET_DIR=/tmp/plugins ./get-plugins.sh

COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:16.0.1-slim-buster

ARG AUTH
ARG EMAIL
ARG ds_uid=1000
ARG ds_gid=1000

RUN groupadd ds --gid ${ds_gid} && \
  useradd --uid ${ds_uid} --gid ${ds_gid} -m -s /bin/bash ds

# hadolint ignore=DL3008,DL3059
RUN mkdir /plugins && chown ds:ds /plugins

# hadolint ignore=DL3059
RUN mkdir /app && chown ds:ds /app

USER ds

WORKDIR /app

COPY --from=builder /tmp/linux-amd64/helm /usr/local/bin/helm
COPY --from=builder dependencies/ /app/
COPY --from=builder spring-boot-loader/ /app/
COPY --from=builder snapshot-dependencies/ /app/
COPY --from=builder application/ /app/
COPY --from=builder /tmp/plugins/ /plugins/

EXPOSE 8080

ENTRYPOINT [ "java", "org.springframework.boot.loader.JarLauncher" ]