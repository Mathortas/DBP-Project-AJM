from django.shortcuts import render, redirect
from django.contrib.auth import logout,authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages

def index(request):
    return render(request, "my_ucsp/index.html")

def calendario(request):
    return render(request, 'my_ucsp/calendario.html')

def curso_detalle(request, curso_id):
    # Datos de ejemplo (luego reemplazar con consultas a la base de datos)
    curso = {
        'nombre': 'Cálculo 1',
        'profesor': 'Janeth Chirinos',
    }
    return render(request, 'my_ucsp/curso-detalle.html', {'curso': curso})

def editar_perfil(request):
    if request.method == 'POST':
        # Obtener los datos del formulario
        nombre = request.POST.get('nombre')
        email = request.POST.get('email')
        
        # Guardar los datos en la sesión en lugar de en la base de datos
        request.session['nombre'] = nombre
        request.session['email'] = email

        # Puedes redirigir a una página de perfil o mantener el flujo de trabajo que desees
        return redirect('perfil')  # o donde quieras redirigir después

    # Mostrar el formulario con los datos actuales (ya sea de la base de datos o de la sesión)
    nombre = request.session.get('nombre', request.user.first_name)
    email = request.session.get('email', request.user.email)
    
    return render(request, 'editar-perfil.html', {'nombre': nombre, 'email': email})

def login_view(request):
    if request.method == "POST":
        email = request.POST['email']
        password = request.POST['password']

        # Crear un usuario ficticio solo para pruebas
        if email == "test@example.com" and password == "password123":
            # Si el email y la contraseña coinciden con el usuario de prueba
            try:
                user = User.objects.get(email=email)  # Intentar obtener el usuario por email
            except User.DoesNotExist:
                # Crear un usuario ficticio si no existe en la base de datos
                user = User.objects.create_user(username='testuser', email=email, password=password)

            # Autenticar al usuario
            user = authenticate(request, username=user.username, password=password)
            if user is not None:
                login(request, user)
                return redirect('index')  # O la URL a la que quieres redirigir después del login
            else:
                messages.error(request, 'Contraseña incorrecta')
        else:
            messages.error(request, 'Email o contraseña incorrectos')

    return render(request, 'my_ucsp/login.html')

def logout_view(request):
    logout(request)
    return redirect('login')

def perfil(request):
    return render(request, 'my_ucsp/perfil.html')