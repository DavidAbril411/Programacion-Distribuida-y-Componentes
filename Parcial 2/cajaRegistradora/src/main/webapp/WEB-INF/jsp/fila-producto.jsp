<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ar.edu.ubp.cajaregistradora.beans.ProductoBean" %>
<%
    ProductoBean producto = (ProductoBean) request.getAttribute("producto");
    Integer nroDetalle = (Integer) request.getAttribute("nro_detalle");
    if (producto != null && nroDetalle != null) {
%>
        <tr data-nro-detalle="<%= nroDetalle %>" data-precio="<%= producto.getPrecio() %>" data-nombre="<%= producto.getNom_producto() %>" data-codigo="<%= producto.getCod_barra() %>">
            <td>
                <%= producto.getNom_producto() %>
                <div class="text-muted small"><%= producto.getCod_barra() %></div>
            </td>
            <td>$<%= String.format("%.2f", producto.getPrecio()) %></td>
            <td class="text-center">
                <button onclick="jCajaRegistradora.eliminar(<%= nroDetalle %>)" class="btn btn-sm btn-outline-danger">
                    <i class="bi bi-trash"></i>
                </button>
            </td>
        </tr>
<%
    }
%>
