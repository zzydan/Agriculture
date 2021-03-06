var form = layui.form;

//生育周期的数据
var sysq_data=[];
//农事数据
var ns_data=[];
//农资类别数据
var nzcategory_data=['肥料','农药','机械','滴灌带','其他'];
//农资数据
var nz_data=[];

$(function () {
    //查询种类列表
    getSpeciesList();
    //查询所有农事
    getWorkList();
    //查询所有农资信息
    getAgricList();
    //加载表
    template_table(null);
})

//查询种类列表
function getSpeciesList() {
    $.ajax({
        url: "/basicCenter/getSpeciesList",
        dataType: "json",
        type: "post",
        success: function (data) {
            var html = "<option value=''>请选择</option>"
            if (data) {
                speciesList = data;
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
            }
            $("#category_like").append(html);
            $("#category_add").append(html);
        }
    })

}
//查询品种列表
function getVarietyList_like() {

    var id = $("#category_like").children("option:selected").val();

    $.ajax({
        url: "/basicCenter/getVarietyListBySpeciesId",
        dataType: "json",
        data: {'SpeciesId': id},
        type: "post",
        success: function (data) {
            $("#variety_like").empty();

            var html = "<option value=\"\">请选择</option>"
            if (data) {
                varietyList = data;
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
            }
            $("#variety_like").append(html)
            layui.form.render("select");
        }
    })

}
//查询所有农事
function getWorkList() {
    $.ajax({
        url: "/basicCenter/getWorkList",
        dataType: "json",
        type: "post",
        async : false,
        data: {},
        success: function (data) {
            ns_data = data;
        }
    })
}
//查询所有农资信息
function getAgricList() {
    $.ajax({
        url: "/basicCenter/getAgricList",
        dataType: "json",
        type: "post",
        async : false,
        data: {},
        success: function (data) {
            nz_data = data;
        }
    })
}
//查询作物品种的周期
function getCrop_growth_cycle() {
    var modal_name = $("#modal_name").val();
    if(modal_name=="add"){
        var category_id = $("#category_add").children("option:selected").val();
        var variety_id = $("#variety_add").children("option:selected").val();
    }
    if(modal_name=="update"){
        var category_id = $("#category_update").children("option:selected").val();
        var variety_id = $("#variety_update").children("option:selected").val();
    }
    $.ajax({
        url: "/basicCenter/getCropGrowthCycleList",
        dataType: "json",
        type: "post",
        async : false,
        data: {'speciesId': category_id,'varietyId': variety_id},
        success: function (data) {
            sysq_data = data;
        }
    })
}


//模糊查询
function template_likeForm_querybtn() {
    var formData = $("#template_likeForm").serialize();

    template_table(formData);
}
//模板表格
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
                        "<a href='javascript:findTemplateById(" + row.id + ")' class=\"layui-btn layui-btn-normal layui-btn-xs\" lay-event=\"edit\">" +
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


//模板计划表
function templatePlan_table() {
    $("#templatePlan_table").bootstrapTable("destroy");
    $("#templatePlan_table").bootstrapTable({ // 对应table标签的id
        cache: false, //关闭缓存
        pagination: true, //开启分页
        sidePagination: "client", //客户端分页client,"server"服务端分页
        pageNumber: 1, //分页起始行,默认第一行
        pageSize: 10, //每页几行
        pageList: [10], //设置每页几行的下拉框
        striped: true,       //是否显示行间隔色
        columns: [//field对应的是entity中的属性 title:列名
            {
                field: 'index', // 返回json数据中的name
                title: '序号', // 表格表头显示文字
                width : 100,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    row.index = index;
                    return index + 1;
                }
            }, {
                field: 'sysq',
                title: '生育时期',
                width : 160,
                formatter: function (value, row, index) {// selNumber'+ row.registerId + '
                    //向模板计划表格中添加生育周期下拉框
                    var sysq_option = "<select onchange='upPlansysq(" + JSON.stringify(row) + ")' class='form-control' name='sysq'><option value=\"\">请选择</option>"
                    if (sysq_data) {
                        $.each(sysq_data, function (a, b) {
                            if(value == b.id){
                                sysq_option += " <option selected value=\"" + b.id + "\">" + b.sysqmc + "</option>"
                            }else {
                                sysq_option += " <option value=\"" + b.id + "\">" + b.sysqmc + "</option>"
                            }

                        })
                    }
                    sysq_option += "</select>"

                    return sysq_option;
                }
            }, {
                field: 'ns',
                title: '农事',
                width : 160,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    //向模板计划表格中添加生育周期下拉框
                    var ns_option = "<select onchange='upPlanns(" + JSON.stringify(row) + ")' class='form-control' name='ns'><option value=\"\">请选择</option>"
                    if (ns_data) {
                        $.each(ns_data, function (a, b) {
                            if(value == b.workId){
                                ns_option += " <option selected value=\"" + b.workId + "\">" + b.workName + "</option>"
                            }else {
                                ns_option += " <option value=\"" + b.workId + "\">" + b.workName + "</option>"
                            }

                        })
                    }
                    ns_option += "</select>"

                    return ns_option;
                }
            }, {
                field: 'nzNumber',
                title: '农资',
                width : 100,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    var str = "";
                    if(value!=""){
                        str = str + "<input type='button' name='nzNumber' value='"+value+
                            "' onclick='showAgricListInfo_Modal("+index+","+JSON.stringify(row.templatePlanAgriculturalList)+")' class='layui-input'>";
                    }else {
                        str = str + "<input type='button' name='nzNumber' value='请选择' " +
                            "onclick='showAgricListInfo_Modal("+index+","+null+")' class='layui-input'>";
                    }

                    return str;
                }
            }, {
                field: 'title',
                title: '农事操作说明',
                width : 500,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    var str = "";

                    str = str + "<input type='text' name='title' value='" + row.title + "' " +
                        "placeholder='请输入' onchange='upPlantitle(" + JSON.stringify(row) + ")' class='layui-input'>";

                    return str;
                }
            }, {
                title: "操作",
                width : 215,
                formatter: function (value, row, index) {
                    var str =
                        "<a href='javascript:addPlanToTable()' class=\"layui-btn layui-btn-info layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-add-1\">" +
                        "</i>新增</a> " +
                        "<a href='javascript:deletePlan(" + index + ")' class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}
//修改表格中生育时期
function upPlansysq(object) {
    var value = $("#templatePlan_table tr[data-index='" + object.index + "'] select[name='sysq']").find("option:selected").val();

    object.sysq = value;

    $("#templatePlan_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改表格中农事
function upPlanns(object) {
    var value = $("#templatePlan_table tr[data-index='" + object.index + "'] select[name='ns']").find("option:selected").val();

    object.ns = value;

    $("#templatePlan_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改表格中农事操作说明
function upPlantitle(object) {
    var value = $("#templatePlan_table tr[data-index='" + object.index + "'] input[name='title']").val();

    object.title = value;

    var rows = {
        index : object.index, //更新列所在行的索引
        field : "title", //要更新列的field
        value : value //要更新列的数据
    }//更新表格数据
    $('#templatePlan_table').bootstrapTable("updateCell",rows);

    //$("#templatePlan_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//创建一个全新table对象
function createPlans(index, sysq, ns, templatePlanAgriculturalList, nzNumber, title) {
    var obj = new Object();
    obj.index = index;
    obj.sysq = sysq;
    obj.ns = ns;
    obj.templatePlanAgriculturalList = templatePlanAgriculturalList;
    obj.nzNumber = nzNumber;
    obj.title = title;
    return obj;
}
//添加信息到table表中
function addPlanToTable() {

    var obj = createPlans('', '', '', '', '', '');

    $("#templatePlan_table").bootstrapTable("append", obj);

}
//删除计划表的某一行
function deletePlan(index) {
    // 声明一个数组
    var arrays = new Array();
    arrays.push(parseInt(index));
    //根据id移除数据
    $("#templatePlan_table").bootstrapTable("remove", {field: 'index', values: arrays});
}
//打开添加模板模态框
function addTemplateInfo() {

    document.getElementById("template_Form").reset();

    $("#addTemplateInfo_Modal").modal("show");
    $("#modal_name").val("add");

    templatePlan_table();
}
//添加模板信息
function addTemplateData() {
    //获取数据
    var template_Form =$("#template_Form").serialize();
    var templatePlanTableData =JSON.stringify($("#templatePlan_table").bootstrapTable("getData"));

    $.ajax({
        url: "/basicCenter/addTemplate?"+template_Form,
        type: "post",
        dataType:"json",
        async: false,
        data: {"templatePlanData":templatePlanTableData},
        success: function (data) {

            $("#addTemplateInfo_Modal").modal("hide");

            $('#template_table').bootstrapTable("refresh");

            alert("新建成功！");


        },
        error: function () {
            alert("请求失败");
        }
    });
}
//查询品种列表
function getVarietyList_add() {

    var id = $("#category_add").children("option:selected").val();

    $.ajax({
        url: "/basicCenter/getVarietyListBySpeciesId",
        dataType: "json",
        data: {'SpeciesId': id},
        type: "post",
        success: function (data) {
            $("#variety_add").empty();

            var html = "<option value=\"\">请选择</option>"
            if (data) {
                varietyList = data;
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
            }
            $("#variety_add").append(html)
            layui.form.render("select");
        }
    })

}
//加载添加模板表
function onUploadTable() {
    //加载作物品种周期
    getCrop_growth_cycle();

    //更新表格
    $("#templatePlan_table").bootstrapTable("removeAll");

    addPlanToTable();
}



//显示农资信息模态框
function showAgricListInfo_Modal(index,object) {

    //打开模态框
    $("#agricListInfo_Modal").modal("show");
    //保存下标
    $("#template_table_index").val(index);

    //加载农资表格
    agricList_table();

    //更新表格
    $("#agricList_table").bootstrapTable("removeAll");
    console.log(object)
    //添加信息
    if(object != null){
        addNZToTable2(object);
    }else {
        addNZToTable();
    }

}
//打开农资模态框
function agricList_table() {
    $("#agricList_table").bootstrapTable("destroy");
    $("#agricList_table").bootstrapTable({ // 对应table标签的id
        cache: false, //关闭缓存
        pagination: true, //开启分页
        sidePagination: "client", //客户端分页client,"server"服务端分页
        pageNumber: 1, //分页起始行,默认第一行
        sortName: "id", //排序名
        sortOrder: "asc", //排序方式
        pageSize: 10, //每页几行
        pageList: [10], //设置每页几行的下拉框
        striped: true,       //是否显示行间隔色
        columns: [//field对应的是entity中的属性 title:列名
            {
                field: 'index', // 返回json数据中的name
                title: '序号', // 表格表头显示文字
                width : 80,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算

                    row.index = index;

                    return index + 1;
                }
            }, {
                field: 'trxfl',
                title: '投入项分类',
                width : 160,
                formatter: function (value, row, index) {
                    //向模板计划表格中添加投入项分类下拉框
                    var nzCategory_option = "<select onchange='upNZcategory(" + JSON.stringify(row) + ")' class='form-control' name='category'><option value=\"\">请选择</option>"
                    if (nzcategory_data) {
                        for (var i = 0 ;i < nzcategory_data.length;i++){
                            if(value == nzcategory_data[i]){
                                nzCategory_option += " <option selected value=\"" + nzcategory_data[i] + "\">" + nzcategory_data[i] + "</option>"
                            }else {
                                nzCategory_option += " <option value=\"" + nzcategory_data[i] + "\">" + nzcategory_data[i] + "</option>"
                            }
                        }
                    }
                    nzCategory_option += "</select>"

                    return nzCategory_option;
                }
            }, {
                field: 'nzmc',
                title: '农资名称',
                width : 160,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    //向模板计划表格中添加投入项分类下拉框
                    var nzName_option = "<select onchange='upNZname(" + JSON.stringify(row) + ")' class='form-control' name='name'><option value=\"\">请选择</option>"
                    if (nz_data) {
                        for (var i = 0 ;i < nz_data.length;i++){
                            if(row.trxfl == nz_data[i].category){
                                if(value == nz_data[i].name){
                                    nzName_option += " <option selected value=\"" + nz_data[i].unitMeasurement + "\">" + nz_data[i].name + "</option>"
                                }else {
                                    nzName_option += " <option value=\"" + nz_data[i].unitMeasurement + "\">" + nz_data[i].name + "</option>"
                                }
                            }
                        }

                    }
                    nzName_option += "</select>"

                    return nzName_option;
                }
            }, {
                field: 'yl',
                title: '用量',
                width : 320,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    var str = "";

                    str = str + "<input type='text' style='width: 240px;' name='unitMeasurement_danwei' value='" + value + "' " +
                        "placeholder='请输入' onchange='upNZunitMeasurement(" + JSON.stringify(row) + ")' class='layui-input layui-input-inline'>"+
                        "<span style='width: 80px'>"+row.danwei+"</span>";

                    return str;
                }
            }, {
                title: "操作",
                width : 200,
                formatter: function (value, row, index) {
                    var str =
                        "<a href='javascript:addNZToTable()' class=\"layui-btn layui-btn-info layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-add-1\">" +
                        "</i>新增</a> " +
                        "<a href='javascript:deleteNZ(" + index + ")' class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}
//修改农资表格中投入项类别
function upNZcategory(object) {
    var value = $("#agricList_table tr[data-index='" + object.index + "'] select[name='category']").find("option:selected").text();

    object.trxfl = value;
    object.danwei = '';

    $("#agricList_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改农资表格中农资名称
function upNZname(object) {
    var value = $("#agricList_table tr[data-index='" + object.index + "'] select[name='name']").find("option:selected").text();
    var danwei = $("#agricList_table tr[data-index='" + object.index + "'] select[name='name']").find("option:selected").val();

    object.nzmc = value;
    object.danwei = danwei;
    $("#agricList_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改农资表格中的投入量
function upNZunitMeasurement(object) {
    var value = $("#agricList_table tr[data-index='" + object.index + "'] input[name='unitMeasurement_danwei']").val();

    object.yl = value;

    $("#agricList_table").bootstrapTable('updateRow', {index: object.index, row: object});
}
//创建农资对象
function createNZObject(index, trxfl, nzmc, yl,danwei) {
    var obj = new Object();
    obj.index = index;
    obj.trxfl = trxfl;
    obj.nzmc = nzmc;
    obj.yl = yl;
    obj.danwei = danwei;
    return obj;
}
//添加农资信息到表格
function addNZToTable() {

    var obj = createNZObject('', '', '', '','');

    $("#agricList_table").bootstrapTable("append", obj);
}
//添加农资信息到表格
function addNZToTable2(templatePlanAgriculturalList) {
    for (var i = 0; i < templatePlanAgriculturalList.length; i++) {
        var obj = createNZObject('', templatePlanAgriculturalList[i].trxfl, templatePlanAgriculturalList[i].nzmc, templatePlanAgriculturalList[i].yl,templatePlanAgriculturalList[i].danwei);

        $("#agricList_table").bootstrapTable("append", obj);
    }
}
//删除计划表的某一行
function deleteNZ(index) {
    // 声明一个数组
    var arrays = new Array();
    arrays.push(parseInt(index));
    //根据id移除数据
    $("#agricList_table").bootstrapTable("remove", {field: 'index', values: arrays});
}
//将农资信息保存到计划表中
function addAgricListData() {
    //总共多少行数据
    var agricTableData=$('#agricList_table').bootstrapTable('getData');

    //验证数据是否填写完毕

    //总共多少行数据
    var row=$("#agricList_table").bootstrapTable("getData").length;

    var index = $("#template_table_index").val();
    var modal_name = $("#modal_name").val();
    if(modal_name=="add"){
        var object = $("#templatePlan_table").bootstrapTable("getRowByIndex",index);

        object.templatePlanAgriculturalList = agricTableData;
        object.nzNumber = row;

        $("#templatePlan_table").bootstrapTable('updateRow', {index: object.index, row: object});
    }
    if(modal_name=="update"){
        var object = $("#templatePlan_table_update").bootstrapTable("getRowByIndex",index);

        object.templatePlanAgriculturalList = agricTableData;
        object.nzNumber = row;

        $("#templatePlan_table_update").bootstrapTable('updateRow', {index: object.index, row: object});
    }

    $("#agricListInfo_Modal").modal("hide");
}


//回显数据
function findTemplateById(id) {
    var template;
    $.ajax({
        url: "/basicCenter/findTemplateById",
        type: "post",
        dataType: "json",
        async: false,
        data: {'templateId': id},
        success: function (data) {
            template = data;
        },
        error: function () {
            alert("请求失败");
        }

    });

    $("#upTemplateInfo_Modal").modal("show");
    $("#modal_name").val("update");
    //加载基本信息
    $("#template_id").val(template.id);
    $("#name_update").val(template.name);
    getSpeciesList_up(template.category);
    getVarietyList_update(template.category,template.variety);

    //加载生育周期
    getCrop_growth_cycle_update(template.category,template.variety);

    //加载计划表
    templatePlan_table_update();
    addPlanToTable_update(template.templatePlanList);

}
//查询作物品种的周期
function getCrop_growth_cycle_update(category,variety) {
    $.ajax({
        url: "/basicCenter/getCropGrowthCycleList",
        dataType: "json",
        type: "post",
        async : false,
        data: {'speciesId': category,'varietyId': variety},
        success: function (data) {
            sysq_data = data;
        }
    })
}
//模板计划表
function templatePlan_table_update() {
    $("#templatePlan_table_update").bootstrapTable("destroy");
    $("#templatePlan_table_update").bootstrapTable({ // 对应table标签的id
        cache: false, //关闭缓存
        pagination: true, //开启分页
        sidePagination: "client", //客户端分页client,"server"服务端分页
        pageNumber: 1, //分页起始行,默认第一行
        pageSize: 10, //每页几行
        pageList: [10], //设置每页几行的下拉框
        striped: true,       //是否显示行间隔色
        columns: [//field对应的是entity中的属性 title:列名
            {
                field: 'index', // 返回json数据中的name
                title: '序号', // 表格表头显示文字
                width : 100,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    row.index = index;
                    return index + 1;
                }
            }, {
                field: 'sysq',
                title: '生育时期',
                width : 160,
                formatter: function (value, row, index) {// selNumber'+ row.registerId + '
                    //向模板计划表格中添加生育周期下拉框
                    var sysq_option = "<select onchange='upPlansysq_update(" + JSON.stringify(row) + ")' class='form-control' name='sysq'><option value=\"\">请选择</option>"
                    if (sysq_data) {
                        $.each(sysq_data, function (a, b) {
                            if(value == b.id){
                                sysq_option += " <option selected value=\"" + b.id + "\">" + b.sysqmc + "</option>"
                            }else {
                                sysq_option += " <option value=\"" + b.id + "\">" + b.sysqmc + "</option>"
                            }

                        })
                    }
                    sysq_option += "</select>"

                    return sysq_option;
                }
            }, {
                field: 'ns',
                title: '农事',
                width : 160,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    //向模板计划表格中添加生育周期下拉框
                    var ns_option = "<select onchange='upPlanns_update(" + JSON.stringify(row) + ")' class='form-control' name='ns'><option value=\"\">请选择</option>"
                    if (ns_data) {
                        $.each(ns_data, function (a, b) {
                            if(value == b.workId){
                                ns_option += " <option selected value=\"" + b.workId + "\">" + b.workName + "</option>"
                            }else {
                                ns_option += " <option value=\"" + b.workId + "\">" + b.workName + "</option>"
                            }

                        })
                    }
                    ns_option += "</select>"

                    return ns_option;
                }
            }, {
                field: 'nzNumber',
                title: '农资',
                width : 100,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    var str = "";
                    if(value!=""){
                        str = str + "<input type='button' name='nzNumber' value='"+value+
                            "' onclick='showAgricListInfo_Modal("+index+","+JSON.stringify(row.templatePlanAgriculturalList)+")' class='layui-input'>";
                    }else {
                        str = str + "<input type='button' name='nzNumber' value='请选择' " +
                            "onclick='showAgricListInfo_Modal("+index+","+null+")' class='layui-input'>";
                    }

                    return str;
                }
            }, {
                field: 'title',
                title: '农事操作说明',
                width : 500,
                formatter: function (value, row, index) {//单元格格式化函数，有三个参数：value： 该列的字段值；row： 这一行的数据对象；index： 行号，第几行，从0开始计算
                    var str = "";

                    str = str + "<input type='text' name='title' value='" + row.title + "' " +
                        "placeholder='请输入' onchange='upPlantitle_update(" + JSON.stringify(row) + ")' class='layui-input'>";

                    return str;
                }
            }, {
                title: "操作",
                width : 215,
                formatter: function (value, row, index) {
                    var str =
                        "<a href='javascript:addPlanToTable_update2()' class=\"layui-btn layui-btn-info layui-btn-xs\" lay-event=\"edit\">" +
                        "<i  class=\"layui-icon layui-icon-add-1\">" +
                        "</i>新增</a> " +
                        "<a href='javascript:deletePlan2(" + index + ")' class=\"layui-btn layui-btn-danger layui-btn-xs\" lay-event=\"del\">" +
                        "<i class=\"layui-icon layui-icon-delete\">" +
                        "</i>删除</a> ";
                    return str;
                }
            }
        ]
    })
}
//修改表格中生育时期
function upPlansysq_update(object) {
    var value = $("#templatePlan_table_update tr[data-index='" + object.index + "'] select[name='sysq']").find("option:selected").val();

    object.sysq = value;

    $("#templatePlan_table_update").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改表格中农事
function upPlanns_update(object) {
    var value = $("#templatePlan_table_update tr[data-index='" + object.index + "'] select[name='ns']").find("option:selected").val();

    object.ns = value;

    $("#templatePlan_table_update").bootstrapTable('updateRow', {index: object.index, row: object});
}
//修改表格中农事操作说明
function upPlantitle_update(object) {
    var value = $("#templatePlan_table_update tr[data-index='" + object.index + "'] input[name='title']").val();

    object.title = value;

    var rows = {
        index : object.index, //更新列所在行的索引
        field : "title", //要更新列的field
        value : value //要更新列的数据
    }//更新表格数据
    $('#templatePlan_table_update').bootstrapTable("updateCell",rows);
}
//添加信息到修改信息table表中
function addPlanToTable_update(list) {
    for (var i = 0; i <list.length ; i++) {
        var obj = createPlans('', list[i].sysq, list[i].ns, list[i].templatePlanAgriculturalList, list[i].templatePlanAgriculturalList.length, list[i].title);
        $("#templatePlan_table_update").bootstrapTable("append", obj);
    }
}
//加载添加模板表
function onUploadTable_update() {
    //加载作物品种周期
    getCrop_growth_cycle();

    //更新表格
    $("#templatePlan_table_update").bootstrapTable("removeAll");

    addPlanToTable_update2();
}
//添加信息到table表中
function addPlanToTable_update2() {

    var obj = createPlans('', '', '', '', '', '');

    $("#templatePlan_table_update").bootstrapTable("append", obj);

}
//删除计划表的某一行
function deletePlan2(index) {
    // 声明一个数组
    var arrays = new Array();
    arrays.push(parseInt(index));
    //根据id移除数据
    $("#templatePlan_table_update").bootstrapTable("remove", {field: 'index', values: arrays});
}
//查询种类列表
function getSpeciesList_up(category) {
    $.ajax({
        url: "/basicCenter/getSpeciesList",
        dataType: "json",
        type: "post",
        success: function (data) {
            var html = "<option value=''>请选择</option>"
            if (data) {
                speciesList = data;
                for (var i = 0; i <data.length ; i++) {
                    if(parseInt(category) == parseInt(data[i].id)){
                        html += "<option selected value=\"" + data[i].id + "\">" + data[i].name + "</option>"
                    }else {
                        html += "<option value=\"" + data[i].id + "\">" + data[i].name + "</option>"
                    }
                }
            }
            $("#category_update").append(html)
        }
    })

}
//查询品种列表
function getVarietyList_update(category,variety) {
    var category_id =$("#category_update").val();

    if(category_id!=null){
        category = category_id;
    }
    $.ajax({
        url: "/basicCenter/getVarietyListBySpeciesId",
        dataType: "json",
        data: {'SpeciesId': category},
        type: "post",
        success: function (data) {
            $("#variety_update").empty();
            var html = "<option value=\"\">请选择</option>"
            if (data) {
                varietyList = data;
                for (var i = 0; i <data.length ; i++) {
                    if(parseInt(variety) == parseInt(data[i].id)){
                        html += "<option selected value=\"" + data[i].id + "\">" + data[i].name + "</option>"
                    }else {
                        html += "<option value=\"" + data[i].id + "\">" + data[i].name + "</option>"
                    }
                }
            }
            $("#variety_update").append(html)
            layui.form.render("select");
        }
    })
}
//修改保存
function updateTemplate() {
//获取数据
    var template_Form =$("#template_Form_update").serialize();
    var templatePlanTableData =JSON.stringify($("#templatePlan_table_update").bootstrapTable("getData"));

    $.ajax({
        url: "/basicCenter/updateTemplate?"+template_Form,
        type: "post",
        dataType:"json",
        async: false,
        data: {"templatePlanData":templatePlanTableData},
        success: function (data) {

            $("#upTemplateInfo_Modal").modal("hide");

            $('#template_table').bootstrapTable("refresh");

            alert("修改成功！");
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
            data: {'templateId': id},
            success: function (data) {
                if (data > 0) {
                    alert("删除成功！！！");
                    $("#template_table").bootstrapTable("refresh");
                }
            },
            error: function () {
                alert("请求失败");
            }
        });
    }
}




