FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server \
    sudo \
    curl \
    wget \
    ca-certificates \
    nano \
    vim \
    iproute2 \
    iputils-ping \
    net-tools \
    procps \
    bash && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd

RUN sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

COPY start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]
