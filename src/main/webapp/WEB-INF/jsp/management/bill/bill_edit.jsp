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
					
					<form action="bill/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="BILL_ID" id="BILL_ID" value="${pd.BILL_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发单日期:</td>
								<td>
									<input type="text" readonly style="width: 150px;height: 31px" value="${pd.BILLDATE}"
									class="input-text"  name="BILLDATE"
									id="BILLDATE" >
								</td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发单人:</td>
								<td><input type="text" name="BILLER" id="BILLER" value="${pd.BILLER}" maxlength="255" placeholder="这里输入发单人" title="发单人" style="width:98%;"/></td>
							</tr>
							<tr style="display: none">
								<td style="width:75px;text-align: right;padding-top: 13px;">项目:</td>
								<td><input type="text" name="ITEMID" id="ITEMID" value="${pd.INVOICE_ID}" maxlength="255" placeholder="这里输入项目" title="项目" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="FNOTE" id="FNOTE" value="${pd.FNOTE}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr style="display: none">
								<td style="width:75px;text-align: right;padding-top: 13px;">合同id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="255" placeholder="这里输入合同id" title="合同id" style="width:98%;"/></td>
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
			if($("#BILLDATE").val()==""){
				$("#BILLDATE").tips({
					side:3,
		            msg:'请输入发单日期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BILLDATE").focus();
			return false;
			}
			if($("#BILLER").val()==""){
				$("#BILLER").tips({
					side:3,
		            msg:'请输入发单人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#BILLER").focus();
			return false;
			}
			if($("#ITEMID").val()==""){
				$("#ITEMID").tips({
					side:3,
		            msg:'请输入项目',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ITEMID").focus();
			return false;
			}
			if($("#FNOTE").val()==""){
				$("#FNOTE").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNOTE").focus();
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
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			var myDate = new Date();
			var year = myDate.getFullYear();
			var month = myDate.getMonth()+1;
			var day = myDate.getDate();
			//alert(year+"-"+month+"-"+day);
			$("#BILLDATE").val(year+"年"+month+"月"+day+"日");
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>