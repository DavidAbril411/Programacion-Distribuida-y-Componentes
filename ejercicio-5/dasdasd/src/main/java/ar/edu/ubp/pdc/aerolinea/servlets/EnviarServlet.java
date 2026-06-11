package ar.edu.ubp.pdc.aerolinea.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/enviar.jsp")
public class EnviarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try(Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=pdc;encrypt=false", "sa", "pyxis")) {
                conn.setAutoCommit(false);
                try(PreparedStatement stmt = conn.prepareStatement("insert into dbo.mejoras_reservas(nro_reserva, tipo_clase, monto)\n" +
                        "values(?, ?, ?)")){
                    stmt.setInt(1, Integer.parseInt(req.getParameter("nro_reserva")));
                    stmt.setString(2, req.getParameter("tipo_clase"));
                    stmt.setDouble(3, Double.parseDouble(req.getParameter("monto")));

                    stmt.executeUpdate();
                    conn.commit();

                    req.getRequestDispatcher("mensaje.jsp").forward(req, resp);
                }
                catch (SQLException ex) {
                    conn.rollback();
                    throw ex;
                }
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }
}
