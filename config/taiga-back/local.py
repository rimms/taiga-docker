from .common import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'taiga',
        'USER': 'taiga',
        'PASSWORD': 'password',
        'HOST': 'taiga-db',
        'PORT': '5432',
    }
}

MEDIA_URL = "http://localhost/media/"
STATIC_URL = "http://localhost/static/"
SITES["front"]["scheme"] = "http"
SITES["front"]["domain"] = "localhost"

SECRET_KEY = "theveryultratopsecretkey"

DEBUG = False
PUBLIC_REGISTER_ENABLED = False

DEFAULT_FROM_EMAIL = "no-reply@localhost"
SERVER_EMAIL = DEFAULT_FROM_EMAIL
