<%-- 
    Document   : search
    Created on : 12 may 2026, 12:55:45
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Buscar Vuelos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .flight-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: all 0.3s;
            margin-bottom: 1.5rem;
        }
        .flight-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.12);
            transform: translateY(-2px);
        }
        .airline-logo {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        .price-tag {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2a5298;
        }
        .route-line {
            position: relative;
            height: 2px;
            background: #dee2e6;
            margin: 10px 0;
        }
        .route-line::after {
            content: '✈';
            position: absolute;
            right: 0;
            top: -10px;
            color: #667eea;
        }
        .search-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 2rem 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">✈️ SkyManager</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/flights/search">Buscar Vuelos</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/bookings/history">Mis Reservas</a></li>
                    <c:if test="${user.admin}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Panel Admin</a></li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${user.nombreCompleto}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Mi Perfil</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="search-header">
        <div class="container">
            <h3><i class="bi bi-search"></i> Resultados de Busqueda</h3>
            <form action="${pageContext.request.contextPath}/flights/search" method="get" class="mt-3">
                <div class="row g-2">
                    <div class="col-md-3">
                        <select name="origen" class="form-select">
                            <c:forEach items="${airports}" var="airport">
                                <option value="${airport.idAeropuerto}" ${param.origen == airport.idAeropuerto ? 'selected' : ''}>
                                    ${airport.ciudad} (${airport.codigoIata})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="destino" class="form-select">
                            <c:forEach items="${airports}" var="airport">
                                <option value="${airport.idAeropuerto}" ${param.destino == airport.idAeropuerto ? 'selected' : ''}>
                                    ${airport.ciudad} (${airport.codigoIata})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <input type="date" name="fecha" class="form-control" value="${param.fecha}">
                    </div>
                    <div class="col-md-2">
                        <select name="pasajeros" class="form-select">
                            <option value="1" ${param.pasajeros == '1' ? 'selected' : ''}>1 Pax</option>
                            <option value="2" ${param.pasajeros == '2' ? 'selected' : ''}>2 Pax</option>
                            <option value="3" ${param.pasajeros == '3' ? 'selected' : ''}>3 Pax</option>
                            <option value="4" ${param.pasajeros == '4' ? 'selected' : ''}>4 Pax</option>
                        </select>
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-light w-100"><i class="bi bi-search"></i></button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="container my-4">
        <c:if test="${empty flights}">
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> No se encontraron vuelos para los criterios seleccionados.
            </div>
        </c:if>

        <div class="row">
            <div class="col-lg-8">
                <c:forEach items="${flights}" var="flight">
                    <div class="card flight-card">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-2 text-center">
                                    <div class="airline-logo mx-auto">${flight.codigoAerolinea}</div>
                                    <small class="text-muted">${flight.nombreAerolinea}</small>
                                </div>
                                <div class="col-md-5">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="text-center">
                                            <h5 class="mb-0">${flight.origenIata}</h5>
                                            <small class="text-muted">${flight.fechaSalida.toLocalTime()}</small>
                                        </div>
                                        <div class="flex-grow-1 px-3">
                                            <div class="route-line"></div>
                                            <small class="text-muted d-block text-center">${flight.duracion}</small>
                                        </div>
                                        <div class="text-center">
                                            <h5 class="mb-0">${flight.destinoIata}</h5>
                                            <small class="text-muted">${flight.fechaLlegada.toLocalTime()}</small>
                                        </div>
                                    </div>
                                    <div class="mt-2">
                                        <small class="text-muted">
                                            <i class="bi bi-calendar"></i> ${flight.fechaSalida.toLocalDate()} | 
                                            <i class="bi bi-people"></i> ${flight.asientosDisponibles} asientos disp.
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-3 text-center">
                                    <div class="price-tag">$${flight.precioBase}</div>
                                    <small class="text-muted">por persona</small>
                                </div>
                                <div class="col-md-2">
                                    <a href="${pageContext.request.contextPath}/bookings/confirm?flightId=${flight.idVuelo}" 
                                       class="btn btn-primary w-100 ${flight.asientosDisponibles < 1 ? 'disabled' : ''}">
                                        ${flight.asientosDisponibles > 0 ? 'Reservar' : 'Agotado'}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <div class="col-lg-4">
                <div class="card shadow-sm sticky-top" style="top: 20px; z-index: 100;">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="bi bi-funnel"></i> Filtros</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">Ordenar por</label>
                            <select class="form-select">
                                <option value="">Seleccionar...</option>
                                <option value="price_asc">Precio: Menor a Mayor</option>
                                <option value="price_desc">Precio: Mayor a Menor</option>
                                <option value="duration">Duracion</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Aerolinea</label>
                            <c:forEach items="${airlines}" var="airline">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="${airline.idAerolinea}">
                                    <label class="form-check-label">${airline.nombre}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <%@ include file="/WEB-INF/views/components/chat-widget.jsp" %>
</body>
</html>
