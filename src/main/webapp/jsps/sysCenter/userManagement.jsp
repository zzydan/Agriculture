<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/sysCenter/userManagement.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">查询条件</div>
                <div class="panel-body">
                    <form id="user_likeForm" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1">电话</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="tel">
                            </div>
                            <label class="control-label col-sm-1">用户名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="username">
                            </div>
                            <div class="col-sm-4" style="text-align:left;">
                                <button type="button" style="margin-left:50px" onclick="user_likeForm_querybtn()"
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
                #user_table tr th {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }

                #user_table tr td {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
            </style>
            <table id="user_table"></table>
        </div>
    </div>
</div>


    <!-- 添加的模态框（Modal） -->
    <div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel" style=" margin-left: -700px;">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 1100px;margin-right: 300px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">新增人员</h4>
                </div>

                <div class="modal-body">

                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="username" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>用户名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="username" name="username"
                                           placeholder="请输入用户登录账号">
                                </div>
                                <label for="Enterprise_select" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>企业</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Enterprise_select" name="Enterprise_select">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>角色</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="role_select_1" name="roleId">

                                    </select>
                                </div>
                                <label for="tel" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>电话</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="tel" name="tel"
                                           placeholder="请输入手机号">
                                </div>
                            </div>
                            <div class="form-group">

                                <label for="password" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>密码</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="password" name="password"
                                           placeholder="请输入密码" value="Zhny123456" onfocus="javascript:if(this.value=='Zhny123456')this.value='';" onblur="javascript:if(this.value=='')this.value='Zhny123456';">
                                </div>
                                <div class="col-sm-5" style="margin-top:9px">
                                    <span style="color: #c0c0c2">如未设置密码，默认密码为Zhny123456</span>
                                </div>
                            </div>
                        </form>
                    </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <a class="layui-btn layui-btn-fluid" onclick="addUserRole()">提交</a>
                        </div>
                    </div>
                </div><!-- /.modal-content -->
            </div>
        </div><!-- /.modal -->

        <!-- 编辑模态框（Modal） -->
        <div class="modal" id="upUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel" style=" margin-left: -700px;">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 1100px;margin-right: 300px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="upmyModalLabel">编辑人员</h4>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" value="" id="id_up" name="id" >
                        <div class="panel-body">
                            <form action="##" class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label for="username_up" class="col-md-1 control-label"><span
                                            style="color: #ff0007">*</span>用户名</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="username_up" name="username_up"
                                               placeholder="请输入用户登录账号">
                                    </div>
                                    <label for="password_up" class="col-md-1 control-label"><span
                                            style="color: #ff0007">*</span>密码</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="password_up" name="password_up"
                                               placeholder="请输入密码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="role_select_1_up" class="col-md-1 control-label"><span
                                            style="color: #ff0007">*</span>角色</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="role_select_1_up" name="roleId_up">

                                        </select>
                                    </div>
                                    <label for="tel_up" class="col-md-1 control-label"><span
                                            style="color: #ff0007">*</span>电话</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="tel_up" name="tel_up"
                                               placeholder="请输入手机号">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="Enterprise_select_1" class="col-md-1 control-label"><span
                                            style="color: #ff0007">*</span>企业</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="Enterprise_select_1" name="Enterprise_select_1">

                                        </select>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <a class="layui-btn layui-btn-fluid" onclick="upUserRoleId()">保存</a>
                        </div>
                    </div>
                </div><!-- /.modal-content -->
            </div>
        </div><!-- /.modal -->
    </div>
