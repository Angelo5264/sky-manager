/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.dao;

/**
 *
 * @author maick
 */

import com.skymanager.config.DatabaseConfig;
import com.skymanager.model.Flight;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlightDAO {
    
    public List<Flight> findAll() {
        List<Flight> flights = new ArrayList<>();
        String sql = "SELECT v.*, a.nombre as nombre_aerolinea, a.codigo_iata as codigo_aerolinea, " +
                     "ao.ciudad as origen_ciudad, ao.codigo_iata as origen_iata, " +
                     "ad.ciudad as destino_ciudad, ad.codigo_iata as destino_iata " +
                     "FROM vuelo v " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "WHERE v.estado = 'PROGRAMADO' " +
                     "ORDER BY v.fecha_salida";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                flights.add(mapFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }
    
    public List<Flight> search(Integer origen, Integer destino, String fecha, Integer pasajeros) {
        List<Flight> flights = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT v.*, a.nombre as nombre_aerolinea, a.codigo_iata as codigo_aerolinea, " +
            "ao.ciudad as origen_ciudad, ao.codigo_iata as origen_iata, " +
            "ad.ciudad as destino_ciudad, ad.codigo_iata as destino_iata " +
            "FROM vuelo v " +
            "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
            "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
            "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
            "WHERE v.estado = 'PROGRAMADO' "
        );
        
        List<Object> params = new ArrayList<>();
        
        if (origen != null) {
            sql.append("AND v.id_aeropuerto_origen = ? ");
            params.add(origen);
        }
        if (destino != null) {
            sql.append("AND v.id_aeropuerto_destino = ? ");
            params.add(destino);
        }
        if (fecha != null && !fecha.isEmpty()) {
            sql.append("AND DATE(v.fecha_salida) = ? ");
            params.add(fecha);
        }
        if (pasajeros != null) {
            sql.append("AND v.asientos_disponibles >= ? ");
            params.add(pasajeros);
        }
        
        sql.append("ORDER BY v.precio_base ASC, v.fecha_salida ASC");
        
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                flights.add(mapFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }
    
    public Flight findById(int id) {
        String sql = "SELECT v.*, a.nombre as nombre_aerolinea, a.codigo_iata as codigo_aerolinea, " +
                     "ao.ciudad as origen_ciudad, ao.codigo_iata as origen_iata, " +
                     "ad.ciudad as destino_ciudad, ad.codigo_iata as destino_iata " +
                     "FROM vuelo v " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "WHERE v.id_vuelo = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapFlight(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean create(Flight flight) {
        String sql = "INSERT INTO vuelo (id_aerolinea, id_aeropuerto_origen, id_aeropuerto_destino, " +
                     "numero_vuelo, fecha_salida, fecha_llegada, capacidad_total, asientos_disponibles, precio_base) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, flight.getIdAerolinea());
            ps.setInt(2, flight.getIdAeropuertoOrigen());
            ps.setInt(3, flight.getIdAeropuertoDestino());
            ps.setString(4, flight.getNumeroVuelo());
            ps.setTimestamp(5, Timestamp.valueOf(flight.getFechaSalida()));
            ps.setTimestamp(6, Timestamp.valueOf(flight.getFechaLlegada()));
            ps.setInt(7, flight.getCapacidadTotal());
            ps.setInt(8, flight.getAsientosDisponibles());
            ps.setBigDecimal(9, flight.getPrecioBase());
            
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    flight.setIdVuelo(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean update(Flight flight) {
        String sql = "UPDATE vuelo SET id_aerolinea=?, id_aeropuerto_origen=?, id_aeropuerto_destino=?, " +
                     "numero_vuelo=?, fecha_salida=?, fecha_llegada=?, capacidad_total=?, " +
                     "asientos_disponibles=?, precio_base=?, estado=? WHERE id_vuelo=?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, flight.getIdAerolinea());
            ps.setInt(2, flight.getIdAeropuertoOrigen());
            ps.setInt(3, flight.getIdAeropuertoDestino());
            ps.setString(4, flight.getNumeroVuelo());
            ps.setTimestamp(5, Timestamp.valueOf(flight.getFechaSalida()));
            ps.setTimestamp(6, Timestamp.valueOf(flight.getFechaLlegada()));
            ps.setInt(7, flight.getCapacidadTotal());
            ps.setInt(8, flight.getAsientosDisponibles());
            ps.setBigDecimal(9, flight.getPrecioBase());
            ps.setString(10, flight.getEstado());
            ps.setInt(11, flight.getIdVuelo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateAvailableSeats(int flightId, int delta) {
        String sql = "UPDATE vuelo SET asientos_disponibles = asientos_disponibles + ? WHERE id_vuelo = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, delta);
            ps.setInt(2, flightId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean delete(int id) {
        String sql = "UPDATE vuelo SET estado='CANCELADO' WHERE id_vuelo=?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int countFlights() {
        String sql = "SELECT COUNT(*) FROM vuelo WHERE estado != 'CANCELADO'";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private Flight mapFlight(ResultSet rs) throws SQLException {
        Flight flight = new Flight();
        flight.setIdVuelo(rs.getInt("id_vuelo"));
        flight.setIdAerolinea(rs.getInt("id_aerolinea"));
        flight.setIdAeropuertoOrigen(rs.getInt("id_aeropuerto_origen"));
        flight.setIdAeropuertoDestino(rs.getInt("id_aeropuerto_destino"));
        flight.setNumeroVuelo(rs.getString("numero_vuelo"));
        flight.setFechaSalida(rs.getTimestamp("fecha_salida").toLocalDateTime());
        flight.setFechaLlegada(rs.getTimestamp("fecha_llegada").toLocalDateTime());
        flight.setCapacidadTotal(rs.getInt("capacidad_total"));
        flight.setAsientosDisponibles(rs.getInt("asientos_disponibles"));
        flight.setPrecioBase(rs.getBigDecimal("precio_base"));
        flight.setEstado(rs.getString("estado"));
        
        flight.setNombreAerolinea(rs.getString("nombre_aerolinea"));
        flight.setCodigoAerolinea(rs.getString("codigo_aerolinea"));
        flight.setOrigenCiudad(rs.getString("origen_ciudad"));
        flight.setOrigenIata(rs.getString("origen_iata"));
        flight.setDestinoCiudad(rs.getString("destino_ciudad"));
        flight.setDestinoIata(rs.getString("destino_iata"));
        
        return flight;
    }
}