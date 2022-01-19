# Generated by Django 3.2.9 on 2021-11-25 11:20

import django.contrib.auth.models
from django.db import migrations, models
import django.db.models.deletion
import django_lifecycle.mixins
import pulpcore.app.models.access_policy


class Migration(migrations.Migration):

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        ('core', '0079_rename_permissions_assignment_accesspolicy_creation_hooks'),
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
            ],
            options={
                'proxy': True,
                'indexes': [],
                'constraints': [],
            },
            bases=(django_lifecycle.mixins.LifecycleModelMixin, 'auth.group', pulpcore.app.models.access_policy.AutoAddObjPermsMixin),
            managers=[
                ('objects', django.contrib.auth.models.GroupManager()),
            ],
        ),
        migrations.AlterField(
            model_name='grouprole',
            name='group',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='object_roles', to='core.group'),
        ),
    ]