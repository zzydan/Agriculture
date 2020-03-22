<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="no-referrer">
    <title>layuiAdmin std - 通用后台管理模板系统（iframe标准版）</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layuiadmin/style/admin.css" media="all">

    <script src="${pageContext.request.contextPath}/static/layuiadmin/layui/layui.js"></script>

    <script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/table/bootstrap-table.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.css"/>

    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/table/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/table/locale/bootstrap-table-zh-CN.min.js"></script>

    <script src="${pageContext.request.contextPath}/static/echarts/echarts.min.js"></script>
</head>

<script>
    layui.config({
        base: '${pageContext.request.contextPath}/static/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'senior']);
    //加载表单控件
    layui.use('form', function(){
        var form = layui.form;
        form.render();
    });
    //时间控件
    var laydate;
    layui.use(['index', 'laydate'], function() {
        laydate = layui.laydate;
        laydate.render({
            elem: '#sbfh_dateFirst'
        });
        laydate.render({
            elem: '#sbfh_dateLast'
        });
        laydate.render({
            elem: '#order_endtime'
        });

        laydate.render({
            elem: '#order_laydate_start'
        });

        laydate.render({
            elem: '#order_laydate_end'
        });
        laydate.render({
            elem: '#plannedStartTime'
        });
        laydate.render({
            elem: '#plannedEndTime'
        });
    })

    //随机码
    function  tid() {
        var mydate = new Date()
        var uuid = mydate.getDay()+ mydate.getHours()+ mydate.getMinutes() + mydate.getSeconds() + mydate.getMilliseconds()+ Math.round(Math.random() * 10000);
        return uuid
    }
    function rid() {
        return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    }
    function uuid() {
        return (tid() +"_" + rid() +"_"+ rid() +"_"+ rid() )
    }

    $(function(){
        $('.modal').on('hidden.bs.modal', function () {
            document.getElementsByTagName('body')[0].className = 'modal-open';
            


        })
    })
</script>

