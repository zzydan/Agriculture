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
            $("#enterpriseid_up").val(data.id);
            $("#enterprisename_up").val(data.name);
            $("#enterpriseaddress_up").val(data.address);
            $("#enterpriseintro_up").val(data.intro);
            $("#enterprisefiliale_up").val(data.filiale);
            $("#enterprisefilialeCenter_up").val(data.filialeCenter);
            $("#enterprisemapperUser1_up").val(data.mapperUser1);
            $("#enterprisemapperUser2_up").val(data.mapperUser2);
            $("#enterprisemapperUser3_up").val(data.mapperUser3);


            $("#upEnterpriseInfo_Modal").modal("show");
        },error:function(){
            console.log("出错了！");
        }
    });
}


/*添加用户信息*/
function addEnterprise() {


    var name=$("#enterprisename_add").val();
    var address=$("#enterpriseaddress_add").val();
    var intro=$("#enterpriseintro_add").val();
    var longitude=$("#longitude_add").val();
    var latitude=$("#latitude_add").val();
    var filiale=$("#enterprisefiliale_add").val();
    var filialeCenter=$("#enterprisefilialeCenter_add").val();

    var mapperUser1=$("#enterprisemapperUser1_add").val();
    var mapperUser2=$("#enterprisemapperUser2_add").val();
    var mapperUser3=$("#enterprisemapperUser3_add").val();

    var formData = new FormData();
    formData.append('name', name);
    formData.append('address', address);
    formData.append('intro', intro);
    formData.append('longitude', longitude);
    formData.append('latitude', latitude);
    formData.append('filiale', filiale);
    formData.append('filialeCenter', filialeCenter);
    formData.append('mapperUser1', mapperUser1);
    formData.append('mapperUser2', mapperUser2);
    formData.append('mapperUser3', mapperUser3);

    //1.获取图片的数据
    var User1Pic=$("#enterprisemapperUser1Pic_add").attr("src");
    if(User1Pic!= null){
        //2.把二进制的图片数据转为Blob对象
        var User1Pic_blob = processData(User1Pic);
        formData.append('User1Pic', User1Pic_blob);
    }
    //1.获取图片的数据
    var User2Pic=$("#enterprisemapperUser2Pic_add").attr("src");
    if(User2Pic!= null){
        //2.把二进制的图片数据转为Blob对象
        var User2Pic_blob = processData(User2Pic);
        formData.append('User2Pic', User2Pic_blob);
    }
    //1.获取图片的数据
    var User3Pic=$("#enterprisemapperUser3Pic_add").attr("src");
    if(User3Pic!= null){
        //2.把二进制的图片数据转为Blob对象
        var User3Pic_blob = processData(User3Pic);
        formData.append('User3Pic', User3Pic_blob);
    }

    $.ajax({
        url: "/sysCenter/addEnterprise",
        type: "post",
        dataType: "json",
        data: formData,
        processData: false,
        contentType: false,
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


