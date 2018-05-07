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
    <style type="text/css">
        html,body{
            width: 100%;
            height: 100%;
        }
        body,div,p{
            margin: 0;
            padding: 0;
        }
        #WordSet{
            width: 100%;
            height: 100%;
        }
        .items-style{
            --row:7;
            --column:7;
            --itemsize:15em;
            width: fit-content;
            height: fit-content;
            display: grid;
            grid-template-columns: repeat(var(--row),var(--itemsize));
            grid-template-rows: repeat(var(--column),var(--itemsize));
        }
        .item-style{
           width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            background-color: lightcyan;
        }

        .item-title{
            font-size: 3em;
        }

        .item-count{
            font-size: 2.5em;
            margin-top: 0.1em;
        }

        .item-date{
            font-size: 1em;
            margin-top: 2em;
        }

        .floatbutton{
            width: 2em;
            height: 2em;
            position:fixed;
            right: 0;
            bottom: 0;
            margin: 1em;
            padding: 1em;
            border-radius: 50%;
            background-color: darkkhaki;
            border: 3px darkkhaki solid;
        }
    </style>
</head>
<body>
   <div id="WordSet">
       <div class="items-style"
            v-bind:style="{'--row':row,'--column':column,
            'grid-row-gap':rowgap+'px','margin':margin+'px'
            ,'--itemsize':itemsize+'px','grid-column-gap':columngap+'px'}">
           <div class="item-style" v-for="item in items">
               <p class="item-title">{{item.title}}</p>
               <p class="item-count">{{item.count}}个</p>
               <p class="item-date">{{item.date}}</p>
           </div>
       </div>
       <img src="/icons/add.svg" class="floatbutton"/>
   </div>
</body>
<script>
    var wordset=new Vue({
        el:"#WordSet",
        data:{
            items:[],
            row:5,
            column:5,
            itemsize:16*15,
            rowgap:-1,
            margin:32,
            columngap:-1,
            screenwidth:document.body.clientWidth,
            rawItemSize:16*15
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

            this.updateItems();
            console.info(this.column);
        },
        mounted:function () {
            window.addEventListener('resize', this.handleResize);
        },
        beforeDestroy: function () {
            window.removeEventListener('resize', this.handleResize)
        },
        methods:{
            handleResize:function () {
                this.screenwidth=document.body.clientWidth;
              this.updateItems();
            },
            updateItems:function () {
                var itemswidth=this.screenwidth-this.margin*2;
                var n=itemswidth/this.rawItemSize;
                this.row=parseInt(n);                   //能容纳item的数量
                if(this.row==1){
                    var leftwidth=itemswidth-(this.row)*this.itemsize;
                    this.itemsize+=leftwidth;
                    this.rowgap=32;
                    this.columngap=0;
                    this.column=this.items.length;
                }else if(this.row==0){
                    var leftwidth=itemswidth-(this.row)*this.itemsize;
                    this.itemsize=itemswidth;
                    this.rowgap=32;
                    this.columngap=0;
                    this.row=1;
                    this.column=this.items.length;
                }else {
                    var leftwidth=itemswidth-(this.row)*this.itemsize;
                    this.rowgap=this.columngap=32;
                    //把多余的width平分给itemsize
                    this.itemsize+=(leftwidth-(this.rowgap)*(this.row-1))/this.row;
                    var m=this.items.length/this.row;
                    if(m-parseInt(m)<=0.0000001){
                        this.column=parseInt(m);
                    }else {
                        this.column=parseInt(m)+1;
                    }
                }
            }
        },
    });
</script>
</html>
