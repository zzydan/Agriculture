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


<!-- 添加模态框（Modal） -->
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
                        <input type="hidden" value="${USER_SESSION.id}" id="id_add" name="id" >
                        <form action="##" class="form-horizontal" role="form" id="roleForm">
                            <div class="form-group">
                                <label for="Enterprise_select_1" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>企业</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Enterprise_select_1" name="Enterprise_select_1">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="roleName" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>角色名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="rolename" name="rolename"
                                           placeholder="请输入新角色名">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="select_roletype" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>客户端</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="select_roletype" name="select_roletype">
                                        <option value="1">pc</option>
                                        <option value="2">app</option>
                                        <option value="3">pc/app</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="roleBz" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>备注</label>
                                <div class="col-md-7 column" >
                                    <textarea rows="7" cols="60"  id="roleBz" name="roleBz"  class="layui-textarea" placeholder="请输入内容"></textarea>
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
<!-- 编辑模态框（Modal） -->
<div class="modal" id="UpUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel_up">编辑角色</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion_up">
                    <input type="hidden" value="" id="id_up" name="id_up" >
                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form" id="roleForm_up">
                            <div class="form-group">
                                <label for="Enterprise_select_1" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>企业</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Enterprise_select_1_up" name="Enterprise_select_1_up">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="roleName" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>角色名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="rolename_up" name="rolename_up"
                                           placeholder="请输入新角色名">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="select_roletype_up" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>客户端</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="select_roletype_up" name="select_roletype_up">
                                        <option value="1">pc</option>
                                        <option value="2">app</option>
                                        <option value="3">pc/app</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="roleBz_up" class="col-md-2 control-label"><span
                                        style="color: #ff0007">*</span>备注</label>
                                <div class="col-md-7 column" >
                                    <textarea rows="7" cols="60"  id="roleBz_up" name="roleBz_up"  class="layui-textarea" placeholder="请输入内容"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="upRole()">提交</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>