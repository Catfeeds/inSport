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
				<div class="" style="text-align: left;margin-left: 10px;margin-top: 10px">
					<!-- <td style="text-align: center;" colspan="10"> -->
					<a  class="btn btn-success btn-xs" onclick="save()">
						<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>保存
					</a>
					<a class="btn btn-primary  btn-xs" onclick="top.Dialog.close();">
						<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
					</a>
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
					
					<form action="invoice/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="INVOICE_ID" id="INVOICE_ID" value="${pd.INVOICE_ID}"/>
						<input type="hidden" name="PROCEEDSTIME_ID" id="PROCEEDSTIME_ID" value="${pd.PROCEEDSTIME_ID}"/>
						<input type="hidden" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
							<table class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="success">
									<th width="15%"><label>应收金额(水电费)：</label></th>
									<th width="10%"><input type="number" style="width: 150px" value="${var1.RECEIVABLE}"
														   class="input-text"  name="RECEIVABLE"
														   id="r${var1.INVOICE_ID}"></th>
									<th ><label>应付款时间(水电费)：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${var1.PAYTIME}"
												class="input-text"  name="PAYTIME"
												id="pt${var1.INVOICE_ID}"></th>
								<th width="15%"><label>付款方名称(水电费)：</label></th>
								<th width="20%"><input type="text" style="width: 150px" value="${var1.PAYERNAME}"
													   class="input-text"  name="PAYERNAME"
													   id="pn${var1.INVOICE_ID}"></th>

								</tr>
								<tr class="success">
									<th width="15%"><label>实际付款金额(水电费)：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${var1.RECEIVABLE_REALITY}"
														   class="input-text"  name="RECEIVABLE_REALITY"
														   id="rr${var1.INVOICE_ID}"></th>
									<th ><label>实际付款时间(水电费)：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${var1.RECEIVABL_PAYTIME}"
												class="input-text"  name="RECEIVABL_PAYTIME"
												id="rpt${var1.INVOICE_ID}"></th>
									<th  ><label>滞纳金:</label></th>
									<th  ><input type="number" style="width: 150px;height: 31px" value="${var1.RECEIVABL_PAYTIME}"
												 class="input-text"  name="RECEIVABL_PAYTIME"
												 id="rpt${var1.INVOICE_ID}"></th>
								</tr>
								</tbody>
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
			if($("#CONTRACT_ID").val()==""){
				$("#CONTRACT_ID").tips({
					side:3,
		            msg:'请输入CONTRACT_ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_ID").focus();
			return false;
			}
			if($("#INVOICENAME").val()==""){
				$("#INVOICENAME").tips({
					side:3,
		            msg:'请输入发票名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENAME").focus();
			return false;
			}
			if($("#INVOICETIME").val()==""){
				$("#INVOICETIME").tips({
					side:3,
		            msg:'请输入开票时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICETIME").focus();
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