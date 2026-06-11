<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:useBean id="listado" class="ar.edu.ubp.verdu.PedidoManagerBean" scope="application"></jsp:useBean>

<%-- Localizar el pedido y ponerlo en el request scope --%>
<c:forEach var="ped" items="${listado.pedidos}">
    <c:if test="${ped.id == param.id}">
        <c:set var="pedido" value="${ped}" scope="request"/>
    </c:if>
</c:forEach>

<%-- Forzar parámetro expand=true para que se visualicen todos los productos --%>
<jsp:include page="pedido.jsp">
    <jsp:param name="expand" value="true"/>
</jsp:include>
