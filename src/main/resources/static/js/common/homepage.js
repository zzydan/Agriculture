layui.use(['index', 'carousel', 'form'], function () {
    var carousel = layui.carousel
        , form = layui.form;

    //常规轮播
    carousel.render({
        elem: '#test-carousel-normal'
        , arrow: 'always'
        , width: 'auto'
        , height: '400px'
    });
})


// 基于准备好的dom，初始化echarts实例
var myChart1 = echarts.init(document.getElementById('main'));
var myChart2 = echarts.init(document.getElementById('main2'));
//声明一个全局数组 用于加载echarts数据
var originalDataName = [];
var originalDataCount = [];

$(function () {
    var sbfh_date = new Date(), sbfh_dateFirst = '', sbfh_dateLast = '';
    var sbfh_year = sbfh_date.getFullYear();
    //格式化月，如果小于9，前面补0
    var sbfh_month = ("0" + (sbfh_date.getMonth() + 1)).slice(-2);
    //格式化日，如果小于9，前面补0
    var sbfh_day = ("0" + sbfh_date.getDate()).slice(-2);
    sbfh_dateFirst = sbfh_year + "-" + sbfh_month + "-01";
    sbfh_dateLast = sbfh_year + "-" + sbfh_month + "-" + sbfh_day;
    //将默认的时间赋值给input框
    $("#sbfh_dateFirst").val(sbfh_dateFirst);
    $("#sbfh_dateLast").val(sbfh_dateLast);

    //统计时间失焦时间
    // $("#sbfh_dateFirst").blur(function () {
    //     echarts_sbfh();
    // });
    // $("#sbfh_dateLast").blur(function () {
    //     echarts_sbfh();
    // });


    // $.ajax({
    //     url: "//",
    //     type: "post",
    //     dataType: "json",
    //     async: false,
    //     data: {"sbfh_dateFirst":sbfh_dateFirst,"sbfh_dateLast":sbfh_dateLast},
    //     success: function (data) {
    //
    //         for(var k in data){
    //             originalDataName_sbfh.push(k);
    //             originalDataCount_sbfh.push(data[k]);
    //         }
    //         histogram_sbfh(originalDataName_sbfh,originalDataCount_sbfh);
    //     },
    //     error: function () {
    //         alert("请求失败");
    //     }
    // });

    //paixu();
})

function paixu() {
    $.ajax({
        url: "/homePage/findAllGoodsNum",
        type: "post",
        dataType: "json",
        data: {},
        success: function (data) {

        },
        error: function () {
            alert("请求失败");
        }
    });

}

//加载echarts图标
function echarts_sbfh() {
    myChart1.clear();
    var sbfh_dateFirst = $("#sbfh_dateFirst").val();
    var sbfh_dateLast = $("#sbfh_dateLast").val();

    $.ajax({
        url: "/sbzt/getsbfhById",
        type: "post",
        dataType: "json",
        async: false,
        data: {"sbfh_dateFirst": sbfh_dateFirst, "sbfh_dateLast": sbfh_dateLast},
        success: function (data) {
            originalDataName_sbfh = [];
            originalDataCount_sbfh = [];
            for (var k in data) {
                originalDataName_sbfh.push(k);
                originalDataCount_sbfh.push(data[k]);
            }
            histogram_sbfh(originalDataName_sbfh, originalDataCount_sbfh);

        },
        error: function () {
            alert("请求失败");
        }
    });
}

//柱状图
function histogram_sbfh(originalDataName_sbfh, originalDataCount_sbfh) {

    // 指定图表的配置项和数据
    option = {
        title: {
            text: '设备负荷率统计报告',
            x: 'center'
        },
        tooltip: {
            trigger: 'axis',
        },
        xAxis: {
            type: 'category',
            data: originalDataName_sbfh,
            name: '设备名称',
        },
        yAxis: {
            type: 'value',
            max: 100,
            axisLabel: {
                show: true,
                interval: 'auto',
                formatter: '{value}%'
            },
        },
        dataZoom: [
            {
                type: 'slider',
                show: true,
                xAxisIndex: [0],
                start: 1,
                end: 35
            }, {
                type: 'inside',
                xAxisIndex: [0],
                start: 1,
                end: 35
            }

        ],
        series: [{
            data: originalDataCount_sbfh,
            type: 'bar',
            name: '设备负荷率',
            itemStyle: {
                normal: {
                    color: '#4ad2ff'
                }
            }
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart2.setOption(option);
}