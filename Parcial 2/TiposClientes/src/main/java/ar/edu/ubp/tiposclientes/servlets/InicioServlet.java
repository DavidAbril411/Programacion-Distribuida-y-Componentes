package ar.edu.ubp.tiposclientes.servlets;

import ar.edu.ubp.tiposclientes.beans.UnidadNegocioBean;
import ar.edu.ubp.tiposclientes.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

@WebServlet(urlPatterns = {"/inicio", "/index.jsp"})
public class InicioServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(
                         "select cod_unidad_negocio = '-1'," +
                                 "       nom_unidad_negocio = 'No informada'," +
                                 "       nro_orden          = 0" +
                                 " union all" +
                                 " select cod_unidad_negocio = cod_unidad_negocio," +
                                 "        nom_unidad_negocio = nom_unidad_negocio," +
                                 "        nro_orden          = row_number() over(order by nom_unidad_negocio)" +
                                 "   from dbo.unidades_negocio (nolock)" +
                                 "  order by nro_orden")) {

                List<UnidadNegocioBean> unidades = new LinkedList<>();
                while (rs.next()) {
                    UnidadNegocioBean u = new UnidadNegocioBean();
                    u.setCodUnidadNegocio(rs.getString("cod_unidad_negocio"));
                    u.setNombreUnidadNegocio(rs.getString("nom_unidad_negocio"));
                    u.setNroOrden(rs.getInt("nro_orden"));
                    unidades.add(u);
                }
                req.setAttribute("unidades", unidades);
                req.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(req, resp);
            }
        }
        catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
