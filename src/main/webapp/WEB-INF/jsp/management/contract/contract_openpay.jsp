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
                        <%--<table class="table table-border table-bg table-bordered" style="margin-top: 10px">
                            <tbody>
                            <tr class="center">
                                <td style="padding-left:2px;">时间</td>
                                <td style="padding-left:2px;">总应付金额</td>
                                <td style="padding-left:2px;">付款所属时间</td>
                                <td style="padding-left:2px;">应付款金额</td>
                                <td style="padding-left:2px;">实际付款时间</td>
                                <td style="padding-left:2px;">实际付款金额</td>
                                <td style="padding-left:2px;">尚没付款金额</td>
                                <td style="padding-left:2px;">操作</td>
                            </tr>


                            </tbody>
                        </table>--%>

                    </div>
                    <div id="divTable" class="col-md-12"  style="padding-bottom:2em;">
                        <button onclick="addTable()" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的主表</button>
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

    function saveTable(tuuid){
        var PAYPRIMARY_ID = "${pd.PAYPRIMARY_ID}";
        var CONTRACT_ID = "${pd.CONTRACT_ID}";
        var CONTRACTPIC = $("#pic"+tuuid).val();
        var STARTTIME = $("#st"+tuuid).val();
        var ENTTIME = $("#et"+tuuid).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>payprimary/saveTable',
            async: false,
            data: {
                PAYPRIMARY_ID : PAYPRIMARY_ID,
                CONTRACT_ID : CONTRACT_ID,
                CONTRACTPIC : CONTRACTPIC,
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
            }
        });
        var table = "";
        table += '<table id="ta'+uuid+'" class="table table-border table-bg table-bordered" style="margin-top: 10px">';
        table += '<tbody id="tb'+uuid+'" ><tr class="center" >';
        table += '<td style="padding-left:2px;">时间</td><td style="padding-left:2px;">总应付金额</td>';
        table += '<td style="padding-left:2px;">付款所属时间</td><td style="padding-left:2px;">应付款金额</td>';
        table += '<td style="padding-left:2px;">实际付款时间</td><td style="padding-left:2px;">实际付款金额</td>';
        table += '<td style="padding-left:2px;">尚没付款金额</td><td style="padding-left:2px;">操作</td>';
        table += '</tr></tbody></table>';
        table += '<div class="col-md-12"  style="padding-bottom:2em;">';
        table += '<button onclick="addTr(\''+uuid+'\')" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的明细项</button>';
        table += '</div>';
        $("#divTable").before(table);
        table = "";
        uuid = "";
    }
    
    function addTr(uuid_var) {
        var isname = $("#pic"+uuid_var).length;
        var count =$("#ta"+uuid_var+" tr").length;
        $("#td1"+uuid_var).attr("rowspan",count);
        $("#td2"+uuid_var).attr("rowspan",count);
        var tr = '';
        tr += '<tr style="border: 1px;solid #dddddd;" class="center" id="'+uuid_var+'">';
        //alert(isname == null ||isname == undefined||isname =="");
        if(isname == 0){
            tr += ' <td id="td1'+uuid_var+'"  class="center" style="padding-left:2px;">' +
                    '<input id="st'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="STARTTIME" >' +
                    ' --- <input id="et'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="ENTTIME" >' +
                    '</td>';
            tr += '<td id="td2'+uuid_var+'"  class="center" style="padding-left:2px;">' +
                    '<input onchange="saveTable(\''+uuid_var+'\')" id="pic'+uuid_var+'" type="number" style="width: 150px" class="input-text"  name="CONTRACTPIC" ></td>';
        }
        tr += '<td style="padding-left:2px;"><input id="spt'+uuid_var+'" type="date" style="width: 150px;height: 31px" '+
              'class="input-text"  name="SHPAYTIME" id="" ></td>'
        tr += '<td style="padding-left:2px;"><input id="sp'+uuid_var+'" type="number" style="width: 150px;height: 31px" ' +
                ' class="input-text"  name="SHPAY" ></td>';
        tr += ' <td style="padding-left:2px;">' +
                '<input id="rpt'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="REALITYPAYTIME" ></td>';
        tr += '<td style="padding-left:2px;">' +
                '<input id="rp'+uuid_var+'" type="number" style="width: 150px" class="input-text"  name="REALITYPAY" ></td>';
        tr += '<td style="padding-left:2px;"></td>';
        tr += '<td style="padding-left:2px;"> ' +
                '<a class="btn btn-xs btn-success" title="保存" onclick="saveDetail(\''+uuid_var+'\');">' +
                '<i class="ace-icon fa fa-check-square-o bigger-120" title="保存"></i>' +
                '</a> ' +
                '</td>';
        tr += '</tr>';
        if(isname == 0) {
            $("#tb" + uuid_var).after(tr);
        }else {
            $("#" + uuid_var).after(tr);
        }
        tr = '';
    }
    
    function saveDetail(uuid_var){
        var PAYPRIMARY_ID = "${pd.PAYPRIMARY_ID}";
        var CONTRACT_ID =  "${pd.CONTRACT_ID}";
        var SHPAYTIME = $("#spt"+uuid_var).val();
        var REALITYPAY = $("#rp"+uuid_var).val();
        var REALITYPAYTIME = $("#rpt"+uuid_var).val();
        var SHPAY =$("#sp"+uuid_var).val();
        var SHPAYTIME = $("#spt"+uuid_var).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>paydetail/saveDetail',
            data: {
                CONTRACT_ID: CONTRACT_ID,
                PAYPRIMARY_ID: PAYPRIMARY_ID,
                REALITYPAY: REALITYPAY,
                SHPAYTIME:SHPAYTIME,
                REALITYPAYTIME:REALITYPAYTIME,
                SHPAY:SHPAY,
                SHPAYTIME:SHPAYTIME
                },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                //window.location.reload();
            }
        });
    }
</script>


</body>
</html>