FROM bitnami/java:17.0.2-debian-10-r57

ARG MAVEN_VERSION=3.8.5

RUN --mount=source=install-maven.sh,target=/provision/install-maven.sh \
    DEST_DIR=/opt/maven MAVEN_VERSION=$MAVEN_VERSION \
    /provision/install-maven.sh
ENV PATH=/opt/maven/bin:$PATH
