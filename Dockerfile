FROM debian:bullseye-slim
RUN mkdir -p /env/ssh \
    /env/ssh/sshd_config.d \
    /run/sshd \
    /root/.ssh && \
    apt-get update && \
    apt-get install -y --no-install-recommends openssh-server \
    fakechroot \
    debootstrap \
    git \
    tmux && \
    rm -rf /var/lib/apt/lists/* \
    /var/cache/apt/archives/* && \
    echo "Include /env/ssh/sshd_config.d/*.conf" >> /etc/ssh/sshd_config && \
    echo "#PermitRootLogin prohibit-password" > /env/ssh/sshd_config.d/custom_sshd.conf && \
    echo "PermitRootLogin yes" >> /env/ssh/sshd_config.d/custom_sshd.conf && \
    touch /env/ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    touch /env/ssh/authorized_keys && \
    chmod 600 /env/ssh/authorized_keys && \
    ln -s /env/ssh/authorized_keys /root/.ssh/authorized_keys
COPY start.sh /
EXPOSE 22
CMD ["sh", "/start.sh"]