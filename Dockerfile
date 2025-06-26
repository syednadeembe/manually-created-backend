FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl wget bash socat iptables ca-certificates \
    openssl gnupg git build-essential cmake pkg-config libjson-c-dev \
    libwebsockets-dev libssl-dev zlib1g-dev

# Install ttyd
RUN git clone https://github.com/tsl0922/ttyd.git /opt/ttyd && \
    cd /opt/ttyd && mkdir build && cd build && \
    cmake .. && make && make install

# Download K3s binary directly
RUN curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/latest/download/k3s && \
    chmod +x /usr/local/bin/k3s

# Set up entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7681 6443

CMD ["/entrypoint.sh"]

