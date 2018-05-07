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
        .title-edit input{
            height: 100%;
            width: 100%;
            padding-top: 1em;
            font-size: 3em;
            border-top-width: 0px;
            border-right-width: 0px;
            border-bottom: 2px solid #dbdbdb;
            border-left-width: 0px;
            outline: none;
        }

        .item-container{
            margin-top: 3em;
            display: flex;
            width: 80%;
            height: fit-content;
            padding: 2em;
            justify-content: center;
            box-shadow:0 0 1em 1px #86e386;
        }

        .item-container .textarea{
            height: fit-content;
            font-size: 1.5em;
            width: 50%;
            margin-right: 1em;
            border-top-width: 0px;
            border-right-width: 0px;
            border-bottom: 2px solid #dbdbdb;
            border-left-width: 0px;
            outline: none;
            overflow-y: hidden;
        }

        .item-container .textarea:focus{
            border-bottom: 2px solid #86e386;
        }

        .item-container .textarea:empty::before{
            content:attr(placeholder);
            color:lightgrey;
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
            box-shadow:0 0 1em 1px #86e386;
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


        @media screen and (max-width: 768px) {
            .title-edit{
                height: 4em;
                padding-left: 2em;
                padding-right: 2em;
            }
            .title-edit input{
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
    </style>
</head>
<body>
<div id="wordEdit">
    <div class="title-edit">
        <input type="text" placeholder="title">
    </div>
    <div class="item-container" v-for="item in items">
        <div contenteditable="true" class="textarea" placeholder="word"></div>
        <div contenteditable="true" class="textarea" placeholder="difination"></div>
    </div>
    <div class="button-container">
        <div class="addItem" @click="addItem($event)">ADD WORDS</div>
    </div>
    <div class="create">CREATE</div>
</div>
</body>
<script>
    var vue=new Vue({
       el:"#wordEdit",
        data:{
           items:[],
        },
        created:function () {
            var item1={
                word:"",
                explain:""
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
        }
    });
</script>
</html>
