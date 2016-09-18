#!/bin/bash
COOOKIT_PRJHOME=/srv/coookit-env

echo "Activating env"
source /srv/coookit-env/bin/activate root 

# Prepare django app
cd $COOOKIT_PRJHOME
python manage.py makemigrations coookit;
python manage.py migrate ;
python manage.py collectstatic --noinput;
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'pass')" | $COOOKIT_PRJHOME/bin/python $COOOKIT_PRJHOME/manage.py shell

echo "Starting supervisord"
/srv/coookit-env/bin/supervisord -c /srv/coookit-env/etc/supervisord.conf

