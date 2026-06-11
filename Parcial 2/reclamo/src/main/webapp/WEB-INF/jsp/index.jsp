<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reclamos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" defer>
    <!-- Custom Scripts -->
    <script src="js/utils.js" defer></script>
    <script src="js/reclamo.js" defer></script>
    <style>
        .text-red {
            color: #d0002d;
        }
        .btn-red {
            background-color: #d0002d;
            color: white;
            border: none;
            padding: 8px 30px;
            font-size: 1.1rem;
        }
        .btn-red:hover {
            background-color: #a80024;
            color: white;
        }
        .form-container {
            max-width: 650px;
            margin: 0 auto;
        }
        .form-label {
            font-size: 0.95rem;
            color: #555;
        }
    </style>
</head>
<body class="bg-white py-4">

<div class="container">
    <div class="form-container" id="mainContainer">
        <!-- Títulos en rojo -->
        <h1 class="text-red fw-bold mb-1" style="font-size: 2.2rem;">Reclamos</h1>
        <h3 class="text-red fw-bold mb-4" style="font-size: 1.3rem;">¿Quiere hacer un reclamo?</h3>
        
        <form id="formReclamo" action="javascript:void(0)" novalidate class="mt-4">
            
            <!-- ¿Conocés tu número de chasis? -->
            <div class="row align-items-center mb-3">
                <label class="col-sm-5 form-label fw-bold mb-0">¿Conocés tu número de chasis? *</label>
                <div class="col-sm-7">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="conoce_chasis" id="conoceChasisSi" value="S" checked>
                        <label class="form-check-label" for="conoceChasisSi">Si</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="conoce_chasis" id="conoceChasisNo" value="N">
                        <label class="form-check-label" for="conoceChasisNo">No</label>
                    </div>
                </div>
            </div>

            <!-- Bloque de datos del vehículo -->
            <div id="seccionVehiculo">
                <!-- Nº de chasis -->
                <div class="row align-items-center mb-3">
                    <label for="nroChasis" class="col-sm-5 form-label fw-bold mb-0">Nº de chasis *</label>
                    <div class="col-sm-7">
                        <div class="input-group">
                            <input type="text" id="nroChasis" name="nro_chasis" class="form-control" maxlength="17" required>
                            <span class="input-group-text bg-white" id="valChasisContainer" style="display: none; width: 45px; justify-content: center; align-items: center;">
                                <img id="imgValChasis" src="" alt="validación" style="width: 18px; height: 18px;">
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Patente -->
                <div class="row align-items-center mb-3">
                    <label for="dominio" class="col-sm-5 form-label fw-bold mb-0">Patente</label>
                    <div class="col-sm-7">
                        <div class="input-group">
                            <input type="text" id="dominio" name="dominio" class="form-control" maxlength="10">
                            <span class="input-group-text bg-white" id="valPatenteContainer" style="display: none; width: 45px; justify-content: center; align-items: center;">
                                <img id="imgValPatente" src="" alt="validación" style="width: 18px; height: 18px;">
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Kilómetros -->
                <div class="row align-items-center mb-3">
                    <label for="km" class="col-sm-5 form-label fw-bold mb-0">Kilómetros</label>
                    <div class="col-sm-7">
                        <input type="number" id="km" name="km" class="form-control" min="0">
                    </div>
                </div>
            </div>

            <!-- Apellido -->
            <div class="row align-items-center mb-3">
                <label for="apellido" class="col-sm-5 form-label fw-bold mb-0">Apellido *</label>
                <div class="col-sm-7">
                    <input type="text" id="apellido" name="apellido" class="form-control" maxlength="100" required>
                </div>
            </div>

            <!-- Nombre -->
            <div class="row align-items-center mb-3">
                <label for="nombre" class="col-sm-5 form-label fw-bold mb-0">Nombre *</label>
                <div class="col-sm-7">
                    <input type="text" id="nombre" name="nombre" class="form-control" maxlength="255" required>
                </div>
            </div>

            <!-- E-mail -->
            <div class="row align-items-center mb-3">
                <label for="email" class="col-sm-5 form-label fw-bold mb-0">E-mail *</label>
                <div class="col-sm-7">
                    <input type="email" id="email" name="email" class="form-control" maxlength="255" required>
                </div>
            </div>

            <!-- Teléfono -->
            <div class="row align-items-center mb-3">
                <label for="telefono" class="col-sm-5 form-label fw-bold mb-0">Teléfono</label>
                <div class="col-sm-7">
                    <input type="tel" id="telefono" name="telefono" class="form-control" maxlength="100">
                </div>
            </div>

            <!-- ¿Desea ser contactado por un vendedor? -->
            <div class="row align-items-center mb-3">
                <label class="col-sm-5 form-label fw-bold mb-0">¿Desea ser contactado por un vendedor? *</label>
                <div class="col-sm-7">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="contactar" id="contactarSi" value="S" checked>
                        <label class="form-check-label" for="contactarSi">Si</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="contactar" id="contactarNo" value="N">
                        <label class="form-check-label" for="contactarNo">No</label>
                    </div>
                </div>
            </div>

            <!-- Reclamo -->
            <div class="mb-3">
                <label for="reclamo" class="form-label fw-bold mb-2">Reclamo (4000 caracteres máx.) *</label>
                <textarea id="reclamo" name="reclamo" class="form-control" rows="6" maxlength="4000" required></textarea>
                <div class="d-flex justify-content-end mt-1">
                    <small id="charCounter" class="text-muted">0 / 4000 caracteres</small>
                </div>
            </div>

            <!-- Botón Registrar Centrado -->
            <div class="text-center mt-4">
                <button type="submit" class="btn btn-red">Registrar</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal de Error de Bootstrap -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-danger text-white border-0 py-3">
        <h5 class="modal-title fw-bold" id="errorModalLabel"><i class="bi bi-exclamation-triangle-fill me-2"></i>Error de Validación</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4 fs-5" id="errorModalBody">
        <!-- Rellenado dinámicamente -->
      </div>
      <div class="modal-footer border-0">
        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous" defer></script>

</body>
</html>
