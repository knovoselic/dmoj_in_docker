#!/bin/sh

python manage.py migrate
uwsgi -d --ini uwsgi.ini
service nginx start
node websocket/daemon.js&
python manage.py runbridged