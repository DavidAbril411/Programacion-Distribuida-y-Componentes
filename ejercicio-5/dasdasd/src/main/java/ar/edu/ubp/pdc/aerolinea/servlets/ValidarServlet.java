package ar.edu.ubp.pdc.aerolinea.servlets;

import ar.edu.ubp.pdc.aerolinea.beans.ReservaBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/validar.jsp")
public class ValidarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            try(Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=pdc;encrypt=false", "sa", "pyxis");
                CallableStatement stmt = conn.prepareCall("{call dbo.val_reserva(?,?)}")) {
                stmt.setString(1, req.getParameter("documento"));
                stmt.setString(2, req.getParameter("cod_reserva"));

                ResultSet rs = stmt.executeQuery();
                ReservaBean reserva = new ReservaBean();
                if (rs.next()) {
                    reserva.setApellido(rs.getString("apellido"));
                    reserva.setNombre(rs.getString("nombre"));
                    reserva.setNroCliente(rs.getInt("nroCliente"));
                    reserva.setFechaReserva(rs.getString("fechaReserva"));
                    reserva.setTipoClase(rs.getString("tipoClase"));
                    reserva.setTipoClaseDesc(rs.getString("tipoClaseDesc"));
                    reserva.setNroReserva(rs.getInt("nroReserva"));
                }
                req.setAttribute("reserva", reserva);
                req.getRequestDispatcher("datos.jsp").forward(req, resp);
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("error-modal.jsp").forward(req, resp);
        }
    }

}
