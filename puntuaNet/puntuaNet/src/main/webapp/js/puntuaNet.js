const form = document.getElementById("iGuardarForm");

if (form) {
    form.addEventListener("submit", buscar);
}

async function buscar(event) {
    try{
        event.preventDefault();
        jUtils.showLoading();

        const form = event.target;
        const data = new FormData(form);

        const response = await fetch("guardar", {
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

        form.reset();

        const responseUltimas = await fetch("ultimas", { method: "GET" });

        if (!responseUltimas.ok) {
            const errorMsg = await responseUltimas.text();
            throw new Error(errorMsg);
        }

        const ultimasHtml = await responseUltimas.text();

        const formularioBefore = document.getElementById("paraBefore");
        const ultimas = document.getElementById("ultimas");
        if(ultimas){
            ultimas.remove();
        }
        formularioBefore.insertAdjacentHTML("afterend", ultimasHtml);


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
