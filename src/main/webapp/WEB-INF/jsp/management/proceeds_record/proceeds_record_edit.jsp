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
					
					<form action="proceeds_record/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROCEEDS_RECORD_ID" id="PROCEEDS_RECORD_ID" value="${pd.PROCEEDS_RECORD_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">类型:</td>
								<td><input type="text" name="TYPE" id="TYPE" value="${pd.TYPE}" maxlength="255" placeholder="这里输入类型" title="类型" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同id:</td>
								<td><input type="text" name="CONTRACTID" id="CONTRACTID" value="${pd.CONTRACTID}" maxlength="100" placeholder="这里输入合同id" title="合同id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">项目id:</td>
								<td><input type="text" name="ITEMID" id="ITEMID" value="${pd.ITEMID}" maxlength="100" placeholder="这里输入项目id" title="项目id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本次应收金额:</td>
								<td><input type="text" name="RECEIVABLE" id="RECEIVABLE" value="${pd.RECEIVABLE}" maxlength="255" placeholder="这里输入本次应收金额" title="本次应收金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金率:</td>
								<td><input type="text" name="OVERDUE" id="OVERDUE" value="${pd.OVERDUE}" maxlength="255" placeholder="这里输入滞纳金率" title="滞纳金率" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金:</td>
								<td><input type="text" name="OVERDUENUM" id="OVERDUENUM" value="${pd.OVERDUENUM}" maxlength="255" placeholder="这里输入滞纳金" title="滞纳金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本次收款金额:</td>
								<td><input type="text" name="RECEIVABLE_N" id="RECEIVABLE_N" value="${pd.RECEIVABLE_N}" maxlength="255" placeholder="这里输入本次收款金额" title="本次收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本次尚未收款金额:</td>
								<td><input type="text" name="NOT_RECEIVABLE" id="NOT_RECEIVABLE" value="${pd.NOT_RECEIVABLE}" maxlength="255" placeholder="这里输入本次尚未收款金额" title="本次尚未收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">本次收款时间:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME" id="RECEIVABL_PAYTIME" value="${pd.RECEIVABL_PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="本次收款时间" title="本次收款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款人:</td>
								<td><input type="text" name="RECEIVABL_EMPL" id="RECEIVABL_EMPL" value="${pd.RECEIVABL_EMPL}" maxlength="255" placeholder="这里输入收款人" title="收款人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款方式:</td>
								<td><input type="text" name="MODE" id="MODE" value="${pd.MODE}" maxlength="255" placeholder="这里输入收款方式" title="收款方式" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方名称:</td>
								<td><input type="text" name="PAYER" id="PAYER" value="${pd.PAYER}" maxlength="255" placeholder="这里输入付款方名称" title="付款方名称" style="width:98%;"/></td>
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
			if($("#TYPE").val()==""){
				$("#TYPE").tips({
					side:3,
		            msg:'请输入类型',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TYPE").focus();
			return false;
			}
			if($("#CONTRACTID").val()==""){
				$("#CONTRACTID").tips({
					side:3,
		            msg:'请输入合同id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACTID").focus();
			return false;
			}
			if($("#ITEMID").val()==""){
				$("#ITEMID").tips({
					side:3,
		            msg:'请输入项目id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ITEMID").focus();
			return false;
			}
			if($("#RECEIVABLE").val()==""){
				$("#RECEIVABLE").tips({
					side:3,
		            msg:'请输入本次应收金额',
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
			if($("#RECEIVABLE_N").val()==""){
				$("#RECEIVABLE_N").tips({
					side:3,
		            msg:'请输入本次收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_N").focus();
			return false;
			}
			if($("#NOT_RECEIVABLE").val()==""){
				$("#NOT_RECEIVABLE").tips({
					side:3,
		            msg:'请输入本次尚未收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NOT_RECEIVABLE").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME").val()==""){
				$("#RECEIVABL_PAYTIME").tips({
					side:3,
		            msg:'请输入本次收款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME").focus();
			return false;
			}
			if($("#RECEIVABL_EMPL").val()==""){
				$("#RECEIVABL_EMPL").tips({
					side:3,
		            msg:'请输入收款人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_EMPL").focus();
			return false;
			}
			if($("#MODE").val()==""){
				$("#MODE").tips({
					side:3,
		            msg:'请输入收款方式',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MODE").focus();
			return false;
			}
			if($("#PAYER").val()==""){
				$("#PAYER").tips({
					side:3,
		            msg:'请输入付款方名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYER").focus();
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