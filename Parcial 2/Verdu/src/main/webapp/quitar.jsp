<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:useBean id="listado" class="ar.edu.ubp.verdu.PedidoManagerBean" scope="application"/>

<%-- Invocar el método del Bean para quitar/rechazar el producto --%>
${listado.quitarProducto(param.pedidoId, param.productoId)}

<%-- Localizar el pedido actualizado e incluir pedido.jsp --%>
<c:forEach var="ped" items="${listado.pedidos}">
    <c:if test="${ped.id == param.pedidoId}">
        <c:set var="pedido" value="${ped}" scope="request"/>
    </c:if>
</c:forEach>

<jsp:include page="pedido.jsp"/>
