FROM jupyter/minimal-notebook

# Switch from joyvan to root
USER root

# This prevents an error
ENV XDG_RUNTIME_DIR=""

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Make sure that we can download libicu55
RUN apt-get update && \
        apt-get install -y software-properties-common && \
        add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" && \
        apt-get update

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        libcurl4 \
        libicu55 \
        libunwind8 \
        netcat

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
