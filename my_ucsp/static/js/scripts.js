function logout() {
    if (confirm("¿Seguro que quieres cerrar sesión?")) {
        window.location.href = "login.html";
    }
}

// Función para navegar (simulación)
function navegar(pagina) {
    window.location.href = pagina;
}