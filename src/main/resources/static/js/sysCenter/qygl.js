$(function () {
    //1.初始化Table
    enterprise_table();
})
function enterprise_table() {
    $("#enterprise_table").bootstrapTable("destroy");
    $("#enterprise_table").bootstrapTable({ // 对应table标签的id
        url: "/sysCenter/findEnterpriseByPage", // 获取表格数据的url
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
                field: 'name',
                title: '企业名称'
            }, {
                field: 'address',
                title: "地址"
            }, {
                field: 'userNumber',
                title: "用户数量"
            }, {
                field: 'createuserName',
                title: "创建人"
            }, {
                field: 'createtime',
                title: "创建时间"
            }, {
                title: "操作",
                formatter: function (value, row, index) {
                    var str =
                        "<a onclick=\"updRoleById(\'" + row.id + "\')\"  class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-edit\">" +
                        "</i>编辑</a> "
                    return str;
                }
            }
        ]
    })
}

//点击打开新建用户模态框
function addEnterpriseInfo() {
    $("#addEnterpriseInfo_Modal").modal("show");
}

//点击打开编辑用户模态框
function updRoleById(id) {
    $.ajax({
        url: "/sysCenter/findEnterpriseById/"+id,
        type:"post",
        dataType:"json",
        success:function(data){
            console.log(data)
            $("#enterpriseid_up").val(data.id);
            $("#enterprisename_up").val(data.name);
            $("#enterpriseaddress_up").val(data.address);
            $("#enterpriseintro_up").val(data.intro);


            $("#upEnterpriseInfo_Modal").modal("show");
        },error:function(){
            console.log("出错了！");
        }
    });
}





/*添加用户信息*/
function addEnterprise() {
    $.ajax({
        url: "/sysCenter/addEnterprise",
        type: "post",
        dataType: "json",
        data: {

        },
        success: function (data) {
            alert("添加成功！！");
            window.location.reload();
        },
        error: function () {
            alert("请求失败");
        }
    });
}

/*修改用户信息*/
function updateEnterprise() {
    $.ajax({
        url: "/sysCenter/updateEnterprise",
        type: "post",
        dataType: "json",
        data: {

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
