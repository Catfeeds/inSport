<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <style>
        .float_div {
            position: absolute;
            width: 40px;
            height: 40px;
            /* border: 1px solid red; */
            /* margin-right:0px;*/
            margin-top: 10px;
            right: 10px;
            /* top: -0px; */
            float: right;
            z-index: 100;
            border-radius: 10px;
            /* background-color: yellow; */
        }

        .delfloat_div {
            position: absolute;
            width: 40px;
            height: 40px;
            /* border: 1px solid red; */
            /* margin-right:0px;*/
            margin-top: 10px;
            left: 10px;
            /* top: -0px; */
            float: right;
            z-index: 100;
            border-radius: 10px;
            /* background-color: yellow; */
        }

    </style>
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
    <link rel="stylesheet" href="static/webContextMenu/css/web.contextmenu.css"/>
    <link rel="stylesheet" href="static/dist/jquery.magnify.min.css"/>
    <script src="static/webContextMenu/js/web.contextmenu.js"></script>
</head>
<body class="no-skin" id="rightj">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
    <!-- /section:basics/sidebar -->
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <table style="margin-top:5px;">
                            <tr>
                                <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" title="当前目录">当前目录:<c:if test="${pd.FNAME == null }">根目录</c:if><c:if test="${not empty pd.FNAME}">${pd.FNAME}</c:if></a></td>
                                <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="editFileName();"  title="修改文件名称">修改文件名称<i id="nach-icon" class="ace-icon fa fa-cog bigger-110 nav-search-icon green"></i></a></td>
                                <td style="vertical-align:top;padding-left:2px"><a class="btn btn-light btn-xs" onclick="deletes();"  title="检索">删除文件<i id="nav-search-icon" class="ace-icon fa fa-cogs bigger-110 nav-search-icon red"></i></a></td>
                                <td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="downs();" title="下载文件">下载文件<i id="downfile" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i></a></td>
                            </tr>
                        </table>
                        <div>
                            <ul class="ace-thumbnails clearfix" id="imgList">
                                <li style="border:none;margin-top: 30px" id="back"
                                    style="margin-top: 30px;margin-left:35px;margin-right:80px;">
                                    <a ondblclick="javascript:history.back(-1)" data-rel="colorbox" class="cboxElement">
                                        <img width="120" height="120" alt="200x200"
                                             src="static/filecatalog/images/super-mono-3d-part2-46.png"/>
                                        <div class="text">
                                            <div class="inner">返回上一页</div>
                                        </div>
                                    </a>
                                    <%--<div style="width: 100%;height: 25px" align="center" >
                                        <p>${var.FNAME}</p>
                                    </div>--%>
                                </li>
                                <c:choose>
                                    <c:when test="${not empty list_catalog}">

                                        <c:forEach items="${list_catalog}" var="var" varStatus="vs">
                                            <li style="border:none;margin-top: 30px">
                                                <a ondblclick="openFile('${var.FITEMID}','${var.FNAME}')" data-rel="colorbox"
                                                   class="cboxElement">
                                                    <img width="120" height="120" alt="200x200"
                                                         src="static/filecatalog/images/fileexplorer.png"/>
                                                    <div class="text">
                                                        <div class="inner">双击打开</div>
                                                    </div>
                                                </a>
                                                <div style="width: 100%;height: 25px" align="center">
                                                    <p>${var.FNAME}</p>
                                                </div>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="100" class="center">您无权查看该文件夹内容</td>
                                            </tr>
                                        </c:if>
                                    </c:when>
                                    <%--<c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center" >文件夹为空</td>
                                        </tr>
                                    </c:otherwise>--%>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${not empty list_files_NotENCTYPT}">
                                        <c:forEach items="${list_files_NotENCTYPT}" var="var" varStatus="vs">
                                            <c:if test="${fn:contains(var.FILE_TYPE,'image')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                            style="width: 120px;"
                                                           data-rel="colorbox" class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img width="120" height="110";
                                                                 src="<%=basePath%>${var.FILE_URL}" alt="">
                                                            <a title="${var.FILENAME}" data-magnify="gallery"
                                                            data-caption="Paraglider flying over Aurlandfjord,
                                                            Norway by framedbythomas" href="<%=basePath%>${var.FILE_URL}">
                                                                 <div  name="inner">   ${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'pdf')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                           data-rel="colorbox"  style="width: 120px;"
                                                           class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img   width="120" height="110" alt="200x200"
                                                                 src="static/filecatalog/images/application-pdf.png"/>
                                                            <a onclick=" wep_open('<%=basePath%>${var.FILE_URL}','${var.FILENAME}')" class="text"
                                                                 style="margin-top: 15px">
                                                                <div name="inner" class="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'word')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                           data-rel="colorbox"  style="width: 120px;"
                                                           class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img  width="120" height="110" alt="200x200"
                                                                 src="static/filecatalog/images/file-word-icon.png"/>
                                                                <div name="inner" class="inner">${var.FILENAME}</div>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'sheet')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                            data-rel="colorbox"  style="width: 120px;"
                                                           class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img  width="120" height="110" alt="200x200"
                                                                 src="static/filecatalog/images/excel.png"/>
                                                                <div  class="inner">${var.FILENAME}</div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="100" class="center">您无权查看该文件夹内容</td>
                                            </tr>
                                        </c:if>
                                    </c:when>
                                </c:choose>
                                <!-- 自己加密的文件 listENCTYPTByYourself-->
                                <c:choose>
                                    <c:when test="${not empty listENCTYPTByYourself}">
                                        <c:forEach items="${listENCTYPTByYourself}" var="var" varStatus="vs">
                                            <c:if test="${fn:contains(var.FILE_TYPE,'image')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <div ondblclick="editJurisdiction('${var.FILEMEANS_ID}')"
                                                             onclick="toSelect('${var.FILEMEANS_ID}')"
                                                             style="width: 120px;"
                                                             data-rel="colorbox" class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img width="120" height="110";
                                                                 src="<%=basePath%>${var.FILE_URL}" alt="">
                                                            <a title="${var.FILENAME}" data-magnify="gallery"
                                                               data-caption="Paraglider flying over Aurlandfjord,
                                                            Norway by framedbythomas" href="<%=basePath%>${var.FILE_URL}">
                                                                <div style="color: red"  name="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'pdf')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                             data-rel="colorbox"  style="width: 120px;"
                                                             class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img   width="120" height="110" alt="200x200"
                                                                   src="static/filecatalog/images/application-pdf.png"/>
                                                            <a onclick=" wep_open('<%=basePath%>${var.FILE_URL}','${var.FILENAME}')" class="text"
                                                               style="margin-top: 15px">
                                                                <div style="color: red" name="inner" class="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'word')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                             data-rel="colorbox"  style="width: 120px;"
                                                             class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img  width="120" height="110" alt="200x200"
                                                                  src="static/filecatalog/images/file-word-icon.png"/>
                                                            <div style="color: red" name="inner" class="inner">${var.FILENAME}</div>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'sheet')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">

                                                        <div onclick="toSelect('${var.FILEMEANS_ID}')"
                                                             data-rel="colorbox"  style="width: 120px;"
                                                             class="cboxElement">
                                                            <div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img  width="120" height="110" alt="200x200"
                                                                  src="static/filecatalog/images/excel.png"/>
                                                            <div style="color: red" class="inner">${var.FILENAME}</div>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="100" class="center">您无权查看该文件夹内容</td>
                                            </tr>
                                        </c:if>
                                    </c:when>
                                </c:choose>
                                <!-- 加密后的文件显示 -->
                                <c:choose>
                                    <c:when test="${not empty list_files_ENCTYPT}">
                                        <c:forEach items="${list_files_ENCTYPT}" var="var" varStatus="vs">
                                            <c:if test="${fn:contains(var.FILE_TYPE,'image')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <div onclick="openByPW('${var.FILEMEANS_ID}');" <%--onclick="toSelect('${var.FILEMEANS_ID}')"--%>
                                                             style="width: 120px;"
                                                             data-rel="colorbox" class="cboxElement">
                                                            <%--<div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                                 class="float_div"
                                                                 style="display: none">
                                                                <img src="static/images/Smile.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>--%>
                                                            <div  name="${var.FILE_URL}" id="del${var.FILEMEANS_ID }"
                                                                  class="delfloat_div"
                                                                  style="display: none">
                                                                <img src="static/images/trash_can.png"
                                                                     style="width: 35px;height: 35px"/>
                                                            </div>
                                                            <img width="120" height="110";
                                                                 src="static/filecatalog/images/locked.png" alt="">
                                                            <a >
                                                                <div  name="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'pdf')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <%--<div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                             class="float_div"
                                                             style="display: none">
                                                            <img src="static/images/Smile.png"
                                                                 style="width: 35px;height: 35px"/>
                                                        </div>--%>
                                                        <div onclick="openByPW('${var.FILEMEANS_ID}');"
                                                             data-rel="colorbox"
                                                             class="cboxElement">
                                                            <img   width="120" height="110" alt="200x200"
                                                                   src="static/filecatalog/images/locked.png"/>
                                                            <a onclick=" wep_open('<%=basePath%>${var.FILE_URL}','${var.FILENAME}')" class="text"
                                                               style="margin-top: 15px">
                                                                <div name="inner" class="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'word')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <%--<div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                             class="float_div"
                                                             style="display: none">
                                                            <img src="static/images/Smile.png"
                                                                 style="width: 35px;height: 35px"/>
                                                        </div>--%>
                                                        <div onclick="openByPW('${var.FILEMEANS_ID}');"
                                                             data-rel="colorbox"
                                                             class="cboxElement">
                                                            <img  width="120" height="110" alt="200x200"
                                                                  src="static/filecatalog/images/locked.png"/>
                                                            <div class="text" style="margin-top: 15px">
                                                                <div name="inner" class="inner">${var.FILENAME}</div>
                                                            </div>
                                                        </div>
                                                            <%--<div style="width: 100%;height: 25px" align="center" >
                                                                <p>${var.FILE_CATALOGURL}</p>
                                                            </div>--%>
                                                    </div>
                                                </li>
                                            </c:if>
                                            <c:if test="${fn:contains(var.FILE_TYPE,'sheet')}">
                                                <li style="border:none;margin-top: 30px;margin-left: 15px">
                                                    <div align="center">
                                                        <%--<div name="${var.FILE_URL}" id="${var.FILEMEANS_ID }"
                                                             class="float_div"
                                                             style="display: none">
                                                            <img src="static/images/Smile.png"
                                                                 style="width: 35px;height: 35px"/>
                                                        </div>--%>
                                                        <div onclick="openByPW('${var.FILEMEANS_ID}');"
                                                             data-rel="colorbox"
                                                             class="cboxElement">
                                                            <img  width="120" height="110" alt="200x200"
                                                                  src="static/filecatalog/images/locked.png"/>
                                                            <a title="${var.FILENAME}" class="text">
                                                                <div name="inner" class="inner">${var.FILENAME}</div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                                <li id="downloads"
                                    style="border:none;margin-top: 30px;margin-left:35px;margin-right:20px;display: none">
                                    <a onclick="downs()" data-rel="colorbox" class="cboxElement">
                                        <img width="100" height="100" alt="200x200"
                                             src="static/filecatalog/images/cloud-down-icon.png"/>
                                        <div class="text">
                                            <div class="inner">下载</div>
                                        </div>
                                    </a>
                                    <%--<div style="width: 100%;height: 25px" align="center" >
                                        <p>${var.FNAME}</p>
                                    </div>--%>
                                </li>
                                <li id="todeletes"
                                    style="border:none;margin-top: 30px;margin-left:35px;margin-right:20px;display: none">
                                    <a onclick="deletes()" data-rel="colorbox" class="cboxElement">
                                        <img width="100" height="100" alt="200x200"
                                             src="static/filecatalog/images/free-60-icons-23.png"/>
                                        <div class="text">
                                            <div class="inner">删除</div>
                                        </div>
                                    </a>
                                    <%--<div style="width: 100%;height: 25px" align="center" >
                                        <p>${var.FNAME}</p>
                                    </div>--%>
                                </li>
                                <li  style="border:none;margin-top: 30px">
                                    <a onclick="addFile('${pd.FPARENTID}','${pd.FNAME}')" data-rel="colorbox" class="cboxElement">
                                        <img width="120" height="120" alt="200x200" src="static/filecatalog/images/add.png"/>
                                        <div class="text">
                                            <div class="inner">添加文件</div>
                                        </div>
                                    </a>
                                    <%--<div style="width: 100%;height: 25px" align="center" >
                                        <p>${var.FNAME}</p>
                                    </div>--%>
                                </li>
                            </ul>
                        </div>


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
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>

<script src="static/dist/jquery.magnify.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态
    
    function editJurisdiction(FILEMEANS_ID) {
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "选择文件权限";
        diag.URL = '<%=basePath%>filemeans/toEditJurisdiction.do?FILEMEANS_ID='+FILEMEANS_ID;
        diag.Width = 600;
        diag.Height = 490;
        diag.CancelEvent = function () { //关闭事件
            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
            diag.close();
        };
        diag.show();
    }

    function openByPW(FILEMEANS_ID){
        //alert("该文件为加密文件，请输入密码后查阅");
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="输入密码";
        diag.URL = '<%=basePath%>filemeans/openByPW.do?FILEMEANS_ID='+FILEMEANS_ID;
        diag.Width = 200;
        diag.Height = 255;
        diag.Modal = true;				//有无遮罩窗口
        diag. ShowMaxButton = true;	//最大化按钮
        diag.ShowMinButton = true;		//最小化按钮
        diag.CancelEvent = function(){ //关闭事件$("#ORDER").val("yes");
            if(diag.innerFrame.contentWindow.document.getElementById('ORDER').value == "yes"){
                var password = diag.innerFrame.contentWindow.document.getElementById('PASSWORD').value;
                //alert(password);
                $.ajax({
                    async: false,
                    cache: false,
                    type: 'POST',
                    data : {
                        FILEMEANS_ID : FILEMEANS_ID,
                        FILE_PASSWORD : password
                    },
                    url: '<%=basePath%>filemeans/writePw',
                    success: function (data) {
                        if(data.result == "ture"){
                            alert("密码正确!!");
                            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
                        }else {
                            alert("密码错误!!");
                        }
                      //  alert(data.result);
                    },
                    error: function () {
                        alert("请求失败");
                    }
                });
            }
            diag.close();
        };
        diag.show();
    }

    //图片预览效果
    $('[data-magnify]').magnify({
        headToolbar: [
            'close'
        ],
        initMaximized: true
    });

    var zNodes;
    function test(event){
            var btnNum = event.button;
            if (btnNum==2)
            {
                alert("您点击了鼠标右键！")
            }
            else if(btnNum==0)
            {
                alert("您点击了鼠标左键！")
            }
            else if(btnNum==1)
            {
                alert("您点击了鼠标中键！");
            }
    }


    //右击菜单
    var menuJson = [
        {
            name:"添加目录",
            id:"menu1",
            callback: function() {
                var FPARENTID = '${pd.FPARENTID}';
                var PNAME = '${pd.FNAME}';
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
                            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
                        },
                        error: function () {
                            alert("请求失败");
                        }
                    });
                    diag.close();
                };
                diag.show();
            }
        },
        {
            name:"修改目录名称",
            id:"menu2",
            callback: function() {
                var FPARENTID = '${pd.FPARENTID}';
                var PNAME = '${pd.FNAME}';
                top.jzts();
                var diag = new top.Dialog();
                diag.Drag=true;
                diag.Title ="修改目录名称";
                diag.URL = '<%=basePath%>filecatalog/goEdit.do?FPARENTID='+FPARENTID+"&PNAME="+PNAME;
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
                            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
                        },
                        error: function () {
                            alert("请求失败");
                        }
                    });
                    diag.close();
                };
                diag.show();
            }
        },
        {
            name:"删除当前目录",
            id:"menu-delete",
            callback: function() {
                var FPARENTID = '${pd.FPARENTID}';
                var PNAME = '${pd.FNAME}';
                bootbox.confirm("确定要删除当前吗?将会把该文件夹里文件连同删除", function (result) {
                    if (result) {
                        $.ajax({
                            async: false,
                            cache: false,
                            type: 'POST',
                            //dataType:"String",
                            url: '<%=basePath%>fileupata/deleteFileCatalog?FITEMID='+FPARENTID+"&FNAME="+PNAME,
                            success: function (data) {
                                window.location.href="<%=basePath%>filecatalog/file_load";
                            },
                            error: function () {
                                alert("请求失败");
                            }
                        });
                    }
                })
            }
        },
    ];

    ContextMenu.bind("#rightj", menuJson);

    //双击打开文件夹
    function openFile(FPARENTID, FNAME) {
        window.location.href = '<%=basePath%>filecatalog/file_load?FPARENTID=' + FPARENTID + '&FNAME=' + FNAME;
    }

    //打开文件
    function wep_open(FILE_URL,FILENAME) {
        FILE_URL = encodeURI(encodeURI(FILE_URL));
        FILENAME = encodeURI(encodeURI(FILENAME));
        //alert(FILE_URL);
        window.open("<%=basePath%>filecatalog/wep_open?FILE_URL=" + FILE_URL +"&FILENAME="+FILENAME);
    }


    $("[name='inner']").each(function () {
      // alert($(this).text().length);
    });


    //选择删除文件
    function toDel(value) {
        if('${isdel}' == 1 || '${isdel}' == '1'){
            return false;
        }
        if ($("#del" + value).css("display") == "none") {
            $("#del" + value).css("display", "");
        } else {
            $("#del" + value).css("display", "none");
        }
    }

    //执行修改任务
    function editFileName(){
            var editfile = [];
            $(".ace-thumbnails .float_div").each(function () {
                if ($(this).css("display") != "none") {
                    editfile.push($(this).attr("name"));
                }
            });
            alert(editfile);
            if (editfile.length == 1){

                for (var index = 0; index < editfile.length; index++) {
                    top.jzts();
                    var diag = new top.Dialog();
                    diag.Drag=true;
                    diag.Title ="修改文件名称";
                    diag.URL = '<%=basePath%>fileupata/goEditName.do?FILE_URL='+editfile[index];
                    diag.Width = 450;
                    diag.Height = 255;
                    diag.Modal = true;				//有无遮罩窗口
                    diag. ShowMaxButton = true;	//最大化按钮
                    diag.ShowMinButton = true;		//最小化按钮
                    diag.CancelEvent = function(){ //关闭事件
                        diag.close();
                        window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
                    };
                    diag.show();

                }
            }

    }

    //执行删除任务
    function deletes() {
        bootbox.confirm("确定要删除吗?", function (result) {
            if (result) {
                var delfile = [];
                $(".ace-thumbnails .float_div").each(function () {
                    if ($(this).css("display") != "none") {
                        delfile.push($(this).attr("name"));
                    }
                });
                for (var index = 0; index < delfile.length; index++) {
                    //alert(delfile[index]);
                    $.ajax({
                        async: false,
                        cache: false,
                        type: 'POST',
                        data : {
                            FILE_URL:delfile[index]
                        },
                        //dataType:"String",
                        url: '<%=basePath%>fileupata/deleteFile',
                        success: function (data) {
                            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
                        },
                        error: function () {
                            alert("请求失败");
                        }
                    });
                }
            }
        });
    }

    //执行下载任务
    function downs() {
        var file = [];
        $(".ace-thumbnails .float_div").each(function () {
            if ($(this).css("display") != "none") {
                file.push($(this).attr("name"));
            }
        });
        for (var index = 0; index < file.length; index++) {
            var index1 = file[index].lastIndexOf("/");
            var url = "<%=basePath%>"+file[index];
            download(file[index].substring(index1 + 1, file[index].length), url);
        }
    }

    function download(name, href) {
        var a = document.createElement("a"), //创建a标签
                e = document.createEvent("MouseEvents"); //创建鼠标事件对象
        e.initEvent("click", false, false); //初始化事件对象
        a.href = href; //设置下载地址
        a.download = name; //设置下载文件名
        a.dispatchEvent(e); //给指定的元素，执行事件click事件
    }


    //选择下载文件
    function toSelect(value) {
        //alert(event.type);
        if ($("#" + value).css("display") == "none") {
            $("#" + value).css("display", "");
        } else {
            $("#" + value).css("display", "none");
        }
        var file = [];
        $(".ace-thumbnails .float_div").each(function () {
            if ($(this).css("display") != "none") {
                file.push($(this).attr("name"));
            }
        });
    }

    //去选择上传文件  FITEMID为文件夹id  FNAME为当前文件夹名称
    function addFile(FITEMID, FNAME) {
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "选择文件权限";
        diag.URL = '<%=basePath%>filecatalog/selectFileJurisdiction.do?FITEMID=' + FITEMID + '&FNAME=' + FNAME;
        diag.Width = 600;
        diag.Height = 490;
        diag.CancelEvent = function () { //关闭事件
            window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FPARENTID}&FNAME=${pd.FNAME}";
            diag.close();
        };
        diag.show();
    }
</script>


</body>
</html>