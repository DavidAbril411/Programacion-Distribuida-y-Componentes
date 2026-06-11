<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    List<Map<String, Object>> items = (List<Map<String, Object>>) request.getAttribute("items");
    if (items != null) {
        for (Map<String, Object> item : items) {
            int nroDetalle = (Integer) item.get("nroDetalle");
            String codBarra = (String) item.get("codBarra");
            String nomProducto = (String) item.get("nomProducto");
            double precio = ((Number) item.get("precio")).doubleValue();
%>
            <tr data-nro-detalle="<%= nroDetalle %>" data-precio="<%= precio %>" data-nombre="<%= nomProducto %>" data-codigo="<%= codBarra %>">
                <td>
                    <%= nomProducto %>
                    <div class="text-muted small"><%= codBarra %></div>
                </td>
                <td>$<%= String.format("%.2f", precio) %></td>
                <td class="text-center">
                    <button onclick="jCajaRegistradora.eliminar(<%= nroDetalle %>)" class="btn btn-sm btn-outline-danger">
                        <i class="bi bi-trash"></i>
                    </button>
                </td>
            </tr>
<%
        }
    }
%>
