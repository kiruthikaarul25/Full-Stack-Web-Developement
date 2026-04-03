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

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String jobIdStr = request.getParameter("jobId");
        if (jobIdStr == null) {
            response.sendRedirect("JobsServlet?error=missingJob");
            return;
        }
        int jobId = Integer.parseInt(jobIdStr);

        try (Connection conn = DBConnection.getConnection()) {
            // Check if already applied
            String checkSql = "SELECT id FROM applications WHERE user_id = ? AND job_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, userId);
            checkPs.setInt(2, jobId);
            var rs = checkPs.executeQuery();
            if (rs.next()) {
                response.sendRedirect("JobsServlet?error=alreadyApplied");
                return;
            }

            // Insert application
            String sql = "INSERT INTO applications (user_id, job_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, jobId);
            ps.executeUpdate();
            response.sendRedirect("JobsServlet?applied=success");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("JobsServlet?error=db");
        }
    }
}