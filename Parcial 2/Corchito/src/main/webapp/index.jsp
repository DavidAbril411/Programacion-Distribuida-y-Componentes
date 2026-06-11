<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/corchito.js" defer></script>
</head>
<body class="container bg-light">
<div class="card d-flex justify-content-center flex-column align-items-center text-center">
    <h3>Juego del Corchito</h3>
    <div id="iError" class="alert alert-danger d-none"></div>

    <jsp:useBean id="listado" class="ar.edu.ubp.corchito.ListadoJugadores" scope="application"></jsp:useBean>

    <div class="card-body">
        <form id="iForm" action="javascript:void(0)" method="POST">
            <table class="table table-bordered">
                <thead class="table-dark">
                <tr>
                    <th scope="col">Jugador</th>
                    <th scope="col">Estado</th>
                </tr>
                </thead>
                <tbody id="iTableBody">
                <c:forEach var="jug" items="${listado.jugadores}">
                    <jsp:include page="row.jsp">
                        <jsp:param name="nombre" value="${jug.nombre}"/>
                        <jsp:param name="eliminado" value="${jug.eliminado}"/>
                    </jsp:include>
                </c:forEach>
                <tr id="iNew">
                    <td>
                        <input type="text" class="form-control" name="nombre" placeholder="Nombre" required
                               maxlength="255">
                    </td>
                    <td>
                        <button id="iBotonAdd" class="btn btn-primary" type="submit">Agregar</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        <button id="iBotonBolilla" class="btn btn-secondary d-none" type="button">Extraer Bolilla</button>
        <button id="iBotonNew" class="btn btn-success d-none" type="button">Iniciar Nuevo Sorteo</button>
    </div>
</div>
</body>
</html>