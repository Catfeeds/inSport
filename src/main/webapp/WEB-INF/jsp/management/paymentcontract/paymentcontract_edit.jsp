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
					
					<form action="paymentcontract/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PAYMENTCONTRACT_ID" id="PAYMENTCONTRACT_ID" value="${pd.PAYMENTCONTRACT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">总金额:</td>
								<td><input type="number" name="AMOUNT" id="AMOUNT" value="${pd.AMOUNT}" maxlength="32" placeholder="这里输入总金额" title="总金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付款金额:</td>
								<td><input type="number" name="DUE_AMOUNT" id="DUE_AMOUNT" value="${pd.DUE_AMOUNT}" maxlength="32" placeholder="这里输入应付款金额" title="应付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额:</td>
								<td><input type="number" name="REALITY_AMOUNT" id="REALITY_AMOUNT" value="${pd.REALITY_AMOUNT}" maxlength="32" placeholder="这里输入实际付款金额" title="实际付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间:</td>
								<td><input class="span10 date-picker" name="REALITYTIME" id="REALITYTIME" value="${pd.REALITYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间" title="实际付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同主id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="255" placeholder="这里输入合同主id" title="合同主id" style="width:98%;"/></td>
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
			if($("#AMOUNT").val()==""){
				$("#AMOUNT").tips({
					side:3,
		            msg:'请输入总金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#AMOUNT").focus();
			return false;
			}
			if($("#DUE_AMOUNT").val()==""){
				$("#DUE_AMOUNT").tips({
					side:3,
		            msg:'请输入应付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DUE_AMOUNT").focus();
			return false;
			}
			if($("#REALITY_AMOUNT").val()==""){
				$("#REALITY_AMOUNT").tips({
					side:3,
		            msg:'请输入实际付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITY_AMOUNT").focus();
			return false;
			}
			if($("#REALITYTIME").val()==""){
				$("#REALITYTIME").tips({
					side:3,
		            msg:'请输入实际付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITYTIME").focus();
			return false;
			}
			if($("#REMARK").val()==""){
				$("#REMARK").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REMARK").focus();
			return false;
			}
			if($("#CONTRACT_ID").val()==""){
				$("#CONTRACT_ID").tips({
					side:3,
		            msg:'请输入合同主id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_ID").focus();
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