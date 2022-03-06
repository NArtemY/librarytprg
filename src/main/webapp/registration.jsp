<%@ page import="com.example.storehouse.*" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="com.example.storehouse.Database" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (!Database.isEnable)Database.Init(10, 10, 10, 10);
    String registerMessage = null;
    boolean isDouble = false;
    if (request.getParameter("register-button") != null) {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        for (Account account: Database.accountList){
            if (account.getLogin().equals(login)) {
                registerMessage = "Аккаунт с таким логином уже существует";
                isDouble = true;
                break;
            }
        }
        if (!isDouble){
            Geologist geolog = new Geologist(name, address, phone, email);
            Admin.addAccount(login, password, geolog);
            response.sendRedirect("authorization.jsp");
        }
    }
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
    <title>Регистрация</title>
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
        <div class="login-area">
            <form action="" method="post">
                Логин: <input style="width: 192px;" class="input-background" required type="text" name="login"><br>
                Пароль: <input class="input-background" required type="password" name="password"><br>
                ФИО: <input style="width: 205px;" class="input-background" required type="text" name="name"><br>
                Адрес: <input style="width: 185px;" class="input-background" required type="text" name="address"><br>
                Телефон: <input required id="online_phone" class="input-background" autofocus="autofocus" value="+7(___)___-__-__" type="tel" placeholder="+7(___)___-__-__" pattern="\+7\s?[\(]{0,1}9[0-9]{2}[\)]{0,1}\s?\d{3}[-]{0,1}\d{2}[-]{0,1}\d{2}" name="phone"><br/>
                Email: <input style="width: 192px;" class="input-background" required type="text" name="email"><br>
                <input style="width: 150px; margin-left: 17%; text-align: center" class="input-background" type="submit" name="register-button" value="Зарегистрироваться">
            </form>
			<script type="text/javascript">
  function setCursorPosition(pos, e) {
    e.focus();
    if (e.setSelectionRange) e.setSelectionRange(pos, pos);
    else if (e.createTextRange) {
      var range = e.createTextRange();
      range.collapse(true);
      range.moveEnd("character", pos);
      range.moveStart("character", pos);
      range.select()
    }
  }

  function mask(e) {
    var matrix = this.placeholder,// .defaultValue
        i = 0,
        def = matrix.replace(/\D/g, ""),
        val = this.value.replace(/\D/g, "");
    def.length >= val.length && (val = def);
    matrix = matrix.replace(/[_\d]/g, function(a) {
      return val.charAt(i++) || "_"
    });
    this.value = matrix;
    i = matrix.lastIndexOf(val.substr(-1));
    i < matrix.length && matrix != this.placeholder ? i++ : i = matrix.indexOf("_");
    setCursorPosition(i, this)
  }
  window.addEventListener("DOMContentLoaded", function() {
    var input = document.querySelector("#online_phone");
    input.addEventListener("input", mask, false);
    input.focus();
    setCursorPosition(3, input);
  });
</script>
            <p><%if(registerMessage != null)%><%=registerMessage%></p>
        </div>
    </div>
</main>
</body>
</html>