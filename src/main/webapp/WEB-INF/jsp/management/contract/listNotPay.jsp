<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- page specific plugin styles -->
    <link rel="stylesheet" href="static/ace/css/colorbox.css"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="static/dist/jquery.magnify.min.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
    <style>
        .magnify-modal {
            box-shadow: 0 0 6px 2px rgba(0, 0, 0, 0.3);
        }

        .magnify-header .magnify-toolbar {
            width: 40px;
            background-color: rgba(0, 0, 0, .5);
        }

        .magnify-stage {
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            border-width: 0;
        }

        .magnify-footer .magnify-toolbar {
            display: inline-block;
            height: 40px;
            background-color: rgba(0, 0, 0, .5);
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
        }

        .magnify-stage img {
            width: 0;
        }

        .magnify-loading {
            background-color: transparent;
        }

    </style>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">

                        <!-- 检索  -->
                        <form action="contract/listNotProceeds.do" method="post" name="Form" id="Form">
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">合同名称</th>
                                    <th class="center">合同编号</th>
                                    <th class="center">签约方</th>
                                    <th class="center">客户联系人姓名</th>
                                    <th class="center">联系电话</th>
                                    <th class="center">项目</th>
                                    <th class="center">合同金额</th>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr id="${var.CONTRACT_ID}" ondblclick="show_contract('${var.CONTRACT_ID}')" onclick="changeColor('${var.CONTRACT_ID}');list_one('${var.CONTRACT_ID}','${var.CONTRACTTYPES}','${var.CONTRACTNAME}')">
                                                    <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                    <td class='center'>${var.CONTRACTNAME}</td>
                                                    <td class='center'>${var.CONTRACTNUM}
                                                        <c:if test="${var.RELEVANCE_ID != '' && var.RELEVANCE_ID != null}">
                                                            <span style="margin-left: 20px" class="red"><i class="ace-icon fa fa-exchange bigger-50"></i></span>
                                                        </c:if>
                                                    </td>
                                                    <td class='center'>${var.CONTRACTOFNAME}</td>
                                                    <td class='center'>${var.CLIENT}</td>
                                                    <td class='center'>${var.TELEPHONE}</td>
                                                    <td class='center'>${var.PROJECT}</td>
                                                    <td class='center'>${var.CONTRACTPIC}</td>
                                                    <td class="center">
                                                        <a class="btn btn-xs btn-info" title="打开付款表格"
                                                           onclick="openPayT('${var.CONTRACT_ID}')">
                                                            <i class="ace-icon fa fa-credit-card bigger-120" title="打开付款表格"></i>
                                                        </a>
                                                            <%--<a class="btn btn-xs btn-info" title="预览图片"
                                                               onclick="show_contract('${var.CONTRACT_ID}')">
                                                                <i class="ace-icon fa fa-laptop bigger-120" title="预览图片"></i>
                                                            </a>--%>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>

                                </tbody>

                            </table>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                           <%-- <label class="control-label" >显示全部：</label>
                                            <label style="margin-top: 5px;margin-right: 15px">
                                                <input onclick="showAlltd(this)"  name="switch-field-1" class="ace ace-switch ace-switch-5" type="checkbox">	<span class="lbl"></span>
                                            </label>--%>
                                        </td>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>

                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->

    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<script src="static/ace/js/jquery.colorbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>

<script src="static/dist/jquery.magnify.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态

    //图片预览效果
    $('[data-magnify]').magnify({
        headToolbar: [
            'close'
        ],
        initMaximized: true
    });

    function showAlltd(value) {
        //$(value).prop("checked");
        if($(value).prop("checked")){

        }
    }

    function selectDate(){
        var option = "";
        var now = new Date();
        var year=now.getFullYear();
        //$("#CONTRACTCLASSIFY").find("option").remove();
        for(var a=0;a<=15;a++){
            option += "<option value=" + year +">" + year +"</option>";
            //document.write("<option>"+year+"</option>");
            year=year-1;

        }
        $("#YEAR").append(option);
       /* for(var i=0;i < listCheClassify.length;i++){
            option += "<option id="+listCheClassify[i].FITEMID+" value="+listCheClassify[i].FNAME+
                    " name="+listCheClassify[i].FNAME+">"+listCheClassify[i].FNAME+"</option>";
        }
        $("#CONTRACTCLASSIFY").append(option);*/
    }

    selectDate();

    function changeColor(CONTRACT_ID) {
        $("#imgList").html('');
        var tr = document.getElementsByTagName("tr");
        for(var i = 0; i < tr.length ; i ++){ // 从第二行开始遍历，i初始为1，递增6
            tr[i].style.backgroundColor = "";
        }
        $("#"+CONTRACT_ID).css("background-color","#CCCC99");

    }

    function list_one(CONTRACT_ID,CONTRACTTYPES,CONTRACTNAME) {
        $("#iframe").attr("src","contract/list_one?CONTRACT_ID="+CONTRACT_ID+"&CONTRACTTYPES="+CONTRACTTYPES+"&CONTRACTNAME="+CONTRACTNAME);
        $("#iframe").css("display","");
    }

    //图片效果
    jQuery(function ($) {
        var $overflow = '';
        var colorbox_params = {
            rel: 'colorbox',
            reposition: true,
            scalePhotos: true,
            scrolling: false,
            previous: '<i class="ace-icon fa fa-arrow-left"></i>',
            next: '<i class="ace-icon fa fa-arrow-right"></i>',
            close: '&times;',
            current: '{current} of {total}',
            maxWidth: '100%',
            maxHeight: '100%',
            onOpen: function () {
                $overflow = document.body.style.overflow;
                document.body.style.overflow = 'hidden';
            },
            onClosed: function () {
                document.body.style.overflow = $overflow;
            },
            onComplete: function () {
                $.colorbox.resize();
            }
        };

        $('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
        $("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner orange fa-spin'></i>");//let's add a custom loading icon

    });

    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }
    $(function () {
        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                    .off('resize.chosen')
                    .on('resize.chosen', function () {
                        $('.chosen-select').each(function () {
                            var $this = $(this);
                            $this.next().css({'width': $this.parent().width()});
                        });
                    }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }


        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });
    });

    function showPic(CONTRACT_ID) {
        $.ajax({
            type: "POST",
            url: '<%=basePath%>contractpicture/listOneContractPic',
            data: {CONTRACT_ID: CONTRACT_ID},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#imgList").html('');
                var count = 0;	//总数
                var html = '';
                var res = data.listOnePic;
                for (var i = 0; i < res.length; i++) {
                    html += '<li>' +
                            '<a data-magnify="gallery"' +
                            ' data-caption="Paraglider flying over Aurlandfjord, Norway by framedbythomas" href="<%=basePath%>' + res[i].URL_PIC + '">' +
                            '<img width="160;" height="160";   src="<%=basePath%>' + res[i].URL_PIC + '" alt="">' +
                            '</a>' +
                            '<div style="width: 100%;height: 25px" align="center" >' +
                            '<button  onclick="delPic('+"'"+res[i].CONTRACTPICTURE_ID+"','"+CONTRACT_ID+"'"+')" style="width: 45px;height: 20px;margin-top:2px" >删除</button>' +
                            '</div>'+
                            '</li>'+ ''
                }
                $("#imgList").append(html);

            }
        });
    }

    function delPic(CONTRACTPICTURE_ID, CONTRACT_ID) {
        bootbox.confirm("确定要删除该相片吗?", function (result) {
            if (result) {
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>contractpicture/delete.do?tm=' + new Date().getTime(),
                    data: {CONTRACTPICTURE_ID: CONTRACTPICTURE_ID},
                    dataType: 'json',
                    //beforeSend: validateData,
                    cache: false,
                    success: function (data) {
                        showPic(CONTRACT_ID);
                    }
                });
            }
        });
    }

    function openOfficeT(CONTRACT_ID){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "写字楼收款表格";
        diag.URL = '<%=basePath%>contract/openOfficeT?CONTRACT_ID='+CONTRACT_ID;
        diag.Width = window.innerWidth * 1.1;
        diag.Height = window.innerHeight;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            //tosearch();
            diag.close();
        };
        diag.show();
    }

    function openPayT(CONTRACT_ID){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "供应商付款表格";
        diag.URL = '<%=basePath%>contract/openPayT?CONTRACT_ID='+CONTRACT_ID;
        diag.Width = window.innerWidth * 0.9;
        diag.Height = window.innerHeight;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            //tosearch();
            diag.close();
        };
        diag.show();
    }

    //新增
    function add() {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "新增";
        diag.URL = '<%=basePath%>contract/goAdd.do';
        diag.Width = window.innerWidth * 0.9;
        diag.Height = window.innerHeight * 0.9;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            tosearch();
            diag.close();
        };
        diag.show();
    }

    //删除
    function del(Id) {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                top.jzts();
                var url = "<%=basePath%>contract/delete.do?CONTRACT_ID=" + Id + "&tm=" + new Date().getTime();
                $.get(url, function (data) {
                    tosearch();
                });
            }
        });
    }

    //修改
    function edit(Id) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "编辑";
        diag.URL = '<%=basePath%>contract/goEdit.do?CONTRACT_ID=' + Id;
        diag.Width = window.innerWidth * 0.9;
        diag.Height = window.innerHeight * 0.9;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            tosearch();
            diag.close();
        };
        diag.show();
    }

    function show_contract(CONTRACT_ID){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "查阅合同信息";
        diag.URL = '<%=basePath%>contract/toShowContrct.do?CONTRACT_ID=' + CONTRACT_ID;
        diag.Width = window.innerWidth * 1.2;
        diag.Height = window.innerHeight * 1.2;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
           //tosearch();
            diag.close();
        };
        diag.show();
    }

    //批量操作
    function makeAll(msg) {
        bootbox.confirm(msg, function (result) {
            if (result) {
                var str = '';
                for (var i = 0; i < document.getElementsByName('ids').length; i++) {
                    if (document.getElementsByName('ids')[i].checked) {
                        if (str == '') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;
                    }
                }
                if (str == '') {
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                        buttons: {"button": {"label": "确定", "className": "btn-sm btn-success"}}
                    });
                    $("#zcheckbox").tips({
                        side: 1,
                        msg: '点这里全选',
                        bg: '#AE81FF',
                        time: 8
                    });
                    return;
                } else {
                    if (msg == '确定要删除选中的数据吗?') {
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>contract/deleteAll.do?tm=' + new Date().getTime(),
                            data: {DATA_IDS: str},
                            dataType: 'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function (data) {
                                $.each(data.list, function (i, list) {
                                    tosearch();
                                });
                            }
                        });
                    }
                }
            }
        });
    }
    ;

    //导出excel
    function toExcel() {
        window.location.href = '<%=basePath%>contract/excel.do';
    }
</script>


</body>
</html>