<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<div id="pedido-${pedido.id}" class="card mb-4 shadow-sm border-success border-start border-5">

  <div class="card-header d-flex justify-content-between align-items-center">

    <div>
      <strong>Pedido #${pedido.id}</strong>
      <c:if test="${pedido.listoEntrega}">
        <c:choose>
          <c:when test="${pedido.completo}">
            <span class="badge bg-success ms-2">
              Completo para entrega
            </span>
          </c:when>
          <c:otherwise>
            <span class="badge bg-warning text-dark ms-2">
              Parcialmente completo para entrega
            </span>
          </c:otherwise>
        </c:choose>
      </c:if>
    </div>

    <div class="form-check">
      <input id="check-${pedido.id}" class="form-check-input"
             type="checkbox" ${pedido.listoEntrega ? 'checked' : ''}>
      <label class="form-check-label" for="check-${pedido.id}">
        Listo para entrega
      </label>
    </div>

  </div>

  <div class="card-body p-0">

    <table class="table table-hover align-middle mb-0">

      <thead class="table-light">
      <tr>
        <th>ID</th>
        <th>Producto</th>
        <th>Cantidad</th>
        <th>Estado</th>
        <th class="text-center">Acción</th>
      </tr>
      </thead>

      <tbody>
      <c:set var="limite" value="${param.expand == 'true' ? 1000 : 4}"/>
      <c:forEach var="prod" items="${pedido.productos}" end="${limite}">
        <tr class="${prod.rechazado ? 'text-danger text-decoration-line-through' : ''}">
          <td>PRD-${prod.id}</td>
          <td>${prod.nombre}</td>
          <td>${prod.cantidad} Kg</td>

          <td>
            <span class="badge ${prod.rechazado ? 'bg-danger' : 'bg-success'}">
              ${prod.rechazado ? 'Rechazado' : 'Disponible'}
            </span>
          </td>

          <td class="text-center">
            <button class="btn btn-outline-danger btn-sm btn-quitar ${(prod.rechazado || pedido.listoEntrega) ? 'd-none' : ''}" data-pedido-id="${pedido.id}" data-producto-id="${prod.id}">
              Quitar
            </button>
          </td>

        </tr>
      </c:forEach>
      </tbody>

    </table>

  </div>

  <c:if test="${pedido.cantidadProductos > 5 && param.expand != 'true'}">
    <div class="card-footer text-end">
      <button class="btn btn-primary btn-sm btn-ver-mas" data-id="${pedido.id}">
        Ver más productos
      </button>
    </div>
  </c:if>

</div>


