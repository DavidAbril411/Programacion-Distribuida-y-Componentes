<%--
  Created by IntelliJ IDEA.
  User: Lab4-PC04
  Date: 11/6/2026
  Time: 18:15
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<div class="col-md-5" id="ultimas">

    <div class="card">

        <div class="card-header">
            Últimas 3 reseñas
        </div>

        <div class="card-body">
            <c:forEach var="resena" items="${resenas}">
                <div class="border-bottom pb-3 mb-3">

                    <div class="d-flex justify-content-between">

                        <strong>${resena.sitio}</strong>

                        <span>
								${resena.puntuacion} <i class="bi bi-star-fill text-warning"></i>
							</span>

                    </div>

                    <p class="my-2">
                            ${resena.observaciones}
                    </p>

                    <small class="text-muted">
                            ${resena.apodo}  · ${resena.fecha}
                    </small>
                </div>
            </c:forEach>

        </div>

    </div>
</div>