const jUtils = {

    getElement: (containerId) => {
        const element = document.getElementById(containerId);
        if (!element) {
            throw new Error(`No existe el elemento '${containerId}'`);
        }
        return element;
    },

    show: (containerId, html = null) => {
        const container = jUtils.getElement(containerId);
        if (html !== null) {
            container.innerHTML = html;
            jUtils.executeScripts(container);
        }
        container.classList.remove('d-none');
    },

    hide: (containerId) => {
        const container = jUtils.getElement(containerId);
        container.classList.add('d-none');
    },

    clean: (containerId) => {
        const container = jUtils.getElement(containerId);
        container.classList.add('d-none');
        container.innerHTML = '';
    },

    executeScripts: (container) => {
        const scripts = container.querySelectorAll('script');
        scripts.forEach(oldScript => {
            const newScript = document.createElement('script');
            Array.from(oldScript.attributes).forEach(attr => {
                newScript.setAttribute(attr.name, attr.value);
            });
            newScript.textContent = oldScript.textContent;
            oldScript.parentNode.replaceChild(newScript, oldScript);
        });
    },

    showLoading: () => {
        if (document.getElementById('iLoading')) {
            return;
        }

        const loader = document.createElement('div');
        loader.id = 'iLoading';
        loader.className = 'loading-overlay d-flex justify-content-center align-items-center';
        loader.innerHTML = `
            <div
                class="spinner-border text-light"
                style="width: 4rem; height: 4rem;"
                role="status"
                aria-hidden="true">
            </div>
        `;

        Object.assign(loader.style, {
            position: 'fixed',
            top: '0',
            left: '0',
            width: '100vw',
            height: '100vh',
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            zIndex: '10000'
        });
        document.body.appendChild(loader);
    },

    hideLoading: () => {
        const loader = document.getElementById('iLoading');
        if (loader) {
            loader.remove();
        }
    }

};