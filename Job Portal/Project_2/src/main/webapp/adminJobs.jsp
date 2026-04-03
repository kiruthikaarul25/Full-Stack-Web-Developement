<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Add New Job | Admin Portal</title>
    <style>
        /* ----- RESET & GLOBAL STYLES (matches dashboard) ----- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f0f4ff 0%, #e6edf7 100%);
            font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 1.5rem;
            margin: 0;
        }

        /* ----- MAIN CARD (CENTERED & ELEGANT) ----- */
        .job-card {
            background: #ffffff;
            max-width: 620px;
            width: 100%;
            border-radius: 2rem;
            box-shadow: 0 25px 45px -12px rgba(0, 0, 0, 0.25), 0 8px 18px rgba(0, 0, 0, 0.05);
            padding: 2rem 2rem 2.2rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .job-card:hover {
            box-shadow: 0 30px 50px -18px rgba(0, 0, 0, 0.3);
        }

        /* ----- TYPOGRAPHY & HEADER ----- */
        h2 {
            font-size: 1.9rem;
            font-weight: 700;
            background: linear-gradient(115deg, #1E2A5E, #2c3e66);
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            letter-spacing: -0.3px;
            border-left: 5px solid #3b82f6;
            padding-left: 1rem;
            margin-bottom: 0.5rem;
        }

        .sub-heading {
            font-size: 0.9rem;
            color: #475569;
            margin-bottom: 1.8rem;
            padding-left: 1rem;
        }

        /* ----- FORM STYLES (MODERN & CLEAN) ----- */
        .job-form {
            display: flex;
            flex-direction: column;
            gap: 1.4rem;
            margin-top: 0.5rem;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .input-group label {
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .input-group label::before {
            content: "•";
            color: #3b82f6;
            font-weight: 800;
            font-size: 1.1rem;
        }

        input, textarea {
            width: 100%;
            padding: 0.85rem 1rem;
            font-size: 1rem;
            font-family: inherit;
            border: 1.5px solid #e2e8f0;
            border-radius: 1rem;
            background-color: #fefefe;
            transition: all 0.2s ease;
            outline: none;
            color: #0f172a;
            resize: vertical;
        }

        textarea {
            min-height: 120px;
            line-height: 1.5;
        }

        input:focus, textarea:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
            background-color: #ffffff;
        }

        input::placeholder, textarea::placeholder {
            color: #94a3b8;
            font-weight: 400;
            font-size: 0.9rem;
        }

        /* ----- SUBMIT BUTTON (same gradient as dashboard) ----- */
        .submit-btn {
            background: linear-gradient(100deg, #1e3a8a, #2563eb);
            color: white;
            font-weight: 700;
            font-size: 1rem;
            padding: 0.9rem 1rem;
            border: none;
            border-radius: 2rem;
            cursor: pointer;
            transition: all 0.25s ease;
            margin-top: 0.6rem;
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
        }

        .submit-btn:hover {
            background: linear-gradient(100deg, #0f2b6d, #1d4ed8);
            transform: scale(1.01);
            box-shadow: 0 10px 18px -6px #1e3a8a60;
        }

        .submit-btn:active {
            transform: scale(0.98);
        }

        /* ----- RESPONSIVE (MOBILE FRIENDLY) ----- */
        @media (max-width: 520px) {
            .job-card {
                padding: 1.5rem;
                border-radius: 1.5rem;
            }
            h2 {
                font-size: 1.6rem;
                padding-left: 0.75rem;
            }
            input, textarea {
                padding: 0.7rem 0.9rem;
            }
            .submit-btn {
                padding: 0.75rem;
            }
        }

        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body>
<div class="job-card">
    <h2>➕ Add New Job</h2>
    <div class="sub-heading">Fill in the details below to post a job opportunity</div>

    <form class="job-form" action="AddJobServlet" method="post">
        <div class="input-group">
            <label for="title">Job Title</label>
            <input type="text" id="title" name="title" placeholder="e.g., Senior Full Stack Developer" required>
        </div>

        <div class="input-group">
            <label for="description">Job Description</label>
            <textarea id="description" name="description" placeholder="Describe responsibilities, requirements, benefits..." required></textarea>
        </div>

        <div class="input-group">
            <label for="location">Location</label>
            <input type="text" id="location" name="location" placeholder="Remote / New York, NY / Hybrid" required>
        </div>

        <button type="submit" class="submit-btn">
            📌 Post Job Listing
        </button>
    </form>
</div>
</body>
</html>