<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/sysCenter/roleManagement.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="addUserInfo()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </div>
            <style>
                #role_table tr th {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
                #role_table tr td {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
            </style>
            <table id="role_table"></table>
        </div>
    </div>
</div>


<!-- 模态框（Modal） -->
<div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增角色</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion">
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
                <div class="panel-body">
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="addRole()">提交</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
