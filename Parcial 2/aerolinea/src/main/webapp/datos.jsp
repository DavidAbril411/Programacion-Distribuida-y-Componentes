<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Bloque: datos del pasajero -->
<div class="border p-3 mb-4 rounded">
  <h5>Datos del pasajero</h5>
  <div class="row">
    <div class="col-md-6">
      <label class="form-label">Apellido</label>
      <div class="form-control">
        <!-- Texto con el apellido -->
        ${reserva.apellido}
      </div>
    </div>
    <div class="col-md-6">
      <label class="form-label">Nombre</label>
      <div class="form-control">
        <!-- Texto con el nombre -->
        ${reserva.nombre}
      </div>
    </div>
  </div>
</div>

<!-- Bloque: mejora de clase -->
<form id="iReservaForm" class="border p-3 mb-4 rounded" action="javascript:void(0)">
  <h5>Mejora de clase</h5>
  <div class="row mb-3">
    <div class="col-4">
      <label class="form-label">Fecha de reserva</label>
      <div class="form-control">
        <!-- Texto de la fecha de reserva -->
        <fmt:parseDate var="fecha" value="${reserva.fechaReserva}" pattern="yyyy-MM-dd"></fmt:parseDate>
        <fmt:setLocale value="es_AR"></fmt:setLocale>
        <fmt:formatDate value="${fecha}" dateStyle="short"></fmt:formatDate>
      </div>
    </div>
    <div class="col-8">
      <label class="form-label">Clase actual</label>
      <div class="form-control">
        <!-- Texto con la clase actual -->
        ${reserva.tipoClaseDesc}
      </div>
    </div>
  </div>
  <div class="row mb-3">
    <div class="col-8">
      <label for="iClaseDeseada" class="form-label">Clase deseada</label>
      <select id="iClaseDeseada" class="form-select" name="tipo_clase" required>
        <option value="" disabled selected>Seleccionar clase</option>
        <option value="EJ">Ejecutiva</option>
        <option value="PC">Primera Clase</option>
      </select>
    </div>

    <div class="col-4">
      <label for="iOferta" class="form-label">Monto ofrecido (USD)</label>
      <input type="number" class="form-control" id="iOferta" name="monto" min="1" placeholder="Ej: 200" required>
      <input type="hidden" name="nro_reserva" value="${reserva.nroReserva}">
    </div>
  </div>
  <div class="row">
    <div class="col-12">
      <button type="submit" class="btn btn-primary">Enviar oferta</button>
    </div>
  </div>
</form>