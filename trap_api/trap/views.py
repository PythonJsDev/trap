from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.exceptions import ValidationError


from .models import Trap, TrapHistoric
from .serializers import TrapSerializer, TrapHistoricSerializer


class TrapVS(viewsets.ModelViewSet):
    queryset = Trap.objects.all()
    serializer_class = TrapSerializer

    def partial_update(self, request, *args, **kwargs):
        trap_object = self.get_object()
        if not trap_object.date_end:
            TrapHistoric.objects.create(
                species=request.data.get("species"), trap_id=trap_object.id
            )
            trap_object.save()
            return Response(
                {"message": f"le piège {trap_object.id} est mis à jour."},
                status=status.HTTP_200_OK,
            )
        return Response(
            {"message": f"le piège {trap_object.id} n'est plus en service."},
            status=status.HTTP_200_OK,
        )


class TrapHistoricVS(viewsets.ModelViewSet):
    queryset = TrapHistoric.objects.all()
    serializer_class = TrapHistoricSerializer

    def list(self, request):
        return Response(
            {"message": "URL non autorisée."},
            status=status.HTTP_405_METHOD_NOT_ALLOWED,
        )

    def retrieve(self, request, *args, **kwargs):
        trap = TrapHistoric.objects.filter(trap_id=self.kwargs["pk"])
        if trap:
            trap_id, dates_species_list = TrapHistoric.historic_of_a_trap(trap)

            return Response(
                {f"{trap_id}": dates_species_list},
                status=status.HTTP_200_OK,
            )
        raise ValidationError(
            {"message": f"Le piège {self.kwargs['pk']} n'existe pas."}
        )
