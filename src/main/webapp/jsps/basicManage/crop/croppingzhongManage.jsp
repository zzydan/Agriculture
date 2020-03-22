<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/basicManage/corp/croppingzhongManage.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="col-md-12 column">
                <ul class="nav nav-tabs">
                    <li >
                        <a href="cropManage.jsp">作物种类</a>
                    </li>
                    <li class="active">
                        <a href="croppingzhongManage.jsp">作物品种</a>
                    </li>
                    <li>
                        <a href="cropshengyuManage.jsp">作物生育时期</a>
                    </li>
                    <li>
                        <a href="cropnongshiManage.jsp">作物农事</a>
                    </li>
                </ul>
            </div>
            <div id="toolbar" class="btn-group" style="padding-top: 20px">
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
<div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style="margin-left: -560px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增品种</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion">
                    <div class="panel-body">
                        <input type="hidden" value="${USER_SESSION.id}" id="id_add" name="id" >
                        <form action="##" class="form-horizontal" role="form" id="roleForm">
                            <div class="form-group">
                                <label for="name" class="col-md-2 control-label">作物品种名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="name" name="name"
                                           placeholder="请输入">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Enterprise_select_1" class="col-md-2 control-label">作物种类</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Enterprise_select_1" name="Enterprise_select_1">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="zwswxld" class="col-md-2 control-label">作物生物学零度</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="zwswxld" name="zwswxld"
                                           placeholder="请输入">
                                </div>
                                <div class="col-sm-5" style="margin-left: -19px;font-size: 23px;">
                                    <span>℃</span>
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="panel-body">
                    <div>
                    </div>
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="addRole()">提交</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
<!-- 编辑模态框（Modal） -->
<div class="modal" id="UpUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style="margin-left: -560px;">
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
                                <label for="name_up" class="col-md-2 control-label">作物品种名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="name_up" name="name_up"
                                           placeholder="请输入">
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="Enterprise_select_1_up" class="col-md-2 control-label">作物种类</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Enterprise_select_1_up" name="Enterprise_select_1_up">

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="zwswxld_up" class="col-md-2 control-label">作物生物学零度</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="zwswxld_up" name="zwswxld_up"
                                           placeholder="请输入">
                                </div>
                                <div class="col-sm-5" style="margin-left: -19px;font-size: 23px;">
                                    <span>℃</span>
                                </div>
                                <div class="col-sm-2">
                                    <span></span>
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