<%-- 
    Document   : home
    Created on : 12 may 2026, 12:55:24
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 4rem 0;
            margin-bottom: 3rem;
        }
        .search-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: -3rem;
        }
        .feature-card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .feature-card:hover { transform: translateY(-5px); }
        .feature-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .btn-search {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 12px 40px;
            font-weight: 600;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
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
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/flights/search">Buscar Vuelos</a></li>
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

    <div class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-3">Explora el Mundo con SkyManager</h1>
            <p class="lead mb-0">Reserva tus vuelos de forma rapida, segura y eficiente</p>
        </div>
    </div>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="search-card">
                    <h4 class="mb-4 text-center"><i class="bi bi-search"></i> Busca tu proximo vuelo</h4>
                    <form action="${pageContext.request.contextPath}/flights/search" method="get">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Origen</label>
                                <select name="origen" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${airports}" var="airport">
                                        <option value="${airport.idAeropuerto}">${airport.ciudad} (${airport.codigoIata})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Destino</label>
                                <select name="destino" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${airports}" var="airport">
                                        <option value="${airport.idAeropuerto}">${airport.ciudad} (${airport.codigoIata})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Fecha</label>
                                <input type="date" name="fecha" class="form-control" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Pasajeros</label>
                                <select name="pasajeros" class="form-select">
                                    <option value="1">1 Pasajero</option>
                                    <option value="2">2 Pasajeros</option>
                                    <option value="3">3 Pasajeros</option>
                                    <option value="4">4 Pasajeros</option>
                                </select>
                            </div>
                            <div class="col-12 text-center mt-3">
                                <button type="submit" class="btn btn-primary btn-search">
                                    <i class="bi bi-search"></i> Buscar Vuelos
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="row mt-5 mb-5">
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon bg-primary bg-opacity-10 text-primary mx-auto">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <h5>Seguridad Garantizada</h5>
                        <p class="text-muted mb-0">Tus datos y transacciones estan protegidos con encriptacion de nivel bancario.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon bg-success bg-opacity-10 text-success mx-auto">
                            <i class="bi bi-lightning-charge"></i>
                        </div>
                        <h5>Reserva Rapida</h5>
                        <p class="text-muted mb-0">Proceso de reserva optimizado en menos de 3 minutos.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100">
                    <div class="card-body text-center p-4">
                        <div class="feature-icon bg-info bg-opacity-10 text-info mx-auto">
                            <i class="bi bi-headset"></i>
                        </div>
                        <h5>Soporte 24/7</h5>
                        <p class="text-muted mb-0">Asistencia personalizada para cualquier consulta o modificacion.</p>
                    </div>
                </div>
            </div>
        </div>

        <h3 class="mb-4"><i class="bi bi-star-fill text-warning"></i> Vuelos Populares</h3>
        <div class="row">
            <c:forEach items="${popularFlights}" var="flight" varStatus="loop">
                <c:if test="${loop.index < 3}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <span class="badge bg-primary">${flight.nombreAerolinea}</span>
                                    <span class="text-success fw-bold">$${flight.precioBase}</span>
                                </div>
                                <h5 class="card-title">${flight.origenCiudad} → ${flight.destinoCiudad}</h5>
                                <p class="text-muted mb-2">
                                    <i class="bi bi-airplane"></i> ${flight.numeroVuelo}<br>
                                    <i class="bi bi-calendar"></i> ${flight.fechaSalida.toLocalDate()}<br>
                                    <i class="bi bi-clock"></i> ${flight.duracion}
                                </p>
                                <a href="${pageContext.request.contextPath}/flights/search?origen=${flight.idAeropuertoOrigen}&destino=${flight.idAeropuertoDestino}&fecha=${flight.fechaSalida.toLocalDate()}&pasajeros=1" 
                                   class="btn btn-outline-primary w-100">Ver Detalles</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-4 mt-5">
        <div class="container">
            <p class="mb-0"> SkyManager - Sistema de Gestion de Vuelos | Desarrollo Web Integrado</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
