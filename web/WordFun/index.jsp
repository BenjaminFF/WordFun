<%--
  Created by IntelliJ IDEA.
  User: benja
  Date: 2018/4/26
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
      <link href="gwstyle.css" type="text/css" rel="stylesheet">
      <style type="text/css">
          .mycontent{
              width: 100%;
              height: 100%;
              font-size: 5em;
              display: flex;
              justify-content: center;
              align-items: center;
          }
      </style>
      <script src="vue.js"></script>
      <script src="jquery.js"></script>
  </head>
  <body>
  <div id="index">
      <div class="navbar">
          <p class="myTitle"><a href="index.jsp">WordFun</a></p>
          <div class="nav-button-group">
              <button class="nav-button" @click="showLogin">登陆</button>
              <button class="nav-button">注册</button>
          </div>
      </div>
      <div class="main-section">
          <div class="mycontent">请开始你的表演</div>
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
              console.info(document.cookie);
              if(document.cookie!=""){
                  var cookies=document.cookie.replace(/\s/,"");
                  var cookies=document.cookie.split(";");
                  for(var i=0;i<cookies.length;i++){
                      var cookie=cookies[i].split("=");
                      if(cookie[0]=="username"){
                          user.username=cookie[1];
                          console.info(cookie[1]);
                      }else
                      if(cookie[0]==" password"){
                          user.password=cookie[1];
                          console.info(cookie[1]);
                      }
                  }
                  $.ajax({
                      type: "POST",
                      url: "/LoginServlet",
                      data: {username:user.username,
                          password:user.password
                      },
                      error:function () {
                          console.info("error");
                      },
                      success:function (data) {
                          var data=JSON.parse(data);
                          console.info(data);
                          if(data.Status=="true"){
                              window.location.href=data.url;
                          }
                      }
                  });
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
                      $.ajax({
                          type: "POST",
                          url: "/LoginServlet",
                          data: {username:user.username,
                              password:user.password
                          },
                          error:function () {
                              console.info("error");
                          },
                          success:function (data) {
                              var data=JSON.parse(data);
                              console.info(data);
                              if(data.Status=="noUser"){
                                  user.namelog="没有该用户！";
                                  user.showNameLog=true;
                              }else if(data.Status=="false"){
                                  user.pwdlog="密码错误！";
                                  user.showPwdLog=true;
                              }else if(data.Status=="true"){
                                  window.location.href=data.url;
                              }else {
                                  user.pwdlog="未知错误！";
                                  user.showPwdLog=true;
                              }
                          }
                      });
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
      var main=new Vue({
         el:"#index",
          data:{
             dialog:dialog,
          },
          created:function () {

          },
          methods:{
             showLogin:function () {
                 this.dialog.isShow=true;
             }
          }
      });
  </script>
  </body>
</html>
