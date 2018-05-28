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
                    <div class="col-xs-12">
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
                        <table class="table table-border table-bg table-bordered" style="margin-top: 10px">
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
                            <tr class="center" id="sum" >
                                <td rowspan="${count +1}" style="padding-left:2px;vertical-align:middle;">${pd.FUSEDATESTART } -- ${pd.FUSEDATEENT }</td>
                                <td rowspan="${count +1}" style="padding-left:2px;vertical-align:middle;">${pd.CONTRACTPIC }</td>
                            </tr> <c:forEach items="${listpays}" var="var" varStatus="vs">
                                <tr class="center" style="background-color: #FFFFCC">
                                    <td style="padding-left:2px;">${var.SHPAYTIME}</td>
                                    <td style="padding-left:2px;">
                                        <input type="number" style="width: 150px;height: 31px" value="${var.SHPAY}"
                                               class="input-text"  name="SHPAY" id="SHPAY${var.PAYTABLE_ID}"
                                        ></td>
                                    <td style="padding-left:2px;">
                                        <input type="date" style="width: 150px;height: 31px" value="${var.REALITYPAYTIME}"
                                               class="input-text"  name="REALITYPAYTIME" id="REATIME${var.PAYTABLE_ID}"
                                        >
                                    </td>
                                    <td style="padding-left:2px;">
                                        <input type="number" style="width: 150px" value="${var.REALITYPAY}"
                                               class="input-text"  name="REALITYPAY" id="REALITYPAY${var.PAYTABLE_ID}"
                                        >
                                    </td>
                                    <td style="padding-left:2px;">
                                        <c:if test="${vs.last }">
                                            ${onPayPic}
                                        </c:if>
                                        <c:if test="${!vs.last }">
                                            ${var.NOPAY}
                                        </c:if>
                                    </td>
                                    <td style="padding-left:2px;">
                                        <a class="btn btn-xs btn-success" title="保存修改"
                                           onclick="editPay('${pd.PAYTABLE_ID}');">
                                            <i class="ace-icon fa fa-check-square-o bigger-120"
                                               title="保存修改"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:forEach items="${arr}" var="var" varStatus="vs">
                                <tr class="center">
                                    <td style="padding-left:2px;">${var}</td>
                                    <td style="padding-left:2px;">
                                        <input type="number" style="width: 150px;height: 31px" value="${everyMonthPay}"
                                               class="input-text"  name="everyMonthPay" id="PIC${var}"
                                        ></td>
                                    <td style="padding-left:2px;">
                                        <input type="date" style="width: 150px;height: 31px" value="${pd.REALITYPAYTIME}"
                                               class="input-text"  name="REALITYPAYTIME" id="REATIME${var}"
                                               >
                                    </td>
                                    <td style="padding-left:2px;">
                                        <input type="number" style="width: 150px" value=""
                                               class="input-text"  name="REALITYPAY" id="REAPAY${var}"
                                               >
                                    </td>

                                    <td style="padding-left:2px;">

                                    </td>
                                    <td style="padding-left:2px;">
                                        <a class="btn btn-xs btn-success" title="保存"
                                           onclick="savePay('${var}','${pd.CONTRACT_ID}');">
                                            <i class="ace-icon fa fa-check-square-o bigger-120"
                                               title="保存"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
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
    function savePay(value,CONTRACT_ID){
        /**
         *  <td style="padding-left:2px;">付款所属时间</td>
         <td style="padding-left:2px;">应付款金额</td> id="PIC"
         <td style="padding-left:2px;">实际付款时间</td> id="REATIME"
         <td style="padding-left:2px;">实际付款金额</td>   id="REALITYPAY"
         */
        var REATIME = $("#REATIME"+value).val();
        var REAPAY = $("#REAPAY"+value).val();
        var PIC = $("#PIC"+value).val();
        var onPayPic = '${onPayPic}' - REAPAY;
        if($("#REATIME"+value).val()==""){
            $("#REATIME"+value).tips({
                side:3,
                msg:'实际付款时间',
                bg:'#AE81FF',
                time:2
            });
            $("#REATIME"+value).focus();
            return false;
        }
        if($("#REAPAY"+value).val()==""){
            $("#REAPAY"+value).tips({
                side:3,
                msg:'实际付款金额',
                bg:'#AE81FF',
                time:2
            });
            $("#REAPAY"+value).focus();
            return false;
        }
        /*if($("#CONTRACTNAME").val()==""){
            $("#CONTRACTNAME").tips({
                side:3,
                msg:'请输入合同名称',
                bg:'#AE81FF',
                time:2
            });
            $("#CONTRACTNAME").focus();
            return false;
        }*/
        //alert("应付款金额:"+PIC+",实际付款时间:"+REATIME+",实际付款金额:"+REAPAY);
        $.ajax({
            type: "POST",
            url: '<%=basePath%>paytable/saveInfo',
            data: {
                CONTRACT_ID: CONTRACT_ID,
                SHPAYTIME: value,
                SHPAY: PIC,
                REALITYPAYTIME:REATIME,
                REALITYPAY:REAPAY,
                NOPAY:onPayPic
                },
            dataType: 'json',
            //beforeSend: validateData,
            cache: false,
            success: function (data) {
                window.location.reload();
            }
        });
    }
</script>


</body>
</html>