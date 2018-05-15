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
    <script src="jquery.js"></script>
</head>
<body>
<div id="index">
    <div class="navbar">
        <p class="myTitle"><a href="client.jsp">WordFun</a></p>
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
</body>
<script>
    var mainsection=new Vue({
       el:"#index",
       data:{
           items:[],
           curFrameSrc:"WordSet.jsp",
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
       }
    });
</script>
</html>
