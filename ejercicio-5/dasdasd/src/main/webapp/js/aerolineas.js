const jAerolineas = {
    validar: async (event) => {
        try {
            event.preventDefault();

            jUtils.clean("iError");
            jUtils.showLoading();

            const data = new FormData(event.target);

            const response = await fetch("validar.jsp", {
                method: "POST",
                body: new URLSearchParams(data),
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                }
            });

            if(!response.ok) {
                const text = await response.text();
                throw new Error(text || response.statusText);
            }

            jUtils.show("iResult", await response.text());
            document.getElementById("iReservaForm").addEventListener("submit", jAerolineas.enviar);
        }
        catch (e) {
            jUtils.show("iError", e.message);
            console.log(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    enviar: async (event) => {
        try {
            event.preventDefault();
            jUtils.clean("iError");
            jUtils.showLoading();

            const data = new FormData(event.target);
            const response = await fetch("enviar.jsp", {
                method: "POST",
                body: new URLSearchParams(data),
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                }
            });

            if(!response.ok) {
                const text = await response.text();
                throw new Error(text || response.statusText);
            }

            document.querySelector("body").innerHTML = await response.text();
        }
        catch (e) {
            jUtils.show("iError", e.message);
            console.log(e);
        }
        finally {
            jUtils.hideLoading();
        }
    },

    limpiar: () => {
        jUtils.clean("iResult");
        jUtils.clean("iError");
    }
}

document.getElementById("iBusqForm").addEventListener("submit", jAerolineas.validar);
document.querySelectorAll("input").forEach(input => {
    input.addEventListener("input", jAerolineas.limpiar);
})