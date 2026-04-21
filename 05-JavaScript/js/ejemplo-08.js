document.getElementById('mensaje').textContent = '¡Hola JavaScript!'; // Cambia el contenido de texto

// Añado un nuevo elemento dentro del div
const nuevoElemento = document.createElement('div'); // Declaro un elemento DIV
nuevoElemento.className = "alert alert-danger"; // Aplico clases de Bootstrap
nuevoElemento.textContent = 'Vamos a seguir aprendiendo'; // Defino el contenido de texto del DIV
document.getElementById('mensaje').appendChild(nuevoElemento); // Añado al final del DIV #mensaje

