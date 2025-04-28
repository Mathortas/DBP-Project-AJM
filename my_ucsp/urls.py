from django.urls import path
from . import views  # Para vincular las vistas con las rutas

urlpatterns = [
    
    path('', views.index, name='index'), 

    path('login/',    views.login_view,  name='login'),
    
    path('logout/',   views.logout_view, name='logout'),
    
    path('calendario/', views.calendario, name='calendario'),

    path('curso/<int:curso_id>/', views.curso_detalle, name='curso-detalle'),

    path('editar-perfil/', views.editar_perfil, name='editar-perfil'),
    
    path('perfil/', views.perfil, name='perfil'),
]
