<%--
  Created by IntelliJ IDEA.
  User: benja
  Date: 2018/5/6
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WordEdit</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!--width=device-width ： 网页宽度等于设备宽度
    initial-scale=1.0 ： 初始缩放比例为1.0 。网页初始页面的大小占整个面积的100%
    maximum-scale=1.0 ： 最大缩放比例为1.0 ，
    user-scalable ： 用户是否可以手动缩放!-->
    <script src="vue.js">
    </script>
    <script src="jquery.js">
    </script>
    <style type="text/css">
        body,html{
            width: 100%;
            height: 100%;
        }
        body,div,p,input{
            margin: 0;
            padding: 0;
            user-select: none;
        }
        #wordEdit{
            width: 100%;
            display: flex;
            align-items: center;
            flex-direction: column;
        }
        .title-edit{
            height: 8em;
            width: 100%;
            box-sizing: border-box;
            padding-left: 8em;
            padding-right: 8em;
        }
        .title-edit .titleinput{
            height: 100%;
            width: 100%;
            padding-top: 1em;
            font-size: 3em;
            border-top-width: 0px;
            border-right-width: 0px;
            border-bottom: 2px solid darkgray;
            border-left-width: 0px;
            outline: none;
            background: none;
            color: #72af25;
        }

        .title-edit input:focus{
            border-bottom: 3px solid green;
        }

        .item-container{
            margin-top: 3em;
            display: flex;
            width: 80%;
            height: fit-content;
            padding: 2em;
            justify-content: center;
            background-color: rgba(255, 255, 255, 0.35);
            box-shadow:0 0 1em 1px rgba(0, 0, 0, 0.21);
        }

        .item-container .textarea{
            height: fit-content;
            font-size: 1.5em;
            width: 50%;
            margin-right: 1em;
            border-top-width: 0px;
            border-right-width: 0px;
            border-bottom: 2px solid darkgray;
            border-left-width: 0px;
            outline: none;
            overflow-y: hidden;
            color: #72af25;
        }

        .item-container .textarea:focus{
            border-bottom: 3px solid green;
        }

        .item-container .textarea:empty::before{
            content:attr(placeholder);
            color:darkgray;
            cursor: text;
        }
        .item-container .textarea:nth-child(2){
            margin-right: 0;
        }

        .button-container{
            margin-top: 3em;
            display: flex;
            width: 80%;
            padding-left: 2em;
            padding-right: 2em;
            height: 6em;
            justify-content: center;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.35);
            box-shadow:0 0 1em 1px rgba(0, 0, 0, 0.21);
        }

        .addItem{
            width: fit-content;
            height: fit-content;
            padding: 0.5em;
            border-top-width: 0px;
            border-right-width: 0px;
            border-bottom: 3px solid lawngreen;
            font-size: 1.2em;
            color: darkgray;
        }
        .addItem:hover{
            color: green;
            cursor: pointer;
            border-bottom: 3px solid green;
        }

        .create{
            font-size: 1.3em;
            margin-top: 2em;
            width: 6em;
            height: 2.5em;
            display: flex;
            color: green;
            justify-content: center;
            align-items: center;
            box-shadow:0 0 1em 3px #86e386;
        }
        .create:hover{
            cursor: pointer;
            background-color: #86e386;
            color: white;
        }

        @media screen and (max-width: 1920px){
            body{
            }
        }


        @media screen and (max-width: 768px) {
            .title-edit{
                height: 4em;
                padding-left: 2em;
                padding-right: 2em;
            }
            .title-edit .titleinput{
                font-size: 2em;
                padding-top: 0.5em;
            }

            .item-container{
                flex-direction: column;
                width: 60%;
            }

            .button-container{
                width: 60%;
                height: 8em;
            }

            .item-container .textarea{
                width: 100%;
            }

            .item-container .textarea:nth-child(2){
                min-height: 5em;
                margin-top: 1em;
                border-bottom-width: 0;
            }
        }
        .toast{
            position: fixed;
            bottom: 5em;
            width: 12em;
            height: 3em;
            border-radius: 2em;
            background-color: rgba(211, 211, 211, 0.4);
            font-size: 1.2em;
            color: red;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="wordEdit">
    <div class="title-edit">
        <input type="text" placeholder="title" class="titleinput" v-model="title">
    </div>
    <div class="item-container" v-for="item in items">
        <div contenteditable="true" class="textarea" placeholder="word"  @input="bindItem('word',item,$event)"></div>
        <div contenteditable="true" class="textarea" placeholder="difination" @input="bindItem('explain',item,$event)"></div>
    </div>
    <div class="button-container">
        <div class="addItem" @click="addItem($event)">ADD WORDS</div>
    </div>
    <div class="create" @click="createItems">CREATE</div>
    <div class="toast">{{errorhint}}</div>
</div>
</body>
<script>
    $(".toast").hide();
    var vue=new Vue({
       el:"#wordEdit",
        data:{
           errorhint:"gg",
           errorHappened:false,
           items:[],
            title:""
        },
        created:function () {
            var item1={
                word:"",
                explain:"",
            };
            var item2={
                word:"",
                explain:""
            }
            this.items.push(item1);
        },
        methods:{
           addItem:function (event) {
               var item={
                   word:"",
                   explain:""
               }
               this.items.push(item);
               var scrolltop=$('.addItem').offset().top;
               console.info();
               if(scrolltop>=$('body').height()-2*$('.button-container').height()){
                   $('body').animate({scrollTop:scrolltop},1000);
               }
           },
           createItems:function () {
               for(var i=0;i<this.items.length;i++){
                   if(this.items[i].word==""||this.items[i].explain==""){
                       break;
                   }
               }
               console.info(i);
               if(this.title==""){
                   $(".titleinput").css("border-bottom","3px solid red");
                   $(".titleinput").focus();
                   this.errorhint="title cannot be empty";
                   $('.toast').show().fadeOut(3000);
                   this.errorHappened=true;
               }else if(i!=this.items.length){      //有item项的word或explain为空
                   if(this.items[i].word==""){
                       var index=i*2;
                       $(".textarea:eq("+index+")").focus();
                       var m=i+1;
                       this.errorhint="the "+m+" row 'word' cannot be empty";
                   }else {
                       var index=i*2+1;
                       $(".textarea:eq("+index+")").focus();
                       var m=i+1;
                       this.errorhint="the "+m+" row 'defination' cannot be empty";
                   }
                   $('.toast').show().fadeOut(3000);
               }else {
                   $.ajax({
                       type: "POST",
                       url: "/WordSetServlet",
                       data: {mydata:jsondata,
                           title:title,
                           timestamp:timestamp
                       },
                       error:function () {
                           console.info("error");
                       },
                       success:function () {
                           console.info("success");
                       }
                   });
               }
               var jsondata=JSON.stringify(this.items);
               var title=this.title;
               var timestamp=(new Date()).valueOf();

           },
           bindItem:function (value,item,event) {
               if(this.title!=""&&this.errorHappened){
                   $(".titleinput").css("border-bottom","3px solid green");
                   this.errorHappened=false;
               }
               if(value=="word"){
                   item.word=event.target.innerHTML;
               }else if(value=="explain"){
                   item.explain=event.target.innerHTML;
               }
           }
        }
    });
</script>
</html>
