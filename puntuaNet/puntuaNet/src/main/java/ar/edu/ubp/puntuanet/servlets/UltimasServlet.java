package ar.edu.ubp.puntuanet.servlets;

import ar.edu.ubp.puntuanet.beans.ResenaBean;
import ar.edu.ubp.puntuanet.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@WebServlet("/ultimas")
public class UltimasServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            try (Connection conn = DBConnection.getConnection()) {

                // 1. Carga catálogo usando Statement
                try (Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("select top 3" +
                             "       sitio         = sitio, " +
                             "       apodo         = apodo," +
                             "   puntuacion    = puntuacion," +
                             "   observaciones = observaciones," +
                             "   fecha         = fecha_reseña" +
                             "  from dbo.reseñas_sitios (nolock)" +
                             " order by fecha_reseña desc")) {
                    List<ResenaBean> resenas = new LinkedList<ResenaBean>();
                    while (rs.next()) {
                        ResenaBean resena = new ResenaBean();
                        resena.setSitio(rs.getString("sitio"));
                        resena.setApodo(rs.getString("apodo"));
                        resena.setPuntuacion(rs.getInt("puntuacion"));
                        resena.setObservaciones(rs.getString("observaciones"));
                        resena.setFecha(rs.getString("fecha"));
                        resenas.add(resena);
                    }
                    req.setAttribute("resenas", resenas);
                    req.getRequestDispatcher("listaResenas.jsp").forward(req, resp);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            resp.setStatus(400);
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
        }
    }
}