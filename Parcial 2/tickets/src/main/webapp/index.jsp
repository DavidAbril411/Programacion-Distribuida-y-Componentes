<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"
            defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/tickets.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
          defer>
</head>
<body class="p-4">
<div class="container d-flex flex-column" id="contenedor">
    <div id="ibuscador" class="d-flex justify-content-center w-100 gap-5">
        <form id="iBuscForm" action="javascript:void(0)" class="form-group d-flex gap-2 w-100">
            <div class="d-flex flex-column gap-2 w-50">
                <label for="buscador" class="form-label fw-bold">Solicitante | Asunto | Texto</label>
                <input type="text" id="buscador" name="buscador" class="form-control" required>
                <button type="submit" class="btn btn-primary w-25">Buscar</button>
            </div>
            <div class="border rounded d-flex justify-content-center flex-column m-auto p-2">
                <span class="form-label fw-bold">Ordenar Por</span>
                <div>
                    <input type="radio" name="ordenar" id="ordenarPorSoli" value="S">
                    <label for="ordenarPorSoli" class="pe-3">Solicitante</label>
                    <input type="radio" name="ordenar" id="ordenarPorFecha" value="F" checked>
                    <label for="ordenarPorFecha" class="pe-3">Fecha</label>
                    <input type="radio" name="ordenar" id="ordenarPorNro" value="T">
                    <label for="ordenarPorNro">Nro.de Ticket</label>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>