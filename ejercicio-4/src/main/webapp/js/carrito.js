const jCarrito = {
  agregar: async (event) => {
    event.preventDefault();
    jUtils.showLoading();

    try {
        const response = await fetch("agregar.jsp", {
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams(new FormData(event.target)),
            method: "POST"
        });

        if(!response.ok) {
            throw new Error(await response.text() || response.statusText);
        }

        const tbody = document.querySelector("#iTabla tbody");
        tbody.insertAdjacentHTML("beforeend", await response.text());

        jCarrito.getUltProducto(tbody);
        jUtils.hideLoading();

        document.getElementById("iForm").reset();
        document.querySelector("#iForm input").focus();
    }
    catch (error) {
        jUtils.hideLoading();
        jUtils.show("iError", error);
    }
  },
  getUltProducto: (tbody) => {
      const tr = tbody.querySelector("tr:last-child");
      let precio = "", producto = "", codBarra = "";

      if(tr) {
          precio = tr.querySelector("input[name=precioFmt]").value;
          producto = tr.querySelector("input[name=nomProducto]").value;
          codBarra = tr.querySelector("input[name=codBarra]").value;
      }

      document.getElementById("iUltPrecio").innerHTML = precio;
      document.getElementById("iUltNomProducto").innerHTML = producto;
      document.getElementById("iUltCodBarra").innerHTML = codBarra;

      jCarrito.calcularTotal();
  },
  calcularTotal: () => {
      const total = Array.from(document.querySelectorAll("input[name=precio]")).reduce((total, input) => {
          return total + parseFloat(input.value);
      }, 0);
      document.getElementById("iTotal").innerHTML = total.toLocaleString({
          style: "currency"
      });
  },
  eliminar: async (btn) => {
    const nroDetalle = btn.closest("tr").querySelector("input[name=nroDetalle]").value;

    jUtils.showLoading();

    try {
        const response = await fetch("./eliminar.jsp", {
            header: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: new URLSearchParams({
                "nro_detalle": nroDetalle
            }),
            method: "POST"
        });

        if(!response.ok) {
            throw new Error(await response.text() || response.statusText);
        }

        btn.closest("tr").remove();

        jCarrito.getUltProducto(document.querySelector("#iTabla tbody"));
        jUtils.hideLoading();
    }
    catch (error) {
        jUtils.hideLoading();
        jUtils.show("iError", error);
    }
  },
  listado: async () => {
      try {
          jUtils.showLoading();
          const response = await fetch("./listado.jsp", {
              headers: {
                 "Content-Type": "application/x-www-form-urlencoded"
              },
              method: "GET"
          });

          if(!response.ok) {
              throw new Error(await response.text() || response.statusText);
          }

          const tbody = document.querySelector("#iTabla tbody");
          tbody.insertAdjacentHTML("beforeend", await response.text());

          jCarrito.getUltProducto(tbody);
          jUtils.hideLoading();
      }
      catch (error) {
          jUtils.hideLoading();
          jUtils.show("iError", error);
      }
  }
};

document.getElementById("iForm").addEventListener("submit", jCarrito.agregar);
jCarrito.listado();