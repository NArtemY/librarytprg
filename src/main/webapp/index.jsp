<%@ page import="com.example.storehouse.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable)Database.Init(10, 10, 10,10);
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
        <meta charset="UTF-8">
        <title>Главная</title>
        <link rel='stylesheet' type='text/css' href='style/style.css' />
    </head>
    <body>
        <header>
            <img class="logo" src="images/temp.png" alt="logo pic">
            <nav>
                <ul class="nav-links">
                    <li><a href="index.jsp">Главная</a></li>
                    <li><a href="minerals.jsp">Минералы</a></li>
                    <li><a href="samples.jsp">Образцы</a></li>
                    <li><a href="expeditions.jsp">Экспедиции</a></li>
					<li><a href="report.jsp">Обращение</a></li>
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
            <div class="main-area">
                <div class="content-area">
                    <div class="img-area">
                        <img class="logoSmall" src="images/warehouse.jpg" alt="">
                    </div>
                    <div class="text-area">
                    <span>
                        Добро пожаловать на сайт коллекции минералов. <br>
                        Данный сайт разработан в рамках курса "Технологии программирования".<br>
                        Всем пользователям данного сайта предоставлена возможность просматривать различные минералы, образцы и экспедиции, а также
                        получить данные о совершённых экспедициях в указанный период времени.<br>
                        Авторизованным пользователям даны привилегии добавления/удаления минералов, образцов и экспедиций.<br>
                        <br>
                    </span>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>