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
            String name = request.getParameter("mineralName");
            String classification = request.getParameter("classificationMineral");
            String condition = request.getParameter("conditionMineral");
            String solid = request.getParameter("solidMineral");
            String internalProperties = request.getParameter("internalPropertiesMineral");
			String chemical = request.getParameter("chemicalMineral");
			String origin = request.getParameter("originMineral");
            Admin.addMineral(name, classification, condition, solid, internalProperties, chemical, origin);
        }
        if (request.getParameter("delete-button") != null) {
            for (int i = Database.mineralList.size() - 1; i >= 0; i--) {
                if (request.getParameter("checkbox" + Database.mineralList.get(i).getId()) != null) {
                    System.out.println(request.getParameter("checkbox" + Database.mineralList.get(i).getId()));
                    Admin.removeMineral(Database.mineralList.get(i).getId());
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Минералы</title>
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
            <h3 >Поиск</h3>
            <input class="input-background" type="text" placeholder="Поиск" id="search-text" onkeyup="tableSearch()">
        </div>
        <div class="flex-box">
            <div class="table-form">
                <h3>Минералы</h3>
                <form action="" method="post">
                    <table id="table-id" class="product-table">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ID</th>
                            <th>Названиие минерала</th>
                            <th>Классификация минерала</th>
                            <th>Состояние минерала</th>
                            <th>Тип криссталической решётки</th>
                            <th>Блеск, цвет, магнитные свойства</th>
                            <th>Химическая формула</th>
							<th>Происхождение</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            for(Mineral mineral: Database.mineralList) {%>
                        <tr>
                            <td><input type="checkbox" name=<%="checkbox"+mineral.getId()%> value="<%=mineral.getId()%>"></td>
                            <td><%=mineral.getId()%></td>
                            <td><%=mineral.getName()%></td>
                            <td><%=mineral.getClassification()%></td>
                            <td><%=mineral.getCondition()%></td>
                            <td><%=mineral.getSolid()%></td>
                            <td><%=mineral.getInternalProperties()%></td>
                            <td><%=mineral.getChemical()%></td>
							<td><%=mineral.getOrigin()%></td>
                        </tr>
                        <%  }%>
                        </tbody>
                    </table>
                    <input class="input-background" type="submit" name="delete-button" value="Удалить">
                </form>
            </div>
            <div class="add-area">
                <form class="add-form" action="" method="post">
					Добавление минерала<br>
                    Название минерала: <input  class="input-background" name="mineralName"><br/>
					Классификация минерала: <input  class="input-background" name="classificationMineral"><br/>
					Состояние минерала: <select style="width: 233px" required class="input-background" name="conditionMineral" id="">
                    <option value=""></option>
                    <option value="Твёрдое">Твёрдое</option>
                    <option value="Жидкое">Жидкое</option>
                </select><br/>
					Тип криссталической решётки: <input  class="input-background" name="solidMineral"><br/>
					Блеск, цвет, магнитные свойства: <input  class="input-background" name="internalPropertiesMineral"><br/>
					Химическая формула: <input  class="input-background" name="chemicalMineral"><br/>
					Происхождение: <input  class="input-background" name="originMineral"><br/>
                    <input class="input-background" type="submit" name="add-button" value="Добавить">
                </form>
            </div>
        </div>
    </div>
</main>
</body>
</html>