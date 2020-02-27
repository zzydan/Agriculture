<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../common/head.jsp"></jsp:include>
<body>

<script src="${pageContext.request.contextPath}/static/js/orderCenter/addOrder.js"></script>

<div class="layui-fluid">
    <div class="layui-card">
        <i class="layui-icon layui-icon-note"><span style="font-size: 20px">创建地块</span></i>
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <style>
                #order_addForm .layui-input-block{
                    width: 300px;
                }
                #order_addForm {
                    margin-left: 300px;
                }
            </style>
            <form id="order_addForm" class="layui-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">地块名称</label>
                        <div class="layui-input-block" style="width:300px">
                            <input type="text" name="name" placeholder="请输入"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">所属分场</label>
                        <div class="layui-input-block">
                            <select name="ssfc" lay-filter="" >
                                <option value="">请选择</option>
                                <option value="4">客户1</option>
                                <option value="5">客户2</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">土壤质地</label>
                        <div class="layui-input-block">
                            <select name="trzd" lay-filter="" >
                                <option value="">请选择</option>
                                <option value="4">客户1</option>
                                <option value="5">客户2</option>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">作物种类</label>
                        <div class="layui-input-block">
                            <select name="zwpz" lay-filter="">
                                <option value="">请选择</option>
                                <option value="2">销售1</option>
                                <option value="3">销售2</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">作物品种</label>
                        <div class="layui-input-block">
                            <select name="zzpz" lay-filter="" >
                                <option value="">请选择</option>
                                <option value="全数检验">全数检验</option>
                                <option value="抽样检验">抽样检验</option>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">地块组长</label>
                    <div class="layui-inline" style="width: 300px">
                        <select name="dkzz" lay-filter="" >
                            <option value="">请选择</option>
                            <option value="全数检验">全数检验</option>
                            <option value="抽样检验">抽样检验</option>
                        </select>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">地块技术员</label>
                        <div class="layui-input-block" style="width:300px">
                            <input type="text" name="dkjsy" placeholder="请输入"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">犁地方向</label>
                    <div class="layui-inline" style="width: 300px">
                        <select id="province" lay-verify="required" lay-search lay-filter="province">

                        </select>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">地块面积</label>
                        <div class="layui-input-block" style="width:300px">
                            <input type="text" name="orderName" placeholder="请输入"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label">地块周长</label>
                        <div class="layui-input-block" style="width:300px">
                            <input type="text" name="orderName" placeholder="请输入"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">经度纬度</label>
                        <div class="layui-input-block" style="width:300px">
                            <input type="text" name="orderName" placeholder="请输入"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
</body>