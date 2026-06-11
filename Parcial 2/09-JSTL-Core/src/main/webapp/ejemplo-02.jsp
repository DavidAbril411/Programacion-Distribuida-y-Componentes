<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ejemplos de JSTL Core">
    <meta name="author" content="Lic. Mariela Pastarini">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>JSTL Core - Ejemplo 2</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
</head>
<body class="container">
    <h3>Condicionales</h3>
    <div class="row">
        <form id="form" name="form" action="ejemplo-02.jsp" method="post" class="col-12 col-md-6">
            <label for="inro">Ingrese un n&uacute;mero</label>
            <input type="text" class="form-control" id="inro" name="nro" value="" size="10" maxlength="10" placeholder="Ingrese un número" required>
            <button type="submit" class="btn btn-success mt-3">Procesar</button>
        </form>
    </div>
    <div class="row">
        <div class="col-12">
            <c:set var="i" value="${param.nro}" scope="page" />
            <c:if test="${!empty i}">
                <h4>Valor informado: ${i}</h4>
                <c:catch var="exception1">
                    <h4>c:if</h4>
                    <c:if test="${i % 2 == 0}">
                        <p>El valor ingresado es par</p>
                    </c:if>
                    <c:if test="${i % 2 != 0}">
                        <p>El valor ingresado es impar</p>
                    </c:if>
                </c:catch>
                <c:if test="${!empty exception1}">
                    <p>El valor ingresado debe ser un n&uacute;mero. Detalle: ${exception1}</p>
                </c:if>
                <c:catch var="exception2">
                    <h4>c:choose</h4>
                    <c:choose>
                        <c:when test="${i mod 2 eq 0}">
                            <p>El valor ingresado es par</p>
                        </c:when>
                        <c:otherwise>
                            <p>El valor ingresado es impar</p>
                        </c:otherwise>
                    </c:choose>
                </c:catch>
                <c:if test="${!empty exception2}">
                    <p>El valor ingresado debe ser un n&uacute;mero. Detalle: ${exception2}</p>
                </c:if>
            </c:if>
            <a href="index.jsp" target="_self">Volver al index principal</a>
        </div>
    </div>
</body>
</html>
