# Digging Into Your App's Container Image Layers for Sneaky Vulnerabilities
## KubeCon EU 2022 - 101 track session playground

### Summary

Mitigating vulnerabilities in container images is, most of the time, a straight-forward task: update the base image, use a newer version of Node or Java, bump the patch version of a project dependency, etc. However, all useful pieces of software are complex and vulnerability scanning tools fall short on explaining why they are flagging some edge-cases.

This session walks you through mitigating critical vulnerabilities in popular container images like Java-based ones, from the obvious to the sneaky ones, and how to leverage layer explorer tools to narrow the search field for the latter. It is meant to be a hands-on session, first we will use Aqua’s [Trivy](https://github.com/aquasecurity/trivy) scanner to analyze an image generated for a Spring Boot app and then wagoodman's [Dive](https://github.com/wagoodman/dive) to explore in which layer we are introducing a version of a library with critical vulnerabilities, while Maven seems to tell us otherwise.

Find the slides ❯ [here](https://static.sched.com/hosted_files/kccnceu2022/fb/KubeCon_EU_2022_Pablo_Galego.pdf) ❮

### Requirements

To get your environment ready for this playground you'll need:

* Docker ➞ [Get Docker](https://docs.docker.com/get-docker/) page.
  * Alternatively, buildah can be used as well ➞ [Installation Instructions](https://github.com/containers/buildah/blob/main/install.md#installing-packaged-versions-of-buildah) README section.

And either...
* Java 16 ➞ Suggestion: [SDKMAN!](https://sdkman.io/) and `sdk install java 16.0.2-tem`.
* Trivy ➞ [Getting started - Installation](https://aquasecurity.github.io/trivy/v0.25.3/getting-started/installation/) page. Make sure to 
  install the `0.25.3` version because more recent ones includes a nice enhancement to the table output that will give us a spoiler.
* Dive ➞ [Installation](https://github.com/wagoodman/dive#installation) README section.
* Run `source setup.sh` to unpack the vulnerabilities database* and set the required variables to build the container images and run the 
  scans.

...or install [Nix](https://nixos.org/download.html) and get a ready to use shell environment running `nix-shell` on the root folder.

*Trivy gets its vulnerability information from a database that is downloaded every now and then when you run a scan. This means that, as 
time passes and more vulnerabilities are included in it, new vulnerabilities will be reported for this project. To keep it reproducible, 
we'll use the database at `/utils` downloaded from the [trivy-db packages page](https://github.com/aquasecurity/trivy-db/pkgs/container/trivy-db/21574977).

### Quick command reference

Build the _builder_ container image
```shell
docker build container-library/java-16/maven
```

Build the demo-service container image
```shell
cd demo-service && ./mvnw install && cd -
```

Run a Trivy scan
```shell
trivy image --severity CRITICAL --ignore-unfixed --format json demo-service-boot:0.1.0-SNAPSHOT
```

Run Dive
```shell
dive demo-service-boot:0.1.0-SNAPSHOT
```
