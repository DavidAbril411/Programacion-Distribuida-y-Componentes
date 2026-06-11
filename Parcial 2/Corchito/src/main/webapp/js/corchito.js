tbody = document.getElementById('iTableBody');

if ([...tbody.children].length > 3) {
    document.getElementById('iBotonBolilla').classList.remove('d-none');
}
const vivos = tbody.querySelectorAll('tr:not(.eliminado)');
console.log(vivos.length - 1);
console.log([...tbody.children].length - 1 );
if ((vivos.length - 1) <= 2 && [...tbody.children].length > vivos.length) {
    document.getElementById('iBotonNew').classList.remove('d-none');
    document.getElementById('iNew').classList.add('d-none');
    document.getElementById('iBotonBolilla').classList.add('d-none');
}

document.getElementById('iForm').addEventListener('submit', async (event) => {
    try {
        event.preventDefault();
        jUtils.clean("iError");

        jUtils.showLoading();

        const data = new FormData(event.target);

        const response = await fetch("save.jsp", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: new URLSearchParams(data)
        });

        if (!response.ok) {
            const text = await response.text();
            throw new Error(text || response.statusText);
        }

        document.getElementById('iNew').insertAdjacentHTML("beforebegin", await response.text());
        event.target.reset();

        if (tbody.children.length > 3) {
            document.getElementById('iBotonBolilla').classList.remove('d-none');
        }

    } catch (error) {
        console.log(error);
        jUtils.show("iError", error.message);
    } finally {
        jUtils.hideLoading();
    }
})

document.getElementById('iBotonBolilla').addEventListener('click', async () => {
    const response = await fetch("extraer.jsp");
    const indice = await response.text();
    tr = tbody.children[parseInt(indice)];
    tr.classList.add('eliminado');
    let cont = 0;
    for (let td of tr.children) {
        td.classList.add('text-danger', 'text-decoration-line-through');
    }
    tr.children[1].textContent = 'Eliminado';
    for (let tr of tbody.children) {
        if (!tr.querySelector('.text-danger')) {
            cont++;
        }
    }
    if (cont == 3) {
        document.getElementById('iBotonNew').classList.remove('d-none');
        document.getElementById('iNew').classList.add('d-none');
        document.getElementById('iBotonBolilla').classList.add('d-none');
    }
});

document.getElementById('iBotonNew').addEventListener('click', async () => {
         await fetch("reiniciar.jsp");
         location.reload();
});