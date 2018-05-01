<%--
  Created by IntelliJ IDEA.
  User: benja
  Date: 2018/4/30
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!--width=device-width ： 网页宽度等于设备宽度
    initial-scale=1.0 ： 初始缩放比例为1.0 。网页初始页面的大小占整个面积的100%
    maximum-scale=1.0 ： 最大缩放比例为1.0 ，
    user-scalable ： 用户是否可以手动缩放!-->
    <title>index</title>
    <link href="gwstyle.css" type="text/css" rel="stylesheet">
    <script src="vue.js"></script>
    <script src="gwjs.js"></script>
</head>
<body>
<div class="navbar">
    <p class="myTitle"><a href="index.jsp">WordFun</a></p>
    <div class="nav-button-group">
        <button class="nav-button">登陆</button>
        <button class="nav-button">注册</button>
    </div>
</div>
<div class="main-section">
    <div class="sidebar"></div>
    <div class="main-content"></div>
</div>

<div class="lg-model">
    <div class="lg-dialog">
        <div class="lg-dialog-nav">

        </div>
        <form class="lg-dialog-form" method="post">
            <div class="form-item">
                <img src="/icons/user.svg"/>
                <input name="username" type="text" style="position: absolute">
            </div>
            <div class="form-item">
                <img src="/icons/lock.svg"/>
                <input name="password" type="text" style="position: absolute">
                <img src="/icons/eye.svg" class="rightimg">
            </div>
            <input type="submit" value="登陆">
        </form>
    </div>
</div>
</body>
<script>

</script>
</html>
