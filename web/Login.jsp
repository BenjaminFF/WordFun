<%--
  Created by IntelliJ IDEA.
  User: benja
  Date: 2018/4/26
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="vue.js"></script>
    <link href="LoginStyle.css" type="text/css" rel="stylesheet">
</head>
<body>
<div id="myForm">
    <p class="title">用户注册</p>
    <div class="form_style" v-for="(item,index) in items">
        <p>{{item.title}}</p>
        <div class="input_div">
            <input type="text" class="inputStyle" v-bind:style="{border:item.border}"
                    v-on:blur="inputBlur(item)" v-on:focus="inputFocus(item)"
                   v-model="item.value" v-autofocus="item.isFocus"
                   >
            <p v-bind:style="{color:item.hintcolor}">{{item.hint}}</p>
        </div>
    </div>
    <button class="mybutton" @click="submitForm">提交</button>
</div>
<script>
    var myForm=new Vue({
        el:"#myForm",
        data:{
            items:[],
            clicked:false
        },
        created:function () {
            var item1={
                title:"姓名",
                hint:"必填，长度为4~16个字符",
                name:'username',
                border:"",
                hintcolor:"",
                value:"",
                isFocus:false,
                valuePassed:false
            };
            var item2={
                title:"密码",
                hint:"必填，长度为6~16个字符，必须包含数字，字母，大小写",
                name:'password',
                border:"",
                hintcolor:"",
                value:"",
                isFocus:false,
                valuePassed:false
            };
            var item3={
                title:"密码确认",
                hint:"请验证上次的输入",
                name:'pw_confirm',
                border:"",
                hintcolor:"",
                value:"",
                isFocus:false,
                valuePassed:false
            }
            var item4={
                title:"邮箱",
                hint:"请输入正确的邮箱格式",
                name:'email',
                border:"",
                hintcolor:"",
                value:"",
                isFocus:false,
                valuePassed:false
            }
            var item5={
                title:"手机",
                hint:"请输入正确的手机号码",
                name:'telephone',
                border:"",
                hintcolor:"",
                value:"",
                isFocus:false,
                valuePassed:false
            }
            this.items.push(item1);
            this.items.push(item2);
            this.items.push(item3);
            this.items.push(item4);
            this.items.push(item5);

        },
        methods:{
            inputFocus:function (item) {
                item.isFocus=true;
                switch (item.name){
                    case 'username':
                        if(item.valuePassed){
                            this.changeItem(item,"名字可用");
                        }else {
                            this.changeItem(item,"必填，长度为4~16个字符");
                        }
                        break;
                    case 'password':
                        if(item.valuePassed){
                            this.changeItem(item,"密码可用");
                        }else {
                            this.changeItem(item,"必填，长度为6~16个字符，必须包含数字，字母，大小写");
                        }
                        break;
                    case 'pw_confirm':
                        if(item.valuePassed){
                            this.changeItem(item,"和上一次密码相符");
                        }else {
                            this.changeItem(item,"请验证上次的输入");
                        }
                        break;
                    case 'email':
                        if(item.valuePassed){
                            this.changeItem(item,"邮箱格式正确");
                        }else {
                            this.changeItem(item,"请输入正确的邮箱格式");
                        }
                        break;
                    case 'telephone':
                        if(item.valuePassed){
                            this.changeItem(item,"手机格式正确");
                        }else {
                            this.changeItem(item,"请输入正确的手机号码");
                        }
                        break;
                }
            },
            inputBlur:function (item) {
                item.isFocus=false;
                switch(item.name){
                    case 'username':
                        if(this.getByteLen(item.value)>=6&&this.getByteLen(item.value)<=16){
                            item.valuePassed=true;
                            this.changeItem(item,"名字可用");
                        }else {
                            item.valuePassed=false;
                            this.changeItem(item,"名字不可用");
                        }
                        break;
                    case 'password':
                        if(this.validatePW(item.value)){
                            item.valuePassed=true;
                            this.changeItem(item,"密码可用");
                        }else {
                            item.valuePassed=false;
                            this.changeItem(item,"密码格式不正确");
                        }
                        break;
                    case 'pw_confirm':
                        var pw_item;
                        for(var i=0;i<this.items.length;i++){
                            if(this.items[i].name=='password'){
                                pw_item=this.items[i];
                                break;
                            }
                        }
                        if(!pw_item.valuePassed){
                            item.valuePassed=false;
                            this.changeItem(item,"请输入正确的密码格式");
                        }else {
                            if (item.value==pw_item.value){
                                item.valuePassed=true;
                                this.changeItem(item,"和上一次密码相符");
                            }else {
                                item.valuePassed=false;
                                this.changeItem(item,"和上一次密码不相符");
                            }
                        }
                        break;
                    case 'email':
                        if(this.IsEmail(item.value)){
                            item.valuePassed=true;
                            this.changeItem(item,"邮箱格式正确");
                        }else {
                            item.valuePassed=false;
                            this.changeItem(item,"请输入正确的邮箱格式");
                        }
                        break;
                    case 'telephone':
                        if(this.IsPhone(item.value)){
                            item.valuePassed=true;
                            this.changeItem(item,"手机号码格式正确");
                        }else {
                            item.valuePassed=false;
                            this.changeItem(item,"手机号码格式不正确");
                        }
                }
            },
            getByteLen:function (val) {
                var len = 0;
                for (var i = 0; i < val.length; i++) {
                    var length = val.charCodeAt(i);
                    if(length>=0&&length<=128)
                    {
                        len += 1;
                    }
                    else
                    {
                        len += 2;
                    }
                }
                return len;
            },
            validatePW:function (val) {
                if(this.getByteLen(val)>=6&&this.getByteLen(val)<=16){
                    if(/[0-9]/.test(val)&&/[a-z]/.test(val)&&/[A-Z]/.test(val)){
                        return true;
                    }
                }
                return false;
            },
            changeItem:function (item,hint) {
                item.hint=hint;
                if(item.isFocus){
                    if(!item.valuePassed){
                        item.border="3px solid #00b3ee";
                        item.hintcolor="#c1c1c1";
                    }
                }else {
                    if(item.valuePassed){
                        item.border="2px solid deepskyblue";
                        item.hintcolor="deepskyblue";
                    }else {
                        item.border="2px solid red";
                        item.hintcolor="red";
                    }
                }
            },
            /*校验邮件地址是否合法 */
            IsEmail:function (str) {
                   var reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[com|cn])/;
                   return reg.test(str);
            },
            IsPhone:function (str) {
                var reg=/^[1-9][0-9]{10}/;
                return reg.test(str);
            },
            submitForm:function () {
               for(var i=0;i<this.items.length;i++){
                   var item=this.items[i];
                   if(!item.valuePassed) {
                       item.isFocus=true;
                       break;
                   }
               }
            }
        },
        directives: {
            autofocus: {
                // 指令的定义
                componentUpdated: function (el,binding) {
                    if(binding.value){
                        el.focus();
                    }
                }
            }
        }
    });
</script>
</body>
</html>
