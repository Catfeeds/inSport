<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8" />
    <title></title>
    <meta name="description" content="overview & stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>

    <script language="javascript" src="static/js/jquery.jqprint-0.3.js"></script>

    <style type="text/css">

        table{
            border-collapse: collapse;/* 边框合并属性  */
        }
        th{
            border: 1px solid #666666;
        }
        td{
            border: 1px solid #666666;
        }
        @page {
            size: auto;  /* auto is the initial value */
            margin: 5mm; /* this affects the margin in the printer settings */
        }
    </style>

</head>
<body>
<div id="zhongxin" style="padding-right: 3%;padding-left: 3%">
    <p align="center" style="font-size: 20px">缴费单</p>
    <p align="left" style="font-size: 15px;text-indent:2em">
    </p>
    <table style="font-size: 15px" width="1050" height="130" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">收款日期</td>
            <td align="center">本次应收款总额</td>
            <td align="center">本次已收款金额</td>
            <td align="center">本次产生滞纳金</td>
            <td align="center">尚未收款金额</td>
            <td align="center">客户名称</td>
            <td align="center">收款人</td>
        </tr>
        <tr>
            <td align="center">${pd.PROCEEDSDATE}</td>
            <td align="center">${pd.RECEIVABLE_REALITY}</td>
            <td align="center">${pd.PROCEEDSNUM}</td>
            <td align="center">${pd.OVERDUENUM}</td>
            <td align="center">${pd.NOT_RECEIVABLE}</td>
            <td align="center">${pd.PAYER}</td>
            <td align="center">${pd.NAME}</td>
        </tr>
    </table>
    <br>
    <table style="font-size: 15px" width="1050" height="20" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">付款方名称</td>
            <td align="center">类型</td>
            <td align="center">合同编号</td>
            <td align="center">收款方式</td>
            <%--<th class="center">项目id</th>--%>
            <td align="center">本次应收金额</td>
            <td align="center">滞纳金率</td>
            <td align="center">滞纳金</td>
            <td align="center">本次收款金额</td>
            <td align="center">本次尚未收款金额</td>
            <td align="center">本次收款时间</td>
            <td align="center">收款人</td>
        </tr>
        <c:if test="${not empty listByProReceiptsID}">
            <c:forEach items="${listByProReceiptsID}" var="var" varStatus="vs">
            <tr>
                <td align='center'>${var.PAYER}</td>
                <td align='center'>${var.TYPE}</td>
                <td align='center'>${var.CONTRACTNUM}</td>
                <td align='center'>${var.MODE}</td>
                    <%--<td align='center'>${var.ITEMID}</td>--%>
                <td align='center'>${var.RECEIVABLE}${var.SETIME}</td>
                <td align='center'>${var.OVERDUE}</td>
                <td align='center'>${var.OVERDUENUM}</td>
                <td align='center'>${var.RECEIVABLE_N}</td>
                <td align='center'>${var.NOT_RECEIVABLE}</td>
                <td align='center'>${var.RECEIVABL_PAYTIME}</td>
                <td align='center'>${var.UNAME}</td>
                </c:forEach>
        </c:if>
    </table>
    <br>
    <div align="right" style="margin-right: 100px">
    <p  style="font-size: 15px">佛山中奥广场管理有限公司</p>
    <p  id="FCREATETIME" style="margin-right:30px;font-size: 15px"></p>
    </div>
    <hr>
    <div id="print" style="margin-bottom: 10%;margin-right: 20%">
        <button align="right" style="" onClick="printAndNone()">打印</button>&nbsp;</td>
    </div>
</div>
<!-- 引入 -->
<script type="text/javascript">

    function printAndNone() {
        $("#print").css("display","none");
        window.print();
        $("#print").css("display","");
    }

    $(function() {
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth()+1;
        var day = myDate.getDate();
        //alert(year+"-"+month+"-"+day);
        $("#FCREATETIME").html(year+"年"+month+"月"+day+"日");
       // window.print();
    });
</script>
</body>
</html>