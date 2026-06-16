<%-- 
    Document   : register
    Created on : 12 may 2026, 12:55:05
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        .register-form { padding: 2.5rem; }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
        }
        .form-control {
            border-radius: 25px;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="register-container">
                    <div class="register-header">
                        <div class="logo-icon">✈️</div>
                        <h3 class="mb-0">Crear Cuenta</h3>
                        <small>Unete a SkyManager</small>
                    </div>
                    <div class="register-form">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <form action="${pageContext.request.contextPath}/register" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Nombre</label>
                                    <input type="text" name="nombre" class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Apellido</label>
                                    <input type="text" name="apellido" class="form-control" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Correo Electronico</label>
                                <input type="email" name="email" class="form-control" placeholder="tu@email.com" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Contrasena</label>
                                <input type="password" name="password" class="form-control" placeholder="Minimo 6 caracteres" required minlength="6">
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Confirmar Contrasena</label>
                                <input type="password" name="confirmPassword" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-register mb-3">Registrarse</button>
                            <div class="text-center">
                                <p class="mb-0">¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Inicia sesion</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>