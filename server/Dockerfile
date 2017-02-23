FROM ubuntu:latest

COPY sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential openssh-server supervisor nginx git-core zsh curl
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs php php-fpm
#php-mysql php-pdo_mysql php-pdo_pgsql php-pdo php-gd php-json php-mcrypt php-openssl
RUN npm i -g pm2
RUN useradd -d /srv/node -m -s /bin/zsh -u 1000 node
#RUN adduser -D -u 1000 -s /bin/zsh -h /srv/node node
#RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
#RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN mkdir -p /var/run/sshd /run/nginx /var/log/supervisor
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d
COPY nginx/index.php /var/www
COPY entrypoint.sh /usr/bin/
USER node
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
USER root
EXPOSE 22 80 443 5000 19999
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
