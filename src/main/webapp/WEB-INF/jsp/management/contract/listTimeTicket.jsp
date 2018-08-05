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
                        <form action="contract/listTimeTicket.do" method="post" name="Form" id="Form">
                            <%--<table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input"
                                                   id="nav-search-input" autocomplete="off" name="CONTRACTNUM"
                                                   value="${pd.CONTRACTNUM }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
                                            <input type="hidden" value="${pd.USERNAME}" name="USERNAME" id="USERNAME" />
										</span>
                                        </div>
                                    </td>
                                    <c:if test="${isDept  == 1}">
                                        <td style="padding-left:12px;">
                                            <label style="margin-top: 5px">部门:</label>
                                            <select name="DEPTNAME" id="DEPTNAME" data-placeholder=""
                                                    style="vertical-align:top;width: 110px;" onchange="selectType(this.value);">
                                                <option value="${pd.DEPTNAME}" name="${pd.DEPTNAME}">${pd.DEPTNAME}</option>
                                                <c:forEach items="${listDept}" var="var" varStatus="vs">
                                                    <option  value="${var.DEPTNAME}" >${var.DEPTNAME}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </c:if>
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
                                    <c:if test="${QX.cha == 1 }">
                                        <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"
                                                                                           onclick="tosearch();" title="检索"><i
                                                id="search-icon"
                                                class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                    </c:if>
                                    <c:if test="${QX.toExcel == 1 }">
                                        <td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs"
                                                                                            onclick="toExcel();" title="导出到EXCEL"><i
                                                id="nav-search-icon"
                                                class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
                                    </c:if>
                                </tr>
                            </table>--%>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">合同名称</th>
                                    <th class="center">合同编号</th>
                                    <th class="center">签约方</th>
                                    <th class="center">客户联系人姓名</th>
                                    <th class="center">联系电话</th>
                                    <th class="center">项目</th>
                                    <th class="center">招待票(张)</th>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr id="${var.CONTRACT_ID}" ondblclick="show_contract('${var.CONTRACT_ID}')" onclick="changeColor('${var.CONTRACT_ID}');list_one('${var.CONTRACT_ID}','${var.CONTRACTTYPES}','${var.CONTRACTNAME}')">
                                                    <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                    <td class='center'>${var.CONTRACTNAME}</td>
                                                    <td class='center'>${var.CONTRACTNUM}
                                                        <c:if test="${var.RELEVANCE_ID != '' && var.RELEVANCE_ID != null}">
                                                            <span style="margin-left: 20px" class="red"><i class="ace-icon fa fa-exchange bigger-50"></i></span>
                                                        </c:if>
                                                    </td>
                                                    <td class='center'>${var.CONTRACTOFNAME}</td>
                                                    <td class='center'>${var.CLIENT}</td>
                                                    <td class='center'>${var.TELEPHONE}</td>
                                                    <td class='center'>${var.PROJECT}</td>
                                                    <td class='center'>${var.INVITATIONTICKET}</td>
                                                    <td class="center">
                                                        <a class="btn btn-xs btn-danger" style="background-color: red" title="取票"
                                                           onclick="getTicket('${var.CONTRACT_ID}')">
                                                            <i class="ace-icon glyphicon glyphicon-tags bigger-120 " title="取票">取票</i>
                                                        </a>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>

                                </tbody>

                            </table>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                           <%-- <label class="control-label" >显示全部：</label>
                                            <label style="margin-top: 5px;margin-right: 15px">
                                                <input onclick="showAlltd(this)"  name="switch-field-1" class="ace ace-switch ace-switch-5" type="checkbox">	<span class="lbl"></span>
                                            </label>--%>
                                        </td>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>

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

<script src="static/dist/jquery.magnify.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态


    function getTicket(CONTRACT_ID){
        bootbox.confirm("确定取票?", function (result) {
            if (result) {
                $.ajax({
                    type: "POST",
                    url: '<%=basePath%>contract/getTicket',
                    data: {CONTRACT_ID: CONTRACT_ID},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        tosearch();
                    }
                });
            }
        });

    }

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



    //导出excel
    function toExcel() {
        window.location.href = '<%=basePath%>contract/excel.do';
    }
</script>


</body>
</html>