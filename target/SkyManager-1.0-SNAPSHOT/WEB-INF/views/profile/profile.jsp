<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - SkyManager</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background: #f4f8fb;
        }

        .profile-header {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            border-radius: 0 0 30px 30px;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }

        .profile-avatar {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            background: white;
            color: #1e3c72;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: auto;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .card-custom {
            border: none;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .stat-box {
            border-radius: 18px;
            padding: 1.5rem;
            background: white;
            box-shadow: 0 6px 18px rgba(0,0,0,0.07);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }

        .btn-blue {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            border: none;
            color: white;
            border-radius: 25px;
            padding: 10px 30px;
        }

        .btn-blue:hover {
            color: white;
            opacity: .9;
        }
    </style>
</head>

<body>

<div class="profile-header text-center">
    <div class="container">
        <div class="profile-avatar mb-3">
            <i class="bi bi-person"></i>
        </div>

        <h2 class="fw-bold mb-1">${user.nombre} ${user.apellido}</h2>
        <p class="mb-1">${user.email}</p>
        <span class="badge bg-light text-primary px-3 py-2">${user.rol}</span>
    </div>
</div>

<div class="container mb-5">

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="row g-4 mb-4">

        <div class="col-md-3">
            <div class="stat-box d-flex align-items-center">
                <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3">
                    <i class="bi bi-airplane"></i>
                </div>
                <div>
                    <small class="text-muted">Vuelos activos</small>
                    <h4 class="mb-0">${vuelosActivos != null ? vuelosActivos : 0}</h4>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-box d-flex align-items-center">
                <div class="stat-icon bg-success bg-opacity-10 text-success me-3">
                    <i class="bi bi-ticket-perforated"></i>
                </div>
                <div>
                    <small class="text-muted">Reservas</small>
                    <h4 class="mb-0">${totalReservas != null ? totalReservas : 0}</h4>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-box d-flex align-items-center">
                <div class="stat-icon bg-info bg-opacity-10 text-info me-3">
                    <i class="bi bi-clock-history"></i>
                </div>
                <div>
                    <small class="text-muted">Pendientes</small>
                    <h4 class="mb-0">${reservasPendientes != null ? reservasPendientes : 0}</h4>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-box d-flex align-items-center">
                <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3">
                    <i class="bi bi-shield-check"></i>
                </div>
                <div>
                    <small class="text-muted">Estado</small>
                    <h6 class="mb-0">${user.estado}</h6>
                </div>
            </div>
        </div>

    </div>

    <div class="row g-4">

        <div class="col-lg-7">
            <div class="card card-custom">
                <div class="card-header bg-white border-0 pt-4 px-4">
                    <h5 class="mb-0">
                        <i class="bi bi-pencil-square text-primary"></i>
                        Editar información personal
                    </h5>
                </div>

                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/profile" method="post">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombre</label>
                                <input type="text" name="nombre" class="form-control" value="${user.nombre}">
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellido</label>
                                <input type="text" name="apellido" class="form-control" value="${user.apellido}">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Correo electrónico</label>
                            <input type="email" name="email" class="form-control" value="${user.email}">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Rol</label>
                                <input type="text" class="form-control" value="${user.rol}" disabled>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Estado</label>
                                <input type="text" class="form-control" value="${user.estado}" disabled>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-blue">
                            <i class="bi bi-save"></i> Guardar cambios
                        </button>

                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card card-custom mb-4">
                <div class="card-body p-4">
                    <h5 class="mb-3">
                        <i class="bi bi-gear text-primary"></i>
                        Gestión rápida
                    </h5>

                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/bookings/history" class="btn btn-outline-primary">
                            <i class="bi bi-ticket-perforated"></i> Ver mis reservas
                        </a>

                        <a href="${pageContext.request.contextPath}/flights/search" class="btn btn-outline-primary">
                            <i class="bi bi-search"></i> Buscar nuevos vuelos
                        </a>

                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                            <i class="bi bi-house"></i> Volver al inicio
                        </a>
                    </div>
                </div>
            </div>

            <div class="card card-custom">
                <div class="card-body p-4">
                    <h5 class="mb-3">
                        <i class="bi bi-calendar-check text-primary"></i>
                        Próximo vuelo
                    </h5>

                    <c:choose>
                        <c:when test="${not empty proximoVuelo}">
                            <p class="mb-1"><strong>Ruta:</strong> ${proximoVuelo.origenCiudad} → ${proximoVuelo.destinoCiudad}</p>
                            <p class="mb-1"><strong>Vuelo:</strong> ${proximoVuelo.numeroVuelo}</p>
                            <p class="mb-0"><strong>Fecha:</strong> ${proximoVuelo.fechaSalida.toLocalDate()}</p>
                        </c:when>

                        <c:otherwise>
                            <p class="text-muted mb-0">
                                No tienes vuelos próximos registrados.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>