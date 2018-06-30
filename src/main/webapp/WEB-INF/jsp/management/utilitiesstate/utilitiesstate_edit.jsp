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
					
					<form action="utilitiesstate/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="UTILITIESSTATE_ID" id="UTILITIESSTATE_ID" value="${pd.UTILITIESSTATE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方名称(水电费):</td>
								<td><input type="text" name="PAYERNAME" id="PAYERNAME" value="${pd.PAYERNAME}" maxlength="255" placeholder="这里输入付款方名称(水电费)" title="付款方名称(水电费)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收款时间(水电费):</td>
								<td><input class="span10 date-picker" name="PAYTIME" id="PAYTIME" value="${pd.PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应收款时间(水电费)" title="应收款时间(水电费)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收金额(水电费):</td>
								<td><input type="number" name="RECEIVABLE" id="RECEIVABLE" value="${pd.RECEIVABLE}" maxlength="32" placeholder="这里输入应收金额(水电费)" title="应收金额(水电费)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金率:</td>
								<td><input type="number" name="OVERDUE" id="OVERDUE" value="${pd.OVERDUE}" maxlength="32" placeholder="这里输入滞纳金率" title="滞纳金率" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际收款时间(水电费):</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME" id="RECEIVABL_PAYTIME" value="${pd.RECEIVABL_PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际收款时间(水电费)" title="实际收款时间(水电费)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际收款金额(水电费):</td>
								<td><input type="number" name="RECEIVABLE_REALITY" id="RECEIVABLE_REALITY" value="${pd.RECEIVABLE_REALITY}" maxlength="32" placeholder="这里输入实际收款金额(水电费)" title="实际收款金额(水电费)" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">上个月总电量读数:</td>
								<td><input type="number" name="LASTMONTH_SUM_E" id="LASTMONTH_SUM_E" value="${pd.LASTMONTH_SUM_E}" maxlength="32" placeholder="这里输入上个月总电量读数" title="上个月总电量读数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月总电量读数:</td>
								<td><input type="number" name="THISMONTH_SUM_E" id="THISMONTH_SUM_E" value="${pd.THISMONTH_SUM_E}" maxlength="32" placeholder="这里输入本月总电量读数" title="本月总电量读数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月总用电量:</td>
								<td><input type="number" name="NUMBER_SUM_E" id="NUMBER_SUM_E" value="${pd.NUMBER_SUM_E}" maxlength="32" placeholder="这里输入本月总用电量" title="本月总用电量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月电费:</td>
								<td><input type="number" name="TOTAL_SUM_E" id="TOTAL_SUM_E" value="${pd.TOTAL_SUM_E}" maxlength="32" placeholder="这里输入本月电费" title="本月电费" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实总价:</td>
								<td><input type="number" name="REALITY_TOTAL_SUM_E" id="REALITY_TOTAL_SUM_E" value="${pd.REALITY_TOTAL_SUM_E}" maxlength="32" placeholder="这里输入实总价" title="实总价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">上个月水量总读数:</td>
								<td><input type="number" name="LASTMONTH_SUM_W" id="LASTMONTH_SUM_W" value="${pd.LASTMONTH_SUM_W}" maxlength="32" placeholder="这里输入上个月水量总读数" title="上个月水量总读数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月水量总读数:</td>
								<td><input type="number" name="THISMONTH_SUM_W" id="THISMONTH_SUM_W" value="${pd.THISMONTH_SUM_W}" maxlength="32" placeholder="这里输入本月水量总读数" title="本月水量总读数" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月总用水量:</td>
								<td><input type="number" name="NUMBER_SUM_W" id="NUMBER_SUM_W" value="${pd.NUMBER_SUM_W}" maxlength="32" placeholder="这里输入本月总用水量" title="本月总用水量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月水费费用:</td>
								<td><input type="number" name="TOTAL_SUM_W" id="TOTAL_SUM_W" value="${pd.TOTAL_SUM_W}" maxlength="32" placeholder="这里输入本月水费费用" title="本月水费费用" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本月水费总费用:</td>
								<td><input type="number" name="REALITY_TOTAL_SUM_W" id="REALITY_TOTAL_SUM_W" value="${pd.REALITY_TOTAL_SUM_W}" maxlength="32" placeholder="这里输入本月水费总费用" title="本月水费总费用" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金:</td>
								<td><input type="number" name="OVERDUENUM" id="OVERDUENUM" value="${pd.OVERDUENUM}" maxlength="32" placeholder="这里输入滞纳金" title="滞纳金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="100" placeholder="这里输入合同id" title="合同id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">时间段id:</td>
								<td><input type="text" name="PROCEEDSTIME_ID" id="PROCEEDSTIME_ID" value="${pd.PROCEEDSTIME_ID}" maxlength="100" placeholder="这里输入时间段id" title="时间段id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票项id:</td>
								<td><input type="text" name="INVOICE_ID" id="INVOICE_ID" value="${pd.INVOICE_ID}" maxlength="100" placeholder="这里输入发票项id" title="发票项id" style="width:98%;"/></td>
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
			if($("#PAYERNAME").val()==""){
				$("#PAYERNAME").tips({
					side:3,
		            msg:'请输入付款方名称(水电费)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME").focus();
			return false;
			}
			if($("#PAYTIME").val()==""){
				$("#PAYTIME").tips({
					side:3,
		            msg:'请输入应收款时间(水电费)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME").focus();
			return false;
			}
			if($("#RECEIVABLE").val()==""){
				$("#RECEIVABLE").tips({
					side:3,
		            msg:'请输入应收金额(水电费)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE").focus();
			return false;
			}
			if($("#OVERDUE").val()==""){
				$("#OVERDUE").tips({
					side:3,
		            msg:'请输入滞纳金率',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OVERDUE").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME").val()==""){
				$("#RECEIVABL_PAYTIME").tips({
					side:3,
		            msg:'请输入实际收款时间(水电费)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY").val()==""){
				$("#RECEIVABLE_REALITY").tips({
					side:3,
		            msg:'请输入实际收款金额(水电费)',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY").focus();
			return false;
			}
			if($("#LASTMONTH_SUM_E").val()==""){
				$("#LASTMONTH_SUM_E").tips({
					side:3,
		            msg:'请输入上个月总电量读数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LASTMONTH_SUM_E").focus();
			return false;
			}
			if($("#THISMONTH_SUM_E").val()==""){
				$("#THISMONTH_SUM_E").tips({
					side:3,
		            msg:'请输入本月总电量读数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#THISMONTH_SUM_E").focus();
			return false;
			}
			if($("#NUMBER_SUM_E").val()==""){
				$("#NUMBER_SUM_E").tips({
					side:3,
		            msg:'请输入本月总用电量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_SUM_E").focus();
			return false;
			}
			if($("#TOTAL_SUM_E").val()==""){
				$("#TOTAL_SUM_E").tips({
					side:3,
		            msg:'请输入本月电费',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TOTAL_SUM_E").focus();
			return false;
			}
			if($("#REALITY_TOTAL_SUM_E").val()==""){
				$("#REALITY_TOTAL_SUM_E").tips({
					side:3,
		            msg:'请输入实总价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITY_TOTAL_SUM_E").focus();
			return false;
			}
			if($("#LASTMONTH_SUM_W").val()==""){
				$("#LASTMONTH_SUM_W").tips({
					side:3,
		            msg:'请输入上个月水量总读数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#LASTMONTH_SUM_W").focus();
			return false;
			}
			if($("#THISMONTH_SUM_W").val()==""){
				$("#THISMONTH_SUM_W").tips({
					side:3,
		            msg:'请输入本月水量总读数',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#THISMONTH_SUM_W").focus();
			return false;
			}
			if($("#NUMBER_SUM_W").val()==""){
				$("#NUMBER_SUM_W").tips({
					side:3,
		            msg:'请输入本月总用水量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NUMBER_SUM_W").focus();
			return false;
			}
			if($("#TOTAL_SUM_W").val()==""){
				$("#TOTAL_SUM_W").tips({
					side:3,
		            msg:'请输入本月水费费用',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TOTAL_SUM_W").focus();
			return false;
			}
			if($("#REALITY_TOTAL_SUM_W").val()==""){
				$("#REALITY_TOTAL_SUM_W").tips({
					side:3,
		            msg:'请输入本月水费总费用',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITY_TOTAL_SUM_W").focus();
			return false;
			}
			if($("#OVERDUENUM").val()==""){
				$("#OVERDUENUM").tips({
					side:3,
		            msg:'请输入滞纳金',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OVERDUENUM").focus();
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
			if($("#PROCEEDSTIME_ID").val()==""){
				$("#PROCEEDSTIME_ID").tips({
					side:3,
		            msg:'请输入时间段id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROCEEDSTIME_ID").focus();
			return false;
			}
			if($("#INVOICE_ID").val()==""){
				$("#INVOICE_ID").tips({
					side:3,
		            msg:'请输入发票项id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICE_ID").focus();
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