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
						<input type="hidden" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}"/>
						<input type="hidden" name="PROCEEDSTIME_ID" id="PROCEEDSTIME_ID" value="${pd.PROCEEDSTIME_ID}"/>
						<input type="hidden" name="INVOICE_ID" id="INVOICE_ID" value="${pd.INVOICE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="electricity" class="table table-striped table-bordered table-hover">
							<tbody>
							<tr class="center">
								<td colspan="11" style="padding-left:2px;font-size: 26px" ><strong>${pd.CONTRACTOFNAME}   电费</strong>
									<a style="margin-left: 10px" class="btn btn-xs btn-success" title="添加电表项"
									   onclick="addTdEl()">
										<i class="ace-icon fa fa-pencil-square-o bigger-120" title="添加电表项">添加电表项</i></a>
								</td>
							</tr>
							<tr class="center">
								<td style="padding-left:2px;">表号</td>
								<td style="padding-left:2px;">上月读数</td>
								<td style="padding-left:2px;">本月读数</td>
								<td style="padding-left:2px;">变比</td>
								<td style="padding-left:2px;">分表值</td>
								<td style="padding-left:2px;">用电数</td>
								<td style="padding-left:2px;">电费单价</td>
								<td style="padding-left:2px;">总价</td>
								<td style="padding-left:2px;">10%线损</td>
								<td style="padding-left:2px;">实总价</td>
								<td style="padding-left:2px;">操作</td>
							</tr>
							<tr class="center" id="el">
								<td style="padding-left:2px;">合计</td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
							</tr>
							</tbody>
						</table>
						<table id="water" class="table table-striped table-bordered table-hover">
							<tr class="center">
								<td colspan="11" style="padding-left:2px;font-size: 26px" >
									<strong>${pd.CONTRACTOFNAME}   水费</strong>
									<a style="margin-left: 10px" class="btn btn-xs btn-success" title="添加水表项"
									   onclick="addTdWa()">
										<i class="ace-icon fa fa-pencil-square-o bigger-120" title="添加水表项">添加水表项</i></a>
								</td>
							</tr>
							<tr class="center">
								<td style="padding-left:2px;">表号</td>
								<td style="padding-left:2px;">上月读数</td>
								<td style="padding-left:2px;">本月读数</td>
								<td style="padding-left:2px;">变比</td>
								<td style="padding-left:2px;">分表值</td>
								<td style="padding-left:2px;">用水量</td>
								<td style="padding-left:2px;">水费单价</td>
								<td style="padding-left:2px;">总价</td>
								<td style="padding-left:2px;">10%线损</td>
								<td style="padding-left:2px;">实总价</td>
								<td style="padding-left:2px;">操作</td>
							</tr>
							<tr class="center" id="wa">
								<td style="padding-left:2px;">合计</td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
							</tr>
						</table>
						</div>
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

		function addTdEl() {
			var uuid = "";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>paytable/getUUID',
				async: false,
				data: {
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					uuid = data.uuid;
				}
			});
			var tr = "";
			tr += '<tr class="success center"><td><label><input type="number" style="width: 50px;"  class="input-text" id="mn_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="lm_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="tm_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="ra_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="va_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="nu_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="pr_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 90px;"  class="input-text" id="to_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 80px;"  class="input-text" id="il_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="rto_e'+uuid+'"></td>';
			tr += '<td> <a class="btn btn-xs btn-success" title="保存" onclick="saveEl(\''+uuid+'\');">' +
					'<i class="ace-icon fa fa-check-square-o bigger-110" title="保存">保存</i></a></th>';
			tr += '</tr>';
			$("#el").before(tr);
			tr = "";
		}

		function addTdWa() {
			var uuid = "";
			$.ajax({
				type: "POST",
				url: '<%=basePath%>paytable/getUUID',
				async: false,
				data: {
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					uuid = data.uuid;
				}
			});
			var tr = "";
			tr += '<tr class="success center"><td><label><input type="number" style="width: 50px;"  class="input-text" id="mn_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="lm_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="tm_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="ra_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="va_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="nu_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="pr_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 90px;"  class="input-text" id="to_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 80px;"  class="input-text" id="il_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;"  class="input-text" id="rto_w'+uuid+'"></td>';
			tr += '<td> <a class="btn btn-xs btn-success" title="保存" onclick="saveWa(\''+uuid+'\');">' +
					'<i class="ace-icon fa fa-check-square-o bigger-110" title="保存">保存</i></a></th>';
			tr += '</tr>';
			$("#wa").before(tr);
			tr = "";
		}
		
		function saveEl(uuid) {
			var LASTMONTH = $("#lm_e"+uuid).val();
			var THISMONTH =  $("#tm_e"+uuid).val();
			var RATIO = $("#ra_e"+uuid).val();
			var FVALUE = $("#va_e"+uuid).val();
			var NUMBER = $("#nu_e"+uuid).val();
			var PRICE =$("#pr_e"+uuid).val();
			var REALITY_TOTAL = $("#rto_e"+uuid).val();
			var ISLOSS = $("#il_e"+uuid).val();
			var METERNUM = $("#mn_e"+uuid).val();
			var INVOICE_ID = $("#INVOICE_ID").val();
			var CONTRACT_ID = $("#CONTRACT_ID").val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>expense/saveElectricity',
				data: {
					CONTRACT_ID: CONTRACT_ID,
					LASTMONTH: LASTMONTH,
					THISMONTH: THISMONTH,
					RATIO:RATIO,
					FVALUE:FVALUE,
					NUMBER:NUMBER,
					PRICE:PRICE,
					REALITY_TOTAL:REALITY_TOTAL,
					ISLOSS:ISLOSS,
					METERNUM:METERNUM,
					INVOICE_ID:INVOICE_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					//alert(uuid_var);
					window.location.reload();
				}
			});
		}

		function saveWa(uuid) {
			var LASTMONTH = $("#lm_w"+uuid).val();
			var THISMONTH =  $("#tm_w"+uuid).val();
			var RATIO = $("#ra_w"+uuid).val();
			var FVALUE = $("#va_w"+uuid).val();
			var NUMBER = $("#nu_w"+uuid).val();
			var PRICE =$("#pr_w"+uuid).val();
			var REALITY_TOTAL = $("#rto_w"+uuid).val();
			var ISLOSS = $("#il_w"+uuid).val();
			var METERNUM = $("#mn_w"+uuid).val();
			var INVOICE_ID = $("#INVOICE_ID").val();
			var CONTRACT_ID = $("#CONTRACT_ID").val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>expense/saveWater',
				data: {
					CONTRACT_ID: CONTRACT_ID,
					LASTMONTH: LASTMONTH,
					THISMONTH: THISMONTH,
					RATIO:RATIO,
					FVALUE:FVALUE,
					NUMBER:NUMBER,
					PRICE:PRICE,
					REALITY_TOTAL:REALITY_TOTAL,
					ISLOSS:ISLOSS,
					METERNUM:METERNUM,
					INVOICE_ID:INVOICE_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					//alert(uuid_var);
					window.location.reload();
				}
			});
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>