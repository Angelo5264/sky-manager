<%-- 
    Document   : receipt
    Created on : 12 may 2026, 12:59:10
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Comprobante de Reserva</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .receipt {
            max-width: 800px;
            margin: 2rem auto;
            border: 2px dashed #dee2e6;
            border-radius: 20px;
            padding: 2rem;
            background: white;
        }
        .receipt-header {
            text-align: center;
            border-bottom: 2px solid #667eea;
            padding-bottom: 1.5rem;
            margin-bottom: 1.5rem;
        }
        .barcode {
            height: 60px;
            background: repeating-linear-gradient(90deg, #000 0px, #000 2px, #fff 2px, #fff 4px);
            margin: 1rem 0;
            border-radius: 5px;
        }
        .stamp {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            border: 3px solid #28a745;
            color: #28a745;
            font-size: 2rem;
            font-weight: bold;
            padding: 0.5rem 2rem;
            border-radius: 10px;
            opacity: 0.3;
            pointer-events: none;
        }
        @media print {
            .no-print { display: none !important; }
            .receipt { border: none; }
        }
    </style>
</head>
<body class="bg-light">
    <div class="container">
        <div class="receipt position-relative">
            <c:if test="${booking.estadoReserva == 'CONFIRMADA'}">
                <div class="stamp">CONFIRMADO</div>
            </c:if>
            
            <div class="receipt-header">
                <h2 class="text-primary mb-2">✈️ SkyManager</h2>
                <h4>Comprobante de Reserva</h4>
                <p class="text-muted mb-0">Codigo: <strong class="fs-5">${booking.codigoConfirmacion}</strong></p>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <h6 class="text-muted">PASAJERO</h6>
                    <p class="mb-1"><strong>${user.nombreCompleto}</strong></p>
                    <p class="text-muted mb-0">${user.email}</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <h6 class="text-muted">FECHA DE RESERVA</h6>
                    <p class="mb-0"><strong>${booking.fechaReserva.toLocalDate()}</strong></p>
                    <small class="text-muted">${booking.fechaReserva.toLocalTime()}</small>
                </div>
            </div>

            <div class="card bg-light border-0 mb-4">
                <div class="card-body">
                    <div class="row align-items-center text-center">
                        <div class="col-md-4">
                            <h3 class="mb-0">${booking.origenCiudad}</h3>
                            <small class="text-muted">Origen</small>
                        </div>
                        <div class="col-md-4">
                            <i class="bi bi-airplane fs-1 text-primary"></i>
                            <p class="mb-0 text-muted">${booking.nombreAerolinea}</p>
                            <strong>${booking.numeroVuelo}</strong>
                        </div>
                        <div class="col-md-4">
                            <h3 class="mb-0">${booking.destinoCiudad}</h3>
                            <small class="text-muted">Destino</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-3 text-center mb-3">
                    <h6 class="text-muted">FECHA DE SALIDA</h6>
                    <p class="mb-0"><strong>${booking.fechaSalida.toLocalDate()}</strong></p>
                </div>
                <div class="col-md-3 text-center mb-3">
                    <h6 class="text-muted">HORA</h6>
                    <p class="mb-0"><strong>${booking.fechaSalida.toLocalTime()}</strong></p>
                </div>
                <div class="col-md-3 text-center mb-3">
                    <h6 class="text-muted">ASIENTO</h6>
                    <p class="mb-0"><strong class="fs-4 text-primary">${booking.numeroAsiento}</strong></p>
                </div>
                <div class="col-md-3 text-center mb-3">
                    <h6 class="text-muted">CLASE</h6>
                    <p class="mb-0"><strong>${booking.clase}</strong></p>
                </div>
            </div>

            <div class="barcode"></div>
            <p class="text-center text-muted small mb-4">Este codigo es unico y valido para el embarque</p>

            <div class="border-top pt-3">
                <div class="row">
                    <div class="col-md-6">
                        <h6 class="text-muted">ESTADO</h6>
                        <span class="badge bg-${booking.estadoReserva == 'CONFIRMADA' ? 'success' : booking.estadoReserva == 'CANCELADA' ? 'danger' : 'info'} fs-6">
                            ${booking.estadoReserva}
                        </span>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h6 class="text-muted">PRECIO TOTAL</h6>
                        <h3 class="text-primary mb-0">$${booking.precioFinal}</h3>
                    </div>
                </div>
            </div>

            <div class="mt-4 text-center no-print">
                <button onclick="window.print()" class="btn btn-primary me-2">
                    <i class="bi bi-printer"></i> Imprimir
                </button>
                <a href="${pageContext.request.contextPath}/bookings/history" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Volver
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
