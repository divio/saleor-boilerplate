# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-12-06 11:06
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [("order", "0022_auto_20171205_0428")]

    operations = [
        migrations.AlterField(
            model_name="deliverygroup",
            name="status",
            field=models.CharField(
                choices=[
                    ("new", "Processing"),
                    ("cancelled", "Cancelled"),
                    ("shipped", "Shipped"),
                    ("payment-pending", "Payment pending"),
                    ("fully-paid", "Fully paid"),
                ],
                default="new",
                max_length=32,
                verbose_name="shipment status",
            ),
        ),
        migrations.AlterField(
            model_name="orderline",
            name="delivery_group",
            field=models.ForeignKey(
                editable=False,
                on_delete=django.db.models.deletion.CASCADE,
                related_name="lines",
                to="order.DeliveryGroup",
                verbose_name="shipment group",
            ),
        ),
    ]
