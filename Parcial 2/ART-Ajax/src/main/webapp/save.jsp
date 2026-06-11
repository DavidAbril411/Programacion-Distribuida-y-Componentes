<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="emp" class="ar.edu.ubp.pdc.artajax.EmpleadoBean">
  <jsp:setProperty name="emp" property="*"></jsp:setProperty>
</jsp:useBean>

${applicationScope.listado.addEmpleado(emp)}

<jsp:include page="row.jsp"></jsp:include>