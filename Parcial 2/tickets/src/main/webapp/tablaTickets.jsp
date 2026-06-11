<%--
  Created by IntelliJ IDEA.
  User: davidabrilperrig
  Date: 11/06/2026
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<table id="tabla" class="table table-bordered table-striped table-hover table-condensed">
    <thead>
    <tr>
        <th>ticket</th>
        <th>fecha_ticket</th>
        <th>solicitante</th>
        <th>asunto_ticket</th>
        <th>texto_ticket</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="ticket" items="${tickets}">
        <tr>
            <td>${ticket.ticket}</td>
            <td>${ticket.fecha_ticket}</td>
            <td>${ticket.solicitante}</td>
            <td>${ticket.asunto_ticket}</td>
            <td>${ticket.texto_ticket}</td>
        </tr>
    </c:forEach>
    </tbody>

</table>