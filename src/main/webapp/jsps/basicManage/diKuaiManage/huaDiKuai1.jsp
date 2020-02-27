<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>
<body>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=xgkjhiLGAq97kwNyjnFiLx2Dy9XOzzE4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
<div class="layui-fluid">
    <div style="width:1400px; height:800px;z-index:9;border:1px solid gray" id="container"></div>
</div>
<%--
    新增分场 进入到页面首先利用浏览器定位来确定地图的中心位置，
    再在输入分场地址的时候添加change事件来改变地图中心位置坐标，
    最后在手动微调拖拽标志具体位置来获取坐标存到数据库。
--%>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/GeoUtils.js"></script>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("container",{mapType: BMAP_HYBRID_MAP});
    map.enableScrollWheelZoom();//启用滚轮放大缩小
    map.addControl(new BMap.NavigationControl());  //添加鱼骨控件
    map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
    map.setCurrentCity("襄阳");          // 设置3D地图显示的城市 此项是必须设置的
    var point = new BMap.Point(119.17727607665722,31.864854683156516);
    map.centerAndZoom(point,19);



    //变量名,标签坐标,多边形坐标,文本,边框颜色
    function fun(i,xy,arr,wb,ys) {
        //创建经纬度数组
        eval("var secRingCenter" + i+" = new BMap.Point("+xy+")");
        eval("var secRing"+i+" = ["+arr+"]");
        //创建多边形
        eval("var secRingPolygon" + i + "= new BMap.Polygon(secRing" + i + ", { strokeColor: \"" + ys + "\", strokeWeight: 4})");
        //eval("var secRingPolygon" + i + "= new BMap.Polygon(secRing" + i + ", { FillColor:\"red\", strokeColor: \"blue\", strokeWeight: 2, strokeOpacity: 0.3 })");

        //添加多边形到地图上
        map.addOverlay(eval("secRingPolygon"+i));

        var resultArea = BMapLib.GeoUtils.getPolygonArea(eval("secRingPolygon" + i)); //计算多边形的面积（单位米）

        //给多边形添加鼠标事件
        eval("secRingPolygon"+i).addEventListener("mouseover", function () {//鼠标经过时
            eval("secRingPolygon" + i).setStrokeColor("red"); //多边形边框为红色
            //eval("secRingPolygon" + i).setFillColor(ys);
            map.addOverlay(eval("secRingLabel"+i)); //添加多边形遮照
            //map.panTo(eval("secRingCenter"+i)); //将地图移动到指定点
        });
        eval("secRingPolygon"+i).addEventListener("mouseout", function () {
            eval("secRingPolygon" + i).setStrokeColor(ys);
            //eval("secRingPolygon" + i).setFillColor("");
            map.removeOverlay(eval("secRingLabel"+i));
        });
        eval("secRingPolygon"+i).addEventListener("click", function () {
            map.zoomIn();
            eval("secRingPolygon" + i).setStrokeColor(ys);
            //eval("secRingPolygon" + i).setFillColor("");
            map.setCenter(eval("secRingCenter"+i));
        });
        //创建标签
        eval("var secRingLabel" + i + "= new BMap.Label(\"<b>" + wb + " 面积(㎡)：" + Math.floor(resultArea) + "</b>\", { offset: new BMap.Size(0, 0), position: secRingCenter" + i + "})");
        eval("secRingLabel"+i).setStyle({ "z-index": "999999", "padding": "2px",  "border": "1px solid #ccff00" });
    }
</script>
</body>