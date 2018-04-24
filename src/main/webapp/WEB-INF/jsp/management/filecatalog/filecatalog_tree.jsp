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
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
    <script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
    <link type="text/css" rel="stylesheet"
          href="plugins/zTree/3.5/zTreeStyle.css"/>
    <%--<link type="text/css" rel="stylesheet"
          href="plugins/zTree/css/demo.css"/>--%>
    <script type="text/javascript"
            src="plugins/zTree/2.6/jquery.ztree-2.6.min.js"></script>
    <script type="text/javascript"
            src="plugins/zTree/3.5/jquery.ztree.core-3.5.js"></script>
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
                        <table style="width:100%;" border="0">
                            <tr>
                                <td style="width:15%;" valign="top" bgcolor="#F9F9F9">
                                    <ul id="treeDemo" class="ztree"></ul>
                                </td>
                                <td style="width:85%;" valign="top">
                                    <iframe
                                            name="treeFrame" id="treeFrame" frameborder="0"
                                            src="<%=basePath%>filecatalog/file_load"
                                    <%-- src="<%=basePath%>http/getCommodity" --%>
                                            style="margin:0 auto;width:100%;height:100%;"></iframe>
                                </td>
                            </tr>
                        </table>
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
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
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
    var zNodes;
    $(function () {
        $.ajax({
            async: false,
            cache: false,
            type: 'POST',
            //dataType:"String",
            url: '<%=basePath%>filecatalog/dateTree',
            success: function (data) {
                //alert(data) ;
                zNodes = data;
            },
            error: function () {
                alert("请求失败");
            }
        });

    });
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onRightClick : function(event, treeId, treeNode) {
                var FPARENTID = treeNode.id;
                var PNAME = treeNode.name;
                top.jzts();
                var diag = new top.Dialog();
                diag.Drag=true;
                diag.Title ="新增目录";
                diag.URL = '<%=basePath%>filecatalog/goAdd.do?FPARENTID='+FPARENTID+"&PNAME="+PNAME;
                diag.Width = 450;
                diag.Height = 355;
                diag.Modal = true;				//有无遮罩窗口
                diag. ShowMaxButton = true;	//最大化按钮
                diag.ShowMinButton = true;		//最小化按钮
                diag.CancelEvent = function(){ //关闭事件
                    $.ajax({
                        async: false,
                        cache: false,
                        type: 'POST',
                        //dataType:"String",
                        url: '<%=basePath%>filecatalog/dateTree',
                        success: function (data) {
                            //alert(data) ;
                            zNodes = data;
                        },
                        error: function () {
                            alert("请求失败");
                        }
                    });
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    var hmainT = document.getElementById("treeFrame");
                    var bheightT = document.documentElement.clientHeight;
                    hmainT.style.width = '100%';
                    hmainT.style.height = (bheightT - 50) + 'px';
                    diag.close();
                };
                diag.show();
            },
            onClick: function (event, treeId, treeNode, clickFlag) {
                // 判断是否父节点
                if (!treeNode.isParent) {
                    /* alert("treeId自动编号：" + treeNode.tId + ", 节点id是："
                     + treeNode.id + ", 节点文本是：" + treeNode.name); */

                }
                //var treeKey = encodeURI(encodeURI(treeNode.name));
                var FPARENTID = treeNode.id;
                if (treeNode.id == 1) {
                    keywords = "";
                    $("#treeFrame").attr("src", '<%=basePath%>filecatalog/file_load?FPARENTID='+FPARENTID);
                }
                $("#treeFrame").attr("src", '<%=basePath%>filecatalog/file_load?FPARENTID='+FPARENTID);
                //$("#treeFrame").attr("src","http://www.baidu.com");
            }
        }
    };

    // 渲染
    $(document).ready(function () {
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        var hmainT = document.getElementById("treeFrame");
        var bheightT = document.documentElement.clientHeight;
        hmainT.style.width = '100%';
        hmainT.style.height = (bheightT - 50) + 'px';
    });


</script>


</body>
</html>