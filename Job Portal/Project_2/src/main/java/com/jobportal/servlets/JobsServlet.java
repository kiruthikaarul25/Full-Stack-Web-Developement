package com.jobportal.servlets;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.jobportal.utils.DBConnection;

@WebServlet("/JobsServlet")
public class JobsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // If not logged in (user), redirect to login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }

        // Retrieve jobs from DB
        List<Job> jobs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, title, description, location FROM jobs ORDER BY posted_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Pass jobs list to JSP
        request.setAttribute("jobs", jobs);
        // Also pass any messages (like applied success) from URL parameters
        request.setAttribute("message", request.getParameter("applied") != null ? "Applied successfully!" :
                              (request.getParameter("error") != null ? "Error or already applied!" : null));
        request.getRequestDispatcher("jobs.jsp").forward(request, response);
    }

    // Simple inner class for Job data (or create separate model class)
    public static class Job {
        private int id;
        private String title;
        private String description;
        private String location;

        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        public String getLocation() { return location; }
        public void setLocation(String location) { this.location = location; }
    }
}