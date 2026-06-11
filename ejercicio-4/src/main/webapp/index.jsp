<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Maqueta - Caja Registradora</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" defer>

    <script type="text/javascript" src="js/utils.js" defer></script>
    <script type="text/javascript" src="js/carrito.js" defer></script>
</head>
<body class="p-4">

<div id="iError" class="d-none"></div>

<div class="container">
    <div class="row mb-4">
        <!-- Ingreso de productos -->
        <div class="col-md-6">
            <form id="iForm" class="input-group" action="javascript:void(0)" method="post">
                <input type="text" class="form-control" name="cod_barra" placeholder="Ingrese el código de barras" maxlength="13" required autofocus>
                <button type="submit" class="btn btn-primary">Añadir</button>
            </form>
        </div>
    </div>

    <div class="row">
        <!-- Tabla de productos -->
        <div class="col-md-6">
            <table id="iTabla" class="table table-bordered">
                <thead class="table-light">
                <tr>
                    <th>Producto</th>
                    <th>Precio</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot class="table-light">
                <tr>
                    <th>Total</th>
                    <th id="iTotal"></th>
                    <th></th>
                </tr>
                </tfoot>
            </table>
        </div>

        <!-- Detalle del último producto -->
        <div class="col-md-6">
            <div class="border p-4 text-center h-100 d-flex flex-column justify-content-center">
                <h1 id="iUltPrecio" class="display-3"></h1>
                <div>
                    <p id="iUltNomProducto" class="fs-5 mb-0 text-muted"></p>
                    <div id="iUltCodBarra" class="text-muted small"></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
