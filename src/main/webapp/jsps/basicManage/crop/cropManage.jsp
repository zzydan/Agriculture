<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/basicManage/corp/cropManage.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=zWlNt9jWwftjOInernxGsIcuGGkmTRWG"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="col-md-12 column">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="cropManage.jsp">作物种类</a>
                    </li>
                    <li>
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
                .item {
                    width: 34px;
                    height: 34px;
                    float: left;
                    position: relative;
                    margin: 0px;
                }
                .addImg {
                    width: 34px;
                    height: 34px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    z-index: 2;
                    cursor: pointer;
                }

                .preview, .preBlock {
                    position: absolute;
                    display: block;
                    width: 34px;
                    height: 34px;
                    left: 0;
                    top: 0;
                }

                .delete {
                    width: 15px;
                    position: absolute;
                    right: -10px;
                    top: -10px;
                    cursor: pointer;
                    display: none;
                }

                .preBlock img {
                    display: block;
                    width: 34px;
                    height: 34px;
                }
                .upload_input {
                    display: block;
                    width: 0;
                    height: 0;
                    -webkit-opacity: 0.0;
                    /* Netscape and Older than Firefox 0.9 */
                    -moz-opacity: 0.0;
                    /* Safari 1.x (pre WebKit!) 老式khtml内核的Safari浏览器*/
                    -khtml-opacity: 0.0;
                    /* IE9 + etc...modern browsers */
                    opacity: .0;
                    /* IE 4-9 */
                    filter: alpha(opacity=0);
                    /*This works in IE 8 & 9 too*/
                    -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
                    /*IE4-IE9*/
                    filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=0);
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
                <h4 class="modal-title" id="myModalLabel">新增作物种类</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion">
                    <div class="panel-body">
                        <input type="hidden" value="${USER_SESSION.id}" id="id_add" name="id" >
                        <form action="##" class="form-horizontal" role="form" id="roleForm">

                            <div class="form-group">
                                <label for="name" class="col-md-2 control-label">作物种类名称</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="name" name="name"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser1Pic_add" class="preview" alt="" name="pic" width="34"
                                             height="34">
                                    </div>

                                    <img class="delete" onclick="deleteImg(this)"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/delete.png">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="panel-body">
                    <div>
                    </div>
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="addcrop()">提交</a>
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
                                <label for="name_up" class="col-md-2 control-label">作物种类名称</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="name_up" name="name_up"
                                           placeholder="请输入">
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