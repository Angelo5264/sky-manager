/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.controller;

/**
 *
 * @author maick
 */
import com.skymanager.dao.UserDAO;
import com.skymanager.model.User;
import com.skymanager.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/login" -> req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            case "/register" -> req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            case "/logout" -> {
                HttpSession session = req.getSession(false);
                if (session != null) session.invalidate();
                resp.sendRedirect(req.getContextPath() + "/login");
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/login" -> {
                String email = req.getParameter("email");
                String password = req.getParameter("password");
                
                User user = userDAO.findByEmail(email);
                if (user != null && PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);
                    resp.sendRedirect(req.getContextPath() + "/home");
                } else {
                    req.setAttribute("error", "Credenciales incorrectas");
                    req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                }
            }
            case "/register" -> {
                String nombre = req.getParameter("nombre");
                String apellido = req.getParameter("apellido");
                String email = req.getParameter("email");
                String password = req.getParameter("password");
                String confirmPassword = req.getParameter("confirmPassword");
                
                if (!password.equals(confirmPassword)) {
                    req.setAttribute("error", "Las contrasenas no coinciden");
                    req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                    return;
                }
                
                if (userDAO.findByEmail(email) != null) {
                    req.setAttribute("error", "El correo ya esta registrado");
                    req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                    return;
                }
                
                User newUser = new User();
                newUser.setNombre(nombre);
                newUser.setApellido(apellido);
                newUser.setEmail(email);
                newUser.setPasswordHash(password);
                newUser.setRol("PASAJERO");
                
                if (userDAO.create(newUser)) {
                    req.setAttribute("success", "Cuenta creada exitosamente. Inicia sesion.");
                    req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                } else {
                    req.setAttribute("error", "Error al crear la cuenta");
                    req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
                }
            }
        }
    }
}