<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%= request.getAttribute("error") != null ? request.getAttribute("error") : "Ocurrió un error inesperado." %>
