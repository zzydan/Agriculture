$(function () {
    getFenChangListByUser();

})

//预加载查询分场信息
function getFenChangListByUser() {
    $.ajax({
        url: "/productCenter/getFenChangListByUser",
        dataType: "json",
        type: "post",
        success: function (data) {
            if (data) {
                var html = "";
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
                $("#parvialfield").append(html);//分场列表条件查询
                layui.form.render("select");
                getSpeciesrByFenChang(data[0].id);
            }
        }
    })
}
function changeSpeciesrByFenChang() {
    getSpeciesrByFenChang($("#parvialfield").val());
}
//预加载查询作物品种
function getSpeciesrByFenChang(fenChangId) {
    $.ajax({
        url: "/productCenter/getSpeciesrByFenChang",
        dataType: "json",
        type: "post",
        data:{"fenChangId":fenChangId},
        success: function (data) {
            if (data) {
                var html = "";
                $.each(data, function (a, b) {
                    html += " <option value=\"" + b.id + "\">" + b.name + "</option>"
                })
                $("#crop_species").append(html);//分场列表条件查询
                layui.form.render("select");
            }
        }
    })
}