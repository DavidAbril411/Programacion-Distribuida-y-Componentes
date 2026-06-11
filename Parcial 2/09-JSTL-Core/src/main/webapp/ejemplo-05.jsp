<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ejemplos de JSTL Core">
    <meta name="author" content="Lic. Mariela Pastarini">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>JSTL Core - Ejemplo 5</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
</head>
<body class="container">
    <h3>Uso de JavaBeans</h3>
    <div class="row mb-4">
        <div class="col-12 col-md-6">
            <form action="ejemplo-05.jsp" method="post">
                <c:forEach var="i" begin="0" end="7">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="icategoria${i}" name="categoria" value="&#${i + 65};"/>
                        <label for="icategoria${i}" class="form-check-label">Categor&iacute;a &#${i + 65};</label>
                    </div>
                </c:forEach>
                <button class="btn btn-primary mt-3">Mostrar selecci&oacute;n</button>
            </form>
        </div>
        <div class="col-12 col-md-6">
            <c:if test="${!empty param}">
                <h5>Categor&iacute;as seleccionadas:</h5>
                <jsp:useBean id="cat" class="ar.edu.ubp.pdc.jstlcore.CategoriasBean" scope="request">
                    <jsp:setProperty name="cat" property="categorias" value="${paramValues.categoria}" />
                </jsp:useBean>
                <ul>
                    <c:forEach items="${cat.categorias}" var="c">
                        <li>${c}</li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
    </div>
    <a href="index.jsp" target="_self">Volver al index principal</a>
</body>
</html>
