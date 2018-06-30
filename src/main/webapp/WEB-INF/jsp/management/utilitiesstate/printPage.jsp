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
    <link href="static/css/bootstrap.min.css" rel="stylesheet" />
    <link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="static/css/font-awesome.min.css" />
    <link rel="stylesheet" href="static/css/ace.min.css" />
    <link rel="stylesheet" href="static/css/ace-responsive.min.css" />
    <link rel="stylesheet" href="static/css/ace-skins.min.css" />
    <script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>

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
<div id="zhongxin">
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
            <td align="center">合同编号</td>
            <td align="center">名称</td>
            <td align="center">签约方</td>
            <td align="center">项目</td>
            <td align="center">合同签订使用时间</td>
        </tr>
        <tr>
            <td align="center">ZHGLB-2018-23</td>
            <td align="center">其他合同</td>
            <td align="center">乙公司</td>
            <td align="center">乙工程</td>
            <td align="center">12312321</td>
        </tr>
    </table>
    <br>
    <table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">

        <tr>
            <td align="center">单元：乙有限公司</td>
            <td align="center">制单日期：2018-03-21</td>
        </tr>
        <tr>
            <td align="center">客户：李先生（办公室）</td>
            <td align="center"></td>
        </tr>
    </table>
    <br>
    <table width="650"    border="1" align="center" cellspacing="0" cellpadding="0"  bgcolor="#221144"  bordercolordark="#ffffff" bordercolorlight="#000000">
        <tr bgcolor="#EFEFFF">
            <td width="37" height="27" align="center">收款项</td>
            <td width="106" align="center">月份</td>
            <td width="106" align="center">应付金额</td>
            <td width="106" align="center">尚未付款金额</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-01</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-02</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-03</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-04</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-05</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-06</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-07</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>
        <tr>
            <td height="30" align="center" bgcolor="#FFFFFF">租用费用</td>
            <td height="30" align="center" bgcolor="#FFFFFF">2017-08</td>
            <td align="center" bgcolor="#FFFFFF">1000&nbsp;</td>
            <td align="center" bgcolor="#FFFFFF">&nbsp;100000</td>
        </tr>

    </table>
    <table width="650" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right"><button onClick="window.print()">打印</button>&nbsp;</td>
        </tr>
    </table>


</div>

<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript">
    $(top.hangge());
</script>
</body>
</html>