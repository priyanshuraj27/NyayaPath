# urls.py in your Django app
from django.urls import path
from .views import signup

urlpatterns = [
    path('signup/', signup, name='signup'),
]
