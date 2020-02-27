<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/static/js/basicManage/fenChangManage/fenChangList.js"></script>
<div class="layui-fluid" style="height: 50%">
    <div class="layui-card">
        <div class="panel-body">

            <div id="toolbar" class="btn-group" style="margin-top:5px;padding-left:1500px;">
                <button id="btn_add" type="button" class="layui-btn" onclick="addFenChang()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
            </div>
            <div style="margin-top: 10px">
                <table id="fenChang_table"></table>
            </div>

        </div>
    </div>
</div>
<script>
    $(function () {
        fenChang_table()
    })
    function addFenChang() {
        window.location.href="./addFenChang.jsp"
    }
    //显示分场列表的方法
    function fenChang_table() {
        $("#fenChang_table").bootstrapTable("destroy");
        $("#fenChang_table").bootstrapTable({ // 对应table标签的id
            url: "/basicCenter/getFenChangList", // 获取表格数据的url
            pagination:true,
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
                            "<a onclick=\"updateFenChang(\'" + row.id + "\')\"  class=\"layui-btn\" lay-event=\"edit\">" +
                            "<i  class=\"layui-icon layui-icon-edit\">" +
                            "</i>编辑</a> "+
                            "<a onclick=\"deleteManager(\'" + row.id + "\')\"  class=\"layui-btn\" lay-event=\"del\">" +
                            "<i class=\"layui-icon layui-icon-delete\">" +
                            "</i>删除</a> ";
                        return str;
                    }
                }
            ]
        })
    }
    function updateFenChang(id) {
        window.location.href="./updateFenChang.jsp?id="+id;
    }
</script>

