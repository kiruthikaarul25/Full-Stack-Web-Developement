package com.jobportal.servlets;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    // Hardcoded admin credentials
    private static final String ADMIN_USER = "Nivi";
    private static final String ADMIN_PASS = "Nivi@31";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (ADMIN_USER.equals(username) && ADMIN_PASS.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", true);
            response.sendRedirect("addJob.jsp");   // redirect to admin dashboard (add job form)
        } else {
            response.sendRedirect("admin.html?error=invalid");
        }
    }
}