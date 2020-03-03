<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/basicManage/AgriclturalManage/AgriclturalManage.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-heading">查询条件</div>
                <div class="panel-body">
                    <form id="user_likeForm" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1">农资名称</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" name="name">
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
    <div class="modal" id="addUserInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
         style=" margin-left: -560px;">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 1100px;margin-right: 300px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">新增农资</h4>
                </div>

                <div class="modal-body">

                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="Agric_select" class="col-md-1 control-label">农资分类</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="Agric_select" name="Agric_select">
                                        <option value="0">请选择</option>
                                        <option value="肥料">肥料</option>
                                        <option value="杀虫">杀虫</option>
                                    </select>
                                </div>
                                <label for="name" class="col-md-1 control-label">农资名称</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="name" name="name"
                                           placeholder="请输入">
                                </div>

                            </div>
                            <div class="form-group">
                                <label for="unitMeasurement" class="col-md-1 control-label">计量单位</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="unitMeasurement" name="unitMeasurement"
                                           placeholder="请输入">
                                </div>
                            </div>

                        </form>
                    </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <a class="layui-btn layui-btn-fluid" onclick="AddAgric()">提交</a>
                        </div>
                    </div>
                </div><!-- /.modal-content -->
            </div>
        </div><!-- /.modal -->

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
                        <input type="hidden" value="" id="id_up" name="id" >
                        <div class="panel-body">
                            <form action="##" class="form-horizontal" role="form">
                                <div class="form-group">
                                    <label for="Agric_select_up" class="col-md-1 control-label">农资分类</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="Agric_select_up" name="Agric_select_up">
                                            <option value="0">请选择</option>
                                            <option value="肥料">肥料</option>
                                            <option value="杀虫">杀虫</option>
                                        </select>
                                    </div>
                                    <label for="name_up" class="col-md-1 control-label">农资名称</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="name_up" name="name_up"
                                               placeholder="请输入">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="unitMeasurement_up" class="col-md-1 control-label">计量单位</label>
                                    <div class="col-sm-4">
                                        <input type="text" class="form-control" id="unitMeasurement_up" name="unitMeasurement_up"
                                               placeholder="请输入">
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
