from rest_framework import serializers
from .models import Trap, TrapHistoric


class TrapSerializer(serializers.ModelSerializer):
    class Meta:
        model = Trap
        fields = "__all__"


class TrapHistoricSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrapHistoric
        fields = "__all__"
