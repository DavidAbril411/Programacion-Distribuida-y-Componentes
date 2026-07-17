package ar.edu.ubp.puntuanet.servlets;

import ar.edu.ubp.puntuanet.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.CookieStore;
import java.sql.*;


@WebServlet("/guardar")
public class GuardarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String correo = req.getParameter("correo");
        String apodo = req.getParameter("apodo");
        String url = req.getParameter("url");
        int puntuacion = Integer.parseInt(req.getParameter("puntuacion"));
        String resena = req.getParameter("resena");
        Cookie correoCookie = new Cookie("correo", correo);


        try {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "{call dbo.ins_reseña_sitio(?, ?, ?, ?, ?)}";
                try (CallableStatement stmt = conn.prepareCall(sql)) {
                    stmt.setString(1, url);
                    stmt.setString(2, correo);
                    stmt.setString(3, apodo);
                    stmt.setInt(4, puntuacion);
                    stmt.setString(5, resena);

                    stmt.execute();
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }
}