<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tr class="${param.eliminado ? "eliminado" : ""}">
    <td class="${param.eliminado ? "text-danger text-decoration-line-through" : ""}">${param.nombre}</td>
    <td class="${param.eliminado ? "text-danger text-decoration-line-through" : ""}">${param.eliminado ? "Eliminado" : "Jugando"}</td>
</tr>