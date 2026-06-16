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
import com.skymanager.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class BookingDAO {
    
    public List<Booking> findByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT r.*, v.numero_vuelo, ao.ciudad as origen_ciudad, ad.ciudad as destino_ciudad, " +
                     "v.fecha_salida, a.nombre as nombre_aerolinea " +
                     "FROM reserva r " +
                     "JOIN vuelo v ON r.id_vuelo = v.id_vuelo " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "WHERE r.id_usuario = ? ORDER BY r.fecha_reserva DESC";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    public List<Booking> findAll() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT r.*, v.numero_vuelo, ao.ciudad as origen_ciudad, ad.ciudad as destino_ciudad, " +
                     "v.fecha_salida, a.nombre as nombre_aerolinea, u.nombre as pasajero_nombre, u.apellido " +
                     "FROM reserva r " +
                     "JOIN vuelo v ON r.id_vuelo = v.id_vuelo " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "JOIN usuario u ON r.id_usuario = u.id_usuario " +
                     "ORDER BY r.fecha_reserva DESC";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    public Booking findById(int id) {
        String sql = "SELECT r.*, v.numero_vuelo, ao.ciudad as origen_ciudad, ad.ciudad as destino_ciudad, " +
                     "v.fecha_salida, a.nombre as nombre_aerolinea, u.nombre as pasajero_nombre, u.apellido " +
                     "FROM reserva r " +
                     "JOIN vuelo v ON r.id_vuelo = v.id_vuelo " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "JOIN usuario u ON r.id_usuario = u.id_usuario " +
                     "WHERE r.id_reserva = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBooking(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Booking findByConfirmationCode(String code) {
        String sql = "SELECT r.*, v.numero_vuelo, ao.ciudad as origen_ciudad, ad.ciudad as destino_ciudad, " +
                     "v.fecha_salida, a.nombre as nombre_aerolinea, u.nombre as pasajero_nombre, u.apellido " +
                     "FROM reserva r " +
                     "JOIN vuelo v ON r.id_vuelo = v.id_vuelo " +
                     "JOIN aeropuerto ao ON v.id_aeropuerto_origen = ao.id_aeropuerto " +
                     "JOIN aeropuerto ad ON v.id_aeropuerto_destino = ad.id_aeropuerto " +
                     "JOIN aerolinea a ON v.id_aerolinea = a.id_aerolinea " +
                     "JOIN usuario u ON r.id_usuario = u.id_usuario " +
                     "WHERE r.codigo_confirmacion = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBooking(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean create(Booking booking) {
        String sql = "INSERT INTO reserva (id_usuario, id_vuelo, numero_asiento, clase, precio_final, codigo_confirmacion) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            String code = "SKY-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            ps.setInt(1, booking.getIdUsuario());
            ps.setInt(2, booking.getIdVuelo());
            ps.setString(3, booking.getNumeroAsiento());
            ps.setString(4, booking.getClase());
            ps.setBigDecimal(5, booking.getPrecioFinal());
            ps.setString(6, code);
            
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    booking.setIdReserva(rs.getInt(1));
                    booking.setCodigoConfirmacion(code);
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean cancel(int bookingId) {
        String sql = "UPDATE reserva SET estado_reserva='CANCELADA' WHERE id_reserva=? AND estado_reserva='CONFIRMADA'";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int countBookings() {
        String sql = "SELECT COUNT(*) FROM reserva WHERE estado_reserva = 'CONFIRMADA'";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setIdReserva(rs.getInt("id_reserva"));
        booking.setIdUsuario(rs.getInt("id_usuario"));
        booking.setIdVuelo(rs.getInt("id_vuelo"));
        booking.setFechaReserva(rs.getTimestamp("fecha_reserva").toLocalDateTime());
        booking.setNumeroAsiento(rs.getString("numero_asiento"));
        booking.setClase(rs.getString("clase"));
        booking.setPrecioFinal(rs.getBigDecimal("precio_final"));
        booking.setEstadoReserva(rs.getString("estado_reserva"));
        booking.setCodigoConfirmacion(rs.getString("codigo_confirmacion"));
        
        booking.setNumeroVuelo(rs.getString("numero_vuelo"));
        booking.setOrigenCiudad(rs.getString("origen_ciudad"));
        booking.setDestinoCiudad(rs.getString("destino_ciudad"));
        booking.setFechaSalida(rs.getTimestamp("fecha_salida").toLocalDateTime());
        booking.setNombreAerolinea(rs.getString("nombre_aerolinea"));
        
        String pasajero = rs.getString("pasajero_nombre");
        if (pasajero != null) {
            booking.setPasajeroNombre(pasajero + " " + rs.getString("apellido"));
        }
        
        return booking;
    }
}