package ar.edu.ubp.cajaregistradora.servlets;

import ar.edu.ubp.cajaregistradora.beans.ProductoBean;
import ar.edu.ubp.cajaregistradora.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/agregar")
public class AgregarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String codBarra = req.getParameter("cod_barra");
        HttpSession session = req.getSession();
        Integer nroCarrito = (Integer) session.getAttribute("nro_carrito");

        try {
            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false); // Transacción
                try {
                    String sql = "{call dbo.ins_producto_carrito(?, ?)}";
                    try (CallableStatement stmt = conn.prepareCall(sql)) {
                        if (nroCarrito == null || nroCarrito == 0) {
                            stmt.setNull(1, Types.INTEGER);
                        } else {
                            stmt.setInt(1, nroCarrito);
                        }
                        stmt.registerOutParameter(1, Types.INTEGER);
                        stmt.setString(2, codBarra);

                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                int nroDetalle = rs.getInt("nroDetalle");
                                String codBarraRes = rs.getString("codBarra");
                                String nomProducto = rs.getString("nomProducto");
                                float precio = rs.getFloat("precio");

                                ProductoBean producto = new ProductoBean();
                                producto.setCod_barra(codBarraRes);
                                producto.setNom_producto(nomProducto);
                                producto.setPrecio(precio);

                                req.setAttribute("producto", producto);
                                req.setAttribute("nro_detalle", nroDetalle);
                            }
                        }
                        nroCarrito = stmt.getInt(1);
                        session.setAttribute("nro_carrito", nroCarrito);
                    }
                    conn.commit(); // Éxito
                } catch (SQLException e) {
                    conn.rollback(); // Deshacer en error
                    throw e;
                }
            }
            req.getRequestDispatcher("/WEB-INF/jsp/fila-producto.jsp").forward(req, resp);
        } catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
        }
    }
}