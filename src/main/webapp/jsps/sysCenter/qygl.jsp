<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/sysCenter/qygl.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
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


    <!-- 模态框（Modal） -->
    <div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 1100px;margin-right: 300px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">新增人员权限</h4>
                </div>

                <div class="modal-body">

                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="roleName" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>用户名</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="username" name="username"
                                           placeholder="请输入用户登录账号">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="roleCode" class="col-md-1 control-label"><span
                                        style="color: #ff0007">*</span>密码</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="password" name="password"
                                           placeholder="请输入密码">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" class="layui-btn"
                                       href="#collapseOne">
                                        选择角色
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <div class="form-group">
                                        <div class="col-sm-offset-0 col-sm-10">
                                            <div class="radio" id="roleRadio">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" class="layui-btn"
                                       href="#collapseTwo">
                                        创建角色并分配权限
                                    </a>
                                </h4>
                            </div>
                            <input type="hidden" value="1" id="collapseID">
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <form action="##" class="form-horizontal" role="form" id="roleForm">
                                        <div class="form-group">
                                            <label for="roleName" class="col-md-1 control-label"><span
                                                    style="color: #ff0007">*</span>角色名</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" id="rolename" name="rolename"
                                                       placeholder="请输入新角色名">
                                            </div>
                                            <div class="col-sm-2">
                                                <span></span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="roleCode" class="col-md-1 control-label"><span
                                                    style="color: #ff0007">*</span>角色码</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" id="rolecode" name="rolecode"
                                                       placeholder="请输入新角色码">
                                            </div>
                                            <div class="col-sm-2">
                                                <span></span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-1"></div>
                                            <div id="resParentCheckbox" class="col-sm-7">

                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
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
    </div>
