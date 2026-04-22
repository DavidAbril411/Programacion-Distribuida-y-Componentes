function crearElemento(texto) {
    let li = document.createElement('li');
    let span = document.createElement('span');
    span.textContent = texto;
    li.appendChild(span);

    let botonEditar = document.createElement('button');
    botonEditar.textContent = 'Editar';
    botonEditar.addEventListener('click', function() {
        let nuevoTexto = prompt("Ingrese el contenido", span.textContent);
        if (nuevoTexto !== null && nuevoTexto.trim() !== "") {
            span.textContent = nuevoTexto;
        }
    });

    let botonEliminar = document.createElement('button');
    botonEliminar.textContent = 'Eliminar';
    botonEliminar.addEventListener('click', function() {
        li.remove();
    });
    li.className = "d-flex gap-2 align-items-end"
    span.className = "flex-fill"
    botonEditar.className = "btn btn-outline-secondary";
    botonEliminar.className = "btn btn-outline-danger"
    li.appendChild(botonEditar);
    li.appendChild(botonEliminar);

    return li;
}
function agregarElemento(event) {
    event.preventDefault();
    let valor = document.getElementById('element').value;
    document.getElementById("list").appendChild(crearElemento(valor));
}