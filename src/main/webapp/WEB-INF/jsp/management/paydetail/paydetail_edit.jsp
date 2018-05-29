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
					
					<form action="paydetail/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PAYDETAIL_ID" id="PAYDETAIL_ID" value="${pd.PAYDETAIL_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">主表id:</td>
								<td><input type="text" name="PAYPRIMARY_ID" id="PAYPRIMARY_ID" value="${pd.PAYPRIMARY_ID}" maxlength="255" placeholder="这里输入主表id" title="主表id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="255" placeholder="这里输入合同id" title="合同id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款所属时间:</td>
								<td><input class="span10 date-picker" name="SHPAYTIME" id="SHPAYTIME" value="${pd.SHPAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="付款所属时间" title="付款所属时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付款金额:</td>
								<td><input type="number" name="SHPAY" id="SHPAY" value="${pd.SHPAY}" maxlength="32" placeholder="这里输入应付款金额" title="应付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间:</td>
								<td><input class="span10 date-picker" name="REALITYPAYTIME" id="REALITYPAYTIME" value="${pd.REALITYPAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间" title="实际付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额:</td>
								<td><input type="number" name="REALITYPAY" id="REALITYPAY" value="${pd.REALITYPAY}" maxlength="32" placeholder="这里输入实际付款金额" title="实际付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">尚没付款金额:</td>
								<td><input type="number" name="ONPAYPIC" id="ONPAYPIC" value="${pd.ONPAYPIC}" maxlength="32" placeholder="这里输入尚没付款金额" title="尚没付款金额" style="width:98%;"/></td>
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
			if($("#PAYPRIMARY_ID").val()==""){
				$("#PAYPRIMARY_ID").tips({
					side:3,
		            msg:'请输入主表id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYPRIMARY_ID").focus();
			return false;
			}
			if($("#CONTRACT_ID").val()==""){
				$("#CONTRACT_ID").tips({
					side:3,
		            msg:'请输入合同id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_ID").focus();
			return false;
			}
			if($("#SHPAYTIME").val()==""){
				$("#SHPAYTIME").tips({
					side:3,
		            msg:'请输入付款所属时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHPAYTIME").focus();
			return false;
			}
			if($("#SHPAY").val()==""){
				$("#SHPAY").tips({
					side:3,
		            msg:'请输入应付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#SHPAY").focus();
			return false;
			}
			if($("#REALITYPAYTIME").val()==""){
				$("#REALITYPAYTIME").tips({
					side:3,
		            msg:'请输入实际付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITYPAYTIME").focus();
			return false;
			}
			if($("#REALITYPAY").val()==""){
				$("#REALITYPAY").tips({
					side:3,
		            msg:'请输入实际付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITYPAY").focus();
			return false;
			}
			if($("#ONPAYPIC").val()==""){
				$("#ONPAYPIC").tips({
					side:3,
		            msg:'请输入尚没付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ONPAYPIC").focus();
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