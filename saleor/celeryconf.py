import os

from celery import Celery
from django.conf import settings

from .extensions import discover_plugins_modules

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "saleor.settings")

app = Celery("saleor")

CELERY_TIMEZONE = "UTC"

# Divio Cloud custom changes, as we use Celery <4
# app.config_from_object("django.conf:settings", namespace="CELERY")
# app.autodiscover_tasks()
app.config_from_object("django.conf:settings")
app.autodiscover_tasks(settings.INSTALLED_APPS)
app.autodiscover_tasks(lambda: discover_plugins_modules(settings.PLUGINS))
