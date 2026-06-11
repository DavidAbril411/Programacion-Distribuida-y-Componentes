package ar.edu.ubp.pdc.ejercicio4.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/eliminar.jsp")
public class EliminarProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            try(Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;database=pdc;user=sa;password=pyxis;encrypt=false")) {
                conn.setAutoCommit(false);

                try(PreparedStatement stmt = conn.prepareStatement("delete d " +
                        "from dbo.detalle_carritos d " +
                        "where d.nro_carrito = ? " +
                        "and d.nro_detalle = ?")) {
                    stmt.setInt(1, (int) req.getSession().getAttribute("nro_carrito"));
                    stmt.setInt(2, Integer.parseInt(req.getParameter("nro_detalle")));

                    stmt.executeUpdate();
                    conn.commit();
                }
                catch (SQLException e) {
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
