# Generated by Django 2.2.18 on 2021-02-02 21:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0057_add_label_indexes'),
    ]

    operations = [
        migrations.AddField(
            model_name='accesspolicy',
            name='customized',
            field=models.BooleanField(default=False),
        ),
    ]