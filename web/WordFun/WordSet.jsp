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
        }
    </style>
</head>
<body>
   <div id="WordSet">
       <div class="toolbar"></div>
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
            containerWidth:-1,
            gridStyle:{
                '--row':3,
                '--column':3,
                '--itemsize':16*10,
                'margin':32,
            },
            rawItemsize:16*10,
            userdata:{

            }
        },
        mounted:function () {
            window.addEventListener('resize', this.handleResize);
            this.initItems();
            console.info(this.containerWidth);
        },
        created:function () {
            var item1={
                title:"Holly",
                count:12,
                date:"2018年4月12日",
            };
            var item2={
                title:"Holly",
                count:12,
                date:"2018年4月12日",
            };
            var item3={
                title:"Holly",
                count:12,
                date:"2018年4月12日",
            };
            var item4={
                title:"Holly",
                count:12,
                date:"2018年4月12日",
            };
            var item5={
                title:"Holly",
                count:12,
                date:"2018年4月12日",
            };
            this.items.push(item1);
            this.items.push(item2);
            this.items.push(item3);
            this.items.push(item4);
            this.items.push(item5);
            this.items.push(item1);
            this.items.push(item2);
            this.items.push(item3);
            this.items.push(item4);
            this.items.push(item5);
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
        },
    });
</script>
</html>
