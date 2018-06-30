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
<div id="zhongxin" style="padding-right: 10%;padding-left: 10%">
    <p align="center" style="font-size: 20px">电费水费温馨提示</p>
    <p align="left" style="font-size: 15px">尊敬的租户：${pd.PAYERNAME}</p>
    <p align="left" style="font-size: 15px;text-indent:2em">
        你好，贵户   ${fn:substring(pd.PAYTIME, 0, 4)}年${fn:substring(pd.PAYTIME,5, 7)}月
        电费为：${pd.REALITY_TOTAL_SUM_E} 元，水费为：${pd.REALITY_TOTAL_SUM_W} 元，合计：${pd.RECEIVABLE} 元。
        请于收到此单的三个工作日到佛山中奥广场管理有限公司
        缴纳电费及水费，逾期缴纳每天按欠款总额的${pd.OVERDUE}%缴纳滞纳金。谢谢合作！
    </p>
    <table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="5">
                ${fn:substring(pd.PAYTIME, 0, 4)}年${fn:substring(pd.PAYTIME,5, 7)}月 电费如下
            </td>
        </tr>
        <tr>
            <td align="center">序号</td>
            <td align="center">上期读数</td>
            <td align="center">本期读数</td>
            <td align="center">用电量（度）</td>
            <td align="center">金额</td>
        </tr>
        <c:if test="${not empty listEl}">
        <c:forEach items="${listEl}" var="var" varStatus="vs">
            <tr>
                <td align="center">${var.METERNUM}</td>
                <td align="center">${var.LASTMONTH}</td>
                <td align="center">${var.THISMONTH}</td>
                <td align="center">${var.NUMBER}</td>
                <td align="center">${var.TOTAL}</td>
            </tr>
        </c:forEach>
        </c:if>
        <tr>
            <td align="center">合计</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center">${pd.NUMBER_SUM_E}</td>
            <td align="center">${pd.TOTAL_SUM_E}</td>
        </tr>
    </table>
    <br>
    <table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="5">
                ${fn:substring(pd.PAYTIME, 0, 4)}年${fn:substring(pd.PAYTIME,5, 7)}月 水费如下
            </td>
        </tr>
        <tr>
            <td align="center">序号</td>
            <td align="center">上期读数</td>
            <td align="center">本期读数</td>
            <td align="center">用水量（吨）</td>
            <td align="center">金额</td>
        </tr>
        <c:if test="${not empty listWa}">
            <c:forEach items="${listWa}" var="var" varStatus="vs">
                <tr>
                    <td align="center">${var.METERNUM}</td>
                    <td align="center">${var.LASTMONTH}</td>
                    <td align="center">${var.THISMONTH}</td>
                    <td align="center">${var.NUMBER}</td>
                    <td align="center">${var.TOTAL}</td>
                </tr>
            </c:forEach>
        </c:if>
        <tr>
            <td align="center">合计</td>
            <td align="center"></td>
            <td align="center"></td>
            <td align="center">${pd.NUMBER_SUM_W}</td>
            <td align="center">${pd.TOTAL_SUM_W}</td>
        </tr>
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