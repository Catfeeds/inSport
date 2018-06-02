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
                        <c:if test="${not empty listOfficeprimary}">
                            <c:forEach items="${listOfficeprimary}" var="var" varStatus="vs">
                                <table id="ta${var.OFFICEPRIMARY_ID}" class="table table-border table-bg table-bordered" style="margin-top: 10px">
                                    <tbody id="tb${var.OFFICEPRIMARY_ID}">
                                    <tr class="center">
                                        <td style="padding-left:2px;">时间</td>
                                        <%--<td style="padding-left:2px;">总应付金额</td>--%>
                                        <td style="padding-left:2px;">租金金额</td>
                                        <td style="padding-left:2px;">水电费</td>
                                        <td style="padding-left:2px;">滞纳金</td>
                                        <td style="padding-left:2px;">应收款金额</td>
                                        <td style="padding-left:2px;">应收款时间</td>
                                        <td style="padding-left:2px;">实际收款金额</td>
                                        <td style="padding-left:2px;">实际收款时间</td>
                                        <td style="padding-left:2px;">未收款金额</td>
                                        <td style="padding-left:2px;">操作</td>
                                    </tr>
                                    <tr class="center" id="sum" >
                                        <td id="td1${var.OFFICEPRIMARY_ID}" rowspan="${count +1}" style="padding-left:2px;vertical-align:middle;">${var.STARTTIME } -- ${var.ENTTIME }</td>
                                        <%--<td id="td2${var.OFFICEPRIMARY_ID}" rowspan="${count +1}"  style="padding-left:2px;vertical-align:middle;">
                                            <p id="pic${var.OFFICEPRIMARY_ID}">${var.CONTRACTPIC }</p>
                                        </td>--%>
                                    </tr>
                                    <c:if test="${not empty listOfficeDetail}">
                                        <c:forEach items="${listOfficeDetail}" var="var1" varStatus="vs1">
                                            <c:if test="${var1.OFFICEPRIMARY_ID == var.OFFICEPRIMARY_ID}">
                                                <tr class="center" style="background-color: #FFFFCC" >
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px;height: 31px" value="${var1.RENT}"
                                                               class="input-text"  name="RENT" id="spt${var1.OFFICEDETAIL_ID}"
                                                        ></td>
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px;height: 31px" value="${var1.UTILITIES}"
                                                               class="input-text"  name="UTILITIES" id="sp${var1.OFFICEDETAIL_ID}"
                                                        ></td>
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px;height: 31px" value="${var1.OVERDUE}"
                                                               class="input-text"  name="OVERDUE" id="rpt${var1.OFFICEDETAIL_ID}"
                                                        >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px;" value="${var1.RECEIVABLE}"
                                                               class="input-text"  name="RECEIVABLE" id="rp${var1.OFFICEDETAIL_ID}"
                                                        >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <input type="date" style="width: 120px;height: 31px;" value="${var1.PAYTIME}"
                                                               class="input-text"  name="PAYTIME" id="rp${var1.OFFICEDETAIL_ID}"
                                                    >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px" value="${var1.RECEIVABLE_REALITY}"
                                                               class="input-text"  name="RECEIVABLE_REALITY" id="rp${var1.OFFICEDETAIL_ID}"
                                                        >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <input type="date" style="width: 120px;height: 31px;" value="${var1.RECEIVABL_PAYTIME}"
                                                               class="input-text"  name="RECEIVABL_PAYTIME" id="rp${var1.OFFICEDETAIL_ID}"
                                                        >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <input type="number" style="width: 120px" value="${var1.UNCOLLECTED}"
                                                               class="input-text"  name="UNCOLLECTED" id="rp${var1.OFFICEDETAIL_ID}"
                                                        >
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                        <a class="btn btn-xs btn-success" title="保存修改"
                                                           onclick="editPay('${var1.OFFICEDETAIL_ID}');">
                                                            <i class="ace-icon fa fa-check-square-o bigger-120"
                                                               title="保存修改"></i>
                                                        </a>
                                                        <a class="btn btn-xs btn-danger" title="删除"
                                                           onclick="delPay('${var1.OFFICEDETAIL_ID}');">
                                                            <i class="ace-icon fa fa-trash-o bigger-120"
                                                               title="删除"></i>
                                                        </a>
                                                    </td>
                                                </tr>

                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <tr id="${var.OFFICEPRIMARY_ID}"></tr>
                                    </tbody>
                                </table>
                                <div class="col-md-12"  style="padding-bottom:2em;">
                                    <button onclick="addTr('${var.OFFICEPRIMARY_ID}')" class="btn btn-info" id=""><i class="fa fa-plus"></i> 添加新的明细项</button>
                                </div>
                            </c:forEach>
                        </c:if>

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

    function delPay(OFFICEDETAIL_ID){
        $.ajax({
            type: "POST",
            url: '<%=basePath%>paydetail/deleteDetail',
            async: false,
            data: {
                OFFICEDETAIL_ID : OFFICEDETAIL_ID
            },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                window.location.reload();
            }
        });
    }

    function editPay(OFFICEDETAIL_ID){
        var OFFICEDETAIL_ID = OFFICEDETAIL_ID;
        var SHPAYTIME = $("#spt"+OFFICEDETAIL_ID).val();
        var SHPAY = $("#sp"+OFFICEDETAIL_ID).val();
        var REALITYPAYTIME = $("#rpt"+OFFICEDETAIL_ID).val();
        var REALITYPAY = $("#rp"+OFFICEDETAIL_ID).val();
        //alert("应付时间:"+SHPAYTIME+",应付金额:"+SHPAY+",实际付款时间:"+REALITYPAYTIME+",实际付款金额:"+REALITYPAY+"。");
        $.ajax({
            type: "POST",
            url: '<%=basePath%>paydetail/editPayDetailInfo',
            async: false,
            data: {
                OFFICEDETAIL_ID : OFFICEDETAIL_ID,
                SHPAYTIME : SHPAYTIME,
                SHPAY : SHPAY,
                REALITYPAYTIME : REALITYPAYTIME,
                REALITYPAY : REALITYPAY
            },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                window.location.reload();
            }
        });
    }

    var newOFFICEPRIMARY_ID = null;

    function saveTable(tuuid){
        var con = confirm("是否保存时间和总金额?"); //在页面上弹出对话框
        if(con == true){
            //alert("是");
        }
        else {
            //alert("否");
            return;
        }
       if(newOFFICEPRIMARY_ID == null || newOFFICEPRIMARY_ID == ""){
            var OFFICEPRIMARY_ID = "${pd.OFFICEPRIMARY_ID}";
        }else {
            var OFFICEPRIMARY_ID = newOFFICEPRIMARY_ID;
        }
        var CONTRACT_ID = "${pd.CONTRACT_ID}";
        var STARTTIME = $("#st"+tuuid).val();
        var ENTTIME = $("#et"+tuuid).val();
        $.ajax({
            type: "POST",
            url: '<%=basePath%>officeprimary/saveTable',
            async: false,
            data: {
                OFFICEPRIMARY_ID : OFFICEPRIMARY_ID,
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
                newOFFICEPRIMARY_ID = data.uuid;
            }
        });
        var table = "";
        table += '<table id="ta'+uuid+'" class="table table-border table-bg table-bordered" style="margin-top: 10px">';
        table += '<tbody id="tb'+uuid+'" ><tr class="center" >';
        table += '<td style="padding-left:2px;">时间</td>';
        table += '<td style="padding-left:2px;">租金金额</td>';
        table += '<td style="padding-left:2px;">水电费</td>';
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
        tr += '<td style="padding-left:2px;"><input id="ut'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="UTILITIES" ></td>';
        tr += '<td style="padding-left:2px;"><input id="od'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="OVERDUE"  ></td>';

        tr += '<td style="padding-left:2px;"><input id="r'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="RECEIVABLE" ></td>'
        tr += '<td style="padding-left:2px;"><input id="pt'+uuid_var+'" type="date" style="width: 110px;height: 31px" ' +
                ' class="input-text"  name="PAYTIME" ></td>';
        tr += '<td style="padding-left:2px;"><input id="rr'+uuid_var+'" type="number" style="width: 110px;height: 31px" '+
                'class="input-text"  name="RECEIVABLE_REALITY"  ></td>'
        tr += '<td style="padding-left:2px;"><input id="rpt'+uuid_var+'" type="date" style="width: 110px;height: 31px" '+
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
        var OFFICEPRIMARY_ID = uuid_var;
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
            url: '<%=basePath%>officedetail/saveDetail',
            data: {
                CONTRACT_ID: CONTRACT_ID,
                OFFICEPRIMARY_ID: OFFICEPRIMARY_ID,
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