package ar.edu.ubp.pdc.ejercicio4.servlets;

import ar.edu.ubp.pdc.ejercicio4.beans.ProductoBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/agregar.jsp")
public class AgregarProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            int nroCarrito = req.getSession().getAttribute("nro_carrito") == null ? 0 : (int) req.getSession().getAttribute("nro_carrito");

            try(Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=pdc;encrypt=false", "sa", "pyxis")) {
                conn.setAutoCommit(false);
                try(CallableStatement stmt = conn.prepareCall("{call dbo.ins_producto_carrito(?,?)}")) {
                    stmt.setInt(1, nroCarrito);
                    stmt.registerOutParameter(1, java.sql.Types.INTEGER);
                    stmt.setString(2, req.getParameter("cod_barra"));

                    ProductoBean producto = new ProductoBean();
                    try(ResultSet result = stmt.executeQuery()) {
                        if(result.next()) {
                            producto.setNroDetalle(result.getShort("nroDetalle"));
                            producto.setCodBarra(result.getString("codBarra"));
                            producto.setNomProducto(result.getString("nomProducto"));
                            producto.setPrecio(result.getDouble("precio"));
                        }

                        if(nroCarrito == 0) {
                            req.getSession().setAttribute("nro_carrito", stmt.getInt(1));
                        }

                        conn.commit();

                        req.setAttribute("producto", producto);
                        req.getRequestDispatcher("/producto.jsp").forward(req, resp);
                    }
                }
                catch(SQLException e) {
                    conn.rollback();
                    throw e;
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
