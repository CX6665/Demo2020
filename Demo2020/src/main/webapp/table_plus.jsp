<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body style="background: url(Demo_img/bg_img1.jpg);background-size: 100%">
<div class="layui-container" style="background: url(Demo_img/bg_img2.jpg);background-repeat: no-repeat">
    <blockquote class="layui-elem-quote layui-text layui-bg-green">
        <h1 style="color:whitesmoke" align="center">学生管理系统</h1>
    </blockquote>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
        <button class="layui-btn" data-type="addFoulor">获取选中数据工资总和</button>
    </div>
    <table class="layui-hide" id="student" lay-filter="student_filter"></table>
</div>
<script src="layui/layui.all.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
        <button class="layui-btn layui-btn-sm" lay-event="input">导入</button>
    </div>
</script>
<script>
    layui.use(['table', 'layer', 'form'], function () {
        const table = layui.table;
        const layer = layui.layer;
        const $ = layui.$;
        const tableIns = table.render({
            elem: '#student'
            , url: '/Demo2020/stu/all'
            , page: true
            , height: 380
            , defaultToolbar: [{
                title: 'search' //标题
                ,layEvent: 'sear' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon-search' //图标类名
            },'filter', 'print', 'exports',{
                title: '注销' //标题
                ,layEvent: 'exit' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon layui-icon-logout' //图标类名
            }]
            , toolbar: '#toolbarDemo'
            , response: {
                statusCode: 200
            }
            ,title:'用户数据表'
            ,totalRow:true
            // ,initSort: {
            //     field: 'id' //排序字段，对应 cols 设定的各字段名
            //     ,type: 'asc' //排序方式  asc: 升序、desc: 降序、null: 默认排序
            // }//只在页面显示，书写排序服务端
            , cols: [[
                {type:'checkbox', fixed: 'left'}
                ,{type:'numbers',fixed: 'left',title: '序号',width:80,totalRowText: '合计: '}
                ,{field: 'name', title: '姓名', width:100,fixed: 'left'}
                ,{field: 'sex', title: '性别', width:80}
                ,{field: 'age', title: '年龄', width:80}
                ,{field: 'foulor', title: '工资', width:100,totalRow: true}
                ,{field: 'id', title: 'id', width: 80, sort: true}
                ,{fixed: 'right', title: '功能', width:178, align:'center', toolbar: '#barDemo'}
            ]]
        });
        table.on('tool(student_filter)', function (obj) {
            const data = obj.data; //获得当前行数据
            const layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if (layEvent === 'detail') {
                //查看
                layer.open({
                    type: 2,
                    content: 'data.jsp',
                    area: ['700px', '400px'],
                    btn: '退出',
                    title: false,
                    yes: function (index, layero) {
                        layer.close(index);
                    },
                    success: function (layero, index) {
                        render_form(layero, index, data)
                    }
                });
            } else if (layEvent === 'del') { //删除
                layer.confirm('真的删除行么', function (index) {
                    // obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/Demo2020/stu/del',
                        type: 'POST',
                        data: {'id': data.id},
                        success: function (res) {
                            console.log(res);
                            layer.close(index);
                            if (res.code === 200) {
                                layer.msg('删除成功');
                                tableIns.reload();
                            } else {
                                layer.msg('删除失败');
                            }
                        },
                        error: function (error) {
                            layer.close(index)
                            layer.msg('http请求错误')
                        }
                    });
                });
            } else if (layEvent === 'edit') { //编辑
                layer.open({
                    type: 2,
                    content: 'edit_plus.jsp',
                    area: ['700px', '400px'],
                    title: false,
                    btn: ['确定', "取消"],
                    yes: function (index, layero) {
                        const iframeWindow = window['layui-layer-iframe' + index]
                            , submitID = 'user-add-save'
                            , submit = layero.find('iframe').contents().find('#' + submitID);
                        //监听提交
                        iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                            const field = data.field; //获取提交的字段
                            $.ajax({
                                url:'/Demo2020/stu/update/plus',
                                type: 'POST',
                                data: JSON.stringify(field),
                                success: function (res){
                                    if (res.code === 200) {
                                        tableIns.reload();
                                        layer.close(index);
                                        layer.msg('更新成功');
                                    } else {
                                        layer.msg('更新失败');
                                    }
                                },
                                error: function (error){
                                    layer.msg('更新失败');
                                }
                            });
                        });
                        submit.trigger('click');
                    },
                    success: function (layero, index) {
                        render_form(layero, index, data)
                    }
                });
            }
            //获得渲染数据
            function render_form(layero, index, data) {
                const body=layer.getChildFrame('body',index)
                body.find('#name').val(data.name);
                body.find('#sex').val(data.sex);
                body.find('#age').val(data.age);
                body.find('#foulor').val(data.foulor);
                body.find('#id').val(data.id);
            }
        });
        table.on('toolbar(student_filter)', function(obj){
            switch(obj.event){
                case 'add':
                    layer.open({
                        type: 2,
                        content: 'add.jsp',
                        area: ['700px', '400px'],
                        btn: ['确定', "取消"],
                        yes: function (index, layero) {
                            const iframeWindow = window['layui-layer-iframe' + index]
                                , submitID = 'user-add-save'
                                , submit = layero.find('iframe').contents().find('#' + submitID);
                            //监听提交
                            iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                                const field = data.field; //获取提交的字段
                                $.ajax({
                                    url:'/Demo2020/stu/add',
                                    type: 'POST',
                                    data: JSON.stringify(field),
                                    success: function (res){
                                        if (res.code === 200) {
                                            tableIns.reload();
                                            layer.close(index);
                                            layer.msg('添加成功');
                                        } else {
                                            layer.msg('添加失败');
                                        }
                                    },
                                    error: function (error){
                                        layer.msg(error);
                                    }
                                });
                            });
                            submit.trigger('click');
                        }
                    });
                break;
                case 'input':
                    layer.msg('导入');
                break;
                case 'exit':
                    layer.confirm('确认是否注销', function (index) {
                        // 注销跳转到登录页面
                        window.location="/Demo2020/Demo_login.jsp"
                    });
                break;
                case 'sear':
                    layer.open({
                        type: 2,
                        content: 'search.jsp',
                        area: ['600px', '300px'],
                        btn: '退出',
                        title: false,
                        success: function (layero, index){
                            var input = layer.getChildFrame("#input",index);
                            var table = layer.getChildFrame("#table",index);

                            input.on('input',function (){
                                let inputText = input.val();
                                $.ajax({
                                    type: "GET"
                                    ,url: "/Demo2020/parseJson"
                                    ,dataType: "json"
                                    ,async: false
                                    ,success: function (list){
                                        var trs = "";
                                        for(var i=0; i<list.length; i++){
                                            //alert(list[i].toString());
                                            if(inputText != "" && list[i].name.startsWith(inputText)){
                                                trs += "<tr>";
                                                trs += "<td style='font-size: large'>"+"姓名:  "+list[i].name+"</td>";
                                                trs += "<td style='font-size: large'>"+"性别:  "+list[i].sex+"</td>";
                                                trs += "<td style='font-size: large'>"+"年龄:  "+list[i].age+"</td>";
                                                trs += "<td style='font-size: large'>"+"工资:  "+list[i].foulor+"</td>";
                                                trs += "<td style='font-size: large'>"+"id: "+list[i].id+"</td>";
                                                trs += "</tr>";
                                            }
                                        }
                                        if(trs==""){
                                            trs +="<td style='font-size:large;color: #fd482c'>"+"查无此人,请重新输入"+"</td>";
                                        }
                                        table.html(trs);
                                    }
                                });
                            });
                        }
                    });
                break;
            }
        });
        var h= layui.$, active = {
            getCheckData: function(){ //获取选中数据
                var checkStatus = table.checkStatus('student')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){ //获取选中数目
                var checkStatus = table.checkStatus('student')
                    ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('student');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
            ,addFoulor:function(){ //计算工资总和
                var checkStatus = table.checkStatus('student')
                    ,data = checkStatus.data;
                var total = 0;
                for(var i=0; i<data.length; i++)
                    total += parseFloat(data[i].foulor,10);
                layer.msg('CalSumFoulor  =  '+total+' 元');
            }
        };
        h('.demoTable .layui-btn').on('click', function(){
            var type = h(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
</body>
</html>
