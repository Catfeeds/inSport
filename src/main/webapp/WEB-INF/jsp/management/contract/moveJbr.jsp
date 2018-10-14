<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <link rel="stylesheet" href="static/silviomore/bootstrap-select.css" />
    <script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
    <script type="text/javascript" src="static/silviomore/bootstrap-select.js"></script>
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
                    <div class="col-xs-12" style="margin-top: 15px">
                        <a  class="btn btn-success btn-xs" onclick="save()">
                            <i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>保存
                        </a>
                        <a class="btn btn-primary  btn-xs" onclick="qx();">
                            <i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
                        </a>
                        <form action="contract/toDoMoveJbr" name="Form" id="Form" method="post">
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <th style="font-size: 20px">
                                            把原经办人：
                                            <select name="OLD_OPERATOR" id="OLD_OPERATOR" class="selectpicker bla bla bli" title="选择经办人"
                                                    data-style="btn-info" data-width="150px" data-height="31px" data-live-search="true"
                                                    style="vertical-align:top;width: 150px;" >
                                                <option value=""></option>
                                                <c:forEach items="${listOperator}" var="var" varStatus="vs">
                                                    <option id="${var.ONAME}" value="${var.ONAME}" name="${var.ONAME}">${var.ONAME}</option>
                                                </c:forEach>
                                            </select><label style="color: red;font-size: 17px">  *</label>
                                            的合同信息移交给新经办人：
                                            <select name="NEW_OPERATOR" id="NEW_OPERATOR" class="selectpicker bla bla bli" title="选择经办人"
                                                    data-style="btn-info" data-width="150px" data-height="31px" data-live-search="true"
                                                    style="vertical-align:top;width: 150px;" >
                                                <option value="" ></option>
                                                <c:forEach items="${listOperator}" var="var" varStatus="vs">
                                                    <option id="${var.ONAME}" value="${var.ONAME}" name="${var.ONAME}">${var.ONAME}</option>
                                                </c:forEach>
                                            </select><label style="color: red;font-size: 17px">  *</label>
                                        </th>
                                    </tr>
                                </table>
                            </div>
                            <div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img
                                    src="static/images/jiazai.gif"/><br/><h4 class="lighter block green">提交中...</h4></div>
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
</div>
<!-- /.main-container -->


<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());

    $(window).on('load', function () {
        $('.selectpicker').selectpicker({
            'selectedText': 'cat',
        });
        // $('.selectpicker').selectpicker('hide');
    });
    function save(){
        if($("#OLD_OPERATOR").val()==""){
            $("#OLD_OPERATOR").tips({
                side:3,
                msg:'请选择原经办人',
                bg:'#AE81FF',
                time:2
            });
            $("#OLD_OPERATOR").focus();
            return false;
        }
        if($("#NEW_OPERATOR").val()==""){
            $("#NEW_OPERATOR").tips({
                side:3,
                msg:'请选择新经办人',
                bg:'#AE81FF',
                time:2
            });
            $("#NEW_OPERATOR").focus();
            return false;
        }
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }


    /* $(function () {
         //日期框
         $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
     });*/
</script>
</body>
</html>