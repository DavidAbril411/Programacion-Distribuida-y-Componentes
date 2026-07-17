<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nombre del proyecto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"
            defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/[nombreProyecto].js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" defer>
</head>
<body>
<table class="table table-bordered">
    <thead class="table-dark">
    <tr>
        <th scope="col">Codigo</th>
        <th scope="col">Nombre</th>
        <th scope="col">Nro. Orden</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="unidad" items="${unidades}">
        <tr>
            <td>${unidad.codUnidadNegocio}</td>
            <td>${unidad.nombreUnidadNegocio}</td>
            <td>${unidad.nroOrden}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>