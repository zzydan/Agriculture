<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>
<body>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=xgkjhiLGAq97kwNyjnFiLx2Dy9XOzzE4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
<div class="layui-fluid">
    <div class="layui-card">
        <i class="layui-icon layui-icon-note"><span style="font-size: 20px">新增分场</span></i>
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <style>
                #order_addForm .layui-input-block{
                    width: 182px;
                }
            </style>
            <form id="order_addForm" class="layui-form" style="margin-left:30%">

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">分场名称</label>
                        <div class="layui-input-block">
                            <input type="text" name="name" placeholder="请输入" id="name"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">分场地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="address" placeholder="请输入" id="address"
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
                <button onclick="submitForm()" class="layui-btn" style="margin-left: 200px;margin-top: 80px">保存</button>
                <button onclick="javascript:history.back(-1);" class="layui-btn" style="margin-left: 120px;margin-top: 80px">取消</button>
            </form>
        </div>
    </div>

</div>
<%--
    新增分场 进入到页面首先利用浏览器定位来确定地图的中心位置，
    再在输入分场地址的时候添加change事件来改变地图中心位置坐标，
    最后在手动微调拖拽标志具体位置来获取坐标存到数据库。
--%>
<script type="text/javascript">
    layui.use('form', function(){//form表单预加载样式
        var form = layui.form;
        form.render();

        //预加载场长下拉框
        getLeaderList();

        //预加载技术员下拉框
        getJiShuList();
    });
    $(function () {

        // 百度地图API功能
        var map = new BMap.Map("allmap",{mapType: BMAP_HYBRID_MAP});
        map.enableScrollWheelZoom();//启用滚轮放大缩小
        var point = new BMap.Point(116.331398,39.897445);
        $("#longitude").val(116.331398);
        $("#latitude").val(39.897445);
        map.centerAndZoom(point,18);

        //浏览器定位
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function(r){
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
                var mk = new BMap.Marker(r.point);
                map.addOverlay(mk);
                map.panTo(r.point);
                $("#longitude").val(r.point.lng);
                $("#latitude").val(r.point.lat);
            }
            else {
                console.log('failed'+this.getStatus());
            }
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
    })



    //添加地块
    function submitForm() {
        $.ajax({
            url:"${pageContext.request.contextPath}/basicCenter/addPlace",
            data:$("#order_addForm").serialize(),
            dataType:"json",
            type:"post",
            success:function(data){
                window.history.go(-1);
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
                $("#fieldlengthUser").append(html)
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
                $("#technicianUser").append(html)
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
</body>