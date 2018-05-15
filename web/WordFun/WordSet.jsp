<%--
  Created by IntelliJ IDEA.
  User: benja
  Date: 2018/5/3
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WordSet</title>
    <script src="vue.js">
    </script>
    <script src="jquery.js"></script>
    <style type="text/css">
        html,body{
            width: 100%;
            height: 100%;
        }
        body,div,p{
            margin: 0;
            padding: 0;
            user-select: none;
        }
        #WordSet{
            width: 100%;
            height: 100%;
        }

        .toolbar{
            background-color: rgba(255, 255, 255, 0.71);
            width: 100%;
            height: 10em;
            box-shadow: 0 0 1em gray;
            display: flex;
            align-items: center;
            position: relative;
        }
        .toolbar p{
            font-size: 3em;
            margin-left: 1em;
        }

        .create_set{
            position: absolute;
            width: 2em;
            height: 2em;
            background-color: #00b3ee;
            right: 5%;
            bottom: -2em;
            padding: 1em;
            border-radius: 50%;
            cursor: pointer;
            z-index: 5;
            box-shadow: 0 0 5px gray;
        }

        .main-content{
            display: flex;
            width: 100%;
            height: auto;
        }

        .left-content{
            flex: 5 0 0;
        }

        .item-container{
            --row:6;
            --column:6;
            --itemsize:4em;
            display: grid;
            grid-gap: 1em;
            justify-content: center;
            grid-template-columns: repeat(var(--column),var(--itemsize));
            grid-template-rows: repeat(var(--row),var(--itemsize));
        }

        .item-style{
            width: 100%;
            height: 100%;
            background-color: white;
            box-shadow: 0 0 0.5em lightgray;
            cursor: pointer;
        }

        .item-style:hover{
            background-color: rgba(134, 227, 134, 0.41);
        }

        .right-content{
            flex: 5 0 0;
        }

        @media screen and (max-width: 768px){
            .left-content{
                width: 100%;
            }
            .right-content{
                width: 0%;
            }
            .create_set{
                right: 1em;
            }
        }
    </style>
</head>
<body>
   <div id="WordSet">
       <div class="toolbar"><p>{{username}}</p>
       <img class="create_set" src="/icons/add.svg" @click="createItem"/>
       </div>
       <div class="main-content">
           <div class="left-content">
               <div class="item-container"  v-bind:style="gridStyle">
                   <div v-for="item in items" class="item-style">
                   </div>
               </div>
           </div>
           <div class="right-content"></div>
       </div>
   </div>
</body>
<script>
    var wordset=new Vue({
        el:"#WordSet",
        data:{
            items:[],
            username:"",
            containerWidth:-1,
            gridStyle:{
                '--row':3,
                '--column':3,
                '--itemsize':16*10,
                'margin':32,
            },
            rawItemsize:16*10,
        },
        mounted:function () {
            window.addEventListener('resize', this.handleResize);
            this.initItems();
            console.info(this.containerWidth);
        },
        created:function () {
            var _self=this;
            $.ajax({
                type: "POST",
                url: "/ClientServlet",
                error:function () {
                    console.info("error");
                },
                success:function (data) {
                    console.info(data);
                    if(data!=""){
                        var data=JSON.parse(data);
                        if(data.Status=="true"){
                            _self.username=data.username;
                        }
                    }
                }
            });
        },
        beforeDestroy: function () {
            window.removeEventListener('resize', this.handleResize)
        },
        methods:{
            handleResize:function () {
                console.info($("body").width());
            },
            initItems:function () {
                this.containerWidth=$(".left-content").width()-this.gridStyle.margin*2;
                var width=this.containerWidth;
                var n=width/this.rawItemsize;
                if(parseInt(n)==1||parseInt(n)==0){
                    this.gridStyle["--column"]=1;
                    this.gridStyle["--row"]=this.items.length;
                    this.gridStyle["--itemsize"]=width;
                    console.info("n==0||1");
                }else {
                    this.gridStyle["--column"]=parseInt(n);
                    this.gridStyle["--row"]=parseInt(this.items.length/parseInt(n))+1;
                    this.gridStyle["--itemsize"]+=(n-parseInt(n))*this.rawItemsize/parseInt(n);
                    console.info(n);
                }
            },
            createItem:function () {
                window.location.href="/WordFun/WordEdit.jsp";
            }
        },
    });
</script>
</html>
