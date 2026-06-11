const jUtils = {
    show: (containerId, html) => {
        document.getElementById(containerId).innerHTML = html;
        document.getElementById(containerId).classList.remove('d-none');
        jUtils.executeScripts(containerId);
    },

    clean: (containerId) => {
        document.getElementById(containerId).classList.add('d-none');
        document.getElementById(containerId).innerHTML = '';
    },

    executeScripts: (containerId) => {
        //Contenedor de los scripts a ejecutar
        const container = document.getElementById(containerId);

        //Obtengo los scripts del contenedor
        const scripts = container.querySelectorAll('script');
        scripts.forEach(script => {
            //Si el script tiene un atributo 'src', crea un nuevo script para cargar y ejecutar
            if (script.src) {
                const newScript = document.createElement('script');
                newScript.src = script.src;
                document.head.appendChild(newScript);
            } else {
                // Si no tiene 'src', es un script inline y se puede ejecutar directamente
                eval(script.innerText);
            }
        });
    },

    showLoading: () => {
        const loader = document.createElement("div");
        loader.id = "iLoading";
        loader.className = "loading-overlay d-flex justify-content-center align-items-center";
        loader.innerHTML = `
            <div class="spinner-border text-light" style="width: 4rem; height: 4rem;" role="status" aria-hidden="true"></div>
        `;
        Object.assign(loader.style, {
            position: "fixed",
            top: "0",
            left: "0",
            width: "100vw",
            height: "100vh",
            backgroundColor: "rgba(0, 0, 0, 0.5)",
            zIndex: 10000
        });
        document.body.appendChild(loader);
    },

    hideLoading: () => {
        const loader = document.getElementById("iLoading");
        if (loader) {
            document.body.removeChild(loader);
        }
    }
};