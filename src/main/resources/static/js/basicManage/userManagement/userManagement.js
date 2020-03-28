$(function () {
    //1.初始化Table
    user_table(null);

    findRole();
    findEnterprise();
})

function findRole() {
    $.ajax({
        type: "post",
        url: "/sysCenter/findRole",
        data: {},
        dataType: "json",
        success: function (data) {
            var str = "";
            if (data != null && data.length != 0) {
                $("#role_select_1").children("option:gt(0)").remove();
                $("#role_select_1_up").children("option:gt(0)").remove();
                str = str + "<option value=''>选择角色</option>";
                for (var i = 0; i < data.length; i++) {
                    str = str + "<option value=" + data[i].id + ">" + data[i].roleName + "</option>";
                }
                $("#role_select_1").append(str);
                $("#role_select_1_up").append(str);

            }
        },//请求失败时回调函数
        error: function () {
            alert("失败 ");
        }
    });
}
function findEnterprise() {
    $.ajax({
        type: "post",
        url: "/sysCenter/findEnterprise",
        data: {},
        dataType: "json",
        success: function (data) {
            var str = "";
            if (data != null && data.length != 0) {
                $("#Enterprise_select").children("option:gt(0)").remove();
                $("#Enterprise_select_1").children("option:gt(0)").remove();
                str = str + "<option value=''>选择角色</option>";
                for (var i = 0; i < data.length; i++) {
                    str = str + "<option value=" + data[i].id + ">" + data[i].name + "</option>";
                }
                $("#Enterprise_select").append(str);
                $("#Enterprise_select_1").append(str);
            }
        },//请求失败时回调函数
        error: function () {
            alert("失败 ");
        }
    });
}


function user_table(formData) {
    $("#user_table").bootstrapTable("destroy");
    $("#user_table").bootstrapTable({ // 对应table标签的id
        url: "/sysCenter/findManager?"+formData, // 获取表格数据的url
        method: "get", //请求方式
        cache: false, //关闭缓存
        toolbar: '#toolbar', //工具按钮用哪个容器
        pagination: true, //开启分页
        sidePagination: "server", //客户端分页client,"server"服务端分页
        pageNumber: 1, //分页起始行,默认第一行
        sortName: "id", //排序名
        sortOrder: "asc", //排序方式
        pageSize: 10, //每页几行
        pageList: [10, 20, 30], //设置每页几行的下拉框
        striped: true,       //是否显示行间隔色
        clickToSelect: true, //设置复选框头
        showRefresh: true,   //是否显示刷新按钮
        //请求参数
        queryParams: function (params) { //参数
            return {
                limit: params.limit,// 每页要显示的数据条数
                offset: params.offset,// 每页显示数据的开始行号
                sort: params.sort,// 要排序的字段
                order: params.order,  // 排序规则
            };
        },//返回
        responseHandler: function (data) {
            return {
                "total": data.total,//总页数
                "rows": data.list //返回数据的集合
            };
        },
        columns: [//field对应的是entity中的属性 title:列名
            {
                field: 'id', // 返回json数据中的name
                title: '序号', // 表格表头显示文字
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    return index + 1;
                }
            }, {
                field: 'truename',
                title: '用户姓名'
            }, {
                field: 'tel',
                title: "手机号"
            }, {
                field: 'name',
                title: "所属企业"
            }, {
                field: 'roleName',
                title: "用户角色"
            }, {
                field: 'roleType',
                title: '客户端',
                formatter: function (value, row, index) {
                    if (value == 1) {
                        return 'app'
                    } else if (value == 2) {
                        return 'pc'
                    }else if (value == 3) {
                        return 'app/pc'
                    } else {
                        return '未知'
                    }
                }
            }, {
                field: 'createtime',
                title: "创建时间"
            }, {
                title: "操作",
                formatter: function (value, row, index) {
                    var str =
                        "<a onclick=\"updRoleById(\'" + row.id + "\')\"  class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-edit\">" +
                        "</i>编辑</a> "+
                        "<a onclick=\"deleteManager(\'" + row.id + "\')\"  class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}

function user_likeForm_querybtn() {
    var formData = $("#user_likeForm").serialize();
    user_table(formData);
}
//点击打开新建用户模态框
function addUserInfo() {
    $("#addUserInfo_Modal").modal("show");
}

//点击打开编辑用户模态框
function updRoleById(id) {
    $.ajax({
        url: "/sysCenter/selectUserId/"+id,
        type:"post",
        dataType:"json",
        success:function(data){
            $("#id_up").val(data.id);
            $("#username_up").val(data.truename);
            $("#password_up").val(data.password);
            $("#tel_up").val(data.tel);
            $("#role_select_1_up option").each(function(){
                if($(this).val()==data.roleId){
                    $(this).attr("selected","selected");
                }
            });
            $("#Enterprise_select_1 option").each(function(){
                if($(this).val()==data.enterpriseId){
                    $(this).attr("selected","selected");
                }
            });
            $("#upUserInfo_Modal").modal("show");
        },error:function(){
            console.log("出错了！");
        }
    });
}

function addUserRole() {
    var userName=$("#username").val();
    var password=$("#password").val();
    var roleId=$("#role_select_1").val();
    var id=$("#Enterprise_select").val();
    var tel=$("#tel").val();
    $.ajax({
        url: "/sysCenter/addUser",
        type: "post",
        dataType: "json",
        data: {
            userName:userName,
            password:password,
            roleId:roleId,
            tel:tel,
            id:id
        },
        success: function (data) {
            alert("创建管理员成功！！");
            window.location.reload();
        },
        error: function () {
            alert("请求失败");
        }
    });
}
/*修改用户信息*/
function upUserRoleId() {
    var id=$("#id_up").val();
    var userName=$("#username_up").val();
    var password=$("#password_up").val();
    var roleId=$("#role_select_1_up").val();
    var enterpriseId=$("#Enterprise_select_1").val();
    var tel=$("#tel_up").val();
    $.ajax({
        url: "/sysCenter/upUserId",
        type: "post",
        dataType: "json",
        data: {
            id:id,
            userName:userName,
            password:password,
            roleId:roleId,
            tel:tel,
            enterpriseId:enterpriseId
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
            url: "/sysCenter/deleteUserId/"+id,
            type: "post",
            dataType: "json",
            success: function (data) {
                if(data>0){
                    alert("删除成功！！！");
                    $("#user_table").bootstrapTable("refresh");
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
