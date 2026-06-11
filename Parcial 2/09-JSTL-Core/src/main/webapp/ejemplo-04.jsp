<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ejemplos de JSTL Core">
    <meta name="author" content="Lic. Mariela Pastarini">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>JSTL Core - Ejemplo 4</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
</head>
<body class="container">
    <h3 class="mb-3">Construcci&oacute;n de URL</h3>
    <c:url var="url" value="ejemplo-04-datos.jsp">
        <c:param name="apellido">PASTARINI</c:param>
        <c:param name="nombre">MARIELA</c:param>
        <c:param name="genero">F</c:param>
    </c:url>
    <a href="${url}" target="_self">Ir a p&aacute;gina del ejemplo</a>
    <br>
    <%--Al descomentar redireccionará a la página informada--%>
    <%--<c:redirect url="https://miubp3.ubp.edu.ar"/>--%>
    <br>
    <a href="index.jsp" target="_self">Volver al index principal</a>
</body>
</html>
