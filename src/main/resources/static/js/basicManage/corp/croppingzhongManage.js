$(function () {
    role_table();
    findEnter();

})

//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
    /*findRes();*/
}
function findEnter() {
    $.ajax({
        type: "post",
        url: "/basicCenter/SelectCropAll",
        data: {},
        dataType: "json",
        success: function (data) {
            var str = "";
            if (data != null && data.length != 0) {
                $("#Enterprise_select_1").children("option:gt(0)").remove();
                $("#Enterprise_select_1_up").children("option:gt(0)").remove();
                str = str + "<option value=''>选择种类</option>";
                for (var i = 0; i < data.length; i++) {
                    str = str + "<option value=" + data[i].id + ">" + data[i].name + "</option>";
                }
                $("#Enterprise_select_1").append(str);
                $("#Enterprise_select_1_up").append(str);
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
        url: "/basicCenter/findVariety", // 获取表格数据的url
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
                title: '品种名称'
            }, {
                field: 'name1',
                title: '所属种类'
            }, {
                field: 'truename',
                title: '创建人'
            }, {
                field: 'zwswxld',
                title: '生物学零度'
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
function addRole() {
    var userId=$("#id_add").val();
    var name=$("#name").val();
    var species=$("#Enterprise_select_1").val();
    var zwswxld=$("#zwswxld").val();
    $.ajax({
        url: "/basicCenter/InsertVariety",
        type: "post",
        dataType: "json",
        data: {
            userId:userId,
            name:name,
            species:species,
            zwswxld:zwswxld
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
    var name=$("#name_up").val();
    var species=$("#Enterprise_select_1_up").val();
    var zwswxld=$("#zwswxld_up").val();
    $.ajax({
        url: "/basicCenter/updataVariety",
        type: "post",
        dataType: "json",
        data: {
            id:id,
            name:name,
            species:species,
            zwswxld:zwswxld
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
            url: "/basicCenter/deleteVariety/"+id,
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
        url: "/basicCenter/findVarietyId/"+id,
        type:"post",
        dataType:"json",
        success:function(data){
            $("#id_up").val(data.id);
            $("#name_up").val(data.name);
            $("#zwswxld_up").val(data.zwswxld);
            $("#Enterprise_select_1_up option").each(function(){
                if($(this).val()==data.species){
                    $(this).attr("selected","selected");
                }
            });
            $("#UpUserInfo_Modal").modal("show");
        },error:function(){
            console.log("出错了！");
        }
    });
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