-- LA CONTRASEÑA DE ADMIN es 123456

CREATE DATABASE IF NOT EXISTS skymanager 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE skymanager;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('PASAJERO', 'ADMINISTRADOR') DEFAULT 'PASAJERO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('ACTIVO', 'INACTIVO') DEFAULT 'ACTIVO'
);

CREATE TABLE aeropuerto (
    id_aeropuerto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_iata CHAR(3) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE aerolinea (
    id_aerolinea INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo_iata CHAR(2) NOT NULL UNIQUE,
    pais_origen VARCHAR(100) NOT NULL
);

CREATE TABLE vuelo (
    id_vuelo INT AUTO_INCREMENT PRIMARY KEY,
    id_aerolinea INT NOT NULL,
    id_aeropuerto_origen INT NOT NULL,
    id_aeropuerto_destino INT NOT NULL,
    numero_vuelo VARCHAR(20) NOT NULL UNIQUE,
    fecha_salida DATETIME NOT NULL,
    fecha_llegada DATETIME NOT NULL,
    capacidad_total INT NOT NULL,
    asientos_disponibles INT NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL,
    estado ENUM('PROGRAMADO', 'EN_VUELO', 'ATERRIZADO', 'CANCELADO') DEFAULT 'PROGRAMADO',
    FOREIGN KEY (id_aerolinea) REFERENCES aerolinea(id_aerolinea),
    FOREIGN KEY (id_aeropuerto_origen) REFERENCES aeropuerto(id_aeropuerto),
    FOREIGN KEY (id_aeropuerto_destino) REFERENCES aeropuerto(id_aeropuerto)
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_vuelo INT NOT NULL,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    numero_asiento VARCHAR(10) NOT NULL,
    clase ENUM('ECONOMICA', 'EJECUTIVA', 'PRIMERA') DEFAULT 'ECONOMICA',
    precio_final DECIMAL(10,2) NOT NULL,
    estado_reserva ENUM('CONFIRMADA', 'CANCELADA', 'COMPLETADA') DEFAULT 'CONFIRMADA',
    codigo_confirmacion VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_vuelo) REFERENCES vuelo(id_vuelo)
);

CREATE TABLE asiento (
    id_asiento INT AUTO_INCREMENT PRIMARY KEY,
    id_vuelo INT NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL,
    clase ENUM('ECONOMICA', 'EJECUTIVA', 'PRIMERA') DEFAULT 'ECONOMICA',
    disponible BOOLEAN DEFAULT TRUE,
    id_reserva INT NULL,
    FOREIGN KEY (id_vuelo) REFERENCES vuelo(id_vuelo),
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    UNIQUE KEY uk_vuelo_asiento (id_vuelo, numero_asiento)
);

-- DATOS DE PRUEBA

INSERT INTO usuario (nombre, apellido, email, password_hash, rol) VALUES
('Admin', 'Sistema', 'admin@skymanager.com', '$2a$12$/Xzwgu9Cpp1pjUxQRJ8CsuwsM8mEh5yfrd8PVmMDZ3mb4TVH4aeAW', 'ADMINISTRADOR'),
('Jose', 'Yachas', 'jose@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'PASAJERO'),
('Anaiz', 'Palomino', 'anaiz@email.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MqrqhmM6JGKpS4G3R1G2JH8YpfB0Bqy', 'PASAJERO');



INSERT INTO aeropuerto (codigo_iata, nombre, ciudad, pais) VALUES
('LIM', 'Jorge Chavez', 'Lima', 'Peru'),
('CUZ', 'Alejandro Velasco Astete', 'Cusco', 'Peru'),
('AQP', 'Rodriguez Ballon', 'Arequipa', 'Peru'),
('TRU', 'Capitan FAP Carlos Martinez de Pinillos', 'Trujillo', 'Peru'),
('JUL', 'Inca Manco Capac', 'Juliaca', 'Peru'),
('MIA', 'Miami International', 'Miami', 'Estados Unidos'),
('MAD', 'Adolfo Suarez Madrid-Barajas', 'Madrid', 'Espana'),
('BOG', 'El Dorado', 'Bogota', 'Colombia');

INSERT INTO aerolinea (nombre, codigo_iata, pais_origen) VALUES
('Avianca', 'AV', 'Colombia'),
('LATAM Airlines', 'LA', 'Chile'),
('Sky Airline', 'H2', 'Peru'),
('JetSmart', 'JA', 'Chile');

INSERT INTO vuelo (id_aerolinea, id_aeropuerto_origen, id_aeropuerto_destino, numero_vuelo, fecha_salida, fecha_llegada, capacidad_total, asientos_disponibles, precio_base, estado) VALUES
(1, 1, 2, 'AV1234', '2026-05-15 08:00:00', '2026-05-15 09:10:00', 180, 150, 350.00, 'PROGRAMADO'),
(1, 1, 2, 'AV1235', '2026-05-15 14:30:00', '2026-05-15 15:40:00', 180, 120, 380.00, 'PROGRAMADO'),
(2, 1, 2, 'LA2051', '2026-05-15 10:00:00', '2026-05-15 11:15:00', 220, 200, 320.00, 'PROGRAMADO'),
(1, 1, 3, 'AV2100', '2026-05-16 07:00:00', '2026-05-16 08:15:00', 160, 140, 280.00, 'PROGRAMADO'),
(2, 1, 8, 'LA2400', '2026-05-17 23:00:00', '2026-05-18 06:30:00', 250, 230, 1200.00, 'PROGRAMADO'),
(3, 1, 2, 'H2101', '2026-05-15 16:00:00', '2026-05-15 17:10:00', 186, 180, 250.00, 'PROGRAMADO');

-- Generar asientos
DELIMITER //
CREATE PROCEDURE GenerateSeats()
BEGIN
    DECLARE v_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT id_vuelo FROM vuelo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_id;
        IF done THEN LEAVE read_loop; END IF;
        
        SET @row = 1;
        WHILE @row <= 25 DO
            INSERT INTO asiento (id_vuelo, numero_asiento, clase, disponible) VALUES
            (v_id, CONCAT(@row, 'A'), 'ECONOMICA', TRUE),
            (v_id, CONCAT(@row, 'B'), 'ECONOMICA', TRUE),
            (v_id, CONCAT(@row, 'C'), 'ECONOMICA', TRUE),
            (v_id, CONCAT(@row, 'D'), 'ECONOMICA', TRUE),
            (v_id, CONCAT(@row, 'E'), 'ECONOMICA', TRUE),
            (v_id, CONCAT(@row, 'F'), 'ECONOMICA', TRUE);
            SET @row = @row + 1;
        END WHILE;
        
        SET @row = 26;
        WHILE @row <= 30 DO
            INSERT INTO asiento (id_vuelo, numero_asiento, clase, disponible) VALUES
            (v_id, CONCAT(@row, 'A'), 'EJECUTIVA', TRUE),
            (v_id, CONCAT(@row, 'B'), 'EJECUTIVA', TRUE),
            (v_id, CONCAT(@row, 'C'), 'EJECUTIVA', TRUE),
            (v_id, CONCAT(@row, 'D'), 'EJECUTIVA', TRUE);
            SET @row = @row + 1;
        END WHILE;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

CALL GenerateSeats();
DROP PROCEDURE GenerateSeats;
