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

                        <form action="filecatalog/${msg }.do" name="Form" id="Form" method="post">
                            <input type="hidden" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}"/>
                            <div id="zhongxin" style="padding-top: 13px;">
                                <table id="table_report" class="table table-striped table-bordered table-hover">
                                    <tr>
                                        <td style="width:155px;text-align: right;padding-top: 13px;">选择文件格式:</td>
                                        <td>
                                            <select name="type" id="type" data-placeholder=""
                                                    style="vertical-align:top;width: 150px;" onchange="selectType(this.value)">
                                                <option value="图片" name="图片">图片</option>
                                                <option value="PDF" name="PDF">PDF</option>
                                                <option value="word" name="word">word</option>
                                                <option value="Excel" name="Excel">Excel</option>
                                                <option value="PPT" name="PPT">PPT</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">当前目录:</td>
                                        <td><input readonly="readonly" type="text" name="" value="${pd.FNAME}" maxlength="32"
                                                   placeholder="这里输入FPARENTID" title="FPARENTID" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
                                        <td><input type="text" name="FREMAK" id="FREMAK" value="${pd.FREMAK}" maxlength="255"
                                                   placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="10">
                                            <a class="btn btn-mini btn-primary"
                                               onclick="add('${pd.FITEMID}','${pd.FNAME}');">添加</a>
                                            <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                        </td>
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
    //保存
    function add(FITEMID, FNAME) {
        var type = $("#type").val();
        if (type == "图片") {
            var diag = new top.Dialog();
            diag.Drag = true;
            diag.Title = "新增图片";
            diag.URL = '<%=basePath%>fileupata/goAddPic.do?FITEMID=' + FITEMID+'&FNAME='+FNAME;
            diag.Width = 800;
            diag.Height = 490;
            diag.CancelEvent = function () { //关闭事件

                diag.close();
                //tosearch();
            };
            diag.show();
        }else {
            var diag = new top.Dialog();
            diag.Drag = true;
            diag.Title = "新增图片";
            diag.URL = '<%=basePath%>fileupata/goAddFile.do?FITEMID=' + FITEMID+'&FNAME='+FNAME;
            diag.Width = 800;
            diag.Height = 490;
            diag.CancelEvent = function () { //关闭事件

                diag.close();
                //tosearch();
            };
            diag.show();
        }

    }

    $(function () {
        //日期框
        $('.date-picker').datepicker({autoclose: true, todayHighlight: true});
    });
</script>
</body>
</html>