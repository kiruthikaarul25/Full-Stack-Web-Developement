package com.jobportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Database details
    String url = "jdbc:mysql://localhost:3306/jobportal";
    String user = "root";
    String password = "nk3125";

    // SQL Query
    String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Validation
        if (name == null || email == null || pass == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || pass.trim().isEmpty()) {

            response.sendRedirect("register.html?error=empty");
            return;
        }

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Try-with-resources (auto close)
            try (Connection conn = DriverManager.getConnection(url, user, password);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, pass);

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("login.html?success=1");
                } else {
                    response.sendRedirect("register.html?error=db");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();

            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                response.sendRedirect("register.html?error=email");
            } else {
                response.sendRedirect("register.html?error=server");
            }
        }
    }
}