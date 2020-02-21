<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="head.jsp"></jsp:include>



<body style="background-color: #ebebeb">

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">常规轮播</div>
                <div class="layui-card-body">
                    <div class="layui-carousel" id="test-carousel-normal" lay-filter="test-carousel-normal">
                        <div carousel-item="">
                            <div><<img src="/static/img/bj1.png" alt="轮播图"></div>
                            <div><<img src="/static/img/bj2.png" alt="轮播图"></div>
                            <div><<img src="/static/img/bj3.png" alt="轮播图"></div>
                            <div><<img src="/static/img/bj4.png" alt="轮播图"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md8">
            <div class="layui-card">
                <div class="layui-card-header">信息图示

                    <span style="margin-left: 645px">
                        统计时间：
                        <input type="text" style="width: 160px;display: inline" class="form-control"
                               id="sbfh_dateFirst"/>--
                        <input type="text" style="width: 160px;display: inline" class="form-control"
                               id="sbfh_dateLast"/>
                    </span>

                </div>
                <div class="layui-card-body" style="height: 500px">
                    <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade"
                         lay-filter="LAY-index-dataview">
                        <div carousel-item id="LAY-index-dataview" style="height: 500px">
                            <div>
                                <div id="main" style="width: 1050px;height:450px;"></div>
                            </div>
                            <div>
                                <div id="main2" style="width: 1050px;height:450px;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">商品销售量</div>
                <div class="layui-card-body">
                    <table class="layui-table layuiadmin-page-table" lay-skin="line">
                        <thead>
                        <tr>
                            <th>用户名</th>
                            <th>最后登录时间</th>
                            <th>状态</th>
                            <th>获得赞</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span class="first">胡歌</span></td>
                            <td><i class="layui-icon layui-icon-log"> 11:20</i></td>
                            <td><span>在线</span></td>
                            <td>22 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td><span class="second">彭于晏</span></td>
                            <td><i class="layui-icon layui-icon-log"> 10:40</i></td>
                            <td><span>在线</span></td>
                            <td>21 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td><span class="third">靳东</span></td>
                            <td><i class="layui-icon layui-icon-log"> 01:30</i></td>
                            <td><i>离线</i></td>
                            <td>66 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td>吴尊</td>
                            <td><i class="layui-icon layui-icon-log"> 21:18</i></td>
                            <td><i>离线</i></td>
                            <td>45 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td>许上进</td>
                            <td><i class="layui-icon layui-icon-log"> 09:30</i></td>
                            <td><span>在线</span></td>
                            <td>21 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td>小蚊子</td>
                            <td><i class="layui-icon layui-icon-log"> 21:18</i></td>
                            <td><i>在线</i></td>
                            <td>45 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        <tr>
                            <td>贤心</td>
                            <td><i class="layui-icon layui-icon-log"> 09:30</i></td>
                            <td><span>在线</span></td>
                            <td>21 <i class="layui-icon layui-icon-praise"></i></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script src="${pageContext.request.contextPath}/static/js/common/homepage.js"></script>
