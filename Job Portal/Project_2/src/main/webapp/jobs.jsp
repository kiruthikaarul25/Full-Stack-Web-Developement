<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.jobportal.servlets.JobsServlet.Job" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Available Jobs | Job Portal</title>
    <style>
        /* ----- RESET & GLOBAL (same as dashboard) ----- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f0f4ff 0%, #e6edf7 100%);
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            min-height: 100vh;
            padding: 2rem 1.5rem;
        }

        /* ----- MAIN CONTAINER (CENTERED CONTENT) ----- */
        .jobs-container {
            max-width: 800px;
            margin: 0 auto;
        }

        /* ----- HEADER CARD (similar to dashboard card but full width) ----- */
        .header-card {
            background: #ffffff;
            border-radius: 2rem;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 15px 30px -12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            font-size: 2rem;
            font-weight: 700;
            background: linear-gradient(115deg, #1E2A5E, #2c3e66);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            letter-spacing: -0.3px;
            margin-bottom: 0.5rem;
        }

        .welcome-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-top: 0.5rem;
            padding-top: 0.75rem;
            border-top: 1px solid #edf2f7;
        }

        .user-greeting {
            color: #2c3e66;
            font-weight: 500;
            background: #f1f5f9;
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.9rem;
        }

        .logout-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #f1f5f9;
            color: #b91c1c;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.4rem 1.2rem;
            border-radius: 40px;
            transition: all 0.2s;
        }

        .logout-link:hover {
            background: #fee2e2;
            color: #991b1b;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        /* ----- MESSAGE STYLES (success/error) ----- */
        .message {
            padding: 0.9rem 1.2rem;
            margin-bottom: 1.5rem;
            border-radius: 1rem;
            font-weight: 500;
            text-align: center;
        }
        .success {
            background: #d1fae5;
            color: #065f46;
            border-left: 5px solid #10b981;
        }
        .error {
            background: #fee2e2;
            color: #991b1b;
            border-left: 5px solid #ef4444;
        }

        /* ----- JOB CARDS (modern, elevated) ----- */
        .job-card {
            background: #ffffff;
            border-radius: 1.5rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 20px -6px rgba(0, 0, 0, 0.08);
            transition: all 0.25s ease;
            border: 1px solid rgba(226, 232, 240, 0.6);
        }

        .job-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 30px -12px rgba(0, 0, 0, 0.12);
            border-color: #cbd5e1;
        }

        .job-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.3rem;
        }

        .job-location {
            display: inline-block;
            background: #eef2ff;
            color: #1e40af;
            padding: 0.2rem 0.8rem;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .job-description {
            color: #334155;
            line-height: 1.5;
            margin-bottom: 1.2rem;
            font-size: 0.95rem;
        }

        /* apply button - matches dashboard primary style but green tint for action */
        .apply-btn {
            background: linear-gradient(100deg, #059669, #10b981);
            color: white;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 2rem;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 2px 5px rgba(5, 150, 105, 0.2);
        }

        .apply-btn:hover {
            background: linear-gradient(100deg, #047857, #059669);
            transform: scale(1.02);
            box-shadow: 0 6px 12px -6px #059669;
        }

        .apply-btn:active {
            transform: scale(0.98);
        }

        /* empty state */
        .empty-state {
            background: white;
            border-radius: 1.5rem;
            padding: 2rem;
            text-align: center;
            color: #475569;
            box-shadow: 0 8px 20px -6px rgba(0,0,0,0.05);
        }

        /* responsive */
        @media (max-width: 640px) {
            body {
                padding: 1rem;
            }
            .header-card {
                padding: 1rem 1.2rem;
            }
            h2 {
                font-size: 1.6rem;
            }
            .job-title {
                font-size: 1.25rem;
            }
            .welcome-section {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
<div class="jobs-container">
    <div class="header-card">
        <h2>📋 Available Jobs</h2>
        <div class="welcome-section">
            <span class="user-greeting">👋 Welcome, <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Guest" %>!</span>
            <a href="logout.html" class="logout-link">🚪 Logout</a>
        </div>
    </div>

    <% 
        String message = (String) request.getAttribute("message");
        if (message != null) { 
            String msgClass = message.contains("success") ? "success" : "error";
    %>
        <div class="message <%= msgClass %>"><%= message %></div>
    <% } %>

    <%
        List<Job> jobs = (List<Job>) request.getAttribute("jobs");
        if (jobs != null && !jobs.isEmpty()) {
            for (Job job : jobs) {
    %>
        <div class="job-card">
            <div class="job-title"><%= job.getTitle() %></div>
            <div class="job-location">📍 <%= job.getLocation() %></div>
            <div class="job-description"><%= job.getDescription() %></div>
            <form action="ApplyJobServlet" method="post">
                <input type="hidden" name="jobId" value="<%= job.getId() %>">
                <button type="submit" class="apply-btn">✨ Apply Now</button>
            </form>
        </div>
    <%
            }
        } else {
    %>
        <div class="empty-state">
            <p>🌟 No jobs available at the moment. Please check back later!</p>
        </div>
    <% } %>
</div>
</body>
</html>