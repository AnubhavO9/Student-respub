<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Result</title>

    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #d4fcf7, #dbeeff);
        }

        .card-container {
            width: 600px;
            padding: 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .table-container {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #206b5d;
            color: white;
        }

        .no-result {
            color: red;
            font-size: 18px;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="card-container">
    <h4>Student Result</h4>

    <%
        String url = "jdbc:mysql://localhost:3306/student";
        String user = "root";
        String password = "1234";
        
        String rollNumberStr = request.getParameter("rollNumber");

        if (rollNumberStr != null && !rollNumberStr.trim().isEmpty() && rollNumberStr.matches("\\d+")) {
            try {
                int rollNumber = Integer.parseInt(rollNumberStr);
                Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection con = DriverManager.getConnection(url, user, password);
                     PreparedStatement pstmt = con.prepareStatement("SELECT * FROM result WHERE roll_number = ?")) {

                    pstmt.setInt(1, rollNumber);
                    try (ResultSet res = pstmt.executeQuery()) {
                        if (res.next()) {
                            String name = res.getString("name");
                            int physics = res.getInt("Physics");
                            int maths = res.getInt("Maths");
                            int science = res.getInt("Science");
                            int socialScience = res.getInt("Social_Science");
                            int physical = res.getInt("Pysical"); // Ensure correct column name
    %>
                            <p><strong>Name:</strong> <%= name %></p>
                            <p><strong>Roll Number:</strong> <%= rollNumber %></p>

                            <div class="table-container">
                                <table>
                                    <tr><th>Subject</th><th>Marks</th></tr>
                                    <tr><td>Physics</td><td><%= physics %></td></tr>
                                    <tr><td>Maths</td><td><%= maths %></td></tr>
                                    <tr><td>Science</td><td><%= science %></td></tr>
                                    <tr><td>Social Science</td><td><%= socialScience %></td></tr>
                                    <tr><td>Physical Education</td><td><%= physical %></td></tr>
                                </table>
                            </div>
    <%
                        } else {
    %>
                            <p class="no-result">No student found with Roll Number: <%= rollNumber %></p>
    <%
                        }
                    }
                }
            } catch (Exception e) {
    %>
                <p class="no-result">Error: <%= e.getMessage() %></p>
    <%
            }
        } else {
    %>
            <p class="no-result">Error: Invalid Roll Number format.</p>
    <%
        }
    %>
</div>

<!-- Materialize JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

</body>
</html>
