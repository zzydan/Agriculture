$(function () {
    role_table();
    findEnter();
    findEntersp();
})

$(document).ready(function() {

    var MaxInputs       = 8;
    var InputsWrapper   = $("#InputsWrapper");
    var AddButton       = $("#AddMoreFileBox");

    var x = InputsWrapper.length;
    var FieldCount=0;

    $(AddButton).click(function (e)
    {
        if(x <= MaxInputs)
        {
            FieldCount++;

            $(InputsWrapper).append(
                 '<tr>'
                +'<td>'
                +"<input type=\"text\" class=\"form-control\" id=\"zwswxld_up"+FieldCount+"\" name=\"zwswxld_up\" placeholder=\"请输入\">"
                +'</td>'
                +'<td  style="width:600px";>'
                +'<div class="form-group">'
                +'<div class="col-sm-1">'
                +'</div>'
                +'<div class="col-sm-4" style="top: 7px;">'
                +"<input type=\"date\" class=\"form-control\" id=\"starttime"+FieldCount+"\" name=\"starttime\" placeholder=\"请输入\" style=\"width:200px\";>"
                +'</div>'
                +'<div class="col-sm-1">'
                +'</div>'
                +'<div class="col-sm-4" style="top: 7px;">'
                +"<input type=\"date\" class=\"form-control\" id=\"endtime"+FieldCount+"\" name=\"endtime\" placeholder=\"请输入\"  style=\"width:200px\";>"
                +'</div>'
                +'</div>'
                +'</td>'
                +'<td>'
                +'<div class="item">'
                +'<img class="icon addImg" onclick=\"clickImg(this);"\ src="/static/jquerygwscmoban/images/addImg.png">'
                +'<input name="url" type="file" class="upload_input" onchange="change(this)">'
                +'<div class="preBlock">'
                +"<img id=\"enterprisemapperUser1Pic_add"+FieldCount+"\" class=\"preview\" alt=\"\" name=\"pic\" width=\"34\" height=\"34\">"
                +'</div>'
                +'<img class="delete" onclick=\"deleteImg(this);"\ src="/static/jquerygwscmoban/images/delete.png">'
                +'</div>'
                +'</td>'
                +'<td>'
                +'<button type="button" class="layui-btn layui-btn-danger layui-btn-sm" onclick=\"deleteThis(this.parentNode.parentNode)\">删除</button>'
                +'</td>'
                +'</tr>'
            );
            x++;
        }
        return false;
    });

    $("body").on("click",".removeclass", function(e){
        if( x > 1 ) {
            $(this).parent('div').remove();
            x--;
        }
        return false;
    })

});
//删除
function deleteThis(i) {
    i.remove();
}
//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
    /*findRes();*/
}
function findEnter() {
    $.ajax({
        type: "post",
        url: "/basicCenter/findVariety",
        data: {},
        dataType: "json",
        success: function (data) {
            var str = "";
            if (data != null && data.length != 0) {
                $("#cv_id").children("option:gt(0)").remove();
                $("#cv_id_up").children("option:gt(0)").remove();
                str = str + "<option value=''>选择品种</option>";
                for (var i = 0; i < data.length; i++) {
                    str = str + "<option value=" + data[i].id + ">" + data[i].name + "</option>";
                }
                $("#cv_id").append(str);
                $("#cv_id_up").append(str);

            }
        },//请求失败时回调函数
        error: function () {
            alert("失败 ");
        }
    });
}

function findEntersp() {
    $.ajax({
        type: "post",
        url: "/basicCenter/SelectCropAll",
        data: {},
        dataType: "json",
        success: function (data) {
            var str = "";
            if (data != null && data.length != 0) {
                $("#cs_id").children("option:gt(0)").remove();
                $("#cs_id_up").children("option:gt(0)").remove();
                str = str + "<option value=''>选择种类</option>";
                for (var i = 0; i < data.length; i++) {
                    str = str + "<option value=" + data[i].id + ">" + data[i].name + "</option>";
                }
                $("#cs_id").append(str);
                $("#cs_id_up").append(str);

            }
        },//请求失败时回调函数
        error: function () {
            alert("失败 ");
        }
    });
}
function role_table() {
    $("#role_table").bootstrapTable("destroy");
    $("#role_table").bootstrapTable({ // 对应table标签的id
        url: "/basicCenter/FindCropGrowthCycleTime", // 获取表格数据的url
        method: "get", //请求方式
        cache: false, //关闭缓存
        toolbar: '#toolbar', //工具按钮用哪个容器
        pagination: true, //开启分页
        sidePagination: "client", //客户端分页client,"server"服务端分页
        pageNumber: 1, //分页起始行,默认第一行
        sortName: "id", //排序名
        sortOrder: "asc", //排序方式
        pageSize: 10, //每页几行
        pageList: [10, 20, 30], //设置每页几行的下拉框
        striped: true,       //是否显示行间隔色
        clickToSelect: true, //设置复选框头
        showRefresh: true,   //是否显示刷新按钮
        columns: [//field对应的是entity中的属性 title:列名
            {
                field: 'id', // 返回json数据中的name
                title: '序号', // 表格表头显示文字
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    return index + 1;
                }
            }, {
                field: 'csname',
                title: '品种名称'
            }, {
                field: 'sysqmc',
                title: '生育时期'
            }, {
                field: 'truename',
                title: '创建人'
            }, {
                field: 'createtime',
                title: '创建时间',
            }, {
                title: "操作",
                formatter: function (value, row, index) {
                    var str =
                        "<a onclick=\"updRoleById(\'" + row.id + "\')\" class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
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

var zwswxld_up=[];
var starttime=[];
var endtime=[];
var pic=[];
function addRole() {

    var zws=document.getElementsByName("zwswxld_up");
    for(var i=0;i<zws.length;i++){
        zwswxld_up.push(zws[i].value);
    }
    var start=document.getElementsByName("starttime");
    for(var i=0;i<start.length;i++){
        starttime.push(start[i].value);
    }
    var end=document.getElementsByName("endtime");
    for(var i=0;i<end.length;i++){
        endtime.push(end[i].value);
    }
    var cropSpeciesId=$("#cs_id").val();
    var cropVarietyId=$("#cv_id").val();
    alert(cropSpeciesId)
    alert(cropVarietyId)
    $.ajax({
        url: "/basicCenter/addCropGrowth",
        type: "post",
        dataType: "json",
        data: {
            zwswxld_up:zwswxld_up,
            starttime:starttime,
            endtime:endtime,
            cropSpeciesId:cropSpeciesId,
            cropVarietyId:cropVarietyId
        },
        success: function (data) {
            alert("创建成功！！");
            window.location.reload();
        },
        error: function () {
            alert("请求失败");
        }
    });
}


function upRole() {
    var id=$("#id_up").val();
    var enterpriseId=$("#Enterprise_select_1_up").val();
    var roleName=$("#rolename_up").val();
    var roleType=$("#select_roletype_up").val();
    var roleBz=$("#roleBz_up").val();
    $.ajax({
        url: "/basicCenter/upRoleId",
        type: "post",
        dataType: "json",
        data: {
            id:id,
            enterpriseId:enterpriseId,
            roleName:roleName,
            roleType:roleType,
            roleBz:roleBz
        },
        success: function (data) {
            alert("修改角色成功！！");
            window.location.reload();
        },
        error: function () {
            alert("请求失败");
        }
    });
}
//删除
function deleteManager(id) {
    if (confirm("确认删除么！！！")) {
        $.ajax({
            url: "/basicCenter/deleteCrop/"+id,
            type: "post",
            dataType: "json",
            success: function (data) {
                if(data>0){
                    alert("删除成功！！！");
                    $("#role_table").bootstrapTable("refresh");
                }
            },
            error: function () {
                alert("请求失败");
            }
        });
    }
}

//点击打开编辑用户模态框
function updRoleById(id) {
    $.ajax({
        url: "/basicCenter/SelectCropTimeId/"+id,
        type:"post",
        dataType:"json",
        success:function(data){
            $("#id_up").val(data.id);
            $("#rolename_up").val(data.roleName);
            $("#roleBz_up").val(data.roleBz);

            $("#cs_id_up option").each(function(){
                if($(this).val()==data.cropSpeciesId){
                    $(this).attr("selected","selected");
                }
            });
            $("#cv_id_up option").each(function(){
                if($(this).val()==data.cropVarietyId){
                    $(this).attr("selected","selected");
                }
            });
            $("#UpUserInfo_Modal").modal("show");
        },error:function(){
            console.log("出错了！");
        }
    });
}

//删除角色
function deleteRole(id) {
    if (confirm("确认删除么！！！")) {
        $.ajax({
            url: "/basicCenter/deleteRole",
            type: "post",
            dataType: "json",
            async: false,
            data: {'roleId':id},
            success: function (data) {
                if(data>0){
                    alert("删除成功！！！");
                    $("#role_table").bootstrapTable("refresh");
                }
            },
            error: function () {
                alert("请求失败");
            }
        });
    }
}


//点击
var clickImg = function(obj){
    $(obj).parent().find('.upload_input').click();
}
//删除
var deleteImg = function(obj){
    $(obj).parent().find('input').val('');
    $(obj).parent().find('img.preview').attr("src","");
    //IE9以下
    $(obj).parent().find('img.preview').css("filter","");
    $(obj).hide();
    $(obj).parent().find('.addImg').show();
}
//选择图片
function change(file) {
    //预览
    var pic = $(file).parent().find(".preview");
    //添加按钮
    var addImg = $(file).parent().find(".addImg");
    //删除按钮
    var deleteImg = $(file).parent().find(".delete");

    var ext=file.value.substring(file.value.lastIndexOf(".")+1).toLowerCase();

    // gif在IE浏览器暂时无法显示
    if(ext!='png'&&ext!='jpg'&&ext!='jpeg'){
        if (ext != '') {
            alert("图片的格式必须为png或者jpg或者jpeg格式！");
        }
        return;
    }
    //判断IE版本
    var isIE = navigator.userAgent.match(/MSIE/)!= null,
        isIE6 = navigator.userAgent.match(/MSIE 6.0/)!= null;
    isIE10 = navigator.userAgent.match(/MSIE 10.0/)!= null;
    if(isIE && !isIE10) {
        file.select();
        var reallocalpath = document.selection.createRange().text;
        // IE6浏览器设置img的src为本地路径可以直接显示图片
        if (isIE6) {
            pic.attr("src",reallocalpath);
        }else{
            // 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
            pic.css("filter","progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src=\"" + reallocalpath + "\")");
            // 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
            pic.attr('src','data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==');
        }
        addImg.hide();
        deleteImg.show();
    }else {
        html5Reader(file,pic,addImg,deleteImg);
    }
}
//H5渲染
function html5Reader(file,pic,addImg,deleteImg){
    var file = file.files[0];
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(e){
        pic.attr("src",this.result);
    }
    addImg.hide();
    deleteImg.show();
}
function processData(dataUrl) {
    var binaryString = window.atob(dataUrl.split(',')[1]);
    var arrayBuffer = new ArrayBuffer(binaryString.length);
    var intArray = new Uint8Array(arrayBuffer);
    for (var i = 0, j = binaryString.length; i < j; i++) {
        intArray[i] = binaryString.charCodeAt(i);
    }

    var data = [intArray],
        blob;

    try {
        blob = new Blob(data);
    } catch (e) {
        window.BlobBuilder = window.BlobBuilder ||
            window.WebKitBlobBuilder ||
            window.MozBlobBuilder ||
            window.MSBlobBuilder;
        if (e.name === 'TypeError' && window.BlobBuilder) {
            var builder = new BlobBuilder();
            builder.append(arrayBuffer);
            blob = builder.getBlob(imgType); // imgType为上传文件类型，即 file.type
        } else {
            console.log('版本过低，不支持上传图片');
        }
    }
    return blob;
}