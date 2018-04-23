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
					
					<form action="filemeans/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="FILEMEANS_ID" id="FILEMEANS_ID" value="${pd.FILEMEANS_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件名称:</td>
								<td><input type="text" name="FILENAME" id="FILENAME" value="${pd.FILENAME}" maxlength="255" placeholder="这里输入文件名称" title="文件名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件路径:</td>
								<td><input type="text" name="FILE_URL" id="FILE_URL" value="${pd.FILE_URL}" maxlength="255" placeholder="这里输入文件路径" title="文件路径" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件创建时间:</td>
								<td><input class="span10 date-picker" name="FILE_CREATETIME" id="FILE_CREATETIME" value="${pd.FILE_CREATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="文件创建时间" title="文件创建时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件权限:</td>
								<td><input type="text" name="FILE_JURISDICTION" id="FILE_JURISDICTION" value="${pd.FILE_JURISDICTION}" maxlength="255" placeholder="这里输入文件权限" title="文件权限" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件类型:</td>
								<td><input type="text" name="FILE_TYPE" id="FILE_TYPE" value="${pd.FILE_TYPE}" maxlength="255" placeholder="这里输入文件类型" title="文件类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件创建人员:</td>
								<td><input type="text" name="FILE_CREATEUSER" id="FILE_CREATEUSER" value="${pd.FILE_CREATEUSER}" maxlength="255" placeholder="这里输入文件创建人员" title="文件创建人员" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件下载次数:</td>
								<td><input type="number" name="FILE_DOWNLOAD" id="FILE_DOWNLOAD" value="${pd.FILE_DOWNLOAD}" maxlength="32" placeholder="这里输入文件下载次数" title="文件下载次数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">文件查阅次数:</td>
								<td><input type="number" name="FILE_READ" id="FILE_READ" value="${pd.FILE_READ}" maxlength="32" placeholder="这里输入文件查阅次数" title="文件查阅次数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="FILE_REMARK" id="FILE_REMARK" value="${pd.FILE_REMARK}" maxlength="500" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			if($("#FILENAME").val()==""){
				$("#FILENAME").tips({
					side:3,
		            msg:'请输入文件名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILENAME").focus();
			return false;
			}
			if($("#FILE_URL").val()==""){
				$("#FILE_URL").tips({
					side:3,
		            msg:'请输入文件路径',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_URL").focus();
			return false;
			}
			if($("#FILE_CREATETIME").val()==""){
				$("#FILE_CREATETIME").tips({
					side:3,
		            msg:'请输入文件创建时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_CREATETIME").focus();
			return false;
			}
			if($("#FILE_JURISDICTION").val()==""){
				$("#FILE_JURISDICTION").tips({
					side:3,
		            msg:'请输入文件权限',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_JURISDICTION").focus();
			return false;
			}
			if($("#FILE_TYPE").val()==""){
				$("#FILE_TYPE").tips({
					side:3,
		            msg:'请输入文件类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_TYPE").focus();
			return false;
			}
			if($("#FILE_CREATEUSER").val()==""){
				$("#FILE_CREATEUSER").tips({
					side:3,
		            msg:'请输入文件创建人员',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_CREATEUSER").focus();
			return false;
			}
			if($("#FILE_DOWNLOAD").val()==""){
				$("#FILE_DOWNLOAD").tips({
					side:3,
		            msg:'请输入文件下载次数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_DOWNLOAD").focus();
			return false;
			}
			if($("#FILE_READ").val()==""){
				$("#FILE_READ").tips({
					side:3,
		            msg:'请输入文件查阅次数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_READ").focus();
			return false;
			}
			if($("#FILE_REMARK").val()==""){
				$("#FILE_REMARK").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FILE_REMARK").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>