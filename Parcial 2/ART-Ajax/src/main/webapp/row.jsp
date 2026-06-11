<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tr>
  <td class="${param.resultado eq 'NA' ? 'text-danger' : ''}">${param.apellido}</td>
  <td class="${param.resultado eq 'NA' ? 'text-danger' : ''}">${param.nombre}</td>
  <td class="${param.resultado eq 'NA' ? 'text-danger' : ''}">${param.dni}</td>
  <td class="${param.resultado eq 'NA' ? 'text-danger' : ''}">${param.resultado eq 'A' ? "Apto" : "No Apto"}</td>
  <td class="text-center">-</td>
</tr>