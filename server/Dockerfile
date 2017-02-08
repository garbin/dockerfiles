FROM alpine

RUN apk update
RUN apk add openssh supervisor nginx vim bash git build-base shadow nodejs-current zsh curl
RUN apk add php5 php5-fpm php5-mysql php5-pdo_mysql php5-pdo php5-gd
RUN npm i -g pm2
RUN adduser -D -u 1000 -s /bin/zsh -h /srv/node node
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN mkdir -p /var/run/sshd /run/nginx /var/log/supervisor
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d
COPY nginx/index.php /var/www
COPY entrypoint.sh /usr/bin/
USER node
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
USER root
EXPOSE 22 80 443 19999
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
