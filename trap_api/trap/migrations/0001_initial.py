# Generated by Django 4.2.3 on 2023-07-29 17:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('person', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Trap',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('category', models.CharField(choices=[('L', 'Loup'), ('C', 'Crocodile'), ('P', 'Poule')], default='L', max_length=1)),
                ('trap_number', models.CharField(max_length=50)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('date_end', models.DateTimeField(blank=True, null=True)),
                ('trapper', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='person', to='person.person')),
            ],
        ),
        migrations.CreateModel(
            name='TrapHistoric',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_updated', models.DateTimeField(auto_now_add=True)),
                ('species', models.CharField(blank=True, max_length=500)),
                ('trap', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='trap', to='trap.trap')),
            ],
        ),
    ]