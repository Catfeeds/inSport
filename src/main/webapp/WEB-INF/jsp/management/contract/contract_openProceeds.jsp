﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12" >
                        <table class="table table-border table-bg table-bordered" style="margin-top: 10px">
                            <tbody>
                            <tr class="center">
                                <td colspan="5" style="padding-left:2px;font-size: 26px" ><strong>${pd.CONTRACTOFNAME }</strong></td>
                            </tr>
                            <tr class="center">
                                <td style="padding-left:2px;">合同编号</td>
                                <td style="padding-left:2px;">合同名称</td>
                                <td style="padding-left:2px;">签约方</td>
                                <td style="padding-left:2px;">项目</td>
                                <td style="padding-left:2px;">合同签订使用时间</td>
                            </tr>
                            <tr class="center">
                                <td style="padding-left:2px;">${pd.CONTRACTNUM }</td>
                                <td style="padding-left:2px;">${pd.CONTRACTNAME }</td>
                                <td style="padding-left:2px;">${pd.CONTRACTOFNAME }</td>
                                <td style="padding-left:2px;">${pd.PROJECT }</td>
                                <td style="padding-left:2px;">${pd.FUSEDATESTART } -- ${pd.FUSEDATEENT }</td>
                            </tr>
                            </tbody>
                        </table>
                        <c:if test="${pd1.ISEW == '1'}">

                            <c:if test="${not empty listProTime}">
                                <c:forEach items="${listProTime}" var="var" varStatus="vs">
                                    <table id="ta" class="table table-border table-bg table-bordered" style="margin-top: 10px">
                                        <tbody id="tb">
                                        <tr class="center">
                                            <td style="padding-left:2px;">时间</td>
                                            <td style="padding-left:2px;">租金金额</td>
                                                <%-- <td style="padding-left:2px;">水电费</td>--%>
                                            <td style="padding-left:2px;">租金滞纳金</td>
                                                <%--  <td style="padding-left:2px;">水电费滞纳金</td>--%>
                                            <td style="padding-left:2px;">应收款总金额</td>
                                            <td style="padding-left:2px;">实际收款总金额</td>
                                            <td style="padding-left:2px;">未收款金额</td>
                                            <td style="padding-left:2px;">新增发单记录</td>
                                        </tr>
                                        <tr class="center" id="sum" >
                                            <td id="td1" rowspan="10000"
                                                style="padding-left:2px;vertical-align:middle;">
                                                    ${var.STARTTIME } -- ${var.ENTTIME }
                                            </td>
                                        </tr>
                                        <c:if test="${not empty listInvoice}">
                                            <c:forEach items="${listInvoice}" var="var1" varStatus="vs1">
                                                <c:if test="${var.PROCEEDSTIME_ID == var1.PROCEEDSTIME_ID}">
                                                    <tr class="center" style="vertical-align:middle;" >
                                                        <td style="padding-left:2px;">
                                                            <p>${var1.RECEIVABLE}&emsp;&emsp;
                                                                <c:if test="${var1.STARTTIME != null && var1.STARTTIME != ''  && var1.ENDTIME != null  && var1.ENDTIME != '' }">
                                                                    (${var1.STARTTIME} --- ${var1.ENDTIME})
                                                                </c:if>
                                                            </p>
                                                        </td>
                                                            <%-- <td style="padding-left:2px;">
                                                                 <p> ${var1.URECEIVABLE}</p>
                                                             </td>--%>
                                                        <td style="padding-left:2px;">
                                                            <p>  ${var1.OVERDUE}</p>
                                                        </td>
                                                            <%-- <td style="padding-left:2px;">
                                                                 <p>   ${var1.OVERDUENUM}</p>
                                                             </td>--%>
                                                        <td style="padding-left:2px;">
                                                            <p>   ${var1.SUM_IU}</p>
                                                        </td>
                                                        <td style="padding-left:2px;">
                                                            <p>  ${var1.SUM_R}</p>
                                                        </td>
                                                        <td style="padding-left:2px;">
                                                            <p>   ${var1.SUM_N}</p>
                                                        </td>

                                                        <td style="padding-left:2px;">
                                                            <a class="btn btn-xs btn-warning" title="新增发单记录"
                                                               onclick="addWarning('${var1.INVOICE_ID}','${var1.CONTRACT_ID}');">
                                                                <i class="ace-icon fa fa-exclamation-circle bigger-120"
                                                                   title="新增发单记录"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                        <tr id="${var.PROCEEDSPRIMARY_ID}"></tr>
                                        </tbody>
                                    </table>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <c:if test="${pd1.ISEW == '0' || pd1.ISEW == ''}">
                        <table id="ta" class="table table-border table-bg table-bordered" style="margin-top: 10px">
                            <tbody id="tb">
                            <tr class="center">
                                <td style="padding-left:2px;">应收款时间</td>
                                <td style="padding-left:2px;">应收金额</td>
                                    <%-- <td style="padding-left:2px;">水电费</td>--%>
                                <td style="padding-left:2px;">滞纳金</td>
                                    <%--  <td style="padding-left:2px;">水电费滞纳金</td>--%>
                                <td style="padding-left:2px;">实际收款总金额</td>
                                <td style="padding-left:2px;">未收款金额</td>
                                <td style="padding-left:2px;">新增发单记录</td>
                            </tr>
                            <c:if test="${not empty listInvoice}">
                                <c:forEach items="${listInvoice}" var="var1" varStatus="vs1">
                                        <tr class="center" style="vertical-align:middle;" >
                                            <td style="padding-left:2px;">
                                                <p>  ${var1.RECEIVABLE}</p>
                                            </td>
                                            <td style="padding-left:2px;">
                                                <p>  ${var1.PAYTIME}</p>
                                            </td>
                                            <td style="padding-left:2px;">
                                                <p>   ${var1.OVERDUE}</p>
                                            </td>
                                            <td style="padding-left:2px;">
                                                <p>  ${var1.RECEIVABLE_REALITY}</p>
                                            </td>
                                            <td style="padding-left:2px;">
                                                <p>   ${var1.NOT_RECEIVABLE}</p>
                                            </td>

                                            <td style="padding-left:2px;">
                                                <a class="btn btn-xs btn-warning" title="新增发单记录"
                                                   onclick="addWarning('${var1.INVOICE_ID}','${var1.CONTRACT_ID}');">
                                                    <i class="ace-icon fa fa-exclamation-circle bigger-120"
                                                       title="新增发单记录"></i>
                                                </a>
                                            </td>
                                        </tr>
                                </c:forEach>
                            </c:if>
                            <tr id="${var.PROCEEDSPRIMARY_ID}"></tr>
                        </table>
                        </c:if>
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
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态

    function addWarning(INVOICE_ID,CONTRACT_ID) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="收款记录明细";
        diag.URL = '<%=basePath%>bill/addWarning.do?INVOICE_ID='+INVOICE_ID+"&CONTRACT_ID="+CONTRACT_ID;
        diag.Width = window.innerWidth * 0.9;
        diag.Height = window.innerHeight * 0.9;
        diag.Modal = true;				//有无遮罩窗口
        diag. ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function(){ //关闭事件
            diag.close();
        };
        diag.show();
    }

    function toCalUncollected(PROCEEDSDETAIL_ID){
        var RECEIVABLE_REALITY = $("#rr"+PROCEEDSDETAIL_ID).val();
        var RECEIVABLE = $("#r"+PROCEEDSDETAIL_ID).val();
        var UNCOLLECTED = parseFloat(RECEIVABLE) - parseFloat(RECEIVABLE_REALITY);
        $("#uc"+PROCEEDSDETAIL_ID).val(UNCOLLECTED.toFixed(2));//未收款金额
    }

    function toCalOverDue(PROCEEDSDETAIL_ID){
        var OVERDUE = '${pd1.OVERDUE}';
        var RENT = $("#re"+PROCEEDSDETAIL_ID).val();
        var UTILITIES = $("#ut"+PROCEEDSDETAIL_ID).val();
        var RECEIVABL_PAYTIME = $("#rpt"+PROCEEDSDETAIL_ID).val();
        var PAYTIME = $("#pt"+PROCEEDSDETAIL_ID).val();
        //alert(Date.parse(new Date(RECEIVABL_PAYTIME))+"----------------"+Date.parse(new Date(PAYTIME)));
        var differ = (Date.parse(new Date(RECEIVABL_PAYTIME))-Date.parse(new Date(PAYTIME)))/(1000*60*60*24);
        var OVERDUENUM = (parseFloat(RENT) + parseFloat(UTILITIES)) * OVERDUE * differ;
        //alert(parseFloat(RENT) + parseFloat(UTILITIES));
        $("#od"+PROCEEDSDETAIL_ID).val(OVERDUENUM.toFixed(2)); // 滞纳金
        $("#r"+PROCEEDSDETAIL_ID).val((OVERDUENUM + parseFloat(RENT) + parseFloat(UTILITIES)).toFixed(2)); // 应收金额
        toCalUncollected(PROCEEDSDETAIL_ID);
    }

    function delproceedsDetail(PROCEEDSDETAIL_ID){
        bootbox.confirm("确定要删除改明细吗?删除后将无法恢复!", function(result) {
            if(result) {
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>proceedsdetail/deleteDetail',
                    async: false,
                    data: {
                        PROCEEDSPRIMARY_ID : PROCEEDSPRIMARY_ID
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        window.location.reload();
                    }
                });
            }
        });
    }

    function delproceedsPrimary(PROCEEDSPRIMARY_ID){
        bootbox.confirm("确定要删除吗?删除后将无法恢复!", function(result) {
            if(result) {
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>proceedsprimary/delproceedsPrimary',
                    async: false,
                    data: {
                        PROCEEDSPRIMARY_ID : PROCEEDSPRIMARY_ID
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        window.location.reload();
                    }
                });
            }
        });
    }

    function editProceedsDetailInfo(PROCEEDSDETAIL_ID){
        var PROCEEDSDETAIL_ID = PROCEEDSDETAIL_ID;
        var RENT = $("#re"+PROCEEDSDETAIL_ID).val();
        var UTILITIES = $("#ut"+PROCEEDSDETAIL_ID).val();
        var OVERDUE = $("#od"+PROCEEDSDETAIL_ID).val();
        var RECEIVABLE =$("#r"+PROCEEDSDETAIL_ID).val();
        var PAYTIME = $("#pt"+PROCEEDSDETAIL_ID).val();
        var RECEIVABLE_REALITY = $("#rr"+PROCEEDSDETAIL_ID).val();
        var RECEIVABL_PAYTIME = $("#rpt"+PROCEEDSDETAIL_ID).val();
        var UNCOLLECTED = $("#uc"+PROCEEDSDETAIL_ID).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>proceedsdetail/editProceedsDetailInfo',
            async: false,
            data: {
                PROCEEDSDETAIL_ID : PROCEEDSDETAIL_ID,
                RENT : RENT,
                UTILITIES : UTILITIES,
                OVERDUE : OVERDUE,
                RECEIVABLE : RECEIVABLE,
                PAYTIME : PAYTIME,
                RECEIVABLE_REALITY : RECEIVABLE_REALITY,
                RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
                UNCOLLECTED : UNCOLLECTED
            },
            dataType: 'json',
            cache: false,
            success: function (data) {
                window.location.reload();
            }
        });
    }

    var newPROCEEDSPRIMARY_ID = null;

    function saveTable(tuuid){
        var con = confirm("是否保存时间?"); //在页面上弹出对话框
        if(con == true){
            //alert("是");
        }
        else {
            //alert("否");
            return;
        }
        if(newPROCEEDSPRIMARY_ID == null || newPROCEEDSPRIMARY_ID == ""){
            var PROCEEDSPRIMARY_ID = "${pd.PROCEEDSPRIMARY_ID}";
        }else {
            var PROCEEDSPRIMARY_ID = newPROCEEDSPRIMARY_ID;
        }
        var CONTRACT_ID = "${pd.CONTRACT_ID}";
        var STARTTIME = $("#st"+tuuid).val();
        var ENTTIME = $("#et"+tuuid).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>proceedsprimary/saveTable',
            async: false,
            data: {
                PROCEEDSPRIMARY_ID : PROCEEDSPRIMARY_ID,
                CONTRACT_ID : CONTRACT_ID,
                STARTTIME : STARTTIME,
                ENTTIME : ENTTIME
            },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
            }
        });
    }

    function addTable(){
        var uuid = "";
        $.ajax({
            type: "POST",
            url: '<%=basePath%>paytable/getUUID',
            async: false,
            data: {
            },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                uuid = data.uuid;
                newPROCEEDSPRIMARY_ID = data.uuid;
            }
        });
        var table = "";
        table += '<table id="ta'+uuid+'" class="table table-border table-bg table-bordered" style="margin-top: 10px">';
        table += '<tbody id="tb'+uuid+'" ><tr class="center" >';
        table += '<td style="padding-left:2px;">时间</td>';
        table += '<td style="padding-left:2px;">租金金额</td>';
        if('${pd.CONTRACTCLASSIFY}' == "写字楼"){
            table += '<td style="padding-left:2px;">水电费</td>';
        }
        table += '<td style="padding-left:2px;">滞纳金</td>';
        table += '<td style="padding-left:2px;">应收款金额</td>';
        table += '<td style="padding-left:2px;">应收款时间</td>';
        table += '<td style="padding-left:2px;">实际收款金额</td>';
        table += '<td style="padding-left:2px;">实际收款时间</td>';
        table += '<td style="padding-left:2px;">未收款金额</td>';
        table += '<td style="padding-left:2px;">操作</td>';
        table += '</tr></tbody></table>';
        table += '<div class="col-md-12"  style="padding-bottom:2em;">';
        table += '<button onclick="addTr(\''+uuid+'\')" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的明细项</button>';
        table += '</div>';
        $("#divTable").before(table);
        table = "";
        uuid = "";
    }

    function addTr(uuid_var) {
        var isname = $("#td1"+uuid_var).length;
        var count =$("#ta"+uuid_var+" tr").length;
        // alert(count);
        $("#td1"+uuid_var).attr("rowspan",count);
        //$("#td2"+uuid_var).attr("rowspan",count);
        var tr = '';
        tr += '<tr style="border: 1px;solid #dddddd;" class="center">';
        //alert(isname == null ||isname == undefined||isname =="");
        if(isname == 0){
            tr += '<td id="td1'+uuid_var+'"  class="center" style="padding-left:2px;">' +
                '<input id="st'+uuid_var+'" type="date" style="width: 110px;height: 31px" class="input-text"  name="STARTTIME" >' +
                ' --- <input onchange="saveTable(\''+uuid_var+'\')" id="et'+uuid_var+'" type="date" style="width: 110px;height: 31px" class="input-text"  name="ENTTIME" >' +
                '</td>';
            /* tr += '<td id="td2'+uuid_var+'"  class="center" style="padding-left:2px;">' +
                     '<input onchange="saveTable(\''+uuid_var+'\')" id="pic'+uuid_var+'" type="number" style="width: 110px" ' +
                     'class="input-text"  name="CONTRACTPIC" ></td>';*/
        }
        tr += '<td style="padding-left:2px;"><input id="re'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
            'class="input-text"  name="RENT"  ></td>';
        if('${pd.CONTRACTCLASSIFY}' == "写字楼"){
            tr += '<td style="padding-left:2px;"><input id="ut'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="UTILITIES" ></td>';
        }else {
            tr += '<td style="display: none"><input id="ut'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="UTILITIES" ></td>';
        }
        tr += '<td style="padding-left:2px;"><input id="od'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
            'class="input-text"  name="OVERDUE"  ></td>';

        tr += '<td style="padding-left:2px;"><input id="r'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
            'class="input-text"  name="RECEIVABLE" ></td>'
        tr += '<td style="padding-left:2px;"><input id="pt'+uuid_var+'" type="date" style="width: 150px;height: 31px" ' +
            ' class="input-text"  name="PAYTIME" ></td>';
        tr += '<td style="padding-left:2px;"><input id="rr'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
            'class="input-text"  name="RECEIVABLE_REALITY"  ></td>'
        tr += '<td style="padding-left:2px;"><input id="rpt'+uuid_var+'" type="date" style="width: 150px;height: 31px" '+
            'class="input-text"  name="RECEIVABL_PAYTIME" id="" ></td>';

        tr += ' <td style="padding-left:2px;">' +
            '<input id="uc'+uuid_var+'" type="number" style="width: 110px;height: 31px" class="input-text"  name="UNCOLLECTED" ></td>';
        tr += '<td style="padding-left:2px;"> ' +
            '<a class="btn btn-xs btn-success" title="保存" onclick="saveDetail(\''+uuid_var+'\');">' +
            '<i class="ace-icon fa fa-check-square-o bigger-120" title="保存"></i>' +
            '</a> ' +
            '</td>';
        tr += '</tr>';
        if(isname == 0){
            tr += '<tr id="'+uuid_var+'"></tr>';
        }
        if(isname == 0) {
            $("#tb" + uuid_var).after(tr);
        }else {
            $("#" + uuid_var).before(tr);
        }
        tr = '';
    }

    function saveDetail(uuid_var){
        var PROCEEDSPRIMARY_ID = uuid_var;
        var CONTRACT_ID =  "${pd.CONTRACT_ID}";
        var RENT = $("#re"+uuid_var).val();
        var UTILITIES = $("#ut"+uuid_var).val();
        var OVERDUE = $("#od"+uuid_var).val();
        var RECEIVABLE =$("#r"+uuid_var).val();
        var PAYTIME = $("#pt"+uuid_var).val();
        var RECEIVABLE_REALITY = $("#rr"+uuid_var).val();
        var RECEIVABL_PAYTIME = $("#rpt"+uuid_var).val();
        var UNCOLLECTED = $("#uc"+uuid_var).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>proceedsdetail/saveDetail',
            data: {
                CONTRACT_ID: CONTRACT_ID,
                PROCEEDSPRIMARY_ID: PROCEEDSPRIMARY_ID,
                RENT: RENT,
                UTILITIES:UTILITIES,
                OVERDUE:OVERDUE,
                RECEIVABLE:RECEIVABLE,
                RECEIVABLE_REALITY:RECEIVABLE_REALITY,
                RECEIVABL_PAYTIME:RECEIVABL_PAYTIME,
                UNCOLLECTED:UNCOLLECTED,
                PAYTIME:PAYTIME
            },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                //alert(uuid_var);
                window.location.reload();
            }
        });
    }
</script>


</body>
</html>