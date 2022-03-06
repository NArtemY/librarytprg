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
    if (cookie != null && cookie.getValue().equals("admin")) {
        isLoggedIn = true;
        if (request.getParameter("add-button") != null) {
            String nameMineral = request.getParameter("inputMineralSample");
            String origin = request.getParameter("originSample");
            String detection = request.getParameter("detectionSample");
            String source = request.getParameter("sourceSample");
			Mineral minerals = Database.getMineralByName(nameMineral);
            Admin.addSample(minerals, origin, detection, source);
        }
        if (request.getParameter("delete-button") != null) {
            for (int i = Database.sampleList.size() - 1; i >= 0; i--) {
                if (request.getParameter("checkbox" + Database.sampleList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.sampleList.get(i).getId()));
                    Admin.removeSample(Database.sampleList.get(i).getId());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Образцы</title>
    <link rel='stylesheet' type='text/css' href='style/style.css' />
    <script>
        function tableSearch() {
            var phrase = document.getElementById('search-text');
            var table = document.getElementById('table-id');
            var regPhrase = new RegExp(phrase.value, 'i');
            var flag = false;
            for (var i = 1; i < table.rows.length; i++) {
                flag = false;
                for (var j = table.rows[i].cells.length - 1; j >= 0; j--) {
                    flag = regPhrase.test(table.rows[i].cells[j].innerHTML);
                    if (flag) break;
                }
                if (flag) {
                    table.rows[i].style.display = "";
                } else {
                    table.rows[i].style.display = "none";
                }
            }
        }
    </script>
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
        <div style="margin-bottom: 30px ">
            <h3>Поиск</h3>
            <input class="input-background" type="text" placeholder="Поиск" id="search-text" onkeyup="tableSearch()">
        </div>
        <div class="flex-box">
            <div class="table-form">
                <h3>Образцы</h3>
                <form action="" method="post">
                    <table id="table-id" class="product-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Входящий минерал</th>
                            <th>Происхождение</th>
                            <th>Место обнаружения</th>
                            <th>Источник</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Sample sample: Database.sampleList) {%>
                        <tr>
                            <td><input type="checkbox" name=<%="checkbox"+sample.getId()%> value="<%=sample.getId()%>"></td>
                            <td><%=sample.getId()%></td>
                            <td><%=sample.getMinerals().getName()%></td>
                            <td><%=sample.getOrigin()%></td>
                            <td><%=sample.getDetection()%></td>
                            <td><%=sample.getSource()%></td>
                        </tr>
                        <%  }%>
                        </tbody>
                    </table>
                    <input class="input-background" type="submit" name="delete-button" value="Удалить">
                </form>
            </div>
            <div class="add-area">
                <form class="add-form" action="" method="post">
					Добавление нового образца<br>
					Входящий минерал:
                    <select required name="inputMineralSample" class="input-background">
                        <option value=""></option>
                        <%
                            for (Mineral mineral : Database.mineralList) {
                        %>
                        <option value="<%=mineral.getName()%>"><%=mineral.getName()%></option>
                        <%}%>
                    </select><br/>
					Происхождение: <input  class="input-background" name="originSample"><br/>
					Место обнаружения: <input  class="input-background" name="detectionSample"><br/>
					Источник: <input  class="input-background" name="sourceSample"><br/>
                    <input class="input-background" type="submit" name="add-button" value="Добавить">
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>