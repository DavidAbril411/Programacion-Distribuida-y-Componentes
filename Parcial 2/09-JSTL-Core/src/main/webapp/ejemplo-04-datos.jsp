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
    <div class="row mt-5 mb-5">
        <div class="col-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Datos personales</h5>
                    <p class="card-text"><b>Apellido</b>: ${param.apellido}</p>
                    <p class="card-text"><b>Nombre</b>: ${param.nombre}</p>
                    <p class="card-text"><b>G&eacute;nero</b>: ${(empty param.genero ? "No Informado" : (param.genero eq "F" ? "Femenino" : (param.genero eq "NB" ? "No binario" : "Masculino")))}</p>
                </div>
            </div>
        </div>
    </div>
    <a href="ejemplo-04.jsp" target="_self">Volver</a>
</body>
</html>
