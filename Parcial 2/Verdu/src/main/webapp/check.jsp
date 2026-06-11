<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:useBean id="listado" class="ar.edu.ubp.verdu.PedidoManagerBean" scope="application"></jsp:useBean>

<%-- invoke the bean method to update the state --%>
${listado.marcarEntrega(param.id, param.checked)}

<%-- locate the updated order bean and set it in request scope --%>
<c:forEach var="ped" items="${listado.pedidos}">
    <c:if test="${ped.id == param.id}">
        <c:set var="pedido" value="${ped}" scope="request"/>
    </c:if>
</c:forEach>

<%-- render and return the updated card fragment --%>
<jsp:include page="pedido.jsp"/>
