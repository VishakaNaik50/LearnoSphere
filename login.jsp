<%@ page import="java.sql.*" %>
<%! Connection con; %>
<%! PreparedStatement ps; %>
<% 
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Check if the form is submitted
    if (email != null && password != null) {
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo1", "root", "");

            // Create a prepared statement to validate login credentials
            String query = "SELECT * FROM register WHERE Email = ? AND Password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                response.sendRedirect("courses.html");
            } else {
                out.println("<h3>Invalid email or password. Please try again.</h3>");
            }
            

            // Close resources
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
%>


