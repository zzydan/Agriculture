<%--
    使用百度地图能实现大部分需求，但还有一点需求不太满意，画完多边形之后，调整完多边形之后触发的事件没有封装，自己定义又极其麻烦。
    还有多边形调整之后的面积。这些都需要自己写方法也不太方便。



--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
    body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
    #allmap {width: 100%; height:500px; overflow: hidden;}
    dl,dt,dd,ul,li{
        margin:0;
        padding:0;
        list-style:none;
    }
    p{font-size:12px;}
    dt{
        font-size:14px;
        font-family:"微软雅黑";
        font-weight:bold;
        border-bottom:1px dotted #000;
        padding:5px 0 5px 5px;
        margin:5px 0;
    }
    dd{
        padding:5px 0 0 5px;
    }
    li{
        line-height:28px;
    }
</style>
<script src="${pageContext.request.contextPath}/static/js/GeoUtils.js"></script>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=xgkjhiLGAq97kwNyjnFiLx2Dy9XOzzE4"></script>
<!--加载鼠标绘制工具-->
<script type="text/javascript" src="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="//api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />

<title>鼠标绘制工具</title>
</head>
<body>
<div id="allmap" style="overflow:hidden;zoom:1;position:relative;">
    <div id="map" style="margin-left:10%;width:80%;height:100%;-webkit-transition: all 0.5s ease-in-out;transition: all 0.5s ease-in-out;"></div>
</div>
<div id="result">
    <button onclick="getPoint()" class="layui-btn" style="margin-left: 40%;margin-top: 100px">确定</button>
    <button onclick="clearAll()" class="layui-btn" style="margin-left: 5%;margin-top: 100px">清除</button>
</div>




<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map('map',{mapType: BMAP_HYBRID_MAP});
    var poi = new BMap.Point(119.17727607665722,31.864854683156516);
    map.centerAndZoom(poi, 19);
    map.enableScrollWheelZoom();//可以滚动地图

    var searchCtrl=null;//自定义控件变量
    var area=null;//多边形面积
    var overlays = [];//所有多边形经纬度的集合
    var overlay=null;//当前这一个多边形的经纬度
    var girth=null //选取的多边形的周长
    var overlaycomplete = function(e){
        overlays.push(e.overlay);
        if(overlays.length>1){
            //overlays.splice(overlays.length-1, 1);
            map.removeOverlay(overlays[overlays.length-2]);
        }
        var path = e.overlay.getPath();//Array<Point> 返回多边型的点数组

        for(var i=0;i<path.length;i++){
            console.log("lng:"+path[i].lng+"\n lat:"+path[i].lat);
        }
        e.overlay.enableEditing();//画完多边形后，实现可编辑
        //e.overlay.addEventListener('mousedown', getPoint);
    };

    var styleOptions = {
        strokeColor:"red",    //边线颜色。
        fillColor:"red",      //填充颜色。当参数为空时，圆形将没有填充效果。
        strokeWeight: 3,       //边线的宽度，以像素为单位。
        strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
        fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
        strokeStyle: 'solid' //边线的样式，solid或dashed。
    }
    //实例化鼠标绘制工具
    var drawingManager = new BMapLib.DrawingManager(map, {
            isOpen: true, //是否开启绘制模式
            enableDrawingTool: true, //是否显示工具栏
            drawingMode:BMAP_DRAWING_POLYGON,//绘制模式  多边形
            //enableCalculate:true,//开启距离面积计算
            drawingToolOptions: {
                anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
                offset: new BMap.Size(5, 5), //偏离值
                drawingModes:[
                    BMAP_DRAWING_POLYGON //只显示多边形工具栏
                ]

            },
            /*circleOptions: styleOptions, //圆的样式
            polylineOptions: styleOptions, //线的样式
            rectangleOptions: styleOptions, //矩形的样式,*/

            polygonOptions: styleOptions //多边形的样式
        })
    //添加鼠标绘制工具监听事件，用于获取绘制结果
    drawingManager.addEventListener('overlaycomplete', overlaycomplete);


    //点击下一步事件
    function nextStep(){

        //将获取到的courseid传入到session
        sessionStorage.setItem("overlay",overlay);
        sessionStorage.setItem("area",area);
        sessionStorage.setItem("girth",girth);
        //跳转到修改页面
        window.location.href="./huaDiKuai3.jsp";
    }
    //清除覆盖物
    function clearAll() {
        for(var i = 0; i < overlays.length; i++){
            map.removeOverlay(overlays[i]);
        }
        //调用自定义控件方法，实现地图上出现提示文字

        map.removeOverlay(searchCtrl);//移除控件
        overlays.length = 0
        drawingManager.open()//清除多边形后，鼠标仍在绘制多边形状态

    }
    //清除自定义控件
    function clearControl() {
        map.removeOverlay(searchCtrl);//移除控件

    }
    //获取选中经纬度
    function getPoint(){
        area = getArea(overlays[ overlays.length-1]);
        area = area.toFixed(2);
        if(area==0){

            alert("请选取地块！！！")
            clearAll();
            return false;
        }
        //调用自定义控件方法，实现地图上出现提示文字
        searchCtrl=new SearchControl(2,500,30);
        map.addControl(searchCtrl);
        for(var i = 0; i < overlays.length; i++){
            overlays[i].disableEditing();//点击确定完，关闭多边形可编辑
        }


    }

    /**
     * 自定义的control
     * 需要依赖的 文件有http://fontawesome.io/assets/font-awesome/css/font-awesome.css
     */
    //生成自定义控件的方法
    function SearchControl(posIndex,left,top){
        var position=[BMAP_ANCHOR_TOP_LEFT,BMAP_ANCHOR_TOP_RIGHT,BMAP_ANCHOR_BOTTOM_LEFT,BMAP_ANCHOR_BOTTOM_RIGHT];
        this.defaultAnchor=position[posIndex];
        this.defaultOffset=new BMap.Size(left,top);
    }
    SearchControl.prototype=new BMap.Control();
    SearchControl.prototype.initialize=function(map){
        var div=document.createElement("div");
        $(div).css({
            height:"40px",
            width:"400px",
            overflow:"auto",
            border:"1px solid #aaa",
            backgroundColor:"#fff",

        });
        $(div).html("<div  style=\"margin-top: 7px;display: inline-block\">&nbsp;选定分区面积为："+area+"亩,周长" +girth+"米"+
            "<button onclick='nextStep()' class=\"layui-btn layui-btn-xs\" style=\"margin-left: 30px\">下一步</button>" +
            "<button onclick='clearControl()' class=\"layui-btn layui-btn-xs\" >取&nbsp;消</button>" +
            "</div>")
        map.getContainer().appendChild(div);
        return div;

str="<div class=\"mui-input-group\" style=\"width: 90%;margin-left: 5%;margin-bottom: 5px;\" id=\"di\">\n" +
    "\t\t\t\t\t\t<div class=\"mui-input-row\" style=\"position: relative;margin-bottom: 5px;\">\n" +
    "\t\t\t\t\t\t\t<img id=\"img\" style=\"position: absolute;height: 20px;width: 20px;right: -2px;top: -2px;\" src=\"../../images/no.png\">\n" +
    "\t\t\t\t\t\n" +
    "\t\t\t\t\t\t\t<label>农资名称</label>\n" +
    "\t\t\t\t\t\t\t<a class=\"mui-navigate-right\">\n" +
    "\t\t\t\t\t\t\t\t<span class=\"mui-badge1\">\n" +
    "\t\t\t\t\t\t\t\t\t<select class=\"mui-h5\" id=\"d1\" style=\"margin:right; color:#000;\">\n" +
    "\t\t\t\t\t\n" +
    "\t\t\t\t\t\t\t\t\t</select>\n" +
    "\t\t\t\t\t\t\t\t</span>\n" +
    "\t\t\t\t\t\t\t</a>\n" +
    "\t\t\t\t\t\t</div>\n" +
    "\t\t\t\t\t\t<div class=\"mui-input-row\" style=\"position: relative;\">\n" +
    "\t\t\t\t\t\t\t<label>农资使用量</label>\n" +
    "\t\t\t\t\t\t\t<input type=\"text\" name=\"\" style=\" position: absolute;top: 5px;right: 50px; height: 30px;  margin-right: 60px;  border: 1px solid;width: 60px; border-color:silver\"\n" +
    "\t\t\t\t\t\t\t class=\"in1\" id=\"\" value=\"\" />\n" +
    "\t\t\t\t\t\t\t<a class=\"mui-navigate-right\">\n" +
    "\t\t\t\t\t\t\t\t<span class=\"mui-badge1\">\n" +
    "\t\t\t\t\t\t\t\t\t<select class=\"mui-h5\" id=\"d22\" style=\"margin:right; color:#000;\">\n" +
    "\t\t\t\t\t\t\t\t\t\t<option value=\"\">kg/亩</option>\n" +
    "\t\t\t\t\t\t\t\t\t\t<option value=\"\">g/亩</option>\n" +
    "\t\t\t\t\t\t\t\t\t\t<option value=\"\">L/亩</option>\n" +
    "\t\t\t\t\t\t\t\t\t\t<option value=\"\">ML/亩</option>\n" +
    "\t\t\t\t\t\t\t\t\t</select>\n" +
    "\t\t\t\t\t\t\t\t</span>\n" +
    "\t\t\t\t\t\t\t</a>\n" +
    "\t\t\t\t\t\n" +
    "\t\t\t\t\t\t</div>\n" +
    "\t\t\t\t\t</div>"

    }




    //参数是一个百度类型的多边形覆盖物
    function getArea(polygon){
        // 检查类型：既不是百度类型的范围又不是数组类型的数据，直接返回0
        if (!(polygon instanceof BMap.Polygon) && !(polygon instanceof Array)) {
            return 0;
        }

        //如果是百度类型的，得到点集合，不是的话，另说。
        var pts = new Array();
        if (polygon instanceof BMap.Polygon) {
            pts = polygon.getPath();
            overlay=pts;
            girth=BMapLib.GeoUtils.getPolylineDistance(overlay) //计算周长
            girth=girth.toFixed(2);
        }

        //判断数组的长度，如果是小于3的话，不构成面，无法计算面积
        if (pts.length < 3) {

            return 0;
        }

        var totalArea = 0;// 初始化总面积
        var LowX = 0.0;
        var LowY = 0.0;
        var MiddleX = 0.0;
        var MiddleY = 0.0;
        var HighX = 0.0;
        var HighY = 0.0;
        var AM = 0.0;
        var BM = 0.0;
        var CM = 0.0;
        var AL = 0.0;
        var BL = 0.0;
        var CL = 0.0;
        var AH = 0.0;
        var BH = 0.0;
        var CH = 0.0;
        var CoefficientL = 0.0;
        var CoefficientH = 0.0;
        var ALtangent = 0.0;
        var BLtangent = 0.0;
        var CLtangent = 0.0;
        var AHtangent = 0.0;
        var BHtangent = 0.0;
        var CHtangent = 0.0;
        var ANormalLine = 0.0;
        var BNormalLine = 0.0;
        var CNormalLine = 0.0;
        var OrientationValue = 0.0;
        var AngleCos = 0.0;
        var Sum1 = 0.0;
        var Sum2 = 0.0;
        var Count2 = 0;
        var Count1 = 0;
        var Sum = 0.0;
        var Radius = 6378137.0;// ,WGS84椭球半径
        var Count = pts.length;
        for ( var i = 0; i < Count; i++) {
            if (i == 0) {
                LowX = pts[Count - 1].lng * Math.PI / 180;
                LowY = pts[Count - 1].lat * Math.PI / 180;
                MiddleX = pts[0].lng * Math.PI / 180;
                MiddleY = pts[0].lat * Math.PI / 180;
                HighX = pts[1].lng * Math.PI / 180;
                HighY = pts[1].lat * Math.PI / 180;
            } else if (i == Count - 1) {
                LowX = pts[Count - 2].lng * Math.PI / 180;
                LowY = pts[Count - 2].lat * Math.PI / 180;
                MiddleX = pts[Count - 1].lng * Math.PI / 180;
                MiddleY = pts[Count - 1].lat * Math.PI / 180;
                HighX = pts[0].lng * Math.PI / 180;
                HighY = pts[0].lat * Math.PI / 180;
            } else {
                LowX = pts[i - 1].lng * Math.PI / 180;
                LowY = pts[i - 1].lat * Math.PI / 180;
                MiddleX = pts[i].lng * Math.PI / 180;
                MiddleY = pts[i].lat * Math.PI / 180;
                HighX = pts[i + 1].lng * Math.PI / 180;
                HighY = pts[i + 1].lat * Math.PI / 180;
            }
            AM = Math.cos(MiddleY) * Math.cos(MiddleX);
            BM = Math.cos(MiddleY) * Math.sin(MiddleX);
            CM = Math.sin(MiddleY);
            AL = Math.cos(LowY) * Math.cos(LowX);
            BL = Math.cos(LowY) * Math.sin(LowX);
            CL = Math.sin(LowY);
            AH = Math.cos(HighY) * Math.cos(HighX);
            BH = Math.cos(HighY) * Math.sin(HighX);
            CH = Math.sin(HighY);
            CoefficientL = (AM * AM + BM * BM + CM * CM)/ (AM * AL + BM * BL + CM * CL);
            CoefficientH = (AM * AM + BM * BM + CM * CM)/ (AM * AH + BM * BH + CM * CH);
            ALtangent = CoefficientL * AL - AM;
            BLtangent = CoefficientL * BL - BM;
            CLtangent = CoefficientL * CL - CM;
            AHtangent = CoefficientH * AH - AM;
            BHtangent = CoefficientH * BH - BM;
            CHtangent = CoefficientH * CH - CM;
            AngleCos = (AHtangent * ALtangent + BHtangent * BLtangent + CHtangent* CLtangent)/ (Math.sqrt(AHtangent * AHtangent + BHtangent* BHtangent + CHtangent * CHtangent) * Math.sqrt(ALtangent * ALtangent + BLtangent* BLtangent + CLtangent * CLtangent));
            AngleCos = Math.acos(AngleCos);
            ANormalLine = BHtangent * CLtangent - CHtangent * BLtangent;
            BNormalLine = 0 - (AHtangent * CLtangent - CHtangent* ALtangent);
            CNormalLine = AHtangent * BLtangent - BHtangent * ALtangent;
            if (AM != 0)
                OrientationValue = ANormalLine / AM;
            else if (BM != 0)
                OrientationValue = BNormalLine / BM;
            else
                OrientationValue = CNormalLine / CM;
            if (OrientationValue > 0) {
                Sum1 += AngleCos;
                Count1++;
            } else {
                Sum2 += AngleCos;
                Count2++;
            }
        }

        var tempSum1, tempSum2;
        tempSum1 = Sum1 + (2 * Math.PI * Count2 - Sum2);
        tempSum2 = (2 * Math.PI * Count1 - Sum1) + Sum2;
        if (Sum1 > Sum2) {
            if ((tempSum1 - (Count - 2) * Math.PI) < 1)
                Sum = tempSum1;
            else
                Sum = tempSum2;
        } else {
            if ((tempSum2 - (Count - 2) * Math.PI) < 1)
                Sum = tempSum2;
            else
                Sum = tempSum1;
        }
        totalArea = (Sum - (Count - 2) * Math.PI) * Radius * Radius;

        //平方米转换为亩 平方米换为亩的计算口诀为“加半左移三”
        totalArea=(totalArea+totalArea/2)*0.001

        return totalArea; // 返回总面积
    }
</script>
</body>