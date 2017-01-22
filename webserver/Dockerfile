FROM mhart/alpine-node:latest

RUN apk update
RUN apk add openssh supervisor nginx vim bash git
RUN npm install -g pod pm2
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN mkdir -p /var/run/sshd /run/nginx
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
COPY entrypoint.sh /usr/bin/

EXPOSE 22 80 443 19999
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
