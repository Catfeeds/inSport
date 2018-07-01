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
								<td colspan="11" style="padding-left:2px;font-size: 26px" >
									<strong>${pd.CONTRACTOFNAME}   电费</strong>
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
							</tr>
							<c:if test="${not empty listEl }">
							<c:forEach items="${listEl}" var="var" varStatus="vs">
							<tr class="center">
								<td style="padding-left:2px;">
										${var.METERNUM}
								</td>
								<td style="padding-left:2px;">
										${var.LASTMONTH}
								</td>
								<td style="padding-left:2px;">
										${var.THISMONTH}
								</td>
								<td style="padding-left:2px;">
										${var.RATIO}
								</td>
								<td style="padding-left:2px;">
										${var.FVALUE}
								</td>
								<td style="padding-left:2px;">
										${var.NUMBER}
								</td>
								<td style="padding-left:2px;">
										${var.PRICE}
								</td>
								<td style="padding-left:2px;">
										${var.TOTAL}
								</td>
								<td style="padding-left:2px;">
										${var.ISLOSS}
								</td>
								<td style="padding-left:2px;">
										${var.REALITY_TOTAL}
								</td>
							</tr>
							</c:forEach>
							</c:if>
							<tr class="center" id="el">
								<td  style="padding-left:2px;">合计</td>
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
							</tr>
							<c:if test="${not empty listWa }">
							<c:forEach items="${listWa}" var="var" varStatus="vs">
								<tr class="center">
									<td style="padding-left:2px;">
											${var.METERNUM}
									</td>
									<td style="padding-left:2px;">
											${var.LASTMONTH}
									</td>
									<td style="padding-left:2px;">
											${var.THISMONTH}
									</td>
									<td style="padding-left:2px;">
											${var.RATIO}
									</td>
									<td style="padding-left:2px;">
											${var.FVALUE}
									</td>
									<td style="padding-left:2px;">
											${var.NUMBER}
									</td>
									<td style="padding-left:2px;">
											${var.PRICE}
									</td>
									<td style="padding-left:2px;">
											${var.TOTAL}
									</td>
									<td style="padding-left:2px;">
											${var.ISLOSS}
									</td>
									<td style="padding-left:2px;">
											${var.REALITY_TOTAL}
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<tr class="center" id="wa">
								<td style="padding-left:2px;">合计</td>
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
								<th class="center">${pd.PAYERNAME}</th>

								<th class="center"><label>应收款时间(水电费)：</label></th>
								<th class="center">${utiPd.PAYTIME}</th>
								<th class="center"><label>应收金额(水电费)：</label></th>
								<th class="center">${utiPd.RECEIVABLE}</th>
								<th width="20%">滞纳金率：${pd.OVERDUE}</th>
							</tr>
							<tr class="success">
								<th  class="center"><label>滞纳金:</label></th>
								<th  class="center">${utiPd.OVERDUENUM}</th>
								<th class="center"><label>实际收款时间(水电费)：</label></th>
								<th class="center">${utiPd.RECEIVABL_PAYTIME}</th>
								<th class="center"><label>实际收款金额(水电费)：</label></th>
								<th class="center">${utiPd.RECEIVABLE_REALITY}</th>
								<th class="center">
									<c:if test="${not empty utiPd}">
										<a class="btn btn-xs " title="打印通知单" onclick="print('${utiPd.UTILITIESSTATE_ID}','${pd.INVOICE_ID}');">
											<i class="ace-icon glyphicon glyphicon-print bigger-120" title="打印通知单">打印通知单</i>
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


		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>