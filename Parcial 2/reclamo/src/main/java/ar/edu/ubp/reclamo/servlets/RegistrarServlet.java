package ar.edu.ubp.reclamo.servlets;

import ar.edu.ubp.reclamo.beans.ReclamoBean;
import ar.edu.ubp.reclamo.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

@WebServlet("/registrar")
public class RegistrarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Recibir parámetros
        String conoceChasisStr = req.getParameter("conoce_chasis");
        boolean conoceChasis = "S".equals(conoceChasisStr);

        String nroChasis = conoceChasis ? req.getParameter("nro_chasis") : null;
        String dominio = conoceChasis ? req.getParameter("dominio") : null;
        String kmStr = conoceChasis ? req.getParameter("km") : null;

        String apellido = req.getParameter("apellido");
        String nombre = req.getParameter("nombre");
        String email = req.getParameter("email");
        String telefono = req.getParameter("telefono");
        String contactarStr = req.getParameter("contactar");
        String reclamoTexto = req.getParameter("reclamo");

        // Validaciones básicas de servidor
        if (apellido == null || apellido.trim().isEmpty() ||
            nombre == null || nombre.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            reclamoTexto == null || reclamoTexto.trim().isEmpty()) {
            
            resp.setStatus(400);
            req.setAttribute("error", "Los campos marcados con asterisco (*) son obligatorios.");
            req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
            return;
        }

        // Si conoce el chasis, chasis y patente son obligatorios (por la check constraint)
        if (conoceChasis) {
            if (nroChasis == null || nroChasis.trim().isEmpty() ||
                dominio == null || dominio.trim().isEmpty()) {
                resp.setStatus(400);
                req.setAttribute("error", "Si conoce el chasis, el número de chasis y la patente son obligatorios.");
                req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
                return;
            }
        }

        // Traducir contactar ("S" o "N")
        String contactar = "S".equals(contactarStr) ? "S" : "N";

        // Instanciar y rellenar JavaBean (ReclamoBean)
        ReclamoBean reclamo = new ReclamoBean();
        reclamo.setApellido(apellido.trim());
        reclamo.setNombre(nombre.trim());
        reclamo.setEmail(email.trim());
        reclamo.setTelefono(telefono != null ? telefono.trim() : null);
        reclamo.setContactar(contactar);
        reclamo.setReclamo(reclamoTexto.trim());
        
        reclamo.setNroChasis(nroChasis != null ? nroChasis.trim() : null);
        reclamo.setDominio(dominio != null ? dominio.trim() : null);
        
        if (kmStr != null && !kmStr.trim().isEmpty()) {
            try {
                reclamo.setKm(Integer.parseInt(kmStr.trim()));
            } catch (NumberFormatException e) {
                // Si hay un formato inválido de km, lo dejamos como null
                reclamo.setKm(null);
            }
        } else {
            reclamo.setKm(null);
        }

        try {
            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false); // Transacción
                try {
                    String sql = "insert into dbo.reclamos(nro_chasis, dominio, km, apellido, nombre, email, telefono, contactar, reclamo) " +
                                 "values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                        
                        // 1. Chasis (desde el Bean)
                        if (reclamo.getNroChasis() == null || reclamo.getNroChasis().isEmpty()) {
                            pstmt.setNull(1, Types.VARCHAR);
                        } else {
                            pstmt.setString(1, reclamo.getNroChasis());
                        }

                        // 2. Dominio (desde el Bean)
                        if (reclamo.getDominio() == null || reclamo.getDominio().isEmpty()) {
                            pstmt.setNull(2, Types.VARCHAR);
                        } else {
                            pstmt.setString(2, reclamo.getDominio());
                        }

                        // 3. Kilómetros (desde el Bean)
                        if (reclamo.getKm() == null) {
                            pstmt.setNull(3, Types.INTEGER);
                        } else {
                            pstmt.setInt(3, reclamo.getKm());
                        }

                        // 4. Apellido (desde el Bean)
                        pstmt.setString(4, reclamo.getApellido());

                        // 5. Nombre (desde el Bean)
                        pstmt.setString(5, reclamo.getNombre());

                        // 6. Email (desde el Bean)
                        pstmt.setString(6, reclamo.getEmail());

                        // 7. Telefono (desde el Bean)
                        if (reclamo.getTelefono() == null || reclamo.getTelefono().isEmpty()) {
                            pstmt.setNull(7, Types.VARCHAR);
                        } else {
                            pstmt.setString(7, reclamo.getTelefono());
                        }

                        // 8. Contactar (desde el Bean)
                        pstmt.setString(8, reclamo.getContactar());

                        // 9. Reclamo (desde el Bean)
                        pstmt.setString(9, reclamo.getReclamo());

                        pstmt.executeUpdate();
                    }
                    conn.commit(); // Éxito
                } catch (SQLException e) {
                    conn.rollback(); // Deshacer en error
                    throw e;
                }
            }
            req.getRequestDispatcher("/WEB-INF/jsp/exito.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
        }
    }
}
