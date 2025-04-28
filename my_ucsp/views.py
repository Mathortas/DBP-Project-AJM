from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
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
    
    return render(request, 'editar_perfil.html', {'nombre': nombre, 'email': email})

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('email')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('index')
        else:
            messages.error(request, 'Correo o contraseña incorrectos')
            return redirect('login')
    return render(request, 'my_ucsp/login.html')

def logout_view(request):
    logout(request)
    return redirect('login')

def perfil(request):
    return render(request, 'my_ucsp/perfil.html')