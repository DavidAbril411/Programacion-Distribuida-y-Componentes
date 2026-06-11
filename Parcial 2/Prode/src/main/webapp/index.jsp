<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
    <link rel="stylesheet" href="styles.css">
    <script src="JS/utils.js" defer></script>
    <script src="JS/script.js" defer></script>
    <title>Prode</title>
</head>
<body class="container bg-light">
<div class="card d-flex justify-content-center flex-column align-items-center text-center">
    <h3>Prode</h3>
    <div id="iError" class="alert alert-danger d-none"></div>

    <jsp:useBean id="equipos" class="ar.edu.ubp.prode.EquiposBeans" scope="application"></jsp:useBean>

    <div class="card-body">
        <form id="iForm" action="javascript:void(0)" method="POST">
            <table class="table table-bordered">
                <thead class="table-dark">
                <tr>
                    <th scope="col">Equipo</th>
                    <th scope="col">L</th>
                    <th scope="col">E</th>
                    <th scope="col">V</th>
                    <th scope="col">Equipo</th>
                </tr>
                </thead>
                <tbody id="iTableBody">
                <c:forEach var="equipos" items="${equipos.equipos}">
                    <tr>
                        <td>${equipos.get(0)}</td>
                        <td>
                            <input type="checkbox">
                        </td>
                        <td>
                            <input type="checkbox">
                        </td>
                        <td>
                            <input type="checkbox">
                        </td>
                        <td>${equipos.get(1)}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button type="submit">Resultados</button>
        </form>
    </div>
</div>
</body>
</html>