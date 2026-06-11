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
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/inicio", "/index.jsp"})
public class InicioServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<ProductoBean> catalogo = new ArrayList<>();
        List<ProductoBean> carrito = new ArrayList<>();
        double total = 0.0;
        String ultimoNombre = "";
        String ultimoCodigo = "";
        double ultimoPrecio = 0.0;

        try {
            try (Connection conn = DBConnection.getConnection()) {
                
                // 1. Carga catálogo usando Statement
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT cod_barra, nom_producto, precio FROM dbo.productos ORDER BY nom_producto")) {
                    while (rs.next()) {
                        ProductoBean p = new ProductoBean();
                        p.setCod_barra(rs.getString("cod_barra"));
                        p.setNom_producto(rs.getString("nom_producto"));
                        p.setPrecio(rs.getFloat("precio"));
                        catalogo.add(p);
                    }
                }
                
                // 2. Carga carrito usando PreparedStatement si existe nro_carrito en sesión
                Integer nroCarrito = (Integer) session.getAttribute("nro_carrito");
                if (nroCarrito != null && nroCarrito > 0) {
                    try (PreparedStatement pstmt = conn.prepareStatement(
                        "select nroDetalle = d.nro_detalle, codBarra = p.cod_barra, nomProducto = p.nom_producto, precio = p.precio " +
                        "from dbo.detalle_carritos d (nolock) join dbo.productos p (nolock) on d.nro_producto = p.nro_producto " +
                        "where d.nro_carrito = ? order by d.fecha_hora_registro")) {
                        pstmt.setInt(1, nroCarrito);
                        try (ResultSet rs = pstmt.executeQuery()) {
                            while (rs.next()) {
                                ProductoBean p = new ProductoBean();
                                p.setNro_producto(rs.getInt("nroDetalle")); // Guardamos temporalmente nroDetalle
                                p.setCod_barra(rs.getString("codBarra"));
                                p.setNom_producto(rs.getString("nomProducto"));
                                p.setPrecio(rs.getFloat("precio"));
                                carrito.add(p);
                                
                                total += p.getPrecio();
                                ultimoNombre = p.getNom_producto();
                                ultimoCodigo = p.getCod_barra();
                                ultimoPrecio = p.getPrecio();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }

        req.setAttribute("catalogo", catalogo);
        req.setAttribute("carrito", carrito);
        req.setAttribute("total", total);
        req.setAttribute("ultimoNombre", ultimoNombre);
        req.setAttribute("ultimoCodigo", ultimoCodigo);
        req.setAttribute("ultimoPrecio", ultimoPrecio);

        req.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(req, resp);
    }
}
