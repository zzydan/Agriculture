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
        <div class="layui-tab-item">2</div>

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
        var lids=[];//存放回显的多边形的id
        var map1=null;
    $(function () {
        $.ajax({
            url:"/basicCenter/getFenChangListVo",
            dataType:"json",
            type:"post",
            success:function(data){

                if(data){
                    fenChangList=data;
                    getMap(fenChangList[0].longitude,fenChangList[0].latitude);
                }

            }
        })


    })
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
        for (let i = 0; i <fenChangList.length ; i++) {
            if(fenChangId==fenChangList[i].id){
              var  lotVoList =fenChangList[i].lotVoList//当前分场的所有地块的集合

                for (let j = 0; j < lotVoList.length; j++) {
                    var lid=lotVoList[j].lid //地块的id
                    lids.push(lid)//存进全局变量数组
                    var  locationVoList =lotVoList[j].locationVoList//id为lotVoList[j].lid所有地块的经纬度集合
                    var arr=new Array();//新建一个数组
                    var str=""
                    for (let k= 0; k< locationVoList.length; k++) {
                        if(k==0){
                            str+="new BMap.Point("+locationVoList[k].lng+","+locationVoList[k].lat+"),"
                        }else if(k==locationVoList.length-1){
                            str+="new BMap.Point("+locationVoList[k].lng+","+locationVoList[k].lat+")"
                            fun(lid,str) //调用方法回显地块
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
           // window.location.href="./huaDiKuai2.jsp"
        $("#huaDiKUai_Modal").modal("show")
    }

    //变量名,标签坐标,多边形坐标,文本,边框颜色
    function fun(lid,arr) {
        //创建经纬度数组
        eval("var secRing"+lid+" = ["+arr+"]");
        //创建多边形
        eval("var secRingPolygon" + lid + "= new BMap.Polygon(secRing" + lid + ", { strokeColor: 'green', strokeWeight: 4})");

        //添加多边形到地图上
        map1.addOverlay(eval("secRingPolygon"+lid));


        //给多边形添加鼠标事件
        eval("secRingPolygon"+lid).addEventListener("click", function () {//单击


            eval("secRingPolygon" + lid).setStrokeColor("blue"); //多边形边框为蓝色


            map1.addOverlay(eval("secRingLabel" + lid)); //添加多边形遮照
        })
        eval("secRingPolygon"+lid).addEventListener("dblclick", function () {//单击


                eval("secRingPolygon" + lid).setStrokeColor("green"); //多边形边框为蓝色
                map1.addOverlay(eval("secRingLabel"+lid)); //添加多边形遮照

            //eval("secRingPolygon" + lid).setFillColor(ys);
            //map1.addOverlay(eval("secRingLabel"+lid)); //添加多边形遮照
            //map.panTo(eval("secRingCenter"+lid)); //将地图移动到指定点
        });
       /* eval("secRingPolygon"+lid).addEventListener("click", function () {
            map.zoomIn();
            eval("secRingPolygon" + lid).setStrokeColor(ys);
            //eval("secRingPolygon" + lid).setFillColor("");
            map.setCenter(eval("secRingCenter"+lid));
        });*/
    }
</script>
<%--
画地块模态框
--%>
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
            /*circleOptions: styleOptions, //圆的样式
            polylineOptions: styleOptions, //线的样式
            rectangleOptions: styleOptions, //矩形的样式,*/

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
        /*//将获取到的courseid传入到session

        sessionStorage.setItem("overlay",overlay);
        sessionStorage.setItem("area",area);
        sessionStorage.setItem("girth",girth);
        //跳转到修改页面
        window.location.href="./huaDiKuai3.jsp";*/
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
                                <input type="text" name="name" placeholder="请输入"
                                       lay-verify="required" autocomplete="on" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属分场</label>
                            <div class="layui-input-block">
                                <select name="ssfc" lay-filter="" lay-verify="required"  >

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">土壤质地</label>
                            <div class="layui-input-block">
                                <select name="trzd" lay-filter="" lay-verify="required" >
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
                            <select name="dkzz" lay-filter=""  lay-verify="required">

                            </select>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">地块技术员</label>
                            <div class="layui-input-block" style="width:300px">
                                <input type="text" name="dkjsy" placeholder="请输入" lay-verify="required"
                                       autocomplete="off" class="layui-input">
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
                                <input id="overlay" name="overlay" >
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
            var form = layui.form;
            form.render();

            //预加载组长下拉框
            getLeaderList();

            //预加载分场名
            getFenChangList();

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
                $("select[name='zwpz']").empty()
                $("select[name='zwpz']").append(html)
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
                $("select[name='zwzl']").empty()
                $("select[name='zwzl']").append(html)
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
                $("select[name='dkzz']").append(html)
                layui.form.render("select");
            }
        })

    }
    //查询分场列表
    function getFenChangList() {
        $.ajax({
            url:"/basicCenter/getFenChangListVo",
            dataType:"json",
            type:"post",
            success:function(data){
                var html="<option value=\"\">请选择</option>"
                if(data){
                    $.each(data,function (a,b) {
                        html+=" <option value=\""+b.id+"\">"+b.name+"</option>"
                    })
                }
                $("select[name='ssfc']").append(html)
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
                $("select[name='zwzl']").append(html)
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
                $("select[name='zwpz']").append(html)
                layui.form.render("select");
            }
        })

    }

</script>