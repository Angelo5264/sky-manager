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
import com.skymanager.model.Seat;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {
    
    public List<Seat> findByFlightId(int flightId) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM asiento WHERE id_vuelo = ? ORDER BY clase, numero_asiento";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, flightId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seats.add(mapSeat(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }
    
    public List<Seat> findAvailableByFlightId(int flightId) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM asiento WHERE id_vuelo = ? AND disponible = TRUE ORDER BY numero_asiento";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, flightId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seats.add(mapSeat(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }
    
    public boolean reserveSeat(int seatId, int bookingId) {
        String sql = "UPDATE asiento SET disponible = FALSE, id_reserva = ? WHERE id_asiento = ? AND disponible = TRUE";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, seatId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean releaseSeat(int bookingId) {
        String sql = "UPDATE asiento SET disponible = TRUE, id_reserva = NULL WHERE id_reserva = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Seat mapSeat(ResultSet rs) throws SQLException {
        Seat seat = new Seat();
        seat.setIdAsiento(rs.getInt("id_asiento"));
        seat.setIdVuelo(rs.getInt("id_vuelo"));
        seat.setNumeroAsiento(rs.getString("numero_asiento"));
        seat.setClase(rs.getString("clase"));
        seat.setDisponible(rs.getBoolean("disponible"));
        seat.setIdReserva(rs.getObject("id_reserva") != null ? rs.getInt("id_reserva") : null);
        return seat;
    }
}