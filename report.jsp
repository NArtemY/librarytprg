<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
//    String dateTime= LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-dd-MM")).toString();
//    System.out.println(dateTime);
    boolean isLoggedIn = false;
    if (!Database.isEnable)Database.Init(10, 10, 10, 10);
    Cookie[] cookies = request.getCookies();
    String cookieName = "status";
    Cookie cookie = null;
    if(cookies != null) {
        for(Cookie c: cookies) {
            if(cookieName.equals(c.getName())) {
                cookie = c;
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Обращение</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
</head>
<body>
<%if (!isLoggedIn){
    if(request.getParameter("delete-button")!=null){%>
<%="<script>alert(\"Вы не являетесь администратором! Для удаления записей требуются права администратора.\")</script>"%>
    <%}}%>
<header>
    <img class="logo" src="images/temp.png" alt="logo pic">
    <nav>
        <ul class="nav-links">
            <li><a href="index.jsp">Главная</a></li>
            <li><a href="minerals.jsp">Минералы</a></li>
            <li><a href="samples.jsp">Образцы</a></li>
            <li><a href="expeditions.jsp">Экспедиции</a></li>
			<li ><a href="report.jsp" >Обращение</a></li>
			<
            <%if (cookie != null && cookie.getValue().equals("admin")){
				%>
			<li><a href="geologs.jsp">Геологи</a></li>
			<%}%>
            <% if (cookie != null && Database.stat!=false){%>
            <%="<li style=\"color: aquamarine\">User: "+cookie.getValue()+"</li>"%>
            <%}%>
			<% if (cookie != null && Database.stat!=false){
				%>
				<li><a class="cta" href="authorization.jsp">Выйти</a></li>
			<%}else{%>
				<li><a class="cta" href="authorization.jsp">Войти</a></li>
			<%}%>
        </ul>
    </nav>
</header>
<main>
    <div class="main-area" style="padding-left: 10%">
        
        <div class="flex-box">
            <div class="table-form">
                <h3>Заявка</h3>
                <form action="" method="post">
                    Тема заявки: <input  class="input-background" name="originSample"><br/><br></br>
					Описание: <br></br><input  class="input-background" name="originSample" style="width:1200px;height:500px;"><br/><br></br>
					Контактный email: <input  class="input-background" name="originSample"><br/>
                    <input class="input-background" type="submit" name="delete-button" value="Отправить">
                </form>
            </div>
            
        </div>
    </div>
</main>
</body>
</html>