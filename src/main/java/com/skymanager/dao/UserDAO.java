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
import com.skymanager.model.User;
import com.skymanager.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    public User findByEmail(String email) {
        String sql = "SELECT * FROM usuario WHERE email = ? AND estado = 'ACTIVO'";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public User findById(int id) {
        String sql = "SELECT * FROM usuario WHERE id_usuario = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM usuario ORDER BY fecha_registro DESC";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public boolean create(User user) {
        String sql = "INSERT INTO usuario (nombre, apellido, email, password_hash, rol) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setString(3, user.getEmail());
            ps.setString(4, PasswordUtil.hashPassword(user.getPasswordHash()));
            ps.setString(5, user.getRol());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    user.setIdUsuario(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean update(User user) {
        String sql = "UPDATE usuario SET nombre=?, apellido=?, email=?, rol=?, estado=? WHERE id_usuario=?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getNombre());
            ps.setString(2, user.getApellido());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRol());
            ps.setString(5, user.getEstado());
            ps.setInt(6, user.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean delete(int id) {
        String sql = "UPDATE usuario SET estado='INACTIVO' WHERE id_usuario=?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM usuario WHERE estado = 'ACTIVO'";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setIdUsuario(rs.getInt("id_usuario"));
        user.setNombre(rs.getString("nombre"));
        user.setApellido(rs.getString("apellido"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setRol(rs.getString("rol"));
        user.setFechaRegistro(rs.getTimestamp("fecha_registro").toLocalDateTime());
        user.setEstado(rs.getString("estado"));
        return user;
    }
}