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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/listar")
public class ListarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer nroCarrito = (Integer) session.getAttribute("nro_carrito");

        List<Map<String, Object>> items = new ArrayList<>();

        if (nroCarrito != null && nroCarrito > 0) {
            try {
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(
                         "select nroDetalle  = d.nro_detalle, " +
                         "       codBarra    = p.cod_barra, " +
                         "       nomProducto = p.nom_producto, " +
                         "       precio      = p.precio " +
                         "  from dbo.detalle_carritos d (nolock) " +
                         "       join dbo.productos p (nolock) " +
                         "         on d.nro_producto = p.nro_producto " +
                         " where d.nro_carrito = ? " +
                         " order by d.fecha_hora_registro")) {
                    pstmt.setInt(1, nroCarrito);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("nroDetalle", rs.getInt("nroDetalle"));
                            item.put("codBarra", rs.getString("codBarra"));
                            item.put("nomProducto", rs.getString("nomProducto"));
                            item.put("precio", rs.getFloat("precio"));
                            items.add(item);
                        }
                    }
                }
            } catch (Exception e) {
                resp.setStatus(400);
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("/WEB-INF/jsp/error-modal.jsp").forward(req, resp);
                return;
            }
        }
        
        req.setAttribute("items", items);
        req.getRequestDispatcher("/WEB-INF/jsp/tabla-completa.jsp").forward(req, resp);
    }
}
