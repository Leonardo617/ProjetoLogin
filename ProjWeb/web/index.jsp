<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <%
        Statement st = null;
        ResultSet rs = null;
    %>
    <body>
        <div class="container">
            <br>
            <form method="post" action="index.jsp">
                <div class="form-group">
                  <label for="exampleInputEmail1">Email:</label>
                  <input type="email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Senha:</label>
                  <input type="password" name="senha" class="form-control" id="exampleInputPassword1">
                </div>
                <button type="submit" class="btn btn-secondary">Enviar</button>
            </form>
            <%
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String nomeUser = "";
                String sen = "";
                String ema = "";
                int i = 0;
                String nomeUsuario = "";
                
                try{
                    st = new Conexao().conectar().createStatement();
                    rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '"+ email +"' and senha = '" + senha + "'");
                    while(rs.next()){
                        ema = rs.getString(3);
                        sen = rs.getString(4);
                        nomeUser = rs.getString(2);
                        rs.last();
                        i = rs.getRow();
                    }
                }catch(Exception e){
                    out.println(e);
                }
                if(email == null || senha == null){
                    out.println("Os dados não foram preenchidos");
                }else{
                    session.setAttribute("nomeUser", nomeUser);
                    response.sendRedirect("restrita.jsp");
                }
            %>
        </div>
    </body>
</html>
