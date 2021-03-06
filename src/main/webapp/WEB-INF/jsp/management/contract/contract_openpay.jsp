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
                        <c:if test="${not empty listPayprimary}">
                            <c:forEach items="${listPayprimary}" var="var" varStatus="vs">
                                <table id="ta${var.PAYPRIMARY_ID}" class="table table-border table-bg table-bordered" style="margin-top: 10px">
                                    <tbody id="tb${var.PAYPRIMARY_ID}">
                                    <tr class="center">
                                        <td style="padding-left:2px;">时间</td>
                                        <td style="padding-left:2px;">总应付金额</td>
                                        <c:if test="${pd.CONTRACTCLASSIFY == '固定供应商'}">
                                        <td style="padding-left:2px;">付款所属时间</td>
                                        </c:if>
                                        <td style="padding-left:2px;">应付款金额</td>
                                        <td style="padding-left:2px;">实际付款金额</td>
                                        <td style="padding-left:2px;">实际付款时间</td>
                                        <c:if test="${pd.CONTRACTCLASSIFY == '固定供应商'}">
                                            <td style="padding-left:2px;">尚未付款金额</td>
                                        </c:if>

                                        <td style="padding-left:2px;width: 250px">备注</td>
                                    </tr>
                                    <tr class="center" id="sum" >
                                        <td id="td1${var.PAYPRIMARY_ID}" rowspan="${count +1}" style="padding-left:2px;vertical-align:middle;">${var.STARTTIME } -- ${var.ENTTIME }</td>
                                        <td id="td2${var.PAYPRIMARY_ID}" rowspan="${count +1}"  style="padding-left:2px;vertical-align:middle;">
                                            <p id="pic${var.PAYPRIMARY_ID}">${var.CONTRACTPIC }</p>
                                        </td>
                                    </tr>
                                    <c:if test="${not empty listPayDetail}">
                                        <c:forEach items="${listPayDetail}" var="var1" varStatus="vs1">
                                            <c:if test="${var1.PAYPRIMARY_ID == var.PAYPRIMARY_ID}">
                                                <tr class="center" style="background-color: #FFFFCC" >
                                                    <c:if test="${pd.CONTRACTCLASSIFY == '固定供应商'}">
                                                        <td style="padding-left:2px;">
                                                                ${var1.SHPAYTIME} -- ${var1.SHPAYTIMEENT}
                                                        </td>
                                                    </c:if>

                                                    <td style="padding-left:2px;">
                                                            ${var1.SHPAY}
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                            ${var1.REALITYPAY}
                                                    </td>
                                                    <td style="padding-left:2px;">
                                                            ${var1.REALITYPAYTIME}
                                                    </td>
                                                    <c:if test="${pd.CONTRACTCLASSIFY == '固定供应商'}">
                                                        <td style="padding-left:2px;">
                                                                ${var1.ONPAYPIC}
                                                        </td>
                                                    </c:if>

                                                    <td style="padding-left:2px;">
                                                       <p>${var1.FNOTE}</p>
                                                    </td>
                                                    <%--<td style="padding-left:2px;">
                                                        <a class="btn btn-xs btn-success" title="保存修改"
                                                           onclick="editPay('${var1.PAYPRIMARY_ID}','${var1.PAYDETAIL_ID}');">
                                                            <i class="ace-icon fa fa-check-square-o bigger-120"
                                                               title="保存修改"></i>
                                                        </a>
                                                        <a class="btn btn-xs btn-danger" title="删除"
                                                           onclick="delPay('${var1.PAYPRIMARY_ID}','${var1.PAYDETAIL_ID}');">
                                                            <i class="ace-icon fa fa-trash-o bigger-120"
                                                               title="删除"></i>
                                                        </a>
                                                    </td>--%>
                                                </tr>

                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <tr id="${var.PAYPRIMARY_ID}"></tr>
                                    </tbody>
                                </table>
                                <%--<div class="col-md-12"  style="padding-bottom:2em;">
                                    <button onclick="addTr('${var.PAYPRIMARY_ID}')" class="btn btn-info" id=""><i class="fa fa-plus"></i> 添加新的明细项</button>
                                </div>--%>
                            </c:forEach>
                        </c:if>

                    </div>
                   <%-- <div id="divTable" class="col-md-12"  style="padding-bottom:2em;">
                        <button onclick="addTable()" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的主表</button>
                    </div>--%>
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


</script>


</body>
</html>