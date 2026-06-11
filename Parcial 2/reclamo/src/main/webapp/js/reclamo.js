const jReclamo = {
    // Inicializar listeners
    init: () => {
        const conoceSi = document.getElementById("conoceChasisSi");
        const conoceNo = document.getElementById("conoceChasisNo");
        const form = document.getElementById("formReclamo");
        const nroChasis = document.getElementById("nroChasis");
        const dominio = document.getElementById("dominio");
        const reclamo = document.getElementById("reclamo");

        if (conoceSi && conoceNo) {
            conoceSi.addEventListener("change", jReclamo.toggleVehiculo);
            conoceNo.addEventListener("change", jReclamo.toggleVehiculo);
            jReclamo.toggleVehiculo(); // estado inicial
        }

        if (nroChasis) {
            nroChasis.addEventListener("blur", jReclamo.validarChasis);
        }

        if (dominio) {
            dominio.addEventListener("blur", jReclamo.validarPatente);
        }

        if (reclamo) {
            reclamo.addEventListener("input", jReclamo.actualizarContador);
        }

        if (form) {
            form.addEventListener("submit", jReclamo.registrarReclamo);
        }
    },

    // Mostrar/ocultar sección de vehículo y alternar obligatoriedad
    toggleVehiculo: () => {
        const conoceSi = document.getElementById("conoceChasisSi");
        const seccion = document.getElementById("seccionVehiculo");
        const nroChasis = document.getElementById("nroChasis");
        const dominio = document.getElementById("dominio");
        const km = document.getElementById("km");

        if (!conoceSi || !seccion) return;

        if (conoceSi.checked) {
            seccion.style.display = "block";
            nroChasis.setAttribute("required", "required");
            dominio.setAttribute("required", "required");
        } else {
            seccion.style.display = "none";
            nroChasis.removeAttribute("required");
            dominio.removeAttribute("required");
            
            // Limpiar valores y marcas al ocultar
            nroChasis.value = "";
            dominio.value = "";
            if (km) km.value = "";
            jReclamo.ocultarValidacionChasis();
            jReclamo.ocultarValidacionPatente();
        }
    },

    // Validar Chasis en pérdida de foco
    validarChasis: async () => {
        const nroChasisInput = document.getElementById("nroChasis");
        if (!nroChasisInput) return;
        const nroChasis = nroChasisInput.value.trim();
        const conoceSi = document.getElementById("conoceChasisSi");

        if (!conoceSi || !conoceSi.checked || nroChasis === "") {
            jReclamo.ocultarValidacionChasis();
            return;
        }

        try {
            // Petición AJAX Estilo B (Body con parámetros manuales)
            const response = await fetch("validar", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `nro_chasis=${encodeURIComponent(nroChasis)}`
            });

            if (!response.ok) {
                throw new Error("Error en la validación del chasis");
            }

            const resultado = await response.text();
            jReclamo.mostrarValidacionChasis(resultado === "S");
        } catch (e) {
            console.error(e);
            jReclamo.ocultarValidacionChasis();
        }
    },

    // Validar Patente en pérdida de foco
    validarPatente: async () => {
        const nroChasisInput = document.getElementById("nroChasis");
        const dominioInput = document.getElementById("dominio");
        if (!nroChasisInput || !dominioInput) return;
        
        const nroChasis = nroChasisInput.value.trim();
        const dominio = dominioInput.value.trim();
        const conoceSi = document.getElementById("conoceChasisSi");

        if (!conoceSi || !conoceSi.checked || dominio === "" || nroChasis === "") {
            jReclamo.ocultarValidacionPatente();
            return;
        }

        try {
            // Petición AJAX Estilo B (Body con parámetros manuales)
            const response = await fetch("validar", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `nro_chasis=${encodeURIComponent(nroChasis)}&dominio=${encodeURIComponent(dominio)}`
            });

            if (!response.ok) {
                throw new Error("Error en la validación de la patente");
            }

            const resultado = await response.text();
            jReclamo.mostrarValidacionPatente(resultado === "S");
        } catch (e) {
            console.error(e);
            jReclamo.ocultarValidacionPatente();
        }
    },

    mostrarValidacionChasis: (existe) => {
        const container = document.getElementById("valChasisContainer");
        const img = document.getElementById("imgValChasis");
        if (container && img) {
            img.src = existe ? "images/icon_ok.png" : "images/icon_wrong.png";
            container.style.display = "flex";
        }
    },

    ocultarValidacionChasis: () => {
        const container = document.getElementById("valChasisContainer");
        if (container) {
            container.style.display = "none";
        }
    },

    mostrarValidacionPatente: (existe) => {
        const container = document.getElementById("valPatenteContainer");
        const img = document.getElementById("imgValPatente");
        if (container && img) {
            img.src = existe ? "images/icon_ok.png" : "images/icon_wrong.png";
            container.style.display = "flex";
        }
    },

    ocultarValidacionPatente: () => {
        const container = document.getElementById("valPatenteContainer");
        if (container) {
            container.style.display = "none";
        }
    },

    // Contador de caracteres del reclamo
    actualizarContador: () => {
        const textarea = document.getElementById("reclamo");
        const counter = document.getElementById("charCounter");
        if (textarea && counter) {
            counter.textContent = `${textarea.value.length} / 4000 caracteres`;
        }
    },

    // Envío del formulario
    registrarReclamo: async (event) => {
        event.preventDefault();
        const form = event.target;

        // Validación visual de HTML5/Bootstrap
        if (!form.checkValidity()) {
            form.classList.add("was-validated");
            return;
        }

        try {
            jUtils.showLoading();

            const data = new FormData(form);

            // Petición AJAX Estilo A (URLSearchParams)
            const response = await fetch("registrar", {
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

            // Si es exitoso, reemplazar el contenedor del formulario por la vista de éxito
            const exitoHtml = await response.text();
            const mainContainer = document.getElementById("mainContainer");
            if (mainContainer) {
                mainContainer.innerHTML = exitoHtml;
            }
        } catch (e) {
            jReclamo.mostrarError(e.message);
            console.error(e);
        } finally {
            jUtils.hideLoading();
        }
    },

    // Mostrar modal de error
    mostrarError: (mensaje) => {
        const modalEl = document.getElementById("errorModal");
        if (modalEl) {
            const modal = new bootstrap.Modal(modalEl);
            const body = document.getElementById("errorModalBody");
            if (body) {
                body.textContent = mensaje;
            }
            modal.show();
        } else {
            alert("Error: " + mensaje);
        }
    }
};

// Inicializar cuando se cargue el DOM
document.addEventListener("DOMContentLoaded", jReclamo.init);
