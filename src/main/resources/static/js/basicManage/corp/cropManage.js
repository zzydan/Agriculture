$(function () {
    role_table();

})

//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
    /*findRes();*/
}
function role_table() {
    $("#role_table").bootstrapTable("destroy");
    $("#role_table").bootstrapTable({ // 对应table标签的id
        url: "/basicCenter/SelectCropAll", // 获取表格数据的url
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
                field: 'name',
                title: '种类名称'
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
//显示所有权限
function findRes() {
    $.ajax({
        url: "/usermanager/findRes",
        type: "post",
        dataType: "json",
        async: false,
        data: {},
        success: function (data) {
            $("#resParentCheckbox").empty();
            for (var i = 0; i < data.length; i++) {
                $("#resParentCheckbox").append("<div id=" + "resChildCheckbox" + data[i].info + " class='panel-body panel-success'></div>");

                $("#resChildCheckbox" + data[i].info).append(
                    "<div><label class='checkbox-inline'>" +
                    "<input type='checkbox' name='listRes' onchange='checkAll(this)' value=" + data[i].id + ">" + data[i].resname +
                    "</label></div>");
                var list = data[i].resList;

                $("#resChildCheckbox" + data[i].info).append("<div>");
                for (var j = 0; j < list.length; j++) {
                    $("#resChildCheckbox" + data[i].info).append(
                        "<label class='checkbox-inline'>" +
                        "<input type='checkbox' name='listRes' onchange='checkaaa(this)' value=" + list[j].id + ">" + list[j].resname +
                        "</label>");
                }
                $("#resParentCheckbox").append("</div></div>");
            }
        },
        error: function () {
            alert("请求失败");
        }
    });
}
//添加作物品种
function addcrop() {
    var userId=$("#id_add").val();
    var name=$("#name").val();

    var formData = new FormData();
    formData.append('userId', userId);
    formData.append('name', name);
    var User1Pic=$("#enterprisemapperUser1Pic_add").attr("src");
    if(User1Pic!= null){
        //2.把二进制的图片数据转为Blob对象
        var User1Pic_blob = processData(User1Pic);
        formData.append('User1Pic', User1Pic_blob);
    }
    alert(userId);
    alert(name);
    alert(User1Pic);
    $.ajax({
        url: "/basicCenter/addcrop",
        type: "post",
        dataType: "json",
        data: formData,
        processData: false,
        contentType: false,
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
    var name=$("#name_up").val();
    $.ajax({
        url: "/basicCenter/UpdateCropSpercies",
        type: "post",
        dataType: "json",
        data: {
            id:id,
            name:name,
        },
        success: function (data) {
            alert("修改成功！！");
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
            url: "/basicCenter/DeleteCropSperciesId/"+id,
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
        url: "/basicCenter/SelectCropSpeciesId/"+id,
        type:"post",
        dataType:"json",
        success:function(data){
            $("#id_up").val(data.id);
            $("#name_up").val(data.name);

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
            url: "/usermanager/deleteRole",
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


//复选框全选全不选
function checkAll(obj) {
    if ($(obj).prop("checked")) {
        $(obj).parent().parent().parent().find("input").prop("checked", true);
    } else {
        $(obj).parent().parent().parent().find("input").prop("checked", false);
    }

}
//复选框子节点联动父节点
function checkaaa(obj) {
    if ($(obj).prop("checked")) {
        $(obj).parent().parent().find("div").children().children().prop("checked", true);
    } else if ($(obj).parent().parent().find("input[type='checkbox']:checked").length == 1) {
        $(obj).parent().parent().find("div").children().children().prop("checked", false);
    }

}
//验证通过
function isOk(obj, text) {
    obj.parent().parent().removeClass("has-error");
    obj.parent().parent().addClass("has-success");
    obj.parent().next().children(":first").html(text);

}
//验证不通过
function isError(obj, text) {
    obj.parent().parent().removeClass("has-success");
    obj.parent().parent().addClass("has-error");
    obj.parent().next().children(":first").html(text);
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