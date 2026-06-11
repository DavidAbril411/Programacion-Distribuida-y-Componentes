package ar.edu.ubp.tickets.beans;

import java.sql.Timestamp;

public class TicketBean {
    private String ticket;
    private String fecha_ticket;
    private String solicitante;
    private String asunto_ticket;
    private String texto_ticket;

    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public String getFecha_ticket() {
        return fecha_ticket;
    }

    public void setFecha_ticket(String fecha_ticket) {
        this.fecha_ticket = fecha_ticket;
    }

    public String getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(String solicitante) {
        this.solicitante = solicitante;
    }

    public String getAsunto_ticket() {
        return asunto_ticket;
    }

    public void setAsunto_ticket(String asunto_ticket) {
        this.asunto_ticket = asunto_ticket;
    }

    public String getTexto_ticket() {
        return texto_ticket;
    }

    public void setTexto_ticket(String texto_ticket) {
        this.texto_ticket = texto_ticket;
    }
}
