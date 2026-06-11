<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatNumber var="precio" value="${requestScope.producto.precio}" type="currency" maxFractionDigits="2" />
<tr>
    <td>
        ${requestScope.producto.nomProducto}
        <div class="text-muted small">${requestScope.producto.codBarra}</div>
        <input type="hidden" name="nroDetalle" value="${requestScope.producto.nroDetalle}">
        <input type="hidden" name="nomProducto" value="${requestScope.producto.nomProducto}">
        <input type="hidden" name="codBarra" value="${requestScope.producto.codBarra}">
        <input type="hidden" name="precio" value="${requestScope.producto.precio}">
        <input type="hidden" name="precioFmt" value="${precio}">
    </td>
    <td>${precio}</td>
    <td class="text-center">
        <button type="button" class="btn btn-sm btn-outline-danger" onclick="jCarrito.eliminar(this)">
            <i class="bi bi-trash"></i>
        </button>
    </td>
</tr>
