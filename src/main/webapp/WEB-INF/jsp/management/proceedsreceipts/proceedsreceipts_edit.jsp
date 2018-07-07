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
					
					<form action="proceedsreceipts/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROCEEDSRECEIPTS_ID" id="PROCEEDSRECEIPTS_ID" value="${pd.PROCEEDSRECEIPTS_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款日期:</td>
								<td><input class="span10 date-picker" name="PROCEEDSDATE" id="PROCEEDSDATE" value="${pd.PROCEEDSDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="收款日期" title="收款日期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款金额:</td>
								<td><input type="text" name="PROCEEDSNUM" id="PROCEEDSNUM" value="${pd.PROCEEDSNUM}" maxlength="255" placeholder="这里输入收款金额" title="收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款滞纳金:</td>
								<td><input type="text" name="OVERDUENUM" id="OVERDUENUM" value="${pd.OVERDUENUM}" maxlength="255" placeholder="这里输入收款滞纳金" title="收款滞纳金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款总额:</td>
								<td><input type="text" name="RECEIVABLE_REALITY" id="RECEIVABLE_REALITY" value="${pd.RECEIVABLE_REALITY}" maxlength="255" placeholder="这里输入收款总额" title="收款总额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">尚未收款金额:</td>
								<td><input type="text" name="NOT_RECEIVABLE" id="NOT_RECEIVABLE" value="${pd.NOT_RECEIVABLE}" maxlength="255" placeholder="这里输入尚未收款金额" title="尚未收款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">客户名称:</td>
								<td><input type="text" name="PAYER" id="PAYER" value="${pd.PAYER}" maxlength="255" placeholder="这里输入客户名称" title="客户名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">收款人:</td>
								<td><input type="text" name="PROCEEDSER" id="PROCEEDSER" value="${pd.PROCEEDSER}" maxlength="255" placeholder="这里输入收款人" title="收款人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已经打印:</td>
								<td><input type="text" name="ISPRINTLN" id="ISPRINTLN" value="${pd.ISPRINTLN}" maxlength="255" placeholder="这里输入是否已经打印" title="是否已经打印" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">打印日期:</td>
								<td><input class="span10 date-picker" name="PRINTLNDATE" id="PRINTLNDATE" value="${pd.PRINTLNDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="打印日期" title="打印日期" style="width:98%;"/></td>
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
			if($("#PROCEEDSDATE").val()==""){
				$("#PROCEEDSDATE").tips({
					side:3,
		            msg:'请输入收款日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROCEEDSDATE").focus();
			return false;
			}
			if($("#PROCEEDSNUM").val()==""){
				$("#PROCEEDSNUM").tips({
					side:3,
		            msg:'请输入收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROCEEDSNUM").focus();
			return false;
			}
			if($("#OVERDUENUM").val()==""){
				$("#OVERDUENUM").tips({
					side:3,
		            msg:'请输入收款滞纳金',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OVERDUENUM").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY").val()==""){
				$("#RECEIVABLE_REALITY").tips({
					side:3,
		            msg:'请输入收款总额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY").focus();
			return false;
			}
			if($("#NOT_RECEIVABLE").val()==""){
				$("#NOT_RECEIVABLE").tips({
					side:3,
		            msg:'请输入尚未收款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NOT_RECEIVABLE").focus();
			return false;
			}
			if($("#PAYER").val()==""){
				$("#PAYER").tips({
					side:3,
		            msg:'请输入客户名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYER").focus();
			return false;
			}
			if($("#PROCEEDSER").val()==""){
				$("#PROCEEDSER").tips({
					side:3,
		            msg:'请输入收款人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PROCEEDSER").focus();
			return false;
			}
			if($("#ISPRINTLN").val()==""){
				$("#ISPRINTLN").tips({
					side:3,
		            msg:'请输入是否已经打印',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISPRINTLN").focus();
			return false;
			}
			if($("#PRINTLNDATE").val()==""){
				$("#PRINTLNDATE").tips({
					side:3,
		            msg:'请输入打印日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRINTLNDATE").focus();
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