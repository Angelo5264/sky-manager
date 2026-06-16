<%-- 
    Document   : history
    Created on : 12 may 2026, 12:56:32
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Mis Reservas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .booking-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 1.5rem;
            transition: all 0.3s;
        }
        .booking-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
        }
        .status-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">✈️ SkyManager</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/flights/search">Buscar Vuelos</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/bookings/history">Mis Reservas</a></li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${user.nombreCompleto}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <h3 class="mb-4"><i class="bi bi-journal-text"></i> Historial de Reservas</h3>
        
        <c:if test="${empty bookings}">
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> No tienes reservas registradas.
                <br><a href="${pageContext.request.contextPath}/flights/search" class="btn btn-primary mt-2">Buscar Vuelos</a>
            </div>
        </c:if>

        <div class="row">
            <c:forEach items="${bookings}" var="booking">
                <div class="col-md-6 col-lg-4">
                    <div class="card booking-card position-relative">
                        <span class="badge bg-${booking.estadoReserva == 'CONFIRMADA' ? 'success' : 'danger'} status-badge">${booking.estadoReserva}</span>
                        <div class="card-body">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-2 me-3">
                                    <i class="bi bi-airplane fs-4"></i>
                                </div>
                                <div>
                                    <h5 class="mb-0">${booking.nombreAerolinea}</h5>
                                    <small class="text-muted">${booking.numeroVuelo}</small>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-0">${booking.origenCiudad}</h6>
                                        <small class="text-muted">${booking.fechaSalida.toLocalTime()}</small>
                                    </div>
                                    <i class="bi bi-arrow-right text-primary"></i>
                                    <div class="text-end">
                                        <h6 class="mb-0">${booking.destinoCiudad}</h6>
                                        <small class="text-muted">${booking.fechaSalida.toLocalDate()}</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="border-top pt-3">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <small class="text-muted d-block">Asiento</small>
                                        <strong>${booking.numeroAsiento}</strong>
                                    </div>
                                    <div class="col-4">
                                        <small class="text-muted d-block">Clase</small>
                                        <strong>${booking.clase}</strong>
                                    </div>
                                    <div class="col-4">
                                        <small class="text-muted d-block">Precio</small>
                                        <strong>$${booking.precioFinal}</strong>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-3 d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/bookings/receipt?code=${booking.codigoConfirmacion}" 
                                   class="btn btn-outline-primary btn-sm flex-fill">
                                    <i class="bi bi-file-earmark-text"></i> Comprobante
                                </a>
                                <c:if test="${booking.estadoReserva == 'CONFIRMADA'}">
                                    <form action="${pageContext.request.contextPath}/bookings/cancel" method="post" class="flex-fill">
                                        <input type="hidden" name="bookingId" value="${booking.idReserva}">
                                        <button type="submit" class="btn btn-outline-danger btn-sm w-100" 
                                                onclick="return confirm('¿Estas seguro de cancelar esta reserva?')">
                                            <i class="bi bi-x-circle"></i> Cancelar
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                            
                            <div class="mt-2 text-center">
                                <small class="text-muted">Codigo: <strong>${booking.codigoConfirmacion}</strong></small>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
