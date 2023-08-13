from django.db import models


class Trap(models.Model):
    class Categories(models.TextChoices):
        LOUP = "L", "Loup"
        CROCODILE = "C", "Crocodile"
        POULE = "P", "Poule"

    category = models.CharField(
        max_length=1, choices=Categories.choices, default=Categories.LOUP
    )
    trap_number = models.CharField(max_length=50)
    trapper = models.ForeignKey(
        "person.Person", on_delete=models.CASCADE, related_name="person"
    )
    date_created = models.DateTimeField(auto_now_add=True)
    date_end = models.DateTimeField(blank=True, null=True)

    def __str__(self) -> str:
        return f"Trap N° : {self.trap_number}"


class TrapHistoric(models.Model):
    trap = models.ForeignKey("trap.Trap", on_delete=models.CASCADE, related_name="trap")
    date_updated = models.DateTimeField(auto_now_add=True)
    species = models.CharField(max_length=500, blank=True)

    def historic_of_a_trap(self):
        dates_spacies_list = []
        for trap in self:
            dates_spacies_list.append([trap.date_updated, trap.species])
        return trap.id, dates_spacies_list

    def __str__(self) -> str:
        return f"Trap id : {self.trap}"
