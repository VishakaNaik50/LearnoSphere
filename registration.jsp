<%@ page import="java.sql.*" %>
<%! Connection con; %>
<%! PreparedStatement ps; %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    if (name != null && email != null && password != null && confirmPassword != null) {
        if (!password.equals(confirmPassword)) {
            out.println("<h3>Passwords do not match! Please try again.</h3>");
            return;
        }

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo1", "root", "");

            // Create a prepared statement to insert user data
            String query = "INSERT INTO register (FirstName, Email, Password) VALUES (?, ?, ?)";
            ps = con.prepareStatement(query);

            // Set the parameters for the query
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            // Execute the insert statement
            int result = ps.executeUpdate();

            if (result > 0) {
                // Redirect to login page after successful registration
                response.sendRedirect("login.html");
            } else {
                out.println("<h3>Registration failed. Please try again.</h3>");
            }

            // Close resources
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
%>

