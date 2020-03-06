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

# Install Azure Agent deps
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

# Because of https://github.com/git-lfs/git-lfs/issues/3571 the git-lfs from apt-get isn't good enough
RUN conda install --yes git git-lfs

# Set git-lfs settings globally (otherwise only refs are cloned)
RUN git config --global --add filter.lfs.required true && \
        git config --global --add filter.lfs.smudge "git-lfs smudge -- %f" && \
        git config --global --add filter.lfs.process "git-lfs filter-process" && \
        git config --global --add filter.lfs.clean "git-lfs clean -- %f"

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
