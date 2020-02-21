var layer;

$(function () {

    layui.use('layer', function(){
        layer = layui.layer;
    });

    loading_res();

    $("a[lay-]").click
})

//时间设置
function currentTime() {
    var d = new Date(), str = '';
    str += d.getFullYear() + '年';
    str += d.getMonth() + 1 + '月';
    str += d.getDate() + '日';
    str += d.getHours() + '时';
    str += d.getMinutes() + '分';
    str += d.getSeconds() + '秒';
    return str;
}

setInterval(function () {
    $('#time').html(currentTime)
}, 1000);

//加载权限
function loading_res() {
    $.ajax({
        type: "post",
        url: "/user/loading_res",
        data: {},
        dataType: "json",
        error: function (error) {
            layer.alert('加载失败！', {
                title: '提示框',
                icon: 0,
            });
        }, success: function (data) {
            var str ="";
            for (var i = 0; i < data.length; i++) {
                str = str +"<li class=\"layui-nav-item\">\n" +
                    "                        <a href=\"javascript:;\" lay-tips='"+data[i].resname+"'>\n" +
                    "                               <i class='layui-icon "+data[i].icon+"'></i> "+
                    "                            <cite>"+data[i].resname+"</cite>\n" +
                    "                        </a>"
                if(data[i].resList.length!=0){
                    str = str + "<dl class='layui-nav-child'>";
                    for (var j = 0; j < data[i].resList.length; j++) {

                        if(data[i].resList[j].info=="productionManagement"){
                            str = str + "<dd><a onclick='productionManagement()'>"+data[i].resList[j].resname+"</a></dd>";

                            continue;
                        }

                        //访问拼接路径
                        var href = data[i].info+"/"+data[i].resList[j].info+".jsp";
                        str = str + "<dd><a lay-href='"+href+"'>"+data[i].resList[j].resname+"</a></dd>";
                    }
                    str = str + "</dl>"
                }
                str = str + "</li>"
            }
            $("#LAY-system-side-menu").append(str);
        }
    });
}


