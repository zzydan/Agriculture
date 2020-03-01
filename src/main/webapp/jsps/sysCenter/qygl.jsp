<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/sysCenter/qygl.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=zWlNt9jWwftjOInernxGsIcuGGkmTRWG"></script>

<style type="text/css">

    .article {
        padding-left: 160px;
        min-height: 230px;
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


<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="addEnterpriseInfo()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </div>
            <style>
                #enterprise_table tr th {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }

                #enterprise_table tr td {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
            </style>
            <table id="enterprise_table"></table>
        </div>
    </div>
</div>


<!-- 模态框（Modal） -->
<div class="modal" id="addEnterpriseInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style="margin-left: -560px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel1">新增企业</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group">
                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form" id="enterpriseForm_add">
                            <div class="form-group">
                                <label for="enterprisename_add" class="col-md-2 control-label">企业名称</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisename_add" name="name"
                                           placeholder="请输入">
                                </div>

                                <label for="enterpriseaddress_add" class="col-md-2 control-label">企业地址</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterpriseaddress_add" name="address"
                                           placeholder="请输入">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterpriseintro_add" class="col-md-2 control-label">备注</label>
                                <div class="col-md-8 column" >
                                    <textarea rows="4" cols="60"  id="enterpriseintro_add" name="intro"
                                              class="layui-textarea" placeholder="请输入内容"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterpriselot_add" class="col-md-2 control-label">企业位置</label>
                                <div class="col-md-8 column" >
                                    <div id="enterpriselot_add" style="width: 500px;height: 300px">

                                    </div>
                                </div>
                                <input hidden id="longitude_add" name="longitude">
                                <input hidden id="latitude_add" name="latitude">
                            </div>
                            <hr />
                            <div class="form-group">
                                <label for="enterprisefiliale_add" class="col-md-2 control-label">提供服务分公司</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisefiliale_add" name="filiale"
                                           placeholder="请输入">
                                </div>

                                <label for="enterprisefilialeCenter_add" class="col-md-2 control-label">提供服务服务中心</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisefilialeCenter_add" name="filialeCenter"
                                           placeholder="请输入">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="enterprisemapperUser1_add" class="col-md-2 control-label">Mapper负责人-1</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser1_add" name="mapperUser1"
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

                            <div class="form-group">
                                <label for="enterprisemapperUser2_add" class="col-md-2 control-label">Mapper负责人-2</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser2_add" name="mapperUser2"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser2Pic_add" class="preview" alt="" name="pic" width="34"
                                             height="34">
                                    </div>
                                    <img class="delete" onclick="deleteImg(this)"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/delete.png">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterprisemapperUser3_add" class="col-md-2 control-label">Mapper负责人-3</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser3_add" name="mapperUser3"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser3Pic_add" class="preview" alt="" name="pic" width="34"
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
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="addEnterprise()">提交</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>


<!-- 模态框（Modal） -->
<div class="modal" id="upEnterpriseInfo_Modal" tabindex="-1" aria-labelledby="myModalLabel"
     style="margin-left: -560px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel2">编辑企业</h4>
            </div>
            <div class="modal-body">
                <div class="panel-group">
                    <div class="panel-body">
                        <form action="##" class="form-horizontal" role="form" id="enterpriseForm_up">
                            <input type="hidden" class="form-control" id="enterpriseid_up" name="id">
                            <div class="form-group">
                                <label for="enterprisename_up" class="col-md-2 control-label">企业名称</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisename_up" name="name"
                                           placeholder="请输入">
                                </div>

                                <label for="enterpriseaddress_up" class="col-md-2 control-label">企业地址</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterpriseaddress_up" name="address"
                                           placeholder="请输入">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterpriseintro_up" class="col-md-2 control-label">备注</label>
                                <div class="col-md-8 column" >
                                    <textarea rows="4" cols="60"  id="enterpriseintro_up" name="intro"
                                              class="layui-textarea" placeholder="请输入内容"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterpriselot_up" class="col-md-2 control-label">企业位置</label>
                                <div class="col-md-8 column" >
                                    <div id="enterpriselot_up" style="width: 500px;height: 300px">

                                    </div>
                                    <input hidden id="longitude_up" name="longitude">
                                    <input hidden id="latitude_up" name="latitude">
                                </div>
                            </div>
                            <hr />
                            <div class="form-group">
                                <label for="enterprisefiliale_up" class="col-md-2 control-label">提供服务分公司</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisefiliale_up" name="filiale"
                                           placeholder="请输入">
                                </div>

                                <label for="enterprisefilialeCenter_up" class="col-md-2 control-label">提供服务服务中心</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="enterprisefilialeCenter_up" name="filialeCenter"
                                           placeholder="请输入">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterprisemapperUser1_up" class="col-md-2 control-label">Mapper负责人-1</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser1_up" name="mapperUser1"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input id="enterprisemapperUser1Pic_up1" name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser1Pic_up" class="preview" alt="" name="pic" width="34"
                                             height="34">
                                    </div>
                                    <img class="delete" onclick="deleteImg(this)"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/delete.png">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterprisemapperUser2_up" class="col-md-2 control-label">Mapper负责人-2</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser2_up" name="mapperUser2"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input id="enterprisemapperUser2Pic_up1" name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser2Pic_up" class="preview" alt="" name="pic" width="34"
                                             height="34">
                                    </div>
                                    <img class="delete" onclick="deleteImg(this)"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/delete.png">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="enterprisemapperUser3_up" class="col-md-2 control-label">Mapper负责人-3</label>
                                <div class="col-md-3 column" >
                                    <input type="text" class="form-control" id="enterprisemapperUser3_up" name="mapperUser3"
                                           placeholder="请输入">
                                </div>
                                <div class="item">
                                    <img class="icon addImg" onclick="clickImg(this);"
                                         src="${pageContext.request.contextPath}/static/jquerygwscmoban/images/addImg.png">
                                    <input id="enterprisemapperUser3Pic_up1" name="url" type="file" class="upload_input" onchange="change(this)">
                                    <div class="preBlock">
                                        <img id="enterprisemapperUser3Pic_up" class="preview" alt="" name="pic" width="34"
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
                    <div class="form-group">
                        <a class="layui-btn layui-btn-fluid" onclick="updateEnterprise()">提交</a>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>