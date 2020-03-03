<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=xgkjhiLGAq97kwNyjnFiLx2Dy9XOzzE4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
<script src="${pageContext.request.contextPath}/static/js/basicManage/fenChangManage/fenChangList.js"></script>

<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="addFenChang()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </div>
            <style>
                #fenChang_table tr th {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }

                #fenChang_table tr td {
                    padding: 1px;
                    height: 37px;
                    font-size: 14px;
                    text-align: center;
                    vertical-align: middle;
                }
            </style>
            <table id="fenChang_table"></table>
        </div>
    </div>
</div>

<!-- 添加模态框（Modal） -->
<div class="modal" id="addFenChang_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">新增分场</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion">
                    <div class="panel-body">
                        <form id="fenChang_addForm" class="layui-form" style="margin-left:20%">

                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场名称</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="name" placeholder="请输入"
                                               lay-verify="required" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="address" placeholder="请输入" id="address1"
                                               autocomplete="off" lay-verify="required" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场厂长</label>
                                    <div class="layui-input-block">
                                        <select  name="fieldlengthUser" lay-verify="required" lay-filter="fieldlengthUser" >
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">技术员</label>
                                    <div class="layui-input-block">
                                        <select name="technicianUser" lay-verify="required" lay-filter="technicianUser" >

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item" style="margin-top: 60px">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场位置</label>

                                    <div id="addmap" style="width: 500px;height: 300px">

                                    </div>
                                </div>
                            </div>
                            <input hidden id="longitude1" name="longitude">
                            <input hidden id="latitude1" name="latitude">

                        </form>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <button onclick="submitAddForm()" class="layui-btn" style="margin-left: 400px">保存</button>
                        <button data-dismiss="modal" aria-hidden="true" class="layui-btn" style="margin-left: 120px">取消</button>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>



<script type="text/javascript">


        //id选择器选中modal框
    $('#addFenChang_Modal').on('show.bs.modal', function () {

        layui.use('form', function(){//form表单预加载样式
            var form = layui.form;
            form.render();

            //预加载场长下拉框
            getLeaderList();

            //预加载技术员下拉框
            getJiShuList();
        });

        // 执行一些动作...
        // 百度地图API功能
        var map = new BMap.Map("addmap");
        map.enableScrollWheelZoom();//启用滚轮放大缩小
        var point = new BMap.Point(116.331398,39.897445);
        $("#longitude1").val(116.331398);
        $("#latitude1").val(39.897445);
        map.centerAndZoom(point,18);

        //浏览器定位
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function(r){
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
                var mk = new BMap.Marker(r.point);
                map.addOverlay(mk);
                map.panTo(r.point);
                $("#longitude1").val(r.point.lng);
                $("#latitude1").val(r.point.lat);
            }
            else {
                console.log('failed'+this.getStatus());
            }
        });

        //地址改变，地图重新根据输入的位置重新加载地图
        $("#address1").change(function () {
            var address = $("#address1").val();
            // 创建地址解析器实例
            var myGeo = new BMap.Geocoder();
            // 将地址解析结果显示在地图上,并调整地图视野
            // "江苏省句容市后白镇徐巷村二圩路杜氏生态农场"
            //河南省周口市东新区搬口乡贾寨村翔耀生态农业园
            myGeo.getPoint(address, function(point){
                if (point) {
                    map.centerAndZoom(point, 18.5);
                    var marker = new BMap.Marker(point);
                    map.addOverlay(marker);
                    //map.addOverlay(new BMap.Marker(point));
                    marker.enableDragging(); //启用标注拖动
                    marker.addEventListener('dragend', function (e) {//拖动标注结束
                        var pointNew = e.point;
                        console.log(pointNew);
                        $("#longitude1").val(pointNew.lng);
                        $("#latitude1").val(pointNew.lat);
                    });
                }else{
                    alert("您选择地址没有解析到结果!");
                }
            }, "北京市");
        })
    })



    //添加地块
    function submitAddForm() {
        $.ajax({
            url:"${pageContext.request.contextPath}/basicCenter/addPlace",
            data:$("#fenChang_addForm").serialize(),
            dataType:"json",
            type:"post",
            success:function(data){
                $("#addFenChang_Modal").modal("hide");
                $("#fenChang_table").bootstrapTable("refresh");
            }
        })
    }
    //查询场长列表
    function getLeaderList() {
        $.ajax({
            url:"/basicCenter/getUserListByRole",
            data:{"roleId":4},
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.truename+"</option>"
                    })
                }
                $("select[name='fieldlengthUser']").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询技术员列表
    function getJiShuList() {
        $.ajax({
            url:"/basicCenter/getUserListByRole",
            data:{"roleId":5},
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.truename+"</option>"
                    })
                }
                /*name="technicianUser"*/
                $("select[name='technicianUser']").append(html)
                layui.form.render("select");
            }
        })

    }

    /*myGeo.getPoint("江苏省句容市后白镇徐巷村二圩路杜氏生态农场", function(Point){
        if (Point) {
            var pointx = Point.lng;
            //纬度
            var pointy = Point.lat;
        }else{
            alert("您选择地址没有解析到结果!");
        }
    }, "北京市");*/
</script>



<!-- 编辑模态框（Modal） -->
<div class="modal" id="updateFenChang_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1100px;margin-right: 300px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel_up">编辑分场</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion_up">
                    <input type="hidden" value="" id="id_up" name="id_up" >
                    <div class="panel-body">

                        <form id="order_addForm" class="layui-form" style="margin-left:20%">

                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场名称</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="name" id="name" placeholder="请输入" id="name"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场地址</label>
                                    <div class="layui-input-block">
                                        <input type="text" name="address" id="address" placeholder="请输入" id="address"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场厂长</label>
                                    <div class="layui-input-block">
                                        <select id="fieldlengthUser" name="fieldlengthUser" lay-filter="fieldlengthUser" >
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-inline">
                                    <label class="layui-form-label">技术员</label>
                                    <div class="layui-input-block">
                                        <select id="technicianUser" name="technicianUser" lay-filter="technicianUser" >

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item" style="margin-top: 60px">
                                <div class="layui-inline">
                                    <label class="layui-form-label">分场位置</label>

                                    <div id="allmap" style="width: 500px;height: 300px">

                                    </div>
                                </div>
                            </div>
                            <input hidden id="longitude" name="longitude">
                            <input hidden id="latitude" name="latitude">
                            <input hidden id="id" name="id">
                        </form>


                    </div>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <button onclick="submitForm()" class="layui-btn" style="margin-left: 400px">保存</button>
                        <button data-dismiss="modal" aria-hidden="true" class="layui-btn" style="margin-left: 120px">取消</button>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>

<script type="text/javascript">
    $('#updateFenChang_Modal').on('show.bs.modal', function () {
        layui.use('form', function(){//form表单预加载样式
            var form = layui.form;
            form.render();

            var id= $("#id").val();
            //回显分厂的详细信息用于修改
            $.ajax({
                url:"${pageContext.request.contextPath}/basicCenter/getFenChangById",
                data:{"id":id},
                dataType:"json",
                type:"post",
                success:function(data){
                    if(data){

                        $("#name").val(data.name)
                        $("#address").val(data.address)

                        $("#technicianUser").append("<option selected='selected' value='"+data.technicianUser+"'>"+data.technicianUserName+"</option>")
                        $("#fieldlengthUser").append("<option selected='selected' value='"+data.fieldlengthUser+"'>"+data.fieldlengthUserName+"</option>")

                        layui.form.render("select");
                        // 百度地图API功能
                        var map = new BMap.Map("allmap");
                        map.enableScrollWheelZoom();//启用滚轮放大缩小
                        var point = new BMap.Point(data.longitude,data.latitude);
                        $("#longitude").val(data.longitude);
                        $("#latitude").val(data.latitude);
                        map.centerAndZoom(point,18);
                        var marker = new BMap.Marker(point);
                        map.addOverlay(marker);
                        marker.setAnimation(BMAP_ANIMATION_BOUNCE);//跳动
                        marker.enableDragging(); //启用标注拖动
                        marker.addEventListener('dragend', function (e) {//拖动标注结束
                            var pointNew = e.point;
                            console.log(pointNew);
                            $("#longitude").val(pointNew.lng);
                            $("#latitude").val(pointNew.lat);
                        });
                        //地址改变，地图重新根据输入的位置重新加载地图
                        $("#address").change(function () {
                            var address = $("#address").val();
                            // 创建地址解析器实例
                            var myGeo = new BMap.Geocoder();
                            // 将地址解析结果显示在地图上,并调整地图视野
                            // "江苏省句容市后白镇徐巷村二圩路杜氏生态农场"
                            //河南省周口市东新区搬口乡贾寨村翔耀生态农业园
                            myGeo.getPoint(address, function(point){
                                if (point) {
                                    map.centerAndZoom(point, 18.5);
                                    var marker = new BMap.Marker(point);
                                    map.addOverlay(marker);
                                    //map.addOverlay(new BMap.Marker(point));
                                    marker.enableDragging(); //启用标注拖动
                                    marker.addEventListener('dragend', function (e) {//拖动标注结束
                                        var pointNew = e.point;
                                        console.log(pointNew);
                                        $("#longitude").val(pointNew.lng);
                                        $("#latitude").val(pointNew.lat);
                                    });
                                }else{
                                    alert("您选择地址没有解析到结果!");
                                }
                            }, "北京市");
                        })


                    }
                }
            })
        })

    });



    //编辑地块
    function submitForm() {
        $.ajax({
            url:"${pageContext.request.contextPath}/basicCenter/updatePlace",
            data:$("#order_addForm").serialize(),
            dataType:"json",
            type:"post",
            success:function(data){
                $("#updateFenChang_Modal").modal("hide");
                $("#fenChang_table").bootstrapTable("refresh");
            }
        })
    }
    /*myGeo.getPoint("江苏省句容市后白镇徐巷村二圩路杜氏生态农场", function(Point){
        if (Point) {
            var pointx = Point.lng;
            //纬度
            var pointy = Point.lat;
        }else{
            alert("您选择地址没有解析到结果!");
        }
    }, "北京市");*/
</script>
