FROM node:alpine

RUN apk update
RUN apk add openssh supervisor nginx vim bash git build-base
RUN apk add php5 php5-fpm php5-mysql php5-pdo_mysql php5-pdo php5-gd
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN mkdir -p /var/run/sshd /run/nginx /srv/pod /var/log/supervisor
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN ln -s /usr/local/bin/npm /usr/bin/npm
RUN ln -s /usr/local/bin/node /usr/bin/node
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d
COPY nginx/index.php /var/www
COPY entrypoint.sh /usr/bin/

EXPOSE 22 80 443 19999
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
