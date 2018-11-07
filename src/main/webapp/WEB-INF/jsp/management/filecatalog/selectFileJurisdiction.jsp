<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/silviomore/bootstrap-select.css" />
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
	<script src="static/silviomore/bootstrap-select.js"></script>
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
				<div class="" style="text-align: left;margin-left: 10px;margin-top: 10px">
					<!-- <td style="text-align: center;" colspan="10"> -->
					<a  class="btn btn-success btn-xs" onclick="addFile('${pd.FITEMID}','${pd.FNAME}')">
						<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>添加上传文件
					</a>
					<a class="btn btn-primary  btn-xs" onclick="top.Dialog.close();">
						<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
					</a>
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
					
					<form action="" name="Form" id="Form" method="post">
						<input type="hidden" name="FILECATALOG_ID" id="FILECATALOG_ID" value="${pd.FILECATALOG_ID}"/>
						<input type="hidden" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}"/>
						<input type="hidden" name="FILE_READUSERS" id="FILE_READUSERS"/>
					</form>
						<label class="control-label" >
							<div class="col-xs-10 label label-lg label-light arrowed-in arrowed-right">
								<b>是否可下载：<i class="ace-icon glyphicon glyphicon-download-alt bigger-110 nav-search-icon blue"></i></b>
							</div>
						</label>
						<label >
							<input onclick="isDowns(this)" checked id="isDowns" name="isDowns" class="ace ace-switch ace-switch-5" type="checkbox">
							<span class="lbl"></span>
						</label>
						<label class="control-label" style="margin-left: 45px">
							<div class="col-xs-10 label label-lg label-light arrowed-in arrowed-right">
								<b>仅本人可见：<i class="ace-icon glyphicon glyphicon-user bigger-110 nav-search-icon blue"></i></b>
							</div>

						</label>
						<label >
							<input onclick="toPrivate(this)" id="private" name="toPrivate" class="ace ace-switch ace-switch-5" type="checkbox">
							<span class="lbl"></span>
						</label>
						<br>
						<label id="toSD" class="control-label" >
							<div class="col-xs-10 label label-lg label-light arrowed-in arrowed-right">
								<b>仅部分人可见：<i class="ace-icon fa fa-users bigger-110 nav-search-icon blue"></i></b>
							</div>
						</label>
						<label id="toSDS" >
							<input onclick="toSomeBody(this)" id="isSomeBody" name="switch-field" class="ace ace-switch ace-switch-5" type="checkbox">
							<span class="lbl"></span>
						</label>
						<label id="toENCTYPT" class="control-label" style="margin-left: 35px">
							<div class="col-xs-10 label label-lg label-light arrowed-in arrowed-right">
								<b>是否加密文件：<i class="ace-icon fa fa-key bigger-110 nav-search-icon blue"></i></b>
							</div>
						</label>
						<label id="toENCTYPTS" >
							<input onclick="toENCTYPT(this)" id="isENCTYPT" name="switch-field" class="ace ace-switch ace-switch-5" type="checkbox">
							<span class="lbl"></span>
						</label>
						<label style="display: none" id="passWord"  class="control-label" >
							填写密码：<input type="password" style="width: 170px"
																	class="input-date"  name=""
																	id="FILE_PASSWORD">
							<a class="btn btn-primary btn-xs" onmouseover="MouseOver()" onmouseout="MouseOut()">
								<i class="ace-icon fa fa-eye bigger-50 nav-search-icon "></i>预览密码
							</a>
						</label>
						<br>
						<div id="selects" style="display: none">
							<p>选择查阅权限人员：</p>
							<label style="display: none" id="somebody" for="somebodyselect"></label>
							<select style="display: none" id="somebodyselect" class="selectpicker bla bla bli"
									data-style="btn-info" multiple data-live-search="true" title="选择权限用户">
								<c:forEach items="${dept}" var="var" varStatus="vs">
									<c:if test="${var.DNAME != userPd.NAME}">
										<option id="${var.DEPARTMENTGROUP_ID}"
												<%--<c:if test="${var.DNAME == userPd.NAME}">
													selected
												</c:if>--%>
												value="${var.UID}" name="${var.PID}">${var.DNAME}</option>
										</c:if>
								</c:forEach>
								</optgroup>
							</select>
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
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());

		function MouseOver()
		{
			$("#FILE_PASSWORD").attr("type","text");
		}

		function MouseOut(value)
		{
			//alert("password");
			$("#FILE_PASSWORD").attr("type","password");
		}

		function toPrivate(value) {
			//alert($(value).prop("checked"));
			if($(value).prop("checked")){
				$("#toSDS").css("display","none");
				$("#toSD").css("display","none");
				$("#toENCTYPT").css("display","none");
				$("#toENCTYPTS").css("display","none");
				$("#passWord").css("display","none");
				$("#selects").css("display","none");
			}else {
				$("#toSDS").css("display","");
				$("#toSD").css("display","");
				$("#toENCTYPT").css("display","");
				$("#toENCTYPTS").css("display","");
			}
		}

		function toENCTYPT(value){
			if($(value).prop("checked")){
				$("#passWord").css("display","");
			}else {
				$("#passWord").css("display","none");
			}
		}

		function toSomeBody(value) {
			//alert($(value).prop("checked"));
			if($(value).prop("checked")){
				$("#selects").css("display","");
				//$("#somebody").css("display","");
			}else {
				//$("#somebodyselect").css("display","none");
				$("#selects").css("display","none");
			}
		}

		//保存 FITEMID为文件夹id  FNAME为当前文件夹名称
		function addFile(FITEMID,FNAME){
			var FILE_READUSERS ='';
			var FILE_ISENCTYPT ='';
			var FILE_PASSWORD = '';
			var FILE_ISPRIVATE = '';
			var FILE_ISDOWN = '0';
			if($("#isSomeBody").prop("checked")){
				FILE_READUSERS='';
				$("#somebodyselect option:selected").each(function () {
					FILE_READUSERS += $(this).val() +",";
				});
				FILE_READUSERS = FILE_READUSERS.substring(0, FILE_READUSERS.length - 1);
				$("#FILE_READUSERS").val(FILE_READUSERS);
			}else {
				FILE_READUSERS='ALL(所有人可见)';
			}
			if($("#private").prop("checked")){
				FILE_READUSERS='ALL(所有人可见)';
			}
			if($("#isENCTYPT").prop("checked")){
				FILE_ISENCTYPT = '1';
				FILE_PASSWORD = $("#FILE_PASSWORD").val();
                if(FILE_PASSWORD == null || FILE_PASSWORD == ""){
                    alert("密码不能为空！！");
                    return false;
				}
			}else {
				FILE_ISENCTYPT = '0';
			}
			if($("#isDowns").prop("checked")){
				FILE_ISDOWN = '1';
			}

			if($("#private").prop("checked")){
				//$("#passWord").css("display","");
				FILE_READUSERS='${userPd.USER_ID}';
				FILE_ISENCTYPT = '0';
				FILE_PASSWORD = '';
				FILE_ISPRIVATE = '1';
			}else {
				FILE_ISPRIVATE = '0';
			}
			//alert(FITEMID+"---"+FNAME+"---"+FILE_READUSERS+"---"+FILE_PASSWORD+"---"+FILE_ISENCTYPT);
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = "选择上传文件";
			 diag.URL = '<%=basePath%>fileupata/goAddFile.do?FITEMID=' + FITEMID + '&FNAME=' + FNAME +"&FILE_ISPRIVATE="+FILE_ISPRIVATE
					 + '&FILE_READUSERS=' + FILE_READUSERS+ '&FILE_PASSWORD=' + FILE_PASSWORD + '&FILE_ISENCTYPT=' + FILE_ISENCTYPT+
					 '&FILE_ISDOWN=' + FILE_ISDOWN;
			 diag.Width = 800;
			 diag.Height = 490;
			 diag.CancelEvent = function () { //关闭事件
			 	//window.location.href="<%=basePath%>filecatalog/file_load?FPARENTID=${pd.FITEMID}&FNAME=${pd.FNAME}";
				 diag.close();
			 };
			 diag.show();
		}

		$(window).on('load', function () {
			$('.selectpicker').selectpicker({
				'selectedText': 'cat'
			});
			// $('.selectpicker').selectpicker('hide');
		});

		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>