package ar.edu.ubp.cajaregistradora.servlets;

import ar.edu.ubp.cajaregistradora.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/eliminar")
public class EliminarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nroDetalleStr = req.getParameter("nro_detalle");
        HttpSession session = req.getSession();
        Integer nroCarrito = (Integer) session.getAttribute("nro_carrito");

        if (nroCarrito == null) {
            resp.setStatus(400);
            req.setAttribute("error", "No existe un carrito activo.");
            req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
            return;
        }

        try {
            int nroDetalle = Integer.parseInt(nroDetalleStr);

            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false); // Transacción
                try {
                    String sql = "DELETE FROM dbo.detalle_carritos WHERE nro_carrito = ? AND nro_detalle = ?";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        pstmt.setInt(1, nroCarrito);
                        pstmt.setInt(2, nroDetalle);
                        int affectedRows = pstmt.executeUpdate();
                        if (affectedRows == 0) {
                            throw new SQLException("El producto no pudo ser eliminado o ya no existe.");
                        }
                    }
                    conn.commit();
                } catch (SQLException e) {
                    conn.rollback();
                    throw e;
                }
            }
            resp.getWriter().print("OK");
        } catch (Exception e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
        }
    }
}
