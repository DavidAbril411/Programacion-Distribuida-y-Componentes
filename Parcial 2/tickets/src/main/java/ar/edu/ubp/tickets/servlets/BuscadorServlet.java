package ar.edu.ubp.tickets.servlets;

import ar.edu.ubp.tickets.beans.TicketBean;
import ar.edu.ubp.tickets.db.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

@WebServlet("/buscar")

public class BuscadorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String valor = req.getParameter("buscador");
        String orden = req.getParameter("ordenar");

        List<TicketBean> lista = new LinkedList<TicketBean>();

        if (valor != null && !valor.equals("")) {
            // Transacción
            try {
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement(
                             "select ticket  = convert(varchar(4), t.ano_ticket) + '-' + replicate('0', 5 - len(convert(varchar(5), t.nro_ticket))) + convert(varchar(5), t.nro_ticket), " +
                                     "       fecha_ticket  = convert(varchar(10), t.fecha_ticket, 103) + ' ' + convert(varchar(5), t.fecha_ticket, 108), " +
                                     "       solicitante   = s.nom_solicitante, " +
                                     "       asunto_ticket = t.asunto_ticket, " +
                                     "       texto_ticket  = t.texto_ticket " +
                                     "  from dbo.tickets t (nolock) " +
                                     "       join dbo.solicitantes s (nolock) " +
                                     "         on t.nro_solicitante = s.nro_solicitante " +
                                     " where (t.asunto_ticket   like '%' + isnull(ltrim(rtrim(?)), '') + '%' " +
                                     "    or  t.texto_ticket    like '%' + isnull(ltrim(rtrim(?)), '') + '%' " +
                                     "    or  s.nom_solicitante like '%' + isnull(ltrim(rtrim(?)), '') + '%') " +
                                     " order by case ? " +
                                     "when 'F' then convert(varchar(10), t.fecha_ticket, 112) + ' ' + convert(varchar(5), t.fecha_ticket, 108) " +
                                     "when 'S' then s.nom_solicitante " +
                                     "when 'T' then convert(varchar(4), t.ano_ticket) + '-' + replicate('0', 5 - len(convert(varchar(5), t.nro_ticket))) + convert(varchar(5), t.nro_ticket) " +
                                     "end"
                     )) {
                    pstmt.setString(1, valor);
                    pstmt.setString(2, valor);
                    pstmt.setString(3, valor);
                    pstmt.setString(4, orden);

                    try (ResultSet rs = pstmt.executeQuery()) {
                        while (rs.next()) {
                            TicketBean ticket = new TicketBean();
                            ticket.setTicket(rs.getString("ticket"));
                            ticket.setFecha_ticket(rs.getString("fecha_ticket"));
                            ticket.setSolicitante(rs.getString("solicitante"));
                            ticket.setAsunto_ticket(rs.getString("asunto_ticket"));
                            ticket.setTexto_ticket(rs.getString("texto_ticket"));
                            lista.add(ticket);
                        }
                    }
                    req.setAttribute("tickets", lista);
                    req.getRequestDispatcher("tablaTickets.jsp").forward(req, resp);
                }
            } catch (ClassNotFoundException | SQLException e) {
                resp.setStatus(400);
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("/error-modal.jsp").forward(req, resp);
            }
        }
    }
}