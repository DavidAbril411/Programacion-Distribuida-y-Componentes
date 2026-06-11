package ar.edu.ubp.pdc.ejercicio4.servlets;

import ar.edu.ubp.pdc.ejercicio4.beans.ProductoBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;

@WebServlet("/listado.jsp")
public class ListadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            int nroCarrito = req.getSession().getAttribute("nro_carrito") == null ? 0 : (int) req.getSession().getAttribute("nro_carrito");

            try(Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=pdc;encrypt=false", "sa", "pyxis");
                PreparedStatement stmt = conn.prepareStatement("select nroDetalle  = d.nro_detalle,\n" +
                        "codBarra    = p.cod_barra,\n" +
                        "nomProducto = p.nom_producto,\n" +
                        "precio      = p.precio\n" +
                        "from dbo.detalle_carritos d (nolock)\n" +
                        "join dbo.productos p (nolock)\n" +
                        "on d.nro_producto = p.nro_producto\n" +
                        "where d.nro_carrito = ?\n" +
                        "order by d.fecha_hora_registro")) {
                stmt.setInt(1, nroCarrito);

                try (ResultSet rs = stmt.executeQuery()) {
                    LinkedList<ProductoBean> listado = new LinkedList<>();
                    while (rs.next()) {
                        ProductoBean producto = new ProductoBean();
                        producto.setNroDetalle(rs.getShort("nroDetalle"));
                        producto.setNomProducto(rs.getString("nomProducto"));
                        producto.setPrecio(rs.getFloat("precio"));
                        producto.setCodBarra(rs.getString("codBarra"));
                        listado.add(producto);
                    }
                    req.setAttribute("listado", listado);
                    req.getRequestDispatcher("listado-productos.jsp").forward(req, resp);
                }
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }

}
