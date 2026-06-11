<%--
  Created by IntelliJ IDEA.
  User: davidabrilperrig
  Date: 14/05/2026
  Time: 7:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:useBean id="equipos" class="ar.edu.ubp.prode.EquiposBeans" scope="application"></jsp:useBean>

${equipos.Resultados()}

<c:forEach var="equipos" items="${equipos.equipos}">
  <tr>
    <td>${equipos.get(0)}</td>
    <td>
        ${equipos.get(0)}
    </td>
    <td>
        ${equipos.get(1)}
    </td>
    <td>${equipos.get(1)}</td>
  </tr>
</c:forEach>