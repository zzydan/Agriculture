$(function () {
    fenChang_table()
})
function addFenChang() {
    //window.location.href="./addFenChang.jsp"
    $("#addFenChang_Modal").modal("show");


}
//显示分场列表的方法
function fenChang_table() {
    $("#fenChang_table").bootstrapTable("destroy");
    $("#fenChang_table").bootstrapTable({ // 对应table标签的id
        url: "/basicCenter/getFenChangList", // 获取表格数据的url
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
                title: '分场名称'
            }, {
                field: 'fieldlengthUserName',
                valign: "middle",
                align:"center",
                title: "分场厂长"
            }, {
                field: 'technicianUserName',
                valign: "middle",
                align:"center",
                title: "技术员"
            }, {
                field: 'roleName',
                valign: "middle",
                align:"center",
                title: "地块数量"
            }, {
                field: 'roleType',
                valign: "middle",
                align:"center",
                title: '分场面积(亩)',
            },{
                title: "操作",
                valign: "middle",
                align:"center",
                formatter: function (value, row, index) {
                    var str =
                        "<a onclick=\"updateFenChang(\'" + row.id + "\')\" class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-edit\">" +
                        "</i>编辑</a> " +
                        "<a onclick=\"deleteManager(\'" + row.id + "\')\" class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}
function updateFenChang(id) {
    $("#id").val(id);
    $("#updateFenChang_Modal").modal('show')

    //window.location.href="./updateFenChang.jsp?id="+id;
}


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
    var map = new BMap.Map("addmap",{mapType: BMAP_HYBRID_MAP});
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
                    var map = new BMap.Map("allmap",{mapType: BMAP_HYBRID_MAP});
                    map.enableScrollWheelZoom();//启用滚轮放大缩小
                    var point = new BMap.Point(data.longitude,data.latitude);
                    $("#longitude").val(data.longitude);
                    $("#latitude").val(data.latitude);
                    map.centerAndZoom(point,18);
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