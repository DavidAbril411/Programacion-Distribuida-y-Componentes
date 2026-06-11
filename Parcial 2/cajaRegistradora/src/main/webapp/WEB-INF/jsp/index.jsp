<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ar.edu.ubp.cajaregistradora.beans.ProductoBean" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Maqueta - Caja Registradora</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous" defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/cajaRegistradora.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" defer>
</head>
<body class="p-4">

<div class="container">
    <div class="row mb-4">
        <!-- Ingreso de productos -->
        <div class="col-md-6">
            <form id="iAgrProdForm" action="javascript:void(0)">
                <label for="codigoBarras" class="form-label fw-bold">Escanear código de barras</label>
                <div class="input-group">
                    <input id="codigoBarras" name="cod_barra" type="text" class="form-control" placeholder="Ingrese el código de barras" maxlength="13" required>
                    <button type="submit" class="btn btn-primary">Añadir</button>
                </div>
            </form>
        </div>
        
        <!-- Catálogo / Productos Rápidos -->
        <div class="col-md-6">
            <label for="selectProductoRapido" class="form-label fw-bold">Añadir producto rápido (Catálogo)</label>
            <select id="selectProductoRapido" class="form-select" onchange="jCajaRegistradora.agregarPorSeleccion(this.value)">
                <option value="">-- Seleccionar producto --</option>
                <%
                    List<ProductoBean> catalogo = (List<ProductoBean>) request.getAttribute("catalogo");
                    if (catalogo != null) {
                        for (ProductoBean p : catalogo) {
                %>
                            <option value="<%= p.getCod_barra() %>"><%= p.getNom_producto() %> ($<%= String.format("%.2f", p.getPrecio()) %>)</option>
                <%
                        }
                    }
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <!-- Tabla de productos -->
        <div class="col-md-6">
            <table class="table table-bordered align-middle">
                <thead class="table-light">
                <tr>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th style="width: 50px;"></th>
                </tr>
                </thead>
                <tbody id="tablaProductosCuerpo">
                <%
                    List<ProductoBean> carrito = (List<ProductoBean>) request.getAttribute("carrito");
                    double total = 0.0;
                    if (request.getAttribute("total") != null) {
                        total = ((Number) request.getAttribute("total")).doubleValue();
                    }
                    
                    if (carrito != null) {
                        for (ProductoBean p : carrito) {
                %>
                            <tr data-nro-detalle="<%= p.getNro_producto() %>" data-precio="<%= p.getPrecio() %>" data-nombre="<%= p.getNom_producto() %>" data-codigo="<%= p.getCod_barra() %>">
                                <td>
                                    <%= p.getNom_producto() %>
                                    <div class="text-muted small"><%= p.getCod_barra() %></div>
                                </td>
                                <td>$<%= String.format("%.2f", p.getPrecio()) %></td>
                                <td class="text-center">
                                    <button onclick="jCajaRegistradora.eliminar(<%= p.getNro_producto() %>)" class="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                <%
                        }
                    }
                %>
                </tbody>
                <tfoot class="table-light">
                <tr>
                    <th>Total</th>
                    <th id="totalCarrito">$<%= String.format("%.2f", total) %></th>
                    <th></th>
                </tr>
                </tfoot>
            </table>
        </div>

        <!-- Detalle del último producto -->
        <%
            String ultimoNombre = (String) request.getAttribute("ultimoNombre");
            String ultimoCodigo = (String) request.getAttribute("ultimoCodigo");
            double ultimoPrecio = 0.0;
            if (request.getAttribute("ultimoPrecio") != null) {
                ultimoPrecio = ((Number) request.getAttribute("ultimoPrecio")).doubleValue();
            }
            if (ultimoNombre == null) ultimoNombre = "";
            if (ultimoCodigo == null) ultimoCodigo = "";
        %>
        <div class="col-md-6">
            <div class="border p-4 text-center h-100 d-flex flex-column justify-content-center bg-light rounded shadow-sm">
                <h1 id="ultimoPrecio" class="display-3">$<%= String.format("%.2f", ultimoPrecio) %></h1>
                <div>
                    <p id="ultimoNombre" class="fs-5 mb-0 text-muted"><%= ultimoNombre.isEmpty() ? "Ningún producto seleccionado" : ultimoNombre %></p>
                    <div id="ultimoCodigo" class="text-muted small"><%= ultimoCodigo %></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal de Error de Bootstrap -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="errorModalLabel"><i class="bi bi-exclamation-triangle-fill me-2"></i>Error</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="errorModalBody">
        <!-- Rellenado dinámicamente -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>
