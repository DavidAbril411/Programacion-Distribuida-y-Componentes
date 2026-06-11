<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Cherries - Administración de Pedidos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/verdu.js" defer></script>
</head>


<body class="bg-light">

<div id="contenedorPedidos" class="container mt-4">

    <div class="row mb-4">
        <div class="col">
            <h2>Administración de Pedidos</h2>

            <p class="text-secondary">
                Verdulería Cherries
            </p>

        </div>
    </div>

    <div id="iError" class="alert alert-danger d-none"></div>

    <jsp:useBean id="listado" class="ar.edu.ubp.verdu.PedidoManagerBean" scope="application"></jsp:useBean>

    <!-- PEDIDO 1001 -->
    <c:forEach var="ped" items="${listado.pedidos}">
        <c:set var="pedido" value="${ped}" scope="request"/>
        <jsp:include page="pedido.jsp"/>
    </c:forEach>

</div>

</div>

</body>
</html>