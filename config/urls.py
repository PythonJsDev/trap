from django.contrib import admin
from django.urls import path, include

from rest_framework.routers import DefaultRouter

from trap_api.person.views import PersonVS
from trap_api.trap.views import TrapVS, TrapHistoricVS

router = DefaultRouter()
router.register("person", PersonVS, basename="person")
router.register("trap", TrapVS, basename="trap")
router.register("trap_historic", TrapHistoricVS, basename="trap_historic")


urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include(router.urls)),
]
