<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ejemplos de JSTL Core">
    <meta name="author" content="Lic. Mariela Pastarini">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>JSTL Core - Ejemplo 3</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
</head>
<body class="container">
    <h3>Iteradores</h3>
    <div class="row mb-5">
        <div class="col-12 col-md-6">
            <h5>c:forEach</h5>
            <form  action="ejemplo-03.jsp" method="post">
                <c:forEach var="i" begin="0" end="7">
                    <c:set var="lista" value="${lista}&#${i + 65};,"/>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="ilibro${i}" name="libro" value="Libro &#${i + 65};"/>
                        <label for="ilibro${i}" class="form-check-label">Libro &#${i + 65};</label>
                    </div>
                </c:forEach>
                <button type="submit" class="btn btn-primary mt-3">Mostrar selecci&oacute;n</button>
            </form>
        </div>
        <div class="col-12 col-md-6">
            <c:set var="libros" value="${paramValues.libro}"/>
            <c:if test="${!empty libros}">
                <h5>Los libros seleccionados son:</h5>
                <ol>
                    <c:forEach var="l" items="${libros}" varStatus="data">
                        <li id="li-${data.index}">${l} (${data.first}; ${data.current}; ${data.index}; ${data.last})</li>
                    </c:forEach>
                </ol>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-md-6">
            <h5>c:forTokens: ${lista}</h5>
            <ul>
                <c:forTokens items="${lista}" delims="," var="i" begin="1" end="5" step="2">
                    <li>${i}</li>
                </c:forTokens>
            </ul>
            <a href="index.jsp" target="_self">Volver al index principal</a>
        </div>
    </div>
</body>
</html>
