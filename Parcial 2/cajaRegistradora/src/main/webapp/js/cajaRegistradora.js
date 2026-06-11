const jCajaRegistradora = {
    // Inicializar listeners
    init: () => {
        const form = document.getElementById("iAgrProdForm");
        if (form) {
            form.addEventListener("submit", jCajaRegistradora.agregar);
        }

        // Intercept F5
        window.addEventListener("keydown", (event) => {
            if (event.key === "F5" || event.keyCode === 116) {
                event.preventDefault();
                jCajaRegistradora.reconstruir();
            }
        });
    },

    // Agregar producto vía formulario (Estilo A: URLSearchParams)
    agregar: async (event) => {
        try {
            event.preventDefault();
            jUtils.showLoading();

            const form = event.target;
            const data = new FormData(form);

            const response = await fetch("agregar", {
                method: "POST",
                body: new URLSearchParams(data),
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                }
            });

            if (!response.ok) {
                const errorMsg = await response.text();
                throw new Error(errorMsg);
            }

            // Recibir la fila HTML
            const filaHtml = await response.text();
            
            // Insertar fila dinámicamente
            const tbody = document.getElementById("tablaProductosCuerpo");
            tbody.insertAdjacentHTML("beforeend", filaHtml);

            // Actualizar total y panel
            jCajaRegistradora.actualizarTotal();
            jCajaRegistradora.actualizarUltimoProducto();

            form.reset();
        }
        catch (e) {
            jCajaRegistradora.mostrarError(e.message);
            console.error(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    // Agregar producto vía Catálogo (Estilo B: manual query string in body)
    agregarPorSeleccion: async (codBarra) => {
        if (!codBarra) return;

        try {
            jUtils.showLoading();

            const response = await fetch("agregar", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `cod_barra=${encodeURIComponent(codBarra)}`
            });

            if (!response.ok) {
                const errorMsg = await response.text();
                throw new Error(errorMsg);
            }

            // Recibir la fila HTML
            const filaHtml = await response.text();
            
            // Insertar fila
            const tbody = document.getElementById("tablaProductosCuerpo");
            tbody.insertAdjacentHTML("beforeend", filaHtml);

            // Actualizar total y panel
            jCajaRegistradora.actualizarTotal();
            jCajaRegistradora.actualizarUltimoProducto();

            // Resetear el select
            document.getElementById("selectProductoRapido").value = "";
        }
        catch (e) {
            jCajaRegistradora.mostrarError(e.message);
            console.error(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    // Eliminar producto (Estilo B: manual query string in body)
    eliminar: async (nroDetalle) => {
        try {
            jUtils.showLoading();

            const response = await fetch("eliminar", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `nro_detalle=${encodeURIComponent(nroDetalle)}`
            });

            if (!response.ok) {
                const errorMsg = await response.text();
                throw new Error(errorMsg);
            }

            // Si es exitoso, remover la fila de la tabla
            const fila = document.querySelector(`tr[data-nro-detalle="${nroDetalle}"]`);
            if (fila) {
                fila.remove();
            }

            // Actualizar total y panel
            jCajaRegistradora.actualizarTotal();
            jCajaRegistradora.actualizarUltimoProducto();
        }
        catch (e) {
            jCajaRegistradora.mostrarError(e.message);
            console.error(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    // Reconstruir la tabla por AJAX (F5)
    reconstruir: async () => {
        try {
            jUtils.showLoading();

            const response = await fetch("listar", {
                method: "POST"
            });

            if (!response.ok) {
                const errorMsg = await response.text();
                throw new Error(errorMsg);
            }

            const tablaHtml = await response.text();
            
            // Reemplazar cuerpo de tabla
            document.getElementById("tablaProductosCuerpo").innerHTML = tablaHtml;

            // Actualizar total y panel
            jCajaRegistradora.actualizarTotal();
            jCajaRegistradora.actualizarUltimoProducto();
        }
        catch (e) {
            jCajaRegistradora.mostrarError(e.message);
            console.error(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    // Sumar el precio de todas las filas y actualizar total
    actualizarTotal: () => {
        const filas = document.querySelectorAll("#tablaProductosCuerpo tr");
        let total = 0.0;
        filas.forEach(fila => {
            const precio = parseFloat(fila.getAttribute("data-precio"));
            if (!isNaN(precio)) {
                total += precio;
            }
        });
        document.getElementById("totalCarrito").textContent = `$${total.toFixed(2)}`;
    },

    // Buscar la última fila y actualizar el panel de la derecha
    actualizarUltimoProducto: () => {
        const filas = document.querySelectorAll("#tablaProductosCuerpo tr");
        if (filas.length > 0) {
            const ultimaFila = filas[filas.length - 1];
            const nombre = ultimaFila.getAttribute("data-nombre");
            const codigo = ultimaFila.getAttribute("data-codigo");
            const precio = parseFloat(ultimaFila.getAttribute("data-precio"));

            document.getElementById("ultimoPrecio").textContent = `$${precio.toFixed(2)}`;
            document.getElementById("ultimoNombre").textContent = nombre;
            document.getElementById("ultimoCodigo").textContent = codigo;
        } else {
            document.getElementById("ultimoPrecio").textContent = "$0.00";
            document.getElementById("ultimoNombre").textContent = "Ningún producto seleccionado";
            document.getElementById("ultimoCodigo").textContent = "";
        }
    },

    // Mostrar modal con el error
    mostrarError: (mensaje) => {
        const modalEl = document.getElementById("errorModal");
        if (modalEl) {
            const modal = new bootstrap.Modal(modalEl);
            document.getElementById("errorModalBody").textContent = mensaje;
            modal.show();
        } else {
            alert("Error: " + mensaje);
        }
    }
}

// Inicializar cuando se cargue el DOM
document.addEventListener("DOMContentLoaded", jCajaRegistradora.init);