$(function () {
    //查询种类列表
    getSpeciesList();
    //查询品种列表
    getVarietyList();

    template_table(null);
})


function template_likeForm_querybtn() {
    var formData = $("#user_likeForm").serialize();

    template_table(formData);

}

function template_table(formData) {
    $("#template_table").bootstrapTable("destroy");
    $("#template_table").bootstrapTable({ // 对应table标签的id
        url: "/basicCenter/findTemplate?" + formData, // 获取表格数据的url
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
                title: '种植方案名称'
            }, {
                field: 'categoryName',
                title: '作物种类'
            }, {
                field: 'varietyName',
                title: '作物品种',
            }, {
                title: "操作",
                formatter: function (value, row, index) {
                    var str =
                        "<a href='javascript:updateTemplate(" + row.id + ")' class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-edit\">" +
                        "</i>编辑</a> " +
                        "<a href='javascript:deleteTemplate(" + row.id + ")' class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}


//修改
function updateTemplate(id) {
    $.ajax({
        url: "/basicCenter/updateTemplate",
        type: "post",
        dataType: "json",
        async: false,
        data: {'userId': id},
        success: function (data) {

        },
        error: function () {
            alert("请求失败");
        }
    });
}

//删除
function deleteTemplate(id) {
    if (confirm("确认删除么！！！")) {
        $.ajax({
            url: "/basicCenter/deleteTemplate",
            type: "post",
            dataType: "json",
            async: false,
            data: {'userId': id},
            success: function (data) {
                if (data > 0) {
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


//查询种类列表
function getSpeciesList() {
    $.ajax({
        url: "/basicCenter/getSpeciesList",
        dataType: "json",
        type: "post",
        success: function (data) {
            var html = "<option value=\"\">请选择</option>"
            if (data) {
                speciesList = data;
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
            }
            $("select[name='category']").append(html)
            layui.form.render("select");
        }
    })

}

//查询品种列表
function getVarietyList() {
    $.ajax({
        url: "/basicCenter/getVarietyList",
        dataType: "json",
        type: "post",
        success: function (data) {
            var html = "<option value=\"\">请选择</option>"
            if (data) {
                varietyList = data;
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
            }
            $("select[name='variety']").append(html)
            layui.form.render("select");
        }
    })

}