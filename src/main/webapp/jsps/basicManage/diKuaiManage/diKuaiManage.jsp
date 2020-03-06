<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=xgkjhiLGAq97kwNyjnFiLx2Dy9XOzzE4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.js"></script>
<link rel="stylesheet" href="http://api.map.baidu.com/library/DrawingManager/1.4/src/DrawingManager_min.css" />
<style>
    #diKuai_addForm .layui-input-block{
        width: 300px;
    }
    #diKuai_addForm {
        margin-left: 150px;
    }
    #diKuai_updateForm .layui-input-block{
        width: 300px;
    }
    #diKuai_updateForm {
        margin-left: 150px;
    }
</style>
<%--选项卡--%>
<div class="layui-tab layui-tab-card">
    <ul class="layui-tab-title">
        <li class="layui-this">地图</li>
        <li>列表</li>

    </ul>
    <div class="layui-tab-content" style="height: 100%;">
        <%--地图--%>
        <div class="layui-tab-item layui-show">
            <div class="layui-fluid">
                <div style="width:1400px; height:735px;z-index:9;border:1px solid gray" id="container"></div>
            </div>
        </div>


        <%--列表--%>
        <div class="layui-tab-item">
            <div class="layui-card">
                <div class="panel-body">
                    <div class="panel panel-default">
                        <div class="panel-heading">查询条件</div>
                        <div class="panel-body">
                            <form id="user_likeForm" class="form-horizontal">
                                <div class="form-group" style="margin-top:15px">
                                    <label class="control-label col-sm-1">选择分场</label>
                                    <div class="col-sm-2">
                                        <select class="form-control" name="fenChangId" id="fenChangId">

                                        </select>
                                    </div>
                                    <label class="control-label col-sm-1">地块名称</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" name="name" id="diKuaiName">
                                    </div>
                                    <div class="col-sm-2" style="text-align:left;">
                                        <button type="button" style="margin-left:50px" onclick="diKuai_table()"
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
                        #diKuai_table tr th {
                            padding: 1px;
                            height: 37px;
                            font-size: 14px;
                            text-align: center;
                            vertical-align: middle;
                        }

                        #diKuai_table tr td {
                            padding: 1px;
                            height: 37px;
                            font-size: 14px;
                            text-align: center;
                            vertical-align: middle;
                        }
                    </style>
                    <table id="diKuai_table"></table>
                </div>
            </div>

        </div>

    </div>
</div>





<%--
    新增分场 进入到页面首先利用浏览器定位来确定地图的中心位置，
    再在输入分场地址的时候添加change事件来改变地图中心位置坐标，
    最后在手动微调拖拽标志具体位置来获取坐标存到数据库。
--%>
<%--
      难点：只有在地图初始化之后才能在地图上加上自定义下拉框控件，而重新加载地图就要重新加载下拉框。
    下拉框选择分场的实现：在进入这个页面之后预加载到所有的分场信息，并存到全局变量fenChangList中，给默认选中的分场的id
    也存到全局变量中fenChangId 用于更新下拉框的值，在获得List的成功回调函数里第一次调用地图方法初始化地图，在下拉框的change
    事件中重新调用地图的方法并给下拉框赋值
--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/GeoUtils.js"></script>
<script type="text/javascript">
        var fenChangId=1;//存放下拉框选中的分场id默认id为1
        var fenChangList=null;//存放所有分场的数据
        var arr=new Array();//新建一个数组存放回显的经纬度数据[{lid:1,str:str},{...}]
        var map1=null;
        var lotId=null;//选中的地块id
        var lots;//选中的分场的所有地块信息
        var technicianUser
        var technicianUserName
    $(function () {

        //预加载查询分场信息
        $.ajax({
            url:"/basicCenter/getFenChangListVo",
            dataType:"json",
            type:"post",
            success:function(data){

                if(data){
                    fenChangList=data;
                    var html=" <option value='0'>请选择</option>"
                    getMap(fenChangList[0].longitude,fenChangList[0].latitude);
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                    $("#fenChangId").append(html);//分场列表条件查询
                    $("#ssfc").append(html);//添加地块，详情页面下拉框赋值
                    layui.form.render("select");
                }

            }
        })

        diKuai_table();
    })
        //显示分场列表的方法
        function diKuai_table() {
            var fenChangId= $("#fenChangId").val();
            if(fenChangId==null){
                fenChangId=0;
            }
            var diKuaiName= $("#diKuaiName").val();
            $("#diKuai_table").bootstrapTable("destroy");
            $("#diKuai_table").bootstrapTable({ // 对应table标签的id
                url: "/basicCenter/getLotListAll?fenChangId="+fenChangId+"&diKuaiName="+diKuaiName, // 获取表格数据的url
                pagination:true,
                toolbar: '#toolbar', //工具按钮用哪个容器
                striped: true,       //是否显示行间隔色
                clickToSelect: true, //设置复选框头
                showRefresh: true,   //是否显示刷新按钮
                pageNumber:1,

                pageSize: 7,
                pageList: [3, 5, 10, 15],
                columns: [//field对应的是entity中的属性 title:列名
                    {
                        field: 'id', // 返回json数据中的name
                        title: '序号', // 表格表头显示文字
                        align:"center",
                        formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                            return index + 1;
                        }
                    }, {
                        field: 'name',
                        align:"center",
                        valign: "middle",
                        title: '地块名称'
                    }, {
                        field: 'ssfc',
                        valign: "middle",
                        align:"center",
                        title: "分场名称"
                    }, {
                        field: 'dkmj',
                        valign: "middle",
                        align:"center",
                        title: "面积(亩)"
                    }, {
                        field: 'trzd',
                        valign: "middle",
                        align:"center",
                        title: "土壤质地"
                    }, {
                        field: 'zwpz',
                        valign: "middle",
                        align:"center",
                        title: '种植品种',
                    }, {
                        field: 'createtime',
                        valign: "middle",
                        align:"center",
                        title: '创建时间',
                    },{
                        title: "操作",
                        valign: "middle",
                        align:"center",
                        formatter: function (value, row, index) {
                            var str =
                                "<a onclick=\"showDiKuaiDetail(\'" + row.id + "\')\" class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                                "<i  class=\"layui-icon layui-icon-edit\">" +
                                "</i>查看</a> " +
                                "<a onclick=\"updateDiKuaiDetail(\'" + row.id + "\')\" class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                                "<i class=\"layui-icon layui-icon-delete\">" +
                                "</i>修改</a> ";
                            return str;
                        }
                    }
                ]
            })
        }
        //初始化地图
    function getMap(lng,lat){
        // 百度地图API功能
        map1 = new BMap.Map("container",{mapType: BMAP_HYBRID_MAP});
        map1.enableScrollWheelZoom();//启用滚轮放大缩小
        map1.addControl(new BMap.NavigationControl());  //添加鱼骨控件
        map1.addControl(new BMap.MapTypeControl());          //添加地图类型控件
        map1.setCurrentCity("襄阳");          // 设置3D地图显示的城市 此项是必须设置的
        var point = new BMap.Point(lng,lat);
        map1.centerAndZoom(point,19);
        //调用自定义控件方法，实现地图上出现提示文字
        var searchCtrl=new SearchControl(0,50,50);
        map1.addControl(searchCtrl);
        getLotByFenChangId();//根据分场查询所有的地块详情
        for (let i = 0; i <fenChangList.length ; i++) {
            if(fenChangId==fenChangList[i].id){
                technicianUserName=fenChangList[i].technicianUserName
                technicianUser=fenChangList[i].technicianUser

              var  lotVoList =fenChangList[i].lotVoList//当前分场的所有地块的集合

                for (let j = 0; j < lotVoList.length; j++) {
                    var lid=lotVoList[j].lid //地块的id

                    var  locationVoList =lotVoList[j].locationVoList//id为lotVoList[j].lid所有地块的经纬度集合

                    var str=""
                    for (let k= 0; k< locationVoList.length; k++) {
                        var obj={}
                        if(k==0){
                            str+="new BMap.Point("+locationVoList[k].lng+","+locationVoList[k].lat+"),"
                        }else if(k==locationVoList.length-1){
                            str+="new BMap.Point("+locationVoList[k].lng+","+locationVoList[k].lat+")"
                            obj.lid=lid;
                            obj.str=str;
                            arr.push(obj);
                            fun(lid,str,'green') //调用方法回显地块
                        }else {
                            str+="new BMap.Point("+locationVoList[k].lng+","+locationVoList[k].lat+"),"
                        }

                    }
                }


            }
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
        //拼接下拉框内容
        var html="<select id=\"fenChangSelect\" style=\"height:35px;width:77px\" name=\"technicianUser\" lay-filter=\"technicianUser\" >"

            $.each(fenChangList,function (a,b) {
                if(b.id==fenChangId){
                    html+=" <option selected value=\""+b.id+"\">"+b.name+"</option>"
                }else {
                    html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                }
            })
        html+= "</select>\n <button onclick=\"huaDiKuai()\" style=\"margin-left: 10px\" class=\"layui-btn\">画地块</button>"
        $(div).html(html)
        layui.form.render("select");
        map.getContainer().appendChild(div);
        return div;
    }
    $("#container").on("change","#fenChangSelect",function () {
        fenChangId=$("#fenChangSelect").val();
        //根据选择的分场重新加载地图
        getMap(fenChangList[fenChangId-1].longitude,fenChangList[fenChangId-1].latitude);
    })


    function huaDiKuai() {

        $("#huaDiKUai_Modal").modal("show")
    }

    //变量名,标签坐标,多边形坐标,文本,边框颜色
    function fun(lid,str,color) {
        //创建经纬度数组
        eval("var secRing"+lid+" = ["+str+"]");
        //创建多边形
        eval("var secRingPolygon" + lid + "= new BMap.Polygon(secRing" + lid + ", { strokeColor: '"+color+"', strokeWeight: 4})");

        //添加多边形到地图上
        map1.addOverlay(eval("secRingPolygon"+lid));


        //给多边形添加鼠标事件
        eval("secRingPolygon"+lid).addEventListener("click", function () {//单击
            getMap(fenChangList[fenChangId-1].longitude,fenChangList[fenChangId-1].latitude);
            map1.clearOverlays()//移除所有多边形
            //重新加载多边形当lid一样时为选中状态变色

            for (let i = 0; i <arr.length ; i++) {
                if(arr[i].lid==lid){
                    fun(arr[i].lid,arr[i].str,'blue')
                    lotId=lid
                    var searchCtrl=new SearchControl2(1,0,0);
                    map1.addControl(searchCtrl);

                }else {

                    fun(arr[i].lid,arr[i].str,'green')
                }
            }

        })

    }
        /**
         * 自定义的control2 点击地块弹出的地块详情
         * 需要依赖的 文件有http://fontawesome.io/assets/font-awesome/css/font-awesome.css
         */
        //生成自定义控件的方法
        //生成自定义控件的方法
        function SearchControl2(posIndex,left,top){
            var position=[BMAP_ANCHOR_TOP_LEFT,BMAP_ANCHOR_TOP_RIGHT,BMAP_ANCHOR_BOTTOM_LEFT,BMAP_ANCHOR_BOTTOM_RIGHT];
            this.defaultAnchor=position[posIndex];
            this.defaultOffset=new BMap.Size(left,top);
        }
        SearchControl2.prototype=new BMap.Control();
        SearchControl2.prototype.initialize=function(map){
            var div=document.createElement("div");
            $(div).css({
                height:"735px",
                width:"300px",
                overflow:"auto",
                border:"1px solid #aaa",
                backgroundColor:"#fff",
            });
            for (let i = 0; i <lots.length ; i++) {
                if(lots[i].id==lotId){
                    var lot=lots[i];
                    $(div).html("<div class=\"layui-card\">\n" +
                "        <div style=\"font-size: 22px\" class=\"layui-card-header\">"+lot.name+"<button onclick='closeDiv(this)'  style=\"margin-top: 10px;width:15px;height: 15px\" class=\"close\">X</button></div>\n" +
                "        <div class=\"layui-card-body\">\n" +
                "\t\t\t<h4>地块信息</h4>\n" +
                "\t\t\t<table class=\"layui-table\" lay-skin=\"nob\">\n" +
                "\t\t\t\t<colgroup>\n" +
                "\t\t\t\t  <col width=\"150\">\n" +
                "\t\t\t\t  <col width=\"150\">\n" +
                "\t\t\t\t</colgroup>\n" +
                "\t\t\t\t<tbody>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>所属分场</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.ssfc+"</td>\n" +
                "\t\t\t\t \n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>土壤质地</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.trzd+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>种植种类</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.zwzl+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>种植品种</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.zwpz+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>地块组长</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.dkzz+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>地块技术员</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.dkjsy+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>犁地方向</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.ldfx+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>地块面积(亩)</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.dkmj+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t  <tr>\n" +
                "\t\t\t\t\t<td>地块周长(m)</td>\n" +
                "\t\t\t\t\t<td align=\"right\">"+lot.dkzc+"</td>\n" +
                "\t\t\t\t  </tr>\n" +
                "\t\t\t\t</tbody>\n" +
                "\t\t\t</table>\n" +
                "\t\t  \n" +
                "        </div>\n" +
                "   </div>")

                    map.getContainer().appendChild(div);
                    return div;
                }
            }

        }
        //点击右上角X删除div
        function closeDiv(obj) {
            map1.getContainer().removeChild(obj.parentNode.parentNode.parentNode);

        }
        //根据地块id查询地块详情
        function getLotByFenChangId() {

            $.ajax({
                url:"/basicCenter/getLotByFenChangId",
                dataType:"json",
                data:{"fenChangId":fenChangId},
                type:"post",
                success:function(data){
                    if(data){
                       lots=data;

                    }
                }
            })

        }
        //打开地块查看模态框
            function showDiKuaiDetail(lotId) {
                $("#showDiKuaiDetail_Modal").modal("show")
                $.ajax({
                    url:"/basicCenter/getLotById",
                    dataType:"json",
                    data:{"lotId":lotId},
                    type:"post",
                    success:function(data){
                        $("#d1").html(data.name);
                        $("#d2").html(data.ssfc);
                        $("#d3").html(data.trzd);
                        $("#d4").html(data.ldfx);
                        $("#d5").html(data.zwzl);
                        $("#d6").html(data.zwpz);
                        $("#d7").html(data.dkzz);
                        $("#d8").html(data.dkjsy);
                        $("#d9").html(data.dkmj);
                        $("#d10").html(data.dkzc);
                    }
                })
        }
        //打开地块详情模态框
        var updateLotDetail ;
            function updateDiKuaiDetail(lotId) {

                $.ajax({
                    url:"/basicCenter/getLotById",
                    dataType:"json",
                    data:{"lotId":lotId},
                    type:"post",
                    success:function(data){

                       if(data){
                           updateLotDetail=data;
                           $("#updateDiKUai_Modal").modal("show")

                       }
                    }
                })
        }
</script>

<!-- 画地块模态框（Modal） -->
<div class="modal" id="huaDiKUai_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1200px;margin-right: 250px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel_up">画地块</h4>
            </div>

            <div class="modal-body">
                <div class="panel-group" id="accordion_up">
                    <div id="allmap" style="overflow:hidden;zoom:1;position:relative;">
                    <div id="map" style="margin-left:10%;width:800px;height:550px;-webkit-transition: all 0.5s ease-in-out;transition: all 0.5s ease-in-out;"></div>
                </div>
                <div id="result">

                </div>

            </div>
                <div class="panel-body">
                    <div class="form-group">
                        <button onclick="getPoint()" class="layui-btn" style="margin-left: 40%;">确定</button>
                        <button onclick="clearAll()" class="layui-btn" style="margin-left: 5%;">清除</button>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
<script type="text/javascript">

    var searchCtrl = null;//自定义控件变量
    var area = null;//多边形面积
    var overlays = [];//所有多边形经纬度的集合
    var girth = null; //选取的多边形的周长
    var map=null;

    $('#huaDiKUai_Modal').on('show.bs.modal', function () {
        // 百度地图API功能
         map = new BMap.Map('map', {mapType: BMAP_HYBRID_MAP});
        var poi = new BMap.Point(119.17727607665722, 31.864854683156516);
        map.centerAndZoom(poi, 19);
        map.enableScrollWheelZoom();//可以滚动地图

        var overlaycomplete = function (e) {
            overlays.push(e.overlay);
            if (overlays.length > 1) {
                //overlays.splice(overlays.length-1, 1);
                map.removeOverlay(overlays[overlays.length - 2]);
            }
            var path = e.overlay.getPath();//Array<Point> 返回多边型的点数组

            for (var i = 0; i < path.length; i++) {
                console.log("lng:" + path[i].lng + "\n lat:" + path[i].lat);
            }
            e.overlay.enableEditing();//画完多边形后，实现可编辑
            //e.overlay.addEventListener('mousedown', getPoint);
        };

        var styleOptions = {
            strokeColor: "red",    //边线颜色。
            fillColor: "red",      //填充颜色。当参数为空时，圆形将没有填充效果。
            strokeWeight: 3,       //边线的宽度，以像素为单位。
            strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
            fillOpacity: 0.6,      //填充的透明度，取值范围0 - 1。
            strokeStyle: 'solid' //边线的样式，solid或dashed。
        }
        //实例化鼠标绘制工具
        var drawingManager = new BMapLib.DrawingManager(map, {
            isOpen: true, //是否开启绘制模式
            enableDrawingTool: true, //是否显示工具栏
            drawingMode: BMAP_DRAWING_POLYGON,//绘制模式  多边形
            //enableCalculate:true,//开启距离面积计算
            drawingToolOptions: {
                anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
                offset: new BMap.Size(5, 5), //偏离值
                drawingModes: [
                    BMAP_DRAWING_POLYGON //只显示多边形工具栏
                ]

            },


            polygonOptions: styleOptions //多边形的样式
        })
        //添加鼠标绘制工具监听事件，用于获取绘制结果
        drawingManager.addEventListener('overlaycomplete', overlaycomplete);


    })


    //点击下一步事件
    function nextStep(){
        $("#basicDiKUai_Modal").modal("show");
        $("#dkmj").val(area)
        $("#dkzc").val(girth)
        var path =overlays[overlays.length-1].getPath();
        var str = path[0].lng.toFixed(4)+"E"+"  "+path[0].lat.toFixed(4)+"N"
        var overlay=[];
        for (let i = 0; i <path.length ; i++) {
            var over={"longitude":path[i].lng,"latitude":path[i].lat}
            overlay.push(over)
        }

        var overla = JSON.stringify(overlay);
        $("#overlay").val(overla)
        $("#location").val(str)

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
        area =  BMapLib.GeoUtils.getPolygonArea(overlays[ overlays.length-1]);//面积
        girth=  BMapLib.GeoUtils.getPolylineDistance(overlays[ overlays.length-1].getPath()) //计算周长
        area = area.toFixed(1);//保留一位小数
        girth = girth.toFixed(1);
        if(area==0){

            alert("请选取地块！！！")
            clearAll();
            return false;
        }
        //调用自定义控件方法，实现地图上出现提示文字
        searchCtrl=new SearchControl1(2,200,30);
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
    function SearchControl1(posIndex,left,top){
        var position=[BMAP_ANCHOR_TOP_LEFT,BMAP_ANCHOR_TOP_RIGHT,BMAP_ANCHOR_BOTTOM_LEFT,BMAP_ANCHOR_BOTTOM_RIGHT];
        this.defaultAnchor=position[posIndex];
        this.defaultOffset=new BMap.Size(left,top);
    }
    SearchControl1.prototype=new BMap.Control();
    SearchControl1.prototype.initialize=function(map){
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
    }
</script>
<!-- 添加地块基本信息模态框（Modal） -->
<div class="modal" id="basicDiKUai_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1200px;height:800px;margin-right: 250px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="">编辑分场基本信息</h4>
            </div>

            <div class="modal-body">
                <form id="diKuai_addForm" class="layui-form">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">地块名称</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" name="name" id="name" placeholder="请输入"
                                       lay-verify="required" autocomplete="on" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属分场</label>
                            <div class="layui-input-block">
                                <select name="ssfc" lay-filter="" id="ssfc" lay-verify="required"  >

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">土壤质地</label>
                            <div class="layui-input-block">
                                <select name="trzd" lay-filter="" id="trzd" lay-verify="required" >
                                    <option value="">请选择</option>
                                    <option value="沙土">沙土</option>
                                    <option value="壤土">壤土</option>
                                    <option value="沙壤土">沙壤土</option>
                                    <option value="中壤土">中壤土</option>

                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">作物种类</label>
                            <div class="layui-input-block">
                                <select id="zwzl" name="zwzl" lay-filter="zwzl" lay-verify="required">

                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">作物品种</label>
                            <div class="layui-input-block">
                                <select id="zwpz" name="zwpz" lay-filter="zwpz" lay-verify="required" >

                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">地块组长</label>
                        <div class="layui-inline" style="width: 300px">
                            <select name="dkzz" lay-filter="" id="dkzz"  lay-verify="required">

                            </select>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">地块技术员</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" id="technicianUserName" readonly lay-verify="required"
                                       autocomplete="off" class="layui-input">
                                <input hidden id="dkjsy" name="dkjsy">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">犁地方向</label>
                        <div class="layui-inline" style="width: 300px">
                            <select id="ldfx" name="ldfx" lay-filter="province" lay-verify="required">
                                <option value="">请选择</option>
                                <option value="东向西">东向西</option>
                                <option value="西向东">西向东</option>
                                <option value="南向北">南向北</option>
                                <option value="北向南">北向南</option>
                            </select>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">地块面积(亩)</label>
                            <div class="layui-input-block" style="width:300px">
                                <input id="dkmj" type="text" name="dkmj" readonly
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">地块周长(米)</label>
                            <div class="layui-input-block" style="width:300px">
                                <input  id="dkzc" type="text" name="dkzc" readonly
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">经度纬度</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" name="location" id="location" readonly
                                       autocomplete="off" class="layui-input">
                                <input hidden id="overlay" name="overlay" >
                            </div>
                        </div>
                    </div>

                <div class="panel-body">
                    <div class="form-group">
                        <button lay-submit="" lay-filter="addDiKuai" class="layui-btn" style="margin-left: 20%;margin-top: 20%">添加</button>
                        <button data-dismiss="modal" aria-hidden="true" class="layui-btn" style="margin-left: 30%;margin-top: 20%">取消</button>
                    </div>
                </div>
                </form>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
<script>

    var speciesList=null;//物种集合
    var varietyList=null;//品种集合
    $('#basicDiKUai_Modal').on('show.bs.modal', function () {
        layui.use('form', function () {//form表单预加载样式
           /* technicianUserName*/
            $("#technicianUserName").val(technicianUserName)
            $("#dkjsy").val(technicianUser)
            var form = layui.form;
            form.render();

            //预加载组长下拉框
            getLeaderList();


            //预加载物种种类
            getSpeciesList();

            //查询物种品种
            getVarietyList()

            //物种下拉框改变，品种的选项相应的变化
            form.on('select(zwzl)', function(data){
                var html="<option value=\"\">请选择</option>"
                if(data.value!=null &&data.value!=""){

                    $.each(varietyList,function (a,b) {
                        if(data.value==b.species){
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                        }
                    })

                }else {
                    $.each(varietyList,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                }
                $("#zwpz").empty()
                $("#zwpz").append(html)
                form.render("select");
            });


            //品种变化相应的物种跟着变化
            //lay-filter="zwpz"
            form.on('select(zwpz)', function(data){
                var html="<option value=\"\">请选择</option>"
                if(data.value!=null &&data.value!=""){
                    var zwpz=null;
                    for (let i = 0; i < varietyList.length; i++) {
                        if(data.value==varietyList[i].id){
                            zwpz=varietyList[i].species
                        }
                    }

                    $.each(speciesList,function (a,b) {
                        if(zwpz==b.id){
                            html+=" <option selected value=\""+b.id+"\">"+b.name+"</option>"
                        }else {
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                        }
                    })

                }else{
                    $.each(speciesList,function (a,b) {
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })

                }
                $("#zwzl").empty()
                $("#zwzl").append(html)
                layui.form.render("select");
            });
            // 监听提交
            form.on('submit(addDiKuai)', function(data) {
                $.ajax({
                    type : "POST",
                    url : "/basicCenter/addLot",
                    data : $("#diKuai_addForm").serialize(),
                    dataType : "json",
                    success : function(data) {
                        window.location.reload()//刷新当前页面.

                    }
                });
                return false;
            });
            form.render(); // 更新全部
        });

    })

    //查询组长列表
    function getLeaderList() {
        $.ajax({
            url:"/basicCenter/getUserListByRole",
            data:{"roleId":6},
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.truename+"</option>"
                    })
                }
                $("#dkzz").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询种类列表
    function getSpeciesList() {
        $.ajax({
            url:"/basicCenter/getSpeciesList",
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    speciesList=data;
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                }
                $("#zwzl").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询品种列表
    function getVarietyList() {
        $.ajax({
            url:"/basicCenter/getVarietyList",
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    varietyList=data;
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                }
                $("#zwpz").append(html)
                layui.form.render("select");
            }
        })

    }

</script>
<!-- 修改地块基本信息模态框（Modal） -->
<div class="modal" id="updateDiKUai_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 1200px;height:800px;margin-right: 250px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" >修改分场基本信息</h4>
            </div>

            <div class="modal-body">
                <form id="diKuai_updateForm" class="layui-form">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">地块名称</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" name="name" placeholder="请输入" id="name1"
                                       lay-verify="required" autocomplete="on" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属分场</label>
                            <div class="layui-input-block">
                                <select name="ssfc" lay-filter="" id= "ssfc1" lay-verify="required"  >

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">土壤质地</label>
                            <div class="layui-input-block">
                                <select name="trzd" lay-filter="" id= "trzd1"  lay-verify="required" >
                                    <option value="">请选择</option>
                                    <option value="沙土">沙土</option>
                                    <option value="壤土">壤土</option>
                                    <option value="沙壤土">沙壤土</option>
                                    <option value="中壤土">中壤土</option>

                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">作物种类</label>
                            <div class="layui-input-block">
                                <select name="zwzl" lay-filter="zwzl1"  id= "zwzl1"  lay-verify="required">

                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">作物品种</label>
                            <div class="layui-input-block">
                                <select name="zwpz" lay-filter="zwpz1" id= "zwpz1"   lay-verify="required" >

                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">地块组长</label>
                        <div class="layui-inline" style="width: 300px">
                            <select name="dkzz" lay-filter="" id="dkzz1"  lay-verify="required">

                            </select>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">地块技术员</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text"  readonly lay-verify="required"  id="dkjsy1"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">犁地方向</label>
                        <div class="layui-inline" style="width: 300px">
                            <select name="ldfx" lay-filter="province" id="ldfx1" lay-verify="required">
                                <option value="">请选择</option>
                                <option value="东向西">东向西</option>
                                <option value="西向东">西向东</option>
                                <option value="南向北">南向北</option>
                                <option value="北向南">北向南</option>
                            </select>
                        </div>

                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">地块面积(亩)</label>
                            <div class="layui-input-block" style="width:300px">
                                <input  type="text" name="dkmj" readonly id="dkmj1"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">地块周长(米)</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" name="dkzc" readonly id="dkzc1"
                                       autocomplete="off" class="layui-input">
                                <input id="id1" name="id" hidden>
                            </div>
                        </div>
                    </div>

                <div class="panel-body">
                    <div class="form-group">
                        <button lay-submit="" lay-filter="updateDiKuai" class="layui-btn" style="margin-left: 20%;margin-top: 20%">修改</button>
                        <button data-dismiss="modal" aria-hidden="true" class="layui-btn" style="margin-left: 30%;margin-top: 20%">取消</button>
                    </div>
                </div>
                </form>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
<script>

    $('#updateDiKUai_Modal').on('show.bs.modal', function () {
        layui.use('form', function () {//form表单预加载样式
            $("#name1").val(updateLotDetail.name)
            $("#ssfc1").val(updateLotDetail.ssfc)
            $("#trzd1").val(updateLotDetail.trzd)
            $("#dkjsy1").val(updateLotDetail.dkjsy)
            $("#ldfx1").val(updateLotDetail.ldfx)
            $("#dkmj1").val(updateLotDetail.dkmj)
            $("#dkzc1").val(updateLotDetail.dkzc)
            $("#id1").val(updateLotDetail.id)
            var form = layui.form;
            form.render();

            //预加载组长下拉框
            getLeaderList1(updateLotDetail.dkzz);


            //预加载物种种类
            getSpeciesList1(updateLotDetail.zwzl);

            //查询物种品种
            getVarietyList1(updateLotDetail.zwpz)

            //查询所属分场
            getFenChangList(updateLotDetail.ssfc)

            //物种下拉框改变，品种的选项相应的变化
            form.on('select(zwpz1)', function(data){
                var html="<option value=\"\">请选择</option>"
                if(data.value!=null &&data.value!=""){

                    $.each(varietyList,function (a,b) {
                        if(data.value==b.species){
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                        }
                    })

                }else {
                    $.each(varietyList,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                }
                $("#zwzl1").empty()
                $("#zwzl1").append(html)
                form.render("select");
            });


            //品种变化相应的物种跟着变化
            //lay-filter="zwpz"
            form.on('select(zwpz1)', function(data){
                var html="<option value=\"\">请选择</option>"
                if(data.value!=null &&data.value!=""){
                    var zwpz=null;
                    for (let i = 0; i < varietyList.length; i++) {
                        if(data.value==varietyList[i].id){
                            zwpz=varietyList[i].species
                        }
                    }

                    $.each(speciesList,function (a,b) {
                        if(zwpz==b.id){
                            html+=" <option selected value=\""+b.id+"\">"+b.name+"</option>"
                        }else {
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                        }
                    })

                }else{
                    $.each(speciesList,function (a,b) {
                            html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })

                }
                $("#zwzl1").empty()
                $("#zwzl1").append(html)
                layui.form.render("select");
            });
            // 监听提交
            form.on('submit(updateDiKuai)', function(data) {
                $.ajax({
                    type : "POST",
                    url : "/basicCenter/updateLot",
                    data : $("#diKuai_updateForm").serialize(),
                    dataType : "json",
                    success : function(data) {
                        window.location.reload()//刷新当前页面.

                    }
                });
                return false;
            });
            form.render(); // 更新全部
        });

    })

    //查询组长列表
    function getLeaderList1(dkzz) {
        $.ajax({
            url:"/basicCenter/getUserListByRole",
            data:{"roleId":6},
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    $.each(data,function (a,b) {
                        if(b.truename==dkzz){
                            html+=" <option selected value=\""+b.id+"\">"+b.truename+"</option>"
                        }else {
                            html+=" <option value=\""+b.id+"\">"+b.truename+"</option>"
                        }
                    })
                }
                $("#dkzz1").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询种类列表
    function getSpeciesList1(zwzl) {
        $.ajax({
            url:"/basicCenter/getSpeciesList",
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    speciesList=data;
                    $.each(data,function (a,b) {
                        if (b.name == zwzl) {
                            html += " <option selected value=\"" + b.id + "\">" + b.name + "</option>"
                        } else {
                            html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                        }
                    })
                }
                $("#zwzl1").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询品种列表
    function getVarietyList1(zwpz) {
        $.ajax({
            url:"/basicCenter/getVarietyList",
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    varietyList=data;
                    $.each(data,function (a,b) {
                        if (b.name == zwpz) {
                            html += " <option selected value=\"" + b.id + "\">" + b.name + "</option>"
                        } else {
                            html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                        }
                    })
                }
                $("#zwpz1").append(html)
                layui.form.render("select");
            }
        })

    }
    function getFenChangList(ssfc) {
        $.ajax({
            url:"/basicCenter/getFenChangListVo",
            dataType:"json",
            type:"post",
            success:function(data){

                if(data){

                    var html=" <option value='0'>请选择</option>"

                    $.each(data,function (a,b) {
                        if (b.name == ssfc) {
                            html += " <option selected value=\"" + b.id + "\">" + b.name + "</option>"
                        } else {
                            html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                        }
                    })

                    $("#ssfc1").append(html);//添加地块，详情页面下拉框赋值
                    layui.form.render("select");
                }

            }
        })
    }
</script>
<!-- 查看地块基本信息模态框（Modal） -->
<div class="modal" id="showDiKuaiDetail_Modal" tabindex="-1" aria-labelledby="myModalLabel" style="margin-left: -700px;">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 800px;height:400px;margin-right: 350px">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" >地块详情</h4>
            </div>

            <div class="modal-body">
                <table class="layui-table" lay-skin="nob">
                    <colgroup> <col width="150"><col width="150"></colgroup>
                    <tr>
                        <td>地块名称：<text id="d1"></text></td>
                        <td>所属分场：<text id="d2"></text></td>
                    </tr>
                    <tr>
                        <td>土壤质地：<text id="d3"></text></td>
                        <td>犁地方向：<text id="d4"></text></td>
                    </tr>
                    <tr>
                        <td>作物种类：<text id="d5"></text></td>
                        <td>作物品种：<text id="d6"></text></td>
                    </tr>
                    <tr>
                        <td>地块组长：<text id="d7"></text></td>
                        <td>地块技术员：<text id="d8"></text></td>
                    </tr>
                    <tr>

                        <td>地块面积(亩)：<text id="d9"></text></td>
                        <td>地块周长：<text id="d10"></text></td>
                    </tr>

                </table>

            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->
</div>
