const form = document.getElementById("iBuscForm");

if (form) {
    form.addEventListener("submit", buscar);
}

async function buscar(event) {
    try{
        event.preventDefault();
        jUtils.showLoading();

        const form = event.target;
        const data = new FormData(form);

        const response = await fetch("buscar", {
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

        // Recibir la tabla HTML
        const tablaHtml = await response.text();

        const contenedorBuscador = document.getElementById("ibuscador");
        const tabla = document.getElementById("tabla");
        if(tabla){
            tabla.remove();
        }
        contenedorBuscador.insertAdjacentHTML("afterend", tablaHtml);
    }catch(e){
        document.body.insertAdjacentHTML('beforeend', e.message);
        const modal = document.getElementById('errorModal');
        if (modal) {
            // Si usás Bootstrap 5:
            const bsModal = new bootstrap.Modal(modal, { backdrop: true, keyboard: true, focus: true });
            bsModal.show();
        }
        console.error(e);
    }finally {
        jUtils.hideLoading();
    }

}