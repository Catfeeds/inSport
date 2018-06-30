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
								<td style="padding-left:2px;">线损(%)</td>
								<td style="padding-left:2px;">实总价</td>
								<td style="padding-left:2px;">操作</td>
							</tr>
							<c:if test="${not empty listEl }">
							<c:forEach items="${listEl}" var="var" varStatus="vs">
							<tr class="center">
								<td style="padding-left:2px;">
									<input type="number" style="width: 50px" value="${var.METERNUM}"
										   class="input-text"  name="E_METERNUM"
										   id="mn${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 110px" value="${var.LASTMONTH}"
										   class="input-text"  name="E_LASTMONTH"
										   id="lm${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" onchange="calExpDif('${var.EXPENSE_ID}')" style="width: 110px" value="${var.THISMONTH}"
										   class="input-text"  name="E_THISMONTH"
										   id="tm${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 50px" value="${var.RATIO}"
										   class="input-text"  name="E_RATIO"
										   id="ra${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 50px" value="${var.FVALUE}"
										   class="input-text"  name="E_FVALUE"
										   id="va${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 100px" value="${var.NUMBER}"
										   class="input-text"  name="E_NUMBER"
										   id="nu${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 80px" value="${var.PRICE}"
										   class="input-text"  name="E_PRICE"
										   id="pr${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 110px" value="${var.TOTAL}"
										   class="input-text"  name="E_TOTAL" onclick="calExpDif('${var.EXPENSE_ID}')"
										   id="to${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 50px" value="${var.ISLOSS}"
										   class="input-text"  name="E_ISLOSS" onchange="calExpDif('${var.EXPENSE_ID}')"
										   id="il${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<input type="number" style="width: 110px" value="${var.REALITY_TOTAL}"
										   class="input-text"  name="E_REALITY_TOTAL"
										   id="rto${var.EXPENSE_ID}">
								</td>
								<td style="padding-left:2px;">
									<a style="margin-left: 10px" class="btn btn-xs btn-success" title="保存"
									   onclick="editExpense('${var.EXPENSE_ID}')">
										<i class="ace-icon fa fa-cog bigger-120" title="保存">保存</i></a>
									<a style="margin-left: 10px" class="btn btn-xs btn-danger" title="删除"
									   onclick="delExpense('${var.EXPENSE_ID}')">
										<i class="ace-icon fa fa-check-square-o bigger-120" title="删除">删除</i></a>
								</td>
							</tr>
							</c:forEach>
							</c:if>
							<tr class="center" id="el">
								<td onclick="calculate('E')" style="padding-left:2px;"><a >合计</a></td>
								<td style="padding-left:2px;"><p id="LASTMONTH_SUM_E">${utiPd.LASTMONTH_SUM_E}</p></td>
								<td style="padding-left:2px;"><p id="THISMONTH_SUM_E">${utiPd.THISMONTH_SUM_E}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="NUMBER_SUM_E">${utiPd.NUMBER_SUM_E}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="TOTAL_SUM_E">${utiPd.TOTAL_SUM_E}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="REALITY_TOTAL_SUM_E">${utiPd.REALITY_TOTAL_SUM_E}</p></td>
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
								<td style="padding-left:2px;">线损(%)</td>
								<td style="padding-left:2px;">实总价</td>
								<td style="padding-left:2px;">操作</td>
							</tr>
							<c:if test="${not empty listWa }">
							<c:forEach items="${listWa}" var="var" varStatus="vs">
								<tr class="center">
									<td style="padding-left:2px;">
										<input type="number" style="width: 50px" value="${var.METERNUM}"
											   class="input-text"  name="W_METERNUM"
											   id="mn${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 110px" value="${var.LASTMONTH}"
											   class="input-text"  name="W_LASTMONTH"
											   id="lm${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 110px" value="${var.THISMONTH}"
											   class="input-text"  name="W_THISMONTH"  onchange="calExpDif('${var.EXPENSE_ID}')"
											   id="tm${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 50px" value="${var.RATIO}"
											   class="input-text"  name="W_RATIO"
											   id="ra${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 50px" value="${var.FVALUE}"
											   class="input-text"  name="W_FVALUE"
											   id="va${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 100px" value="${var.NUMBER}"
											   class="input-text"  name="W_NUMBER" onclick="calExpDif('${var.EXPENSE_ID}')"
											   id="nu${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 80px" value="${var.PRICE}"
											   class="input-text"  name="W_PRICE"
											   id="pr${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 110px" value="${var.TOTAL}"
											   class="input-text"  name="W_TOTAL" onclick="calExpDif('${var.EXPENSE_ID}')"
											   id="to${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 50px" value="${var.ISLOSS}"
											   class="input-text"  name="W_ISLOSS" onchange="calExpDif('${var.EXPENSE_ID}')"
											   id="il${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<input type="number" style="width: 110px" value="${var.REALITY_TOTAL}"
											   class="input-text"  name="W_REALITY_TOTAL"
											   id="rto${var.EXPENSE_ID}">
									</td>
									<td style="padding-left:2px;">
										<a style="margin-left: 10px" class="btn btn-xs btn-success" title="保存"
										   onclick="editExpense('${var.EXPENSE_ID}')">
											<i class="ace-icon fa fa-cog bigger-120" title="保存">保存</i></a>
										<a style="margin-left: 10px" class="btn btn-xs btn-danger" title="删除"
										   onclick="delExpense('${var.EXPENSE_ID}')">
											<i class="ace-icon fa fa-check-square-o bigger-120" title="删除">删除</i></a>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<tr class="center" id="wa">
								<td  onclick="calculate('W')" style="padding-left:2px;"><a>合计</a></td>
								<td style="padding-left:2px;"><p id="LASTMONTH_SUM_W">${utiPd.LASTMONTH_SUM_W}</p></td>
								<td style="padding-left:2px;"><p id="THISMONTH_SUM_W">${utiPd.THISMONTH_SUM_W}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="NUMBER_SUM_W">${utiPd.NUMBER_SUM_W}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="TOTAL_SUM_W">${utiPd.TOTAL_SUM_W}</p></td>
								<td style="padding-left:2px;"></td>
								<td style="padding-left:2px;"><p id="REALITY_TOTAL_SUM_W">${utiPd.REALITY_TOTAL_SUM_W}</p></td>
								<td style="padding-left:2px;"></td>
							</tr>
						</table>
						<table class="table table-border table-bg table-bordered">
							<tbody>
							<tr class="success">
								<th class="center"><label>付款方名称(水电费)：</label></th>
								<th class="center"><input type="text" style="width: 150px" value="${pd.PAYERNAME}"
														  class="input-text"  name="PAYERNAME"
														  id="PAYERNAME"></th>

								<th class="center"><label>应收款时间(水电费)：</label></th>
								<th class="center"><input type="date" style="width: 150px;height: 31px" value="${utiPd.PAYTIME}"
											class="input-text"  name="PAYTIME"
											id="PAYTIME"></th>
								<th class="center"><label>应收金额(水电费)：</label></th>
								<th class="center"><input type="number" style="width: 150px" value="${utiPd.RECEIVABLE}"
														  class="input-text"  name="RECEIVABLE" onclick="calRece()"
														  id="RECEIVABLE"></th>
								<th width="20%">滞纳金率：${pd.OVERDUE}</th>
							</tr>
							<tr class="success">
								<th  class="center"><label>滞纳金:</label></th>
								<th  class="center"><input type="number" style="width: 150px;height: 31px" onchange="odAndRec()"
														   class="input-text"  name="OVERDUE" value="${utiPd.OVERDUENUM}"
														   id="OVERDUE"></th>

								<th class="center"><label>实际收款时间(水电费)：</label></th>
								<th class="center"><input type="date" style="width: 150px;height: 31px" value="${utiPd.RECEIVABL_PAYTIME}"
											class="input-text"  name="RECEIVABL_PAYTIME" onchange="rece_rea()"
											id="RECEIVABL_PAYTIME"></th>
								<th class="center"><label>实际收款金额(水电费)：</label></th>
								<th class="center"><input type="number" style="width: 150px"  onclick="odAndRec()"
														  class="input-text"  name="RECEIVABLE_REALITY" value="${utiPd.RECEIVABLE_REALITY}"
														  id="RECEIVABLE_REALITY"></th>

								<th class="center">
									<c:if test="${not empty utiPd}">
										<a class="btn btn-xs " title="打印通知单" onclick="print('${utiPd.UTILITIESSTATE_ID}','${pd.INVOICE_ID}');">
											<i class="ace-icon glyphicon glyphicon-print bigger-120" title="打印通知单">打印通知单</i>
										</a>
										<a class="btn btn-xs btn-info" title="修改" onclick="editUtilities('${utiPd.UTILITIESSTATE_ID}');">
											<i class="ace-icon fa fa-check-square-o bigger-120" title="修改">修改</i>
										</a>
									</c:if>
									<c:if test="${utiPd == null}">
										<a class="btn btn-xs btn-success" title="保存" onclick="saveUtilities('${pd.CONTRACT_ID}','${pd.PROCEEDSTIME_ID}','${pd.INVOICE_ID}');">
											<i class="ace-icon fa fa-check-square-o bigger-120" title="保存">保存</i>
										</a>
									</c:if>

								</th>
							</tr>
							</tbody>
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

		function print(UTILITIESSTATE_ID,INVOICE_ID){
			window.open("<%=basePath%>/utilitiesstate/printPage.do?UTILITIESSTATE_ID="+UTILITIESSTATE_ID+"&INVOICE_ID="+INVOICE_ID, "", 'left=250,top=150,width=1150,height=700,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes');
		}

		//修改水电费情况
		function editUtilities(UTILITIESSTATE_ID){
			var RECEIVABLE_REALITY = $("#RECEIVABLE_REALITY").val();
			var PAYERNAME = $("#PAYERNAME").val();
			var PAYTIME = $("#PAYTIME").val();
			var RECEIVABLE = $("#RECEIVABLE").val();
			var OVERDUENUM = $("#OVERDUE").val();
			var RECEIVABL_PAYTIME = $("#RECEIVABL_PAYTIME").val();
			var LASTMONTH_SUM_E = $("#LASTMONTH_SUM_E").text();
			var THISMONTH_SUM_E = $("#THISMONTH_SUM_E").text();
			var NUMBER_SUM_E = $("#NUMBER_SUM_E").text();
			var TOTAL_SUM_E = $("#TOTAL_SUM_E").text();
			var REALITY_TOTAL_SUM_E = $("#REALITY_TOTAL_SUM_E").text();
			var LASTMONTH_SUM_W = $("#LASTMONTH_SUM_W").text();
			var THISMONTH_SUM_W = $("#THISMONTH_SUM_W").text();
			var NUMBER_SUM_W = $("#NUMBER_SUM_W").text();
			var TOTAL_SUM_W = $("#TOTAL_SUM_W").text();
			var REALITY_TOTAL_SUM_W = $("#REALITY_TOTAL_SUM_W").text();
			var OVERDUE = '${pd.OVERDUE}';
			$.ajax({
				type: "POST",
				url: '<%=basePath%>utilitiesstate/editUtilitiesState',
				async: false,
				data: {
					RECEIVABLE_REALITY : RECEIVABLE_REALITY,
					PAYERNAME : PAYERNAME,
					PAYTIME : PAYTIME,
					RECEIVABLE : RECEIVABLE,
					OVERDUENUM : OVERDUENUM,
					RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
					LASTMONTH_SUM_E : LASTMONTH_SUM_E,
					THISMONTH_SUM_E : THISMONTH_SUM_E,
					NUMBER_SUM_E : NUMBER_SUM_E,
					TOTAL_SUM_E : TOTAL_SUM_E,
					REALITY_TOTAL_SUM_E : REALITY_TOTAL_SUM_E,
					LASTMONTH_SUM_W : LASTMONTH_SUM_W,
					THISMONTH_SUM_W : THISMONTH_SUM_W,
					NUMBER_SUM_W : NUMBER_SUM_W,
					TOTAL_SUM_W : TOTAL_SUM_W,
					REALITY_TOTAL_SUM_W : REALITY_TOTAL_SUM_W,
					OVERDUE : OVERDUE,
					UTILITIESSTATE_ID : UTILITIESSTATE_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					window.location.reload();
				}
			});
		}

		//保存水电费
		function saveUtilities(CONTRACT_ID,PROCEEDSTIME_ID,INVOICE_ID){
			var RECEIVABLE_REALITY = $("#RECEIVABLE_REALITY").val();
			var PAYERNAME = $("#PAYERNAME").val();
			var PAYTIME = $("#PAYTIME").val();
			var RECEIVABLE = $("#RECEIVABLE").val();
			var OVERDUENUM = $("#OVERDUE").val();
			var RECEIVABL_PAYTIME = $("#RECEIVABL_PAYTIME").val();
			var LASTMONTH_SUM_E = $("#LASTMONTH_SUM_E").text();
			var THISMONTH_SUM_E = $("#THISMONTH_SUM_E").text();
			var NUMBER_SUM_E = $("#NUMBER_SUM_E").text();
			var TOTAL_SUM_E = $("#TOTAL_SUM_E").text();
			var REALITY_TOTAL_SUM_E = $("#REALITY_TOTAL_SUM_E").text();
			var LASTMONTH_SUM_W = $("#LASTMONTH_SUM_W").text();
			var THISMONTH_SUM_W = $("#THISMONTH_SUM_W").text();
			var NUMBER_SUM_W = $("#NUMBER_SUM_W").text();
			var TOTAL_SUM_W = $("#TOTAL_SUM_W").text();
			var REALITY_TOTAL_SUM_W = $("#REALITY_TOTAL_SUM_W").text();
			var OVERDUE = '${pd.OVERDUE}';
			$.ajax({
				type: "POST",
				url: '<%=basePath%>utilitiesstate/saveUtilitiesState',
				async: false,
				data: {
					RECEIVABLE_REALITY : RECEIVABLE_REALITY,
					PAYERNAME : PAYERNAME,
					PAYTIME : PAYTIME,
					RECEIVABLE : RECEIVABLE,
					OVERDUENUM : OVERDUENUM,
					RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
					LASTMONTH_SUM_E : LASTMONTH_SUM_E,
					THISMONTH_SUM_E : THISMONTH_SUM_E,
					NUMBER_SUM_E : NUMBER_SUM_E,
					TOTAL_SUM_E : TOTAL_SUM_E,
					REALITY_TOTAL_SUM_E : REALITY_TOTAL_SUM_E,
					LASTMONTH_SUM_W : LASTMONTH_SUM_W,
					THISMONTH_SUM_W : THISMONTH_SUM_W,
					NUMBER_SUM_W : NUMBER_SUM_W,
					TOTAL_SUM_W : TOTAL_SUM_W,
					REALITY_TOTAL_SUM_W : REALITY_TOTAL_SUM_W,
					OVERDUE : OVERDUE,
					CONTRACT_ID : CONTRACT_ID,
					PROCEEDSTIME_ID : PROCEEDSTIME_ID,
					INVOICE_ID : INVOICE_ID
				},
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function (data) {
					window.location.reload();
				}
			});
		}

		function odAndRec(){
			if($("#RECEIVABLE").val() == null || $("#RECEIVABLE").val() == ""){
				calRece();
			}
			if($("#OVERDUE").val() == null || $("#OVERDUE").val() == ""){
				alert("请输入滞纳金，滞纳金不能为空！！");
			}
			var RECEIVABLE =  $("#RECEIVABLE").val();
			var OVERDUE = $("#OVERDUE").val();
			$("#RECEIVABLE_REALITY").val((parseFloat(OVERDUE) + parseFloat(RECEIVABLE)).toFixed(2));
		}

		//计算实收水电费
		function rece_rea(){
			if($("#RECEIVABLE").val() == null || $("#RECEIVABLE").val() == ""){
				calRece();
			}
			var OVERDUE = '${pd.OVERDUE}';
			var RECEIVABLE =  $("#RECEIVABLE").val();
			var PAYTIME = $("#PAYTIME").val();
			var RECEIVABL_PAYTIME = $("#RECEIVABL_PAYTIME").val();
			var differ = (Date.parse(new Date(RECEIVABL_PAYTIME))-Date.parse(new Date(PAYTIME)))/(1000*60*60*24);
			if(differ > 0){
				var OVERDUENUM =differ * parseFloat(OVERDUE) * parseFloat(RECEIVABLE)*0.01;
				$("#OVERDUE").val(OVERDUENUM.toFixed(2));
			}else {
				var OVERDUENUM = 0;
				$("#OVERDUE").val(0.00);
			}
			$("#RECEIVABLE_REALITY").val(( OVERDUENUM + parseFloat(RECEIVABLE)).toFixed(2));
		}

		//计算应收水电费
		function calRece() {
			calculate('E');
			calculate('W');
			var REALITY_TOTAL_SUM_E = $("#REALITY_TOTAL_SUM_E").text();
			if(REALITY_TOTAL_SUM_E == null ||　REALITY_TOTAL_SUM_E　== ""){
				REALITY_TOTAL_SUM_E = 0;
			}
			//alert(REALITY_TOTAL_SUM_E);
			var REALITY_TOTAL_SUM_W = $("#REALITY_TOTAL_SUM_W").text();
			if(REALITY_TOTAL_SUM_W == null ||　REALITY_TOTAL_SUM_W　== ""){
				REALITY_TOTAL_SUM_W = 0;
			}
			$("#RECEIVABLE").val((parseFloat(REALITY_TOTAL_SUM_E) + parseFloat(REALITY_TOTAL_SUM_W)).toFixed(2));
		}

		//合计
		function calculate(value) {
			var LASTMONTH_SUM = 0.00;
			var THISMONTH_SUM = 0.00;
			var NUMBER_SUM = 0.00;
			var TOTAL_SUM = 0.00;
			var REALITY_TOTAL_SUM = 0.00;
			$("[name='"+value+"_LASTMONTH']").each(function(index,item){
				LASTMONTH_SUM += parseFloat($(this).val());
			});
			$("[name='"+value+"_THISMONTH']").each(function(index,item){
				THISMONTH_SUM += parseFloat($(this).val());
			});
			$("[name='"+value+"_NUMBER']").each(function(index,item){
				NUMBER_SUM += parseFloat($(this).val());
			});
			$("[name='"+value+"_TOTAL']").each(function(index,item){
				TOTAL_SUM += parseFloat($(this).val());
			});
			$("[name='"+value+"_REALITY_TOTAL']").each(function(index,item){
				REALITY_TOTAL_SUM += parseFloat($(this).val());
			});
			$("#LASTMONTH_SUM_"+value).text(LASTMONTH_SUM.toFixed(2));
			$("#THISMONTH_SUM_"+value).text(THISMONTH_SUM.toFixed(2));
			$("#NUMBER_SUM_"+value).text(NUMBER_SUM.toFixed(2));
			$("#TOTAL_SUM_"+value).text(TOTAL_SUM.toFixed(2));
			$("#REALITY_TOTAL_SUM_"+value).text(REALITY_TOTAL_SUM.toFixed(2));
		}

		//计算用量
		function calExpDif(EXPENSE_ID) {
			var LASTMONTH = $("#lm"+EXPENSE_ID).val();
			var THISMONTH = $("#tm"+EXPENSE_ID).val();
			var RATIO = $("#ra"+EXPENSE_ID).val();
			//alert((parseFloat(THISMONTH) - parseFloat(LASTMONTH)).toFixed(2));
			$("#nu"+EXPENSE_ID).val(((parseFloat(THISMONTH) - parseFloat(LASTMONTH)) * parseFloat(RATIO)).toFixed(2));
			calTotal(EXPENSE_ID);
		}

		//计算总价
		function calTotal(EXPENSE_ID){
			var RATIO = $("#ra"+EXPENSE_ID).val();
			var FVALUE = $("#va"+EXPENSE_ID).val();
			var NUMBER = $("#nu"+EXPENSE_ID).val();
			var PRICE = $("#pr"+EXPENSE_ID).val();
			var ISLOSS= $("#il"+EXPENSE_ID).val();
			if(ISLOSS == null || ISLOSS == ""){
				ISLOSS = 0.00;
			}
			var TOTAL = (parseFloat(NUMBER) + parseFloat(FVALUE))* parseFloat(PRICE) * (parseFloat(ISLOSS)*0.01+1);
			$("#to"+EXPENSE_ID).val(TOTAL.toFixed(2));
			$("#rto"+EXPENSE_ID).val(TOTAL.toFixed(2));
		}

		//添加电费的表单
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
			tr += '<td><label><input type="number" style="width: 110px;" onchange="calExpDif(\'_e'+uuid+'\')" class="input-text" id="tm_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"   class="input-text" id="ra_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="va_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;" onclick="calExpDif(\'_e'+uuid+'\')" class="input-text" id="nu_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 80px;"  class="input-text" id="pr_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  onclick="calExpDif(\'_e'+uuid+'\')" class="input-text" id="to_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;" onchange="calExpDif(\'_e'+uuid+'\')" class="input-text" id="il_e'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="rto_e'+uuid+'"></td>';
			tr += '<td> <a class="btn btn-xs btn-success" title="保存" onclick="saveEl(\''+uuid+'\');">' +
					'<i class="ace-icon fa fa-check-square-o bigger-110" title="保存">保存</i></a></th>';
			tr += '</tr>';
			$("#el").before(tr);
			tr = "";
		}

		//添加水费表单
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
			tr += '<td><label><input type="number" style="width: 110px;" onchange="calExpDif(\'_w'+uuid+'\')" class="input-text" id="tm_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="ra_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;"  class="input-text" id="va_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 100px;" onclick="calExpDif(\'_w'+uuid+'\')" class="input-text" id="nu_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 80px;"  class="input-text" id="pr_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;" onclick="calExpDif(\'_w'+uuid+'\')" class="input-text" id="to_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 50px;" onchange="calExpDif(\'_w'+uuid+'\')" class="input-text" id="il_w'+uuid+'"></td>';
			tr += '<td><label><input type="number" style="width: 110px;"  class="input-text" id="rto_w'+uuid+'"></td>';
			tr += '<td> <a class="btn btn-xs btn-success" title="保存" onclick="saveWa(\''+uuid+'\');">' +
					'<i class="ace-icon fa fa-check-square-o bigger-110" title="保存">保存</i></a></th>';
			tr += '</tr>';
			$("#wa").before(tr);
			tr = "";
		}

		//保存电费
		function saveEl(uuid) {
			var LASTMONTH = $("#lm_e"+uuid).val();
			var THISMONTH =  $("#tm_e"+uuid).val();
			var RATIO = $("#ra_e"+uuid).val();
			var FVALUE = $("#va_e"+uuid).val();
			var NUMBER = $("#nu_e"+uuid).val();
			var PRICE =$("#pr_e"+uuid).val();
			var REALITY_TOTAL = $("#rto_e"+uuid).val();
			var ISLOSS = $("#il_e"+uuid).val();
			var TOTAL = $("#to_e"+uuid).val();
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
					TOTAL:TOTAL,
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
					//window.location.reload();
				}
			});
		}

		//保存水费
		function saveWa(uuid) {
			var LASTMONTH = $("#lm_w"+uuid).val();
			var THISMONTH =  $("#tm_w"+uuid).val();
			var RATIO = $("#ra_w"+uuid).val();
			var FVALUE = $("#va_w"+uuid).val();
			var NUMBER = $("#nu_w"+uuid).val();
			var PRICE =$("#pr_w"+uuid).val();
			var REALITY_TOTAL = $("#rto_w"+uuid).val();
			var ISLOSS = $("#il_w"+uuid).val();
			var TOTAL = $("#to_w"+uuid).val();
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
					TOTAL:TOTAL,
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
					//window.location.reload();
				}
			});
		}

		//修改
		function editExpense(EXPENSE_ID) {
			var LASTMONTH = $("#lm"+EXPENSE_ID).val();
			var THISMONTH =  $("#tm"+EXPENSE_ID).val();
			var RATIO = $("#ra"+EXPENSE_ID).val();
			var FVALUE = $("#va"+EXPENSE_ID).val();
			var TOTAL = $("#to"+EXPENSE_ID).val();
			var NUMBER = $("#nu"+EXPENSE_ID).val();
			var PRICE =$("#pr"+EXPENSE_ID).val();
			var REALITY_TOTAL = $("#rto"+EXPENSE_ID).val();
			var ISLOSS = $("#il"+EXPENSE_ID).val();
			var METERNUM = $("#mn"+EXPENSE_ID).val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>expense/editExpense',
				data: {
					LASTMONTH: LASTMONTH,
					THISMONTH: THISMONTH,
					RATIO:RATIO,
					FVALUE:FVALUE,
					NUMBER:NUMBER,
					PRICE:PRICE,
					TOTAL:TOTAL,
					REALITY_TOTAL:REALITY_TOTAL,
					ISLOSS:ISLOSS,
					METERNUM:METERNUM,
					EXPENSE_ID:EXPENSE_ID
				},
				dataType: 'json',
				cache: false,
				success: function (data) {
					alert("修改成功");
					//window.location.reload();
				}
			});
		}

		function delExpense(EXPENSE_ID) {
			var con = confirm("是否删除该表数据?"); //在页面上弹出对话框
			if(con == true){
			}
			else {
				return;
			}
			$.ajax({
				type: "POST",
				url: '<%=basePath%>expense/delExpense',
				data: {
					EXPENSE_ID:EXPENSE_ID
				},
				dataType: 'json',
				cache: false,
				success: function (data) {
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