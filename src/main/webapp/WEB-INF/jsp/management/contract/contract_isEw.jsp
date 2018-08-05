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
                        <form action="contract/isEwlistPage.do?keywords=${pd.keywords}" method="post" name="Form" id="Form">
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input"
                                                   id="nav-search-input" autocomplete="off" name="CONTRACTNUM"
                                                   value="${pd.CONTRACTNUM}" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
                                            <input type="hidden" value="${pd.USERNAME}" name="USERNAME" id="USERNAME" />
										</span>
                                        </div>
                                    </td>
                                    <td style="padding-left:12px;">
                                        <label style="margin-top: 5px">年份:</label>
                                        <select name="YEAR" id="YEAR" data-placeholder=""
                                                style="vertical-align:top;width: 120px;" onchange="selectType(this.value);">
                                            <option value="${pd.YEAR}" name="${pd.YEAR}">${pd.YEAR}</option>
                                        </select>
                                    </td>
                                    <td style="padding-left:12px;">
                                        <label>合同金额区间:</label>
                                        <input type="number" placeholder="输入金额" style="width: 110px" class="nav-search-input"
                                               id="picStart" autocomplete="off" name="picStart"
                                               value="${pd.picStart }" />  -至-
                                        <input type="number" placeholder="输入金额" style="width: 110px" class="nav-search-input"
                                               id="picEnd" autocomplete="off" name="picEnd"
                                               value="${pd.picEnd }" />
                                    </td>
                                    <c:if test="${QX.cha == 1 }">
                                        <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"
                                                                                           onclick="tosearch();" title="检索"><i
                                                id="search-icon"
                                                class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                    </c:if>
                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:35px;">
                                        <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox"/><span
                                                class="lbl"></span></label>
                                    </th>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">合同名称</th>
                                    <th class="center">合同编号</th>
                                    <th class="center">签约方</th>
                                    <th class="center">客户联系人姓名</th>
                                    <th class="center">联系电话</th>
                                    <th class="center">项目</th>
                                    <th class="center">合同金额</th>
                                   <%-- <th class="center">押金</th>
                                    <th class="center">合同签订使用时间</th>
                                    <th class="center">签约时间</th>
                                    <th class="center">经办人</th>
                                    <th class="center">印花税</th>
                                    <th class="center">印花税计提月份</th>
                                    <th class="center">税目</th>
                                    <th class="center">方式</th>
                                    <th class="center">合同类型</th>
                                    <th class="center">招待票</th>--%>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr id="${var.CONTRACT_ID}"
                                                    <%--ondblclick="show_contract('${var.CONTRACT_ID}')" --%>
                                                    onclick="changeColor('${var.CONTRACT_ID}');list_one('${var.CONTRACT_ID}','${var.CONTRACTTYPES}','${var.CONTRACTNAME}')">
                                                    <td class='center'>
                                                        <label class="pos-rel"><input type='checkbox' name='ids'
                                                                                      value="${var.CONTRACT_ID}"
                                                                                      class="ace"/><span
                                                                class="lbl"></span></label>
                                                    </td>
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
                                                   <%-- <c:if test="${var.ISSTAMPDUTY == 1 }">
                                                        <td class='center'>${var.DEPOSIT}</td>
                                                    </c:if>
                                                    <c:if test="${var.ISSTAMPDUTY ==  0}">
                                                        <td class='center'>没有押金</td>
                                                    </c:if>
                                                    <td class='center'>${var.FUSEDATESTART} - ${var.FUSEDATEENT}</td>
                                                    <td class='center'>${var.FDATE}</td>
                                                    <td class='center'>${var.OPERATOR}</td>
                                                    <td class='center'>${var.STAMPDUTY}</td>
                                                    <td class='center'>${var.STAMPDUTYMONTH}</td>
                                                    <td class='center'>${var.TAXITEMS}</td>
                                                    <td class='center'>${var.MODE}</td>
                                                    <td class='center'>${var.CONTRACTTYPES}</td>
                                                    <td class='center'>${var.INVITATIONTICKET}</td>--%>
                                                    <td class="center">
                                                        <a class="btn btn-xs btn-info" title="管理水电项"
                                                           onclick="showUtilities('${var.CONTRACT_ID}');">
                                                            <i class="ace-icon fa fa-tachometer bigger-120"
                                                               title="管理水电项"></i>
                                                        </a>
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
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>

                    </div>
                    <!-- /.col -->
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

    function addUtilities(CONTRACT_ID){
        //alert(LINVOICE_ID);
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "添加水电费项";
        diag.URL = '<%=basePath%>expense/goAdd?CONTRACT_ID='+CONTRACT_ID;
        diag.Width = window.innerWidth * 1.3;
        diag.Height = 1700;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            //tosearch();
            diag.close();
        };
        diag.show();
    }

    function showUtilities(CONTRACT_ID){
        //alert(LINVOICE_ID);
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "查看管理水电费项";
        diag.URL = '<%=basePath%>utilitiesstate/list?CONTRACT_ID='+CONTRACT_ID;
        diag.Width = window.innerWidth * 1.3;
        diag.Height = 1700;
        diag.Modal = true;				//有无遮罩窗口
        diag.ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function () { //关闭事件
            //tosearch();
            diag.close();
        };
        diag.show();
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
        diag.Width = window.innerWidth * 1.9;
        diag.Height = window.innerHeight * 1.9;
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
        diag.Width = window.innerWidth * 1.9;
        diag.Height = window.innerHeight * 1.9;
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