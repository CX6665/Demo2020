<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="layui/css/layui.css">
</head>
<body style="background: url(Demo_img/bg_img1.jpg);background-size: 100%">
<div class="layui-container" style="background: url(Demo_img/bg_img2.jpg);background-repeat: no-repeat">
    <blockquote class="layui-elem-quote layui-text layui-bg-green">
        <h1 style="color:whitesmoke" align="center">English Words System</h1>
    </blockquote>
    <div class="layui-btn-group demoTable">
        <button class="layui-btn" data-type="getCheckData">Get Data</button>
        <button class="layui-btn" data-type="delall">DelAll</button>
        <button class="layui-btn" data-type="isAll">Test</button>
    </div>
    <table class="layui-hide" id="words" lay-filter="words_filter"></table>
</div>
<script src="layui/layui.all.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="detail">Look</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">Edit</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">Del</a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">Add</button>
        <button class="layui-btn layui-btn-sm" lay-event="input">Goto</button>

    </div>
</script>

<script>
    layui.use(['table', 'layer', 'form'], function () {
        const table = layui.table;
        const layer = layui.layer;
        const $ = layui.$;

        const tableIns = table.render({
            elem: '#words'
            , url: '/Demo2020/all_words'
            , page: true
            , height: 380
            , defaultToolbar: [{
                title: 'search' //标题
                ,layEvent: 'sear' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon-search' //图标类名
            },'filter', 'print', 'exports',{
                title: 'Exit' //标题
                ,layEvent: 'exit' //事件名，用于 toolbar 事件中使用
                ,icon: 'layui-icon layui-icon-logout' //图标类名
            }]
            , toolbar: '#toolbarDemo'
            , response: {
                statusCode: 200
            }
            ,title:'User Data Table'
            ,totalRow:true
            , cols: [[
                {type:'checkbox', fixed: 'left',totalRowText: 'Next: '}
                ,{type:'numbers',fixed: 'left',title: '序号',width:80}
                ,{field: 'Szm', title: 'Szm', width:80,fixed: 'left'}
                ,{field: 'Word', title: 'Word', width:100}
                ,{field: 'Meaning', title: 'Meaning', width:200}
                ,{field: 'Example', title: 'Example', width:300}
                ,{fixed: 'right', title: 'Function', width:178, align:'center', toolbar: '#barDemo'}
            ]]
        });
        table.on('tool(words_filter)', function (obj) {
            const data = obj.data; //获得当前行数据
            const layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if (layEvent === 'detail') {
                //查看
                layer.open({
                    type: 2,
                    content: 'words_data.jsp',
                    area: ['700px', '400px'],
                    btn: 'Exit',
                    title: false,
                    yes: function (index, layero) {
                        layer.close(index);
                    },
                    success: function (layero, index) {
                        render_form(layero, index, data)
                    }
                });
            } else if (layEvent === 'del') { //删除
                layer.confirm('Please determine whether to delete!', function (index) {
                    // obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                    //向服务端发送删除指令
                    $.ajax({
                        url: '/Demo2020/delWords',
                        type: 'POST',
                        data: {'Word': data.Word},
                        success: function (res) {
                            console.log(res);
                            layer.close(index);
                            if (res.code === 200) {
                                layer.msg('Delete Successfully');
                                tableIns.reload();
                            } else {
                                layer.msg('Delete Failed');
                            }
                        },
                        error: function (error) {
                            layer.close(index)
                            layer.msg('Http request error')
                        }
                    });
                });
            } else if (layEvent === 'edit') { //编辑
                layer.open({
                    type: 2,
                    content: 'words_edit.jsp',
                    area: ['700px', '400px'],
                    title: false,
                    btn: ['YES', "CANSER"],
                    yes: function (index, layero) {
                        const iframeWindow = window['layui-layer-iframe' + index]
                            , submitID = 'user-add-save'
                            , submit = layero.find('iframe').contents().find('#' + submitID);
                        iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                            const field = data.field; //获取提交的字段
                            $.ajax({
                                url:'/Demo2020/upadateWords',
                                type: 'POST',
                                data: JSON.stringify(field),
                                success: function (res){
                                    if (res.code === 200) {
                                        tableIns.reload();
                                        layer.close(index);
                                        layer.msg('Update Successfull');
                                    } else {
                                        layer.msg('Upadate Failed');
                                    }
                                },
                                error: function (error){
                                    layer.msg('Upadate Failed');
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
                body.find('#Szm').val(data.Szm);
                body.find('#Word').val(data.Word);
                body.find('#Meaning').val(data.Meaning);
                body.find('#Example').val(data.Example);
            }
        });
        table.on('toolbar(words_filter)', function(obj){
            switch(obj.event) {
                case 'add':
                    layer.open({
                        type: 2,
                        content: 'words_add.jsp',
                        area: ['700px', '400px'],
                        btn: ['YES', "CANSER"],
                        yes: function (index, layero) {
                            const iframeWindow = window['layui-layer-iframe' + index]
                                , submitID = 'user-add-save'
                                , submit = layero.find('iframe').contents().find('#' + submitID);
                            //监听提交
                            iframeWindow.layui.form.on('submit(' + submitID + ')', function (data) {
                                const field = data.field; //获取提交的字段
                                $.ajax({
                                    url: '/Demo2020/AddWords',
                                    type: 'POST',
                                    data: JSON.stringify(field),
                                    success: function (res) {
                                        if (res.code === 200) {
                                            tableIns.reload();
                                            layer.close(index);
                                            layer.msg('Add Successfully');
                                        } else {
                                            layer.msg('Add Failed');
                                        }
                                    },
                                    error: function (error) {
                                        layer.msg('Http error');
                                    }
                                });
                            });
                            submit.trigger('click');
                        }
                    });
                    break;
                case 'input':
                    layer.confirm('Make Sure You Jump!', function (index) {
                        // 跳转到学生信息页面
                        window.location = "/Demo2020/table_plus.jsp"
                    });
                    break;
                case 'exit':
                    layer.confirm('To determine whether to write off!', function (index) {
                        // 注销跳转到登录页面
                        window.location="/Demo2020/Demo_login.jsp"
                    });
                    break;
                case 'sear':
                    layer.open({
                        type: 2,
                        content: 'words_search.jsp',
                        area: ['600px', '300px'],
                        btn: 'Exit',
                        title: false,
                        success: function (layero, index){
                            var input = layer.getChildFrame("#input",index);
                            var texteare = layer.getChildFrame("#texteare",index);

                            input.on('input',function (){
                                let inputText = input.val();
                                $.ajax({
                                    type: "GET"
                                    ,url: "/Demo2020/SearchWords"
                                    ,dataType: "json"
                                    ,async: false
                                    ,success: function (list){
                                        var trs = "";
                                        for(var i=0; i<list.length; i++){
                                            if(inputText != "" && list[i].Word.startsWith(inputText)){
                                                trs += "Szm:  "+list[i].Szm+"<br/>";
                                                trs += "Words:  "+list[i].Word+"<br/>";
                                                trs += "Meaning:  "+list[i].Meaning+"<br/>";
                                                trs += "Example:  "+list[i].Example+"<br/>";
                                            }
                                        }
                                        if(trs==""){
                                            trs +="No Data,Please re-enter!";
                                        }
                                        texteare.html(trs);
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
                var checkStatus = table.checkStatus('words')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,delall: function(){ //获取选中数目
                var checkStatus = table.checkStatus('words')
                    ,data = checkStatus.data;
                layer.confirm('Please determine all whether to delete!', function (index) {
                    for (var i = 0; i < data.length; i++) {
                        $.ajax({
                            url: '/Demo2020/delWords',
                            type: 'POST',
                            data: {'Word': data[i].Word},
                            success: function (res) {
                                console.log(res);
                                layer.close(index);
                                if (res.code === 200) {
                                    layer.msg('Delete Successfully');
                                    tableIns.reload();
                                } else {
                                    layer.msg('Delete Failed');
                                }
                            },
                            error: function (error) {
                                layer.close(index)
                                layer.msg('Http request error')
                            }
                        });
                    }
                });
            }
            ,isAll: function(){ //验证是否全选
                var checkStatus = table.checkStatus('words');
                layer.msg(checkStatus.isAll ? 'Check All！': 'Not Fully Selected!')
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
