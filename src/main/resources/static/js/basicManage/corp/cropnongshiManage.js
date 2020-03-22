$(function () {
    role_table();

})

//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
}

function role_table() {
    $("#role_table").bootstrapTable("destroy");
    $("#role_table").bootstrapTable({ // 对应table标签的id
        url: "/basicCenter/FindFarm", // 获取表格数据的url
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
                field: 'workName',
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
function addRole() {
    var id=$("#id_add").val();
    var name=$("#name").val();
    $.ajax({
        url: "/basicCenter/addFarm",
        type: "post",
        dataType: "json",
        data: {
            name:name,
            id:id
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
    $.ajax({
        url: "/basicCenter/UpdateFarm",
        type: "post",
        dataType: "json",
        data: {
            id:id,
            name:name
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
            url: "/basicCenter/deleteFarm/"+id,
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
//点击打开编辑模态框
function updRoleById(id) {
    $.ajax({
        url: "/basicCenter/FindFarmId/"+id,
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

