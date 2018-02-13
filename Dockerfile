FROM ubuntu:16.04

RUN apt-get update

# Install essential packages
RUN apt-get install -y build-essential binutils-doc autoconf flex bison libjpeg-dev
RUN apt-get install -y libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev
RUN apt-get install -y automake libtool libffi-dev curl git tmux gettext vim
RUN apt-get install -y nginx

# Install Python 3
RUN apt-get install -y python3 python3-pip python-dev python3-dev python-pip
RUN apt-get install -y libxml2-dev libxslt-dev
RUN apt-get install -y libssl-dev libffi-dev

# Switch to Python 3 by dafault
RUN rm /usr/bin/python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir -p /opt/taiga
WORKDIR /opt/taiga

# Create the logs directory
RUN mkdir -p logs

# Setup taiga-back
RUN git clone https://github.com/taigaio/taiga-back.git taiga-back && \
    cd taiga-back && git checkout stable && \
    pip install -r requirements.txt

# Setup taiga-front-dist
RUN git clone https://github.com/taigaio/taiga-front-dist.git taiga-front-dist && \
    cd taiga-front-dist && git checkout stable

# Remove the default nginx config file to avoid collision with Taiga
RUN rm /etc/nginx/sites-enabled/default

COPY docker-entrypoint.sh /opt/taiga/docker-entrypoint.sh
ENTRYPOINT ["/opt/taiga/docker-entrypoint.sh"]

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
