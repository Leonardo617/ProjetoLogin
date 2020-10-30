<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FBI</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Lista de usuários</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#textoNavbar" aria-controls="textoNavbar" aria-expanded="false" aria-label="Alterna navegação">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="textoNavbar">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="#">Home <span class="sr-only">(Página atual)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#">Destaques</a>
                </li>
              </ul>
              <span class="navbar-text">
                Bem vindo <b>
                <%
                    String nome = (String) session.getAttribute("nomeUser");
                    out.println(nome);
                    
                    if (nome == null) {
                        response.sendRedirect("index.jsp");
                    }
                %>
                </b> &nbsp; &nbsp;
                <a class="btn btn-primary" href="sair.jsp" style="color: white;">Sair</a>
              </span>
            </div>
        </nav>
        <div class="container">
            
            <div class="row mt-4 mb-4">
                <button class="btn-primary" data-toggle="modal" data-target="#modalExemplo">Novo Usuário</button>  &nbsp; &nbsp; &nbsp;
                <form class="form-inline my-2 my-lg-0">
                    <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Digite um nome" aria-label="Search"> &nbsp; &nbsp;
                    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Buscar</button>
                </form>
            </div>
            
            <table class="table table-striped">
                <thead>
                  <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Email</th>
                    <th scope="col">Senha</th>
                    <th scope="col">Nivel</th>
                  </tr>
                </thead>
                <tbody>
                    
                  <%
                        Statement st = null;
                        ResultSet rs = null;
                        String id = "";
                        String nomeUser = "";
                        String email = "";
                        String senha = "";
                        String nivel = "";
                        
                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM pessoas");
                            while(rs.next()){
                    %>
                                <tr>
                                    <th scope="row"><%= rs.getString(1) %></th>
                                    <td><%= rs.getString(2) %></td>
                                    <td><%= rs.getString(3) %></td>
                                    <td><%= rs.getString(4) %></td>
                                    <td><%= rs.getString(5) %></td>
                                </tr>
                    
                    <%
                                
                            }
                        }catch(Exception e){
                            out.println(e);
                        }
                        
                    %>    
              </table>
            
        </div>
              
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script><script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </body>
</html>


<div class="modal fade" id="modalExemplo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cadastrar usuário</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="restrita.jsp" method="post" class="form" id="cadastro">
        <div class="modal-body">
          
                <div class="form-group">
                  <label>Nome</label>
                  <input type="text" class="form-control" name="nome" id="nome" placeholder="Nome">
                </div>
                <div class="form-group">
                  <label>Email</label>
                  <input type="email" class="form-control" name="email" id="email" placeholder="Email">
                </div>
                <div class="form-group">
                  <label>Senha</label>
                  <input type="password" class="form-control" name="senha" id="senha" placeholder="Senha">
                </div>
                <div class="form-group">
                      <label>Nível</label>
                      <select class="form-control" name="nivel" id="nivel">
                        <option value="comum">Comum</option>
                        <option value="admin">Admin</option>
                      </select>
                </div>



        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-light" data-dismiss="modal">Fechar</button>
          <button type="submit" name="btn-salvar" class="btn btn-primary">Cadastrar</button>
        </div>
      </form>
    </div>
  </div>
</div>


<%
    
    if (request.getParameter("btn-salvar") != null) {
            String nomeInput = request.getParameter("nome");
            String emailInput = request.getParameter("email");
            String senhaInput = request.getParameter("senha");
            String nivelInput = request.getParameter("nivel");
            
            try{
                
                st = new Conexao().conectar().createStatement();
                
                rs = st.executeQuery("SELECT * FROM pessoas WHERE email = '"+ emailInput +"'");
                while(rs.next()){
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("<script>alert('usuario ja está cadastrado')</script>");
                            return;
                        }
                }
                
                st.executeUpdate("INSERT INTO pessoas (nome, email, senha, nivel) VALUES ('"+nomeInput+"','"+emailInput+"','"+senhaInput+"','"+nivelInput+"')");
                
            }catch(Exception e){
                out.println(e);
            }
            
        }

%>