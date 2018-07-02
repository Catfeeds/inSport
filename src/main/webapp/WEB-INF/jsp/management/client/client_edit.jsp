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
					
					<form action="client/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="CLIENT_ID" id="CLIENT_ID" value="${pd.CLIENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">客户名称:</td>
								<td><input type="text" name="FNAME" id="FNAME" value="${pd.FNAME}" maxlength="255" placeholder="这里输入客户名称" title="客户名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">编号:</td>
								<td><input type="text" name="FNUMBER" id="FNUMBER" value="${pd.FNUMBER}" maxlength="255" placeholder="这里输入编号" title="编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">Fitemid:</td>
								<td><input type="number" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="32" placeholder="这里输入Fitemid" title="Fitemid" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">Fparentid:</td>
								<td><input type="number" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}" maxlength="32" placeholder="这里输入Fparentid" title="Fparentid" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">单位/公司:</td>
								<td><input type="text" name="FUNIT" id="FUNIT" value="${pd.FUNIT}" maxlength="255" placeholder="这里输入单位/公司" title="单位/公司" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">联系电话:</td>
								<td><input type="text" name="PHONENUMBER" id="PHONENUMBER" value="${pd.PHONENUMBER}" maxlength="255" placeholder="这里输入联系电话" title="联系电话" style="width:98%;"/></td>
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
			if($("#FNAME").val()==""){
				$("#FNAME").tips({
					side:3,
		            msg:'请输入客户名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNAME").focus();
			return false;
			}
			if($("#FNUMBER").val()==""){
				$("#FNUMBER").tips({
					side:3,
		            msg:'请输入编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNUMBER").focus();
			return false;
			}
			if($("#FITEMID").val()==""){
				$("#FITEMID").tips({
					side:3,
		            msg:'请输入Fitemid',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITEMID").focus();
			return false;
			}
			if($("#FPARENTID").val()==""){
				$("#FPARENTID").tips({
					side:3,
		            msg:'请输入Fparentid',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FPARENTID").focus();
			return false;
			}
			if($("#FUNIT").val()==""){
				$("#FUNIT").tips({
					side:3,
		            msg:'请输入单位/公司',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FUNIT").focus();
			return false;
			}
			if($("#PHONENUMBER").val()==""){
				$("#PHONENUMBER").tips({
					side:3,
		            msg:'请输入联系电话',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PHONENUMBER").focus();
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