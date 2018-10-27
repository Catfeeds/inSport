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
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="static/dist/jquery.magnify.min.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
    <style>
        .magnify-modal {
            box-shadow: 0 0 6px 2px rgba(0, 0, 0, 0.3);
        }

        .magnify-header .magnify-toolbar {
            width: 40px;
            background-color: rgba(0, 0, 0, .5);
        }

        .magnify-stage {
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            border-width: 0;
        }

        .magnify-footer .magnify-toolbar {
            display: inline-block;
            height: 40px;
            background-color: rgba(0, 0, 0, .5);
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
        }

        .magnify-stage img {
            width: 0;
        }

        .magnify-loading {
            background-color: transparent;
        }

        /* 表格容器样式，用flex布局可保证table内容能铺满剩余空间 */
        .sti-tbl-container {
            height : 600px;
            overflow : hidden;
            display : flex;
            flex-direction: column;
        }
        /* 设置表格的布局方式，用于宽度对齐 */
        .sti-tbl-body>table, .sti-tbl-header>table {
            table-layout: fixed;
            overflow-y : scroll;
        }
        /* 设置表格内容容器，用于铺满整个剩余空间 */
        .sti-tbl-container .sti-tbl-body {
            flex-grow : 1;
            overflow-y : scroll;
        }

    </style>
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

                        <!-- 检索  -->
                        <form action="reports/listNotPayDetail.do?CONTRACTNUM=${pd.CONTRACTNUM}" method="post" name="Form" id="Form">
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input"
                                                   id="CONTRACTNUM" autocomplete="off" name="CONTRACTNUM"
                                                   value="${pd.CONTRACTNUM}" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
                                            <input type="hidden" value="${pd.USERNAME}" name="USERNAME" id="USERNAME" />
										</span>
                                        </div>
                                    </td>
                                    <td style="padding-left:12px;">
                                        <label style="margin-top: 5px">部门:</label>
                                        <select name="DEPTNAME" id="DEPTNAME" data-placeholder=""
                                                style="vertical-align:top;width: 110px;" >
                                            <option value="${pd.DEPTNAME}" name="${pd.DEPTNAME}">${pd.DEPTNAME}</option>
                                            <c:forEach items="${listDept}" var="var" varStatus="vs">
                                                <option  value="${var.DEPTNAME}" >${var.DEPTNAME}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td style="padding-left:12px;">
                                        <label style="margin-top: 5px">年份:</label>
                                        <select name="YEAR" id="YEAR" data-placeholder=""
                                                style="vertical-align:top;width: 120px;" onchange="selectType(this.value);">
                                            <option value="${pd.YEAR}" name="${pd.YEAR}">${pd.YEAR}</option>
                                        </select>
                                    </td>
                                    <td style="padding-left:12px;">
                                        <label>合同金额区间:</label>
                                        <input type="number" placeholder="输入金额" style="width: 110px" class="nav-search-input"
                                               id="picStart" autocomplete="off" name="picStart"
                                               value="${pd.picStart }" />  -至-
                                        <input type="number" placeholder="输入金额" style="width: 110px" class="nav-search-input"
                                               id="picEnd" autocomplete="off" name="picEnd"
                                               value="${pd.picEnd }" />
                                    </td>
                                    <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"
                                                                                       onclick="tosearch();" title="检索"><i
                                            id="search-icon"
                                            class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                    <td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs"
                                                                                        onclick="toExcel();" title="导出到EXCEL"><i
                                            id="nav-search-icon"
                                            class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
                                </tr>
                            </table>
                            <!-- 检索  -->
                            <div class="sti-tbl-container">
                                <!-- 表头容器，必须留出17px的滚动条位置 -->
                                <div class="sti-tbl-header" style="padding-right:17px;">
                                    <table class="table table-bordered" style="margin-bottom: 0px;border-bottom-style: none;">
                                        <tr style="background-color: #99CCCC">
                                            <th class="center" style="width:5%;">序号</th>
                                            <th style="width:20%;" class="center">合同编号
                                            </th>
                                            <th style="width:15%;" class="center">合同名称
                                            </th>
                                            <th style="width:40%;" class="center">项目
                                            </th>
                                            <th style="width:10%;" class="center">合同金额
                                            </th>
                                            <th style="width:10%;" class="center">应付金额
                                            </th>
                                            <th style="width:10%;" class="center">应付时间
                                            </th>
                                            <th style="width:10%;" class="center">付款时间
                                            </th>
                                            <th style="width:10%;" class="center">付款金额
                                            </th>
                                            <th style="width:10%;" class="center">未付款金额
                                            </th>
                                        </tr>
                                    </table>
                                </div>
                                <!-- 表格内容容器-->
                                <div class="sti-tbl-body">
                                    <table class="table table-bordered">
                                        <tbody>
                                        <!-- 开始循环 -->
                                        <c:choose>
                                            <c:when test="${not empty varList}">
                                                <c:set value="" var="CONTRACTNUM" ></c:set>
                                                <c:set value="0" var="count" ></c:set>
                                                <c:forEach items="${varList}" var="var1" varStatus="vs1">
                                                    <c:if test="${vs1.index == 0 }">
                                                        <c:set value="${var1.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                                    </c:if>
                                                    <c:if test="${var1.CONTRACTNUM == CONTRACTNUM }">
                                                        <c:set value="${count + 1}" var="count" ></c:set>
                                                    </c:if>
                                                </c:forEach>
                                                <c:set value="" var="CONTRACTNUM" ></c:set>
                                                <c:forEach items="${varList}" var="var" varStatus="vs">
                                                    <tr id="${var.CONTRACT_ID}" ondblclick="show_contract('${var.CONTRACT_ID}')" onclick="changeColor('${var.CONTRACT_ID}');list_one('${var.CONTRACT_ID}','${var.CONTRACTTYPES}','${var.CONTRACTNAME}')">
                                                        <td  class='center' style="width:5%;">${vs.index+1}</td>
                                                        <c:if test="${var.CONTRACTNUM != CONTRACTNUM }">
                                                            <c:set value="0" var="count" ></c:set>
                                                            <c:forEach items="${varList}" var="var2" varStatus="vs2">
                                                                <c:set value="${var.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                                                <c:if test="${var2.CONTRACTNUM == CONTRACTNUM }">
                                                                    <c:set value="${count + 1}" var="count" ></c:set>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:set value="" var="CONTRACTNUM" ></c:set>
                                                        </c:if>
                                                        <c:if test="${var.CONTRACTNUM != CONTRACTNUM }">
                                                            <td class='center' style="vertical-align:middle;width:20%;" rowspan="${count}">${var.CONTRACTNUM}</td>
                                                            <td class='center' style="vertical-align:middle;width:15%;" rowspan="${count}">${var.CONTRACTNAME}</td>
                                                            <td class='center' style="vertical-align:middle;width:40%;" rowspan="${count}">${var.PROJECT}</td>
                                                            <td class='center' style="vertical-align:middle;width:10%;" rowspan="${count}">${var.CONTRACTPIC}</td>
                                                        </c:if>
                                                        <c:set value="${var.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                                        <td style="width:10%;" class='center'>${var.SHPAY}</td>
                                                        <td style="width:10%;" class='center'>${var.SHPAYTIME}</td>
                                                        <td style="width:10%;" class='center'>${var.REALITYPAYTIME}</td>
                                                        <td style="width:10%;" class='center'>${var.REALITYPAY}</td>
                                                        <td style="width:10%;" class='center'>${var.ONPAYPIC}</td>

                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr class="main_info">
                                                    <td colspan="100" class="center">没有相关数据</td>
                                                </tr>
                                                <c:if test="${pd.ex != null }">
                                                    <tr>
                                                        <td colspan="100" class="center">${pd.ex}</td>
                                                    </tr>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <%--<table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">合同编号
                                    </th>
                                    <th class="center">合同名称
                                    </th>
                                    <th class="center">项目
                                    </th>
                                    <th class="center">合同金额
                                    </th>
                                    <th class="center">应付金额
                                    </th>
                                    <th class="center">应付时间
                                    </th>
                                    <th class="center">付款时间
                                    </th>
                                    <th class="center">付款金额
                                    </th>
                                    <th class="center">未付款金额
                                    </th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <c:set value="" var="CONTRACTNUM" ></c:set>
                                        <c:set value="0" var="count" ></c:set>
                                        <c:forEach items="${varList}" var="var1" varStatus="vs1">
                                            <c:if test="${vs1.index == 0 }">
                                                <c:set value="${var1.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                            </c:if>
                                            <c:if test="${var1.CONTRACTNUM == CONTRACTNUM }">
                                                <c:set value="${count + 1}" var="count" ></c:set>
                                            </c:if>
                                        </c:forEach>
                                        <c:set value="" var="CONTRACTNUM" ></c:set>
                                        <c:forEach items="${varList}" var="var" varStatus="vs">
                                            <tr id="${var.CONTRACT_ID}" ondblclick="show_contract('${var.CONTRACT_ID}')" onclick="changeColor('${var.CONTRACT_ID}');list_one('${var.CONTRACT_ID}','${var.CONTRACTTYPES}','${var.CONTRACTNAME}')">
                                                <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                <c:if test="${var.CONTRACTNUM != CONTRACTNUM }">
                                                    <c:set value="0" var="count" ></c:set>
                                                    <c:forEach items="${varList}" var="var2" varStatus="vs2">
                                                        <c:set value="${var.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                                        <c:if test="${var2.CONTRACTNUM == CONTRACTNUM }">
                                                            <c:set value="${count + 1}" var="count" ></c:set>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:set value="" var="CONTRACTNUM" ></c:set>
                                                </c:if>
                                                <c:if test="${var.CONTRACTNUM != CONTRACTNUM }">
                                                    <td class='center' style="vertical-align:middle;" rowspan="${count}">${var.CONTRACTNUM}</td>
                                                    <td class='center' style="vertical-align:middle;" rowspan="${count}">${var.CONTRACTNAME}</td>
                                                    <td class='center' style="vertical-align:middle;" rowspan="${count}">${var.PROJECT}</td>
                                                    <td class='center' style="vertical-align:middle;" rowspan="${count}">${var.CONTRACTPIC}</td>
                                                </c:if>
                                                <c:set value="${var.CONTRACTNUM}" var="CONTRACTNUM" ></c:set>
                                                <td class='center'>${var.SHPAY}</td>
                                                <td class='center'>${var.SHPAYTIME}</td>
                                                <td class='center'>${var.REALITYPAYTIME}</td>
                                                <td class='center'>${var.REALITYPAY}</td>
                                                <td class='center'>${var.ONPAYPIC}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                        <c:if test="${pd.ex != null }">
                                            <tr>
                                                <td colspan="100" class="center">${pd.ex}</td>
                                            </tr>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>

                                </tbody>

                            </table>--%>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>

                    </div>
                    <%--<table style="margin-top:-5px;">
                        <div style="width: 100%;height: 100%">
                            <iframe id="iframe" frameborder="0" scrolling="no" style="width: 100%;display: none;height: 200px" src=""></iframe>
                        </div>
                    </table>
                    <div>
                        <ul class="ace-thumbnails clearfix" id="imgList">
                            <!-- #section:pages/gallery -->
                            <li style="display: none;">
                                <a href="" data-rel="colorbox">
                                    <img width="150" height="150" alt="150x150" src=""/>
                                </a>
                            </li>
                        </ul>
                    </div><!-- PAGE CONTENT ENDS -->--%>

                    <!-- /.col -->
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

<script src="static/dist/jquery.magnify.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态

    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }
    $(function () {
        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                    .off('resize.chosen')
                    .on('resize.chosen', function () {
                        $('.chosen-select').each(function () {
                            var $this = $(this);
                            $this.next().css({'width': $this.parent().width()});
                        });
                    }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }


        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });
    });

    function selectDate(){
        var option = "";
        var now = new Date();
        var year=now.getFullYear();
        //$("#CONTRACTCLASSIFY").find("option").remove();
        for(var a=0;a<=15;a++){
            option += "<option value=" + year +">" + year +"</option>";
            //document.write("<option>"+year+"</option>");
            year=year-1;

        }
        $("#YEAR").append(option);
        /* for(var i=0;i < listCheClassify.length;i++){
         option += "<option id="+listCheClassify[i].FITEMID+" value="+listCheClassify[i].FNAME+
         " name="+listCheClassify[i].FNAME+">"+listCheClassify[i].FNAME+"</option>";
         }
         $("#CONTRACTCLASSIFY").append(option);*/
    }

    selectDate();
    //导出excel
    function toExcel() {
        var picStart = $("#picStart").val();
        var picEnd = $("#picEnd").val();
        var YEAR = $("#YEAR").val();
        var DEPTNAME = $("#DEPTNAME").val();
        var CONTRACTNUM = $("#CONTRACTNUM").val();
        window.location.href = '<%=basePath%>toexcel/excel_NotPay.do?picStart='+picStart+'&picEnd='+picEnd+'&YEAR='+YEAR+'&DEPTNAME='+DEPTNAME+
                '&CONTRACTNUM='+CONTRACTNUM;
    }
</script>


</body>
</html>