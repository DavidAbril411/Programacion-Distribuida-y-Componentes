<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="jug" class="ar.edu.ubp.corchito.JugadorBean">
    <jsp:setProperty name="jug" property="*"></jsp:setProperty>
</jsp:useBean>

${applicationScope.listado.addJugador(jug)}

<jsp:include page="row.jsp"></jsp:include>