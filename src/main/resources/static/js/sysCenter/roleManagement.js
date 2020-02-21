$(function () {
    role_table();
})

//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
    findRes();
}


function role_table() {
    $("#role_table").bootstrapTable("destroy");
    $("#role_table").bootstrapTable({ // 对应table标签的id
        url: "/usermanager/findRole", // 获取表格数据的url
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
                field: 'rolename',
                title: '角色名称'
            }, {
                field: 'rolecode',
                title: '角色编号'
            }, {
                field: 'info',
                title: '角色描述',
            }, {
                field: 'type',
                title: "角色类别",
                formatter: function (value, row, index) {
                    if(value=="dept"){
                        return "部门";
                    }else if(value=="user"){
                        return "用户";
                    }
                }
            }, {
                title: "操作",
                formatter: function (value, row, index) {
                    var str =
                        "<a href='javascript:updateRole(" + row.id + ")' class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-edit\">" +
                        "</i>编辑</a> " +
                        "<a href='javascript:deleteRole(" + row.id + ")' class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
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

//添加角色
function addRole() {
    var rolename = $("#rolename");
    if (!rolename.val()) {
        isError(rolename, "请输入角色信息");
        return false;
    }
    isOk(rolename, "角色信息通过");
    var rolecode = $("#rolecode");
    if (!rolecode.val()) {
        isError(rolecode, "角色编码不能为空");
        return false;
    }
    isOk(rolecode, "角色编码信息通过");

    var voio = $("#roleForm").serialize();

    $.ajax({
        url: "/usermanager/addRoleAndRes",
        type: "post",
        dataType: "json",
        data: voio,
        success: function (data) {

            layer.alert("创建角色成功！！");

            window.location.reload();

        },
        error: function () {
            layer.alert("请求失败");
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