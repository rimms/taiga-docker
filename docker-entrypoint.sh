#!/bin/bash -x

TAIGA_BACK_HOME="/opt/taiga/taiga-back"
cd "${TAIGA_BACK_HOME}"

# Wait for the database startup
sleep 5s

# Initialize
if [ ! -d "${TAIGA_BACK_HOME}/static" ]; then
    python manage.py migrate --noinput
    python manage.py loaddata initial_user
    python manage.py loaddata initial_project_templates
    python manage.py compilemessages
    python manage.py collectstatic --noinput
fi

# Start nginx service
service nginx restart

# Start Taiga backend Django server
exec "$@"
