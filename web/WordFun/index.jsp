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
</head>
<body>
<div id="index">
    <div class="navbar">
        <p class="myTitle"><a href="index.jsp">WordFun</a></p>
        <div class="nav-button-group">
            <button class="nav-button" @click="login">登陆</button>
            <button class="nav-button">注册</button>
        </div>
    </div>
    <div class="main-section" id="main">
        <div class="sidebar" id="sidebar">
            <div v-for="item in items" class="sidebar-item" v-bind:class="{itemChosen:item.isChosen}"
                 @click="switchItem(item)">
                <p v-bind:style="{color:item.titleColor}">{{item.title}}</p>
            </div>
        </div>
        <div class="main-content">
            <iframe v-bind:src="curFrameSrc" frameborder="0"
                    class="main-frame"></iframe>
        </div>
    </div>
</div>


<div class="lg-model" id="lg-dialog" v-if="isShow">
    <div class="lg-dialog">
        <div class="lg-dialog-nav">
            <p>登陆</p>
            <img src="/icons/cross.svg" @click="dismiss"/>
        </div>
        <form class="lg-dialog-form" method="post">
            <div class="form-item" style="margin-top: 2em">
                <div class="input-item">
                    <img src="/icons/user.svg"/>
                    <input name="username" type="text"  v-model="user.username">
                </div>
                <transition name="hintAnimate" v-on:after-enter="afterEnter">
                    <span class="input-hint" v-if="user.showNameLog">{{user.namelog}}</span>
                </transition>
            </div>
            <div class="form-item">
                <div class="input-item">
                    <img src="/icons/lock.svg"/>
                    <input name="password" type="text"
                           v-model="user.password" v-bind:type="user.pwdType">
                    <img v-bind:src="user.imgsrc" class="rightimg" style="cursor: pointer" @click="alterPwdType">
                </div>
                <transition name="hintAnimate" v-on:after-enter="afterEnter">
                    <span class="input-hint" v-if="user.showPwdLog">{{user.pwdlog}}</span>
                </transition>
            </div>

            <input type="submit" value="登陆" class="lg-dialog-submit" @click="submit">
        </form>
    </div>
</div>
</body>
<script>
    var dialog=new Vue({
        el:"#lg-dialog",
        data:{
            isShow:false,
            user:[]
        },
        ready:function () {
            window.addEventListener('resize', this.handleResize);
        },
        created:function () {
            var user={
                username:"",
                password:"",
                showNameLog:false,
                showPwdLog:false,
                pwVisible:false,
                namelog:"",
                pwdlog:"",
                pwdType:"password",
                imgsrc:"/icons/eye.svg"
            }
            this.user=user;
        },
        methods:{
            dismiss:function () {
                this.isShow=false;
            },
            handleResize:function () {
               alert("gg")
            },
            submit:function (event) {
                event.preventDefault();
                var user=this.user;
                if(user.username.length==0||user.password==0){
                    if(user.username.length==0){
                        user.namelog="用户名不能为空！";
                        user.showNameLog=true;
                    } else
                    if(user.password.length==0){
                        user.pwdlog="密码不能为空！";
                        user.showPwdLog=true;
                    }
                }else {
                    var xmlhttp=new XMLHttpRequest();
                    xmlhttp.open("post","/LoginServlet",true);
                    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                    xmlhttp.send("username="+user.username+"&password="+user.password);
                    xmlhttp.onreadystatechange=function (ev) {
                        if(xmlhttp.readyState==4&&xmlhttp.status==200){
                                    console.info(xmlhttp.responseText);
                                    if(xmlhttp.responseText=="noUser"){
                                        user.namelog="没有该用户";
                                        user.showNameLog=true;
                            }else{
                                if(xmlhttp.responseText=="false"){
                                    user.pwdlog="密码错误";
                                    user.showPwdLog=true;
                                }else if(xmlhttp.responseText=="true"){
                                    console.info("success");
                                }else {
                                    user.pwdlog="未知错误";
                                    user.showPwdLog=true;
                                }
                            }
                        }
                    };
                }
            },
            afterEnter:function () {
                this.user.showNameLog=false;
                this.user.showPwdLog=false;
            },
            alterPwdType:function () {
                if(this.user.pwdType=="password"){
                    this.user.pwdType="text";
                    this.user.imgsrc="/icons/hide.svg";
                }else {
                    this.user.pwdType="password";
                    this.user.imgsrc="/icons/eye.svg";
                }
            }
        }
    });

    var mainsection=new Vue({
       el:"#index",
       data:{
           items:[],
           curFrameSrc:"WordSet.jsp",
           dialog:dialog
       },
       created:function () {
           var item1={
               title:"你的单词集",
               iconsrc:"",
               titleColor:"black",
               framesrc:"WordSet.jsp",
               isChosen:true
           };
           var item2={
               title:"单词矩阵",
               iconsrc:"",
               titleColor:"black",
               framesrc:"WordMatrix.jsp",
               isChosen:false
           };
           var item3={
               title:"吊小人",
               iconsrc:"",
               titleColor:"black",
               framesrc:"HangMan.jsp",
               isChosen:false
           };
           var item4={
               title:"乾坤大挪移",
               iconsrc:"",
               titleColor:"black",
               framesrc:"Scramble.jsp",
               isChosen:false
           };
           var item5={
               title:"单词接龙",
               iconsrc:"",
               titleColor:"black",
               framesrc:"WordChain.jsp",
               isChosen:false
           };
           this.items.push(item1);
           this.items.push(item2);
           this.items.push(item3);
           this.items.push(item4);
           this.items.push(item5);
       },
       methods:{
           switchItem:function (item) {
               if(item.isChosen){
                   return;
               }
               for(var i=0;i<this.items.length;i++){
                   if(this.items[i].isChosen){
                       this.items[i].isChosen=false;
                   }
               }
               item.isChosen=true;
               this.curFrameSrc=item.framesrc;
               console.info(item.framesrc);
           },
           login:function () {
               this.dialog.isShow=true;
           }
       }
    });
</script>
</html>
