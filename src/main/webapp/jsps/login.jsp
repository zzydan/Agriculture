<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<!-- Head -->
<head>
    <title>Border sign in Form Flat Responsive Widget Template :: w3layouts</title>
    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <meta name="keywords"
          content="Border sign in Form a Responsive Web Template, Bootstrap Web Templates, Flat Web Templates, Android Compatible Web Template, Smartphone Compatible Web Template, Free Webdesigns for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/js/login/css/style.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/js/login/css/font-awesome.css" type="text/css" media="all">
    <link href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=devanagari,latin-ext"
          rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiadmin/style/admin.css" media="all">
    <script src="${pageContext.request.contextPath}/static/layuiadmin/layui/layui.js"></script>

</head>

<body>
<h1 class="title-agile text-center">智慧农业后台管理系统</h1>
<div class="content-w3ls">
    <div class="content-bottom">
        <h2>登录</h2>
        <form id="login_form">
            <div class="field-group">
                <div class="wthree-field">
                    <input name="userName" id="userName" type="text" value="" placeholder="请输入账户">
                </div>
                <span class="fa fa-user" aria-hidden="true"></span>
            </div>
            <div class="field-group">
                <div class="wthree-field">
                    <input id="password" name="password" type="Password" placeholder="请输入密码">
                </div>
                <span class="fa fa-lock" aria-hidden="true"></span>
            </div>
            <div class="field-group">
                <div class="check">
                    <label class="checkbox w3l">
                        <input type="checkbox" onclick="myFunction()">
                        <i> </i>下次自动登录</label>
                </div>
                <script>
                    function myFunction() {

                    }
                </script>
            </div>
            <div class="wthree-field">
                <input id="login_btn" name="login" value="登录" type="button"/>
            </div>
            <ul class="list-login">
                <li class="switch-agileits">

                </li>
                <li>
                    <a href="#" class="text-right">忘记密码?</a>
                </li>
                <li class="clearfix"></li>
            </ul>
        </form>
    </div>
</div>


<script>
    $(function () {
        var layer ;
        layui.use('layer', function(){
            layer = layui.layer;
        });

        $('#login_btn').on('click', function () {
            var num = 0;
            var str = "";
            $("input[type$='text'],input[type$='password']").each(function (n) {
                if ($(this).val() == "") {
                    layer.alert(str += "" + $(this).attr("placeholder") + "不能为空！\r\n", {
                        title: '提示框',
                        icon: 0,
                    });
                    num++;
                    return false;
                }
            });
            if (num > 0) {
                return false;
            } else {
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/user/login",
                    data: {"userName":$("#userName").val(),"password":$("#password").val()},
                    dataType: "json",
                    error: function (error) {
                        layer.alert('登陆失败！', {
                            title: '提示框',
                            icon: 0,
                        });
                    }, success: function (data) {
                        if (data.flag) {
                            layer.alert('登陆成功！', {
                                title: '提示框',
                                icon: 1,
                            });
                            location.href = "index.jsp";
                        } else {
                            layer.alert(data.message, {
                                title: '提示框',
                                icon: 0,
                            });
                        }
                    }
                });
            }

        });
    })
</script>
</body>
</html>

