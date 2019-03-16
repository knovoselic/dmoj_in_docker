FROM python:2-stretch

RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        git \
        gcc \
        g++ \
        make \
        python-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        gettext \
        curl \
        python \
        python-pip \
        nginx

RUN set -ex \
 && wget -O- https://deb.nodesource.com/setup_8.x | bash -\
 && apt-get install -y --no-install-recommends nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN set -ex \
 && npm config set unsafe-perm=true \
 && npm install -g sass pleeease-cli

RUN set -ex \
 && mkdir /app \
 && cd /app \
 && git clone https://github.com/DMOJ/site.git
WORKDIR /app/site

RUN set -ex && git submodule update --init --recursive

RUN set -ex \
 && pip install -r requirements.txt \
 && pip install mysqlclient uwsgi websocket-client django-mailgun sendgrid-django

RUN set -ex && npm install qu ws simplesets

COPY uwsgi.ini /app/site/uwsgi.ini

RUN set -ex && rm /etc/nginx/sites-available/default
RUN set -ex && rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/sites-enabled/default

COPY config.js websocket/config.js

COPY local_settings.py dmoj/

RUN set -ex && ./make_style.sh
RUN set -ex && python manage.py collectstatic
RUN set -ex && python manage.py compilemessages
RUN set -ex && python manage.py compilejsi18n

EXPOSE 8000

COPY start.sh /app/site/start.sh
CMD /app/site/start.sh