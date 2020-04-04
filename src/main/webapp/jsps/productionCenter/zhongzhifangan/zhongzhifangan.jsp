<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/productionCenter/zhongzhifangan/zhongzhifangan.js"></script>
<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-body">
                    <form id="template_likeForm" class="form-horizontal">
                        <div class="form-group" style="margin-top:15px">
                            <label class="control-label col-sm-1">分场</label>
                            <div class="col-sm-2">
                                <select class="form-control" name="parvialfield" id="parvialfield" onchange="changeSpeciesrByFenChang()">

                                </select>
                            </div>
                            <label class="control-label col-sm-1">种植作物</label>
                            <div class="col-sm-2">
                                <select class="form-control" name="crop_species" id="crop_species">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-card">
        <div class="panel-body">
            <div class="panel panel-default">
                <div class="panel-body">

                </div>
            </div>
        </div>
    </div>
</div>
