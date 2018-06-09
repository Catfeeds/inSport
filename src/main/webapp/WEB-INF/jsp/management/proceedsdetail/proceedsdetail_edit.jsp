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
					
					<form action="proceedsdetail/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROCEEDSDETAIL_ID" id="PROCEEDSDETAIL_ID" value="${pd.PROCEEDSDETAIL_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">租金金额:</td>
								<td><input type="number" name="RENT" id="RENT" value="${pd.RENT}" maxlength="32" placeholder="这里输入租金金额" title="租金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">水电费:</td>
								<td><input type="number" name="UTILITIES" id="UTILITIES" value="${pd.UTILITIES}" maxlength="32" placeholder="这里输入水电费" title="水电费" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金:</td>
								<td><input type="number" name="OVERDUE" id="OVERDUE" value="${pd.OVERDUE}" maxlength="32" placeholder="这里输入滞纳金" title="滞纳金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际收款金额:</td>
								<td><input type="number" name="RECEIVABLE_REALITY" id="RECEIVABLE_REALITY" value="${pd.RECEIVABLE_REALITY}" maxlength="32" placeholder="这里输入实际收款金额" title="实际收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收款金额:</td>
								<td><input type="number" name="RECEIVABLE" id="RECEIVABLE" value="${pd.RECEIVABLE}" maxlength="32" placeholder="这里输入应收款金额" title="应收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收款时间:</td>
								<td><input class="span10 date-picker" name="PAYTIME" id="PAYTIME" value="${pd.PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应收款时间" title="应收款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际收款时间:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME" id="RECEIVABL_PAYTIME" value="${pd.RECEIVABL_PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际收款时间" title="实际收款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">未收款金额:</td>
								<td><input type="number" name="UNCOLLECTED" id="UNCOLLECTED" value="${pd.UNCOLLECTED}" maxlength="32" placeholder="这里输入未收款金额" title="未收款金额" style="width:98%;"/></td>
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
			if($("#RENT").val()==""){
				$("#RENT").tips({
					side:3,
		            msg:'请输入租金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RENT").focus();
			return false;
			}
			if($("#UTILITIES").val()==""){
				$("#UTILITIES").tips({
					side:3,
		            msg:'请输入水电费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UTILITIES").focus();
			return false;
			}
			if($("#OVERDUE").val()==""){
				$("#OVERDUE").tips({
					side:3,
		            msg:'请输入滞纳金',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OVERDUE").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY").val()==""){
				$("#RECEIVABLE_REALITY").tips({
					side:3,
		            msg:'请输入实际收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY").focus();
			return false;
			}
			if($("#RECEIVABLE").val()==""){
				$("#RECEIVABLE").tips({
					side:3,
		            msg:'请输入应收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE").focus();
			return false;
			}
			if($("#PAYTIME").val()==""){
				$("#PAYTIME").tips({
					side:3,
		            msg:'请输入应收款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME").val()==""){
				$("#RECEIVABL_PAYTIME").tips({
					side:3,
		            msg:'请输入实际收款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME").focus();
			return false;
			}
			if($("#UNCOLLECTED").val()==""){
				$("#UNCOLLECTED").tips({
					side:3,
		            msg:'请输入未收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UNCOLLECTED").focus();
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