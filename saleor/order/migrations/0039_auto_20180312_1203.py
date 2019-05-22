# Generated by Django 2.0.2 on 2018-03-12 17:03

from django.conf import settings
from django.db import migrations
import django_prices.models


class Migration(migrations.Migration):

    dependencies = [("order", "0038_auto_20180228_0451")]

    operations = [
        migrations.AlterField(
            model_name="order",
            name="total_gross",
            field=django_prices.models.MoneyField(
                currency=settings.DEFAULT_CURRENCY,
                decimal_places=2,
                default=0,
                max_digits=12,
            ),
        ),
        migrations.AlterField(
            model_name="order",
            name="total_net",
            field=django_prices.models.MoneyField(
                currency=settings.DEFAULT_CURRENCY,
                decimal_places=2,
                default=0,
                max_digits=12,
            ),
        ),
    ]
