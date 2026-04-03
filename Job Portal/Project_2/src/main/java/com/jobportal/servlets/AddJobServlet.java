package com.jobportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.jobportal.utils.DBConnection;

@WebServlet("/AddJobServlet")
public class AddJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("admin.html");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");

        if (title == null || description == null || location == null ||
            title.trim().isEmpty() || description.trim().isEmpty() || location.trim().isEmpty()) {
            response.sendRedirect("addJob.jsp?error=empty");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO jobs (title, description, location) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, location);
            ps.executeUpdate();
            response.sendRedirect("JobsServlet?added=success");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addJob.jsp?error=db");
        }
    }
}