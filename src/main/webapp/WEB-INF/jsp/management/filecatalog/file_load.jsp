<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
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
							<div>
								<ul class="ace-thumbnails clearfix" id="imgList">
									<c:choose>
										<c:when test="${not empty list_catalog}">
											<c:forEach items="${list_catalog}" var="var" varStatus="vs">
												<li style="border:none;margin-top: 30px">
													<a ondblclick="openFile('${var.FITEMID}','${var.FNAME}')" data-rel="colorbox" class="cboxElement">
														<img width="120" height="120" alt="200x200" src="static/filecatalog/images/fileexplorer.png" />
														<div class="text">
															<div class="inner">双击打开</div>
														</div>
													</a>
													<div style="width: 100%;height: 25px" align="center" >
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
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >文件夹为空</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${not empty list_files}">
											<c:forEach items="${list_files}" var="var" varStatus="vs">
												<c:if test="${fn:contains(var.FILE_TYPE,'image')}">
													<li style="border:none;margin-top: 30px">
														<a ondblclick="openFile('${var.FITEMID}')" data-rel="colorbox" class="cboxElement">
															<img width="160" height="110" alt="200x200" src="<%=basePath%>${var.FILE_URL}" />
															<div class="text">
																<div class="inner">点击预览</div>
															</div>
														</a>
														<div style="width: 100%;height: 25px" align="center" >
															<p>${var.FILE_CATALOGURL}</p>
														</div>
													</li>
												</c:if>
												<c:if test="${fn:contains(var.FILE_TYPE,'pdf')}">
													<li style="border:none;margin-top: 30px;">
														<a ondblclick="openFile('${var.FITEMID}')" data-rel="colorbox" class="cboxElement">
															<img width="120" height="120" alt="200x200" src="static/filecatalog/images/application-pdf.png" />
															<div class="text">
																<div class="inner">点击预览</div>
															</div>
														</a>
														<div style="width: 100%;height: 25px" align="center" >
															<p>${var.FILE_CATALOGURL}</p>
														</div>
													</li>
												</c:if>
												<c:if test="${fn:contains(var.FILE_TYPE,'word')}">
													<li style="border:none;margin-top: 30px">
														<a ondblclick="openFile('${var.FITEMID}')" data-rel="colorbox" class="cboxElement">
															<img width="120" height="120" alt="200x200" src="static/filecatalog/images/file-word-icon.png" />
															<div class="text">
																<div class="inner">点击预览</div>
															</div>
														</a>
														<div style="width: 100%;height: 25px" align="center" >
															<p>${var.FILE_CATALOGURL}</p>
														</div>
													</li>
												</c:if>
												<c:if test="${fn:contains(var.FILE_TYPE,'word')}">
													<li style="border:none;margin-top: 30px">
														<a ondblclick="openFile('${var.FITEMID}')" data-rel="colorbox" class="cboxElement">
															<img width="120" height="120" alt="200x200" src="static/filecatalog/images/file-word-icon.png" />
															<div class="text">
																<div class="inner">点击预览</div>
															</div>
														</a>
														<div style="width: 100%;height: 25px" align="center" >
															<p>${var.FILE_CATALOGURL}</p>
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
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >文件夹为空</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<li style="border:none;margin-top: 30px" >
										<a onclick="addFile('${pd.FPARENTID}','${pd.NAME}')" data-rel="colorbox" class="cboxElement">
											<img width="120" height="120" alt="200x200" src="static/filecatalog/images/add.png" />
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
	<%@ include file="../../system/index/foot.jsp"%>
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
		
		function openFile(FPARENTID,FNAME) {
			window.location.href = '<%=basePath%>filecatalog/file_load?FPARENTID='+FPARENTID+'&FNAME='+FNAME;
		}
		
		function addFile(FITEMID,FNAME) {
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title ="选择上传文件";
			diag.URL = '<%=basePath%>fileupata/goAddFile.do?FITEMID=' + FITEMID+'&FNAME='+FNAME;
			diag.Width = 800;
			diag.Height = 490;
			diag.CancelEvent = function () { //关闭事件

				diag.close();
				//tosearch();
			};
			diag.show();
		}
	</script>


</body>
</html>