<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>ART</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/css/bootstrap.min.css">
  <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.8/js/bootstrap.bundle.min.js" defer></script>
  <script src="js/utils.js" defer></script>
  <script src="js/art.js" defer></script>
</head>
<body class="container bg-light">
<h3>Registro de Evaluaci&oacute;n M&eacute;dica</h3>
<div id="iError" class="alert alert-danger d-none"></div>

<jsp:useBean id="listado" class="ar.edu.ubp.pdc.artajax.ListadoEmpleadosBean" scope="application"></jsp:useBean>

<div class="card">
  <div class="card-body">
    <form id="iForm" action="javascript:void(0)" method="POST">
      <table class="table table-bordered">
        <thead class="table-dark">
          <tr>
            <th scope="col">Apellido</th>
            <th scope="col">Nombre</th>
            <th scope="col">DNI</th>
            <th scope="col">Resultado</th>
            <th scope="col" class="text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="emp" items="${listado.empleados}">
            <jsp:include page="row.jsp">
              <jsp:param name="apellido" value="${emp.apellido}"></jsp:param>
              <jsp:param name="nombre" value="${emp.nombre}"></jsp:param>
              <jsp:param name="dni" value="${emp.dni}"></jsp:param>
              <jsp:param name="resultado" value="${emp.resultado}"></jsp:param>
            </jsp:include>
          </c:forEach>
          <tr id="iNew">
            <td>
              <input type="text" class="form-control" name="apellido" placeholder="Apellido" required maxlength="40">
            </td>
            <td>
              <input type="text" class="form-control" name="nombre" placeholder="Nombre" required maxlength="255">
            </td>
            <td>
              <input type="text" class="form-control" name="dni" placeholder="DNI" required maxlength="20">
            </td>
            <td>
              <select name="resultado" class="form-select" required>
                <option value="">Seleccionar</option>
                <option value="A">Apto</option>
                <option value="NA">No apto</option>
              </select>
            </td>
            <td>
              <button type="submit" class="btn btn-success">Guardar</button>
              <button type="reset" class="btn btn-secondary">Cancelar</button>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </div>
</div>
</body>
</html>