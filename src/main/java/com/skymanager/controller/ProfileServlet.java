package com.skymanager.controller;

import java.io.IOException;

import com.skymanager.dao.BookingDAO;
import com.skymanager.dao.UserDAO;
import com.skymanager.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    private BookingDAO bookingDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        req.setAttribute("user", user);

        req.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User userSession = (User) session.getAttribute("user");

        String nombre = req.getParameter("nombre");
        String apellido = req.getParameter("apellido");
        String email = req.getParameter("email");

        User user = userDAO.findById(userSession.getIdUsuario());

        user.setNombre(nombre);
        user.setApellido(apellido);
        user.setEmail(email);

        boolean actualizado = userDAO.update(user);

        if (actualizado) {
            session.setAttribute("user", user);
            req.setAttribute("success", "Perfil actualizado correctamente");
        } else {
            req.setAttribute("error", "No se pudo actualizar el perfil");
        }

        req.setAttribute("user", user);

        req.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp")
                .forward(req, resp);
    }
}
