<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/basicManage/zhongzhifangan/zzfa.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">查询条件</div>
                <div class="panel-body">
                    <form id="user_likeForm" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1">作物种类</label>
                            <div class="col-sm-2">
                                <select class="form-control" name="category">

                                </select>
                            </div>
                            <label class="control-label col-sm-1">作物品种</label>
                            <div class="col-sm-2">
                                <select class="form-control" name="variety">

                                </select>
                            </div>
                            <label class="control-label col-sm-1">种植方案名称</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control" name="name">
                            </div>
                            <div class="col-sm-2" style="text-align:left;">
                                <button type="button" style="margin-left:50px" onclick="template_likeForm_querybtn()"
                                        class="layui-btn">查询
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="addUserInfo()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </div>
            <style>
                #template_table tr th {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }

                #template_table tr td {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
            </style>
            <table id="template_table"></table>
        </div>
    </div>
</div>



<!-- 添加的模态框（Modal） -->
<div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style=" margin-left: -560px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增人员</h4>
            </div>

            <div class="modal-body">

                <div class="panel-body">

                </div>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <a class="layui-btn layui-btn-fluid" onclick="">保存</a>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div>
</div>
<!-- /.modal -->

<!-- 编辑模态框（Modal） -->
<div class="modal" id="upUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style=" margin-left: -560px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="upmyModalLabel">编辑人员</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" value="" id="id_up" name="id">
                <div class="panel-body">

                </div>
            </div>
            <div class="panel-body">
                <div class="form-group">
                    <a class="layui-btn layui-btn-fluid" onclick="">保存</a>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div>
</div>
<!-- /.modal -->
</div>
