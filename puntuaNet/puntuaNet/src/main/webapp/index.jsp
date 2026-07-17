<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ies">
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"
            defer></script>
    <script src="js/utils.js" defer></script>
    <script src="js/puntuaNet.js" defer></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
          defer>
</head>
<body>

<div class="container mt-4">

    <div class="row">

        <!-- Formulario -->
        <div class="col-md-7" id="paraBefore">
            <form id="iGuardarForm" action="javascript:void(0)">
            <div class="card">

                <div class="card-header">
                    Registrar reseña
                </div>

                <div class="card-body">

                    <div class="mb-3">
                        <label for="icorreo" class="form-label">Correo electrónico</label>
                        <input id="icorreo" type="text" name="correo" class="form-control" placeholder="Informa tu correo" required>
                    </div>

                    <div class="mb-3">
                        <label for="iapodo" class="form-label">Apodo</label>
                        <input id="iapodo" type="text" name="apodo" class="form-control" placeholder="Informa un apodo para tu reseña" required>
                    </div>

                    <div class="mb-3">
                        <label for="iurl" class="form-label">URL del sitio</label>
                        <input id="iurl" type="url" name="url" class="form-control"  placeholder="Informa la dirección del sitio que deseas reseñar" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label d-block" for="ie0">
                            Puntuación
                        </label>

                        <div class="d-flex gap-4">

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie0"
                                       value="0"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie0">
                                    <i class="bi bi-star text-warning"></i><br>
                                    0
                                </label>
                            </div>

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie1"
                                       value="1"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie1">
                                    <i class="bi bi-star text-warning"></i><br>
                                    1
                                </label>
                            </div>

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie2"
                                       value="2"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie2">
                                    <i class="bi bi-star text-warning"></i><br>
                                    2
                                </label>
                            </div>

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie3"
                                       value="3"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie3">
                                    <i class="bi bi-star text-warning"></i><br>
                                    3
                                </label>
                            </div>

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie4"
                                       value="4"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie4">
                                    <i class="bi bi-star text-warning"></i><br>
                                    4
                                </label>
                            </div>

                            <div class="form-check text-center">
                                <input class="form-check-input"
                                       type="radio"
                                       name="puntuacion"
                                       id="ie5"
                                       value="5"
                                       required
                                >

                                <label class="form-check-label d-block" for="ie5">
                                    <i class="bi bi-star text-warning"></i><br>
                                    5
                                </label>
                            </div>

                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="icomentario" class="form-label">Reseña</label>
                        <textarea id="icomentario" name="resena" rows="5" class="form-control"  placeholder="Comenta sobre tu valoración" required></textarea>
                    </div>

                </div>

                <div class="card-footer text-end">

                    <button class="btn btn-secondary">
                        Cancelar
                    </button>

                    <button class="btn btn-primary">
                        Guardar
                    </button>

                </div>

            </div>
            </form>
        </div>

    </div>

</div>

</body>
</html>