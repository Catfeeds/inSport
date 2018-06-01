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
					
					<form action="operator/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="OPERATOR_ID" id="OPERATOR_ID" value="${pd.OPERATOR_ID}"/>
						<input type="hidden" name="ONAME" id="ONAME" value="${pd.ONAME}"/>
						<input type="hidden" name="UID" id="UID" value="${pd.UID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">名称:</td>
								<td>
									<%--<input type="text" name="ONAME" id="ONAME" value="${pd.ONAME}" maxlength="255"
										   placeholder="这里输入名称" title="名称" style="width:98%;"/>--%>
									<select name="seONAME" id="seONAME" data-placeholder=""
											style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
										<option value="${pd.ONAME}" name="${pd.ONAME}">${pd.ONAME}</option>
										<c:forEach items="${listOperator}" var="var" varStatus="vs">
											<option id="${var.USER_ID}" value="${var.NAME}" name="${var.USER_ID}">${var.NAME}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<%--<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">UID:</td>
								<td><input type="text" name="UID" id="UID" value="${pd.UID}" maxlength="255" placeholder="这里输入UID" title="UID" style="width:98%;"/></td>
							</tr>--%>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
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

		$("#seONAME").change(function(){
			var USER_ID = $("#seONAME").find("option:selected").attr("name");
			var NAME = $("#seONAME").find("option:selected").val();
			$("#ONAME").val(NAME);
			$("#UID").val(USER_ID);
		})

		//保存
		function save(){
			if($("#ONAME").val()==""){
				$("#ONAME").tips({
					side:3,
		            msg:'请输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ONAME").focus();
			return false;
			}
			if($("#UID").val()==""){
				$("#UID").tips({
					side:3,
		            msg:'请输入UID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UID").focus();
			return false;
			}
			/*if($("#REMARK").val()==""){
				$("#REMARK").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REMARK").focus();
			return false;
			}*/
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