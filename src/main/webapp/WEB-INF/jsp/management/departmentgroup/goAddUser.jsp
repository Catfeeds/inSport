<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <br>
                    <div class="" style="text-align: left;margin-left: 10px">
                        <a class="btn btn-mini btn-primary" onclick="saveInfo()">保存</a> <a
                            class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                    </div>

                    <br>
                    <div class="col-xs-12">
                        <!-- ------------------------------------------------------------------------------- -->
                        <form action="departmentgroup/save.do" name="Form" id="Form"
                              method="post">
                            <input type="hidden" value="${pd.USERS}"
                                   name="USERS" id="USERS"/>
                            <input type="hidden" value="${pd.pid}"
                                   name="pid" id="pid"/>
                            <%--<input
                                type="hidden" value="${pd.QYWXUSER_ID}" name="QYWXUSER_ID"
                                id="QYWXUSER_ID" />--%>
                            <table class="table table-border table-bg table-bordered">
                                <tbody>
                                <tr class="warning">
                                    <th width="20%"><label>部门名称：${pd.pname}</label>
                                    </th>
                                </tr>

                                </tbody>
                            </table>
                        </form>
                        <form action="departmentgroup/goAddUser" method="post" name="Search" id="Search">
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
													<span class="input-icon">
														<input style="width: 150px" type="text" class="nav-search-input"
                                                               id="nav-search-input"
                                                               name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
                                                         <input type="hidden" value="${pd.pid}"
                                                                name="pid" id="pid1"/>
														<i class="ace-icon fa fa-search nav-search-icon"></i>
													</span>
                                        </div>
                                    </td>
                                    <%--<input type="hidden" value="${pd.p_treeKey}" name="p_treeKey" id="p_treeKey" />--%>
                                    <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs"
                                                                                       onclick="tosearch();" title="检索"><i
                                            id="nav-search-icon"
                                            class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                </tr>
                            </table>
                        </form>
                        <c:set var="theString" value="${listUsers}"/>
                        <% int i = 1; %>
                        <table width="100%" border="2" bordercolor="#a0c6e5" style="margin-top: 10px">
                            <c:forEach items="${listUsers}" var="var" varStatus="vs">
                                <% if (i % 5 == 1) { %>
                                　　<tr>
                                　　<% } %>
                                　　<td nowrap align="center" >
                                <label style="float:left;padding-left:10px;padding-top:7px;text-align: center;">
                                    <input name="checkbox1" type="checkbox"
                                        <%--<c:if test="${fn:contains(theString,var.USER_ID)}"> checked="checked" </c:if>--%>
                                           class="ace" id="${var.NAME}" value="${var.USER_ID}">
												<span class="lbl" style="width:90%;margin: 7px;
														border-radius: 5px;padding: 6px">
													用户名称：${var.NAME}<br>
                                </td>
                                　　<% if (i % 5 == 0) { %>
                                　　</tr>
                                　　<% }
                                i++; %>
                            </c:forEach>
                        </table>

                        <!-- ------------------------------------------------------------------------------- -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.page-content -->
        </div>
    </div>
    <!-- /.main-content -->


    <!-- 返回顶部 -->
    <a href="#" id="btn-scroll-up"
       class="btn-scroll-up btn btn-sm btn-inverse"> <i
            class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<script type="text/javascript">
    $(top.hangge());

    function tosearch() {
        $("#Search").submit();
    }

    function saveInfo() {
        jqchk();
        $("#Form").submit();
    }

    function jqchk() { //jquery获取复选框值

        var jsonstr = '[';
        $('input[name="checkbox1"]:checked').each(function () {
                    jsonstr += '{';
                    jsonstr += '"DNAME":"' + $(this).attr("id") + '",';
                    jsonstr += '"UID":"' + $(this).val();
                    jsonstr += '"}';
                    jsonstr += ',';
                }
        );
        jsonstr = jsonstr.substring(0, jsonstr.length - 1);
        jsonstr += ']';
        //$("#FITEMIDs").val(jsonstr);
        /*var chk_value = [];
         $('input[name="checkbox1"]:checked').each(function() {
         chk_value.push($(this).val());
         });
         alert(jsonstr);*/
        $("#USERS").val(jsonstr);
    }
</script>


</body>
</html>