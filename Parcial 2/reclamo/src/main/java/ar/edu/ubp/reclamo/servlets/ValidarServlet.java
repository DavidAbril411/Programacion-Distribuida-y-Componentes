package ar.edu.ubp.reclamo.servlets;

import ar.edu.ubp.reclamo.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;

@WebServlet("/validar")
public class ValidarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nroChasis = req.getParameter("nro_chasis");
        String dominio = req.getParameter("dominio");

        if (nroChasis == null || nroChasis.trim().isEmpty()) {
            resp.setStatus(400);
            resp.getWriter().print("Número de chasis requerido.");
            return;
        }

        try {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "{call dbo.val_vehiculo(?, ?, ?)}";
                try (CallableStatement stmt = conn.prepareCall(sql)) {
                    stmt.setString(1, nroChasis);
                    if (dominio == null || dominio.trim().isEmpty()) {
                        stmt.setNull(2, Types.VARCHAR);
                    } else {
                        stmt.setString(2, dominio);
                    }
                    stmt.registerOutParameter(3, Types.CHAR);
                    stmt.execute();
                    String existe = stmt.getString(3);
                    
                    resp.setContentType("text/plain");
                    resp.getWriter().print(existe);
                }
            }
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().print("Error al validar vehículo: " + e.getMessage());
        }
    }
}
