<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ejemplos de JSTL Core">
    <meta name="author" content="Lic. Mariela Pastarini">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>JSTL Core - Ejemplo 1</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
</head>
<body class="container">
    <h2>Variables</h2>
    <div class="row">
        <div class="col-12 col-md-6">
            <h3>c:out</h3>
            <p><c:out value="¡Hola Mundo!! :)"/></p>
            <p>\${producto.id}: <c:out value="${producto.id}" default="Sin definir"/></p>
            <p>
                \${param.nombre}:
                <c:out value="${param.nombre}">
                    No informado
                </c:out>
            </p>
            <p><c:out value="<b>Texto en negrita</b>" default="Sin valor" escapeXml="false"/></p>
            <p><c:out value="<b>Texto en negrita</b>" default="Sin valor" escapeXml="true"/></p>
        </div>
        <div class="col-12 col-md-6">
            <h3>c:set</h3>
            <c:set var="browser" value="${header['User-Agent']}" scope="session" />
            <p><b>Navegador usado</b>: ${browser}</p>

            <c:set var="sessionid" scope="session">
                <c:out value="${cookie['JSESSIONID'].value}" default="---"/>
            </c:set>
            <p><b>Identificador de Sesi&oacute;n</b>: ${sessionid} <a href="ejemplo-01.jsp" target="_self">Recargar</a></p>

            <c:set var="variable" value="Valor 1" scope="page"/>
            <c:set var="variable" value="Valor 2" scope="request"/>
            <p><b>Variable (pageScope)</b>: ${pageScope.variable}</p>
            <p><b>Variable (requestScope)</b>: ${requestScope.variable}</p>
            <c:remove var="variable" scope="page"/>
            <p><b>Variable removida (pageScope)</b></p>
            <p><b>Variable (pageScope)</b>: <c:out value="${pageScope.variable}" default="Ya no existe"/></p>
            <p><b>Variable (requestScope)</b>: ${requestScope.variable}</p>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6">
            <a href="index.jsp" target="_self">Volver al index principal</a>
        </div>
    </div>
</body>
</html>
