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
	<link rel="stylesheet" href="static/css/fo.css" />
</head>
<body id="sBody" class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="hr hr-18 dotted hr-double"></div>
				<div class="" style="text-align: left;margin-left: 10px">
					<!-- <td style="text-align: center;" colspan="10"> -->
					<%--<a  class="btn btn-success btn-xs" onclick="save()">
						<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>保存
					</a>
					<a class="btn btn-primary  btn-xs" onclick="top.Dialog.close();">
						<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
					</a>--%>
				</div>
				<div class="row">
					<div class="col-xs-12">
						<form action="opportunity/${msg }.do" name="Form" id="Form" method="post">
							<input type="hidden" name="FSTATE" id="FSTATE" value="${pd.FSTATE}"/>
							<input  name="FCREATERID" id="FCREATERID" value="${pd.FCREATERID}"
									type="hidden"  />
							<div id="zhongxin" style="padding-top: 13px;">
								<div style="background-color: #2e6589; height:35px;border-radius: 10px 10px 0px 0px;">
									<p style="margin-left:20px;font-size: 22px;color: white">基本信息</p>
								</div>
								<table id="table_report" class="table table-striped table-bordered table-hover">
									<tbody>
									<tr class="warning">
										<th ><label style="color: red">*</label><label>客户名称:</label></th>
										<th>
											<select name="CONTRACTOFNAME" id="CONTRACTOFNAME" data-placeholder=""
													style="vertical-align:top;width: 150px;">
												<option value="${pd.CONTRACTOFNAME}" name="${pd.CONTRACTOFNAME}">${pd.CONTRACTOFNAME}</option>
												<c:forEach items="${listConToName}" var="var" varStatus="vs">
													<option value="${var.CONTRACTOFNAME}" name="${var.CONTRACTOFNAME}">${var.CONTRACTOFNAME}</option>
												</c:forEach>
											</select>
										</th>
										<th><label style="color: red">*</label><label>收款方式：</label></th>
										<th >
											<select name="MODE" id="MODE" data-placeholder=""
													style="vertical-align:top;width: 150px;" >
												<option value="信用卡" name="信用卡">信用卡</option>
												<option value="现金" name="现金">现金</option>
												<option value="支票" name="支票">支票</option>
												<option value="转账" name="转账">转账</option>
											</select>
										</th>
										<th ><label style="color: red">*</label><label>金额合计：</label></th>
										<th  >
											<input type="text" style="width: 150px" value="${pd.FOPPNAME}"
												   class="input-text"  name="FOPPNAME"
												   id="FOPPNAME"></th>
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
<div style="margin-bottom: 0px;height: 65%"  class="weeks">
	<ul style="margin-left: 0px;margin-bottom: 0px" class="weekItem" id="weektab">
		<li>收款情况</li>
	</ul>
	<div class="box01_c" id="skqk">
		<%--<a style="margin-left: 10px" class="btn btn-success btn-xs" onclick="addItemDetail('${pd.OPPORTUNITY_ID}')">
			<i class="ace-icon fa glyphicon-plus bigger-110 nav-search-icon yellow"></i>新增
		</a>
		<a class="btn btn-primary  btn-xs" onclick="delItemDetail()">
			<i class="ace-icon fa fa-trash-o bigger-120 nav-search-icon "></i>删除
		</a>--%>
		<table id="taskqk" class="table table-striped table-bordered table-hover"
			   style="margin-top:5px;">
			<tr>
				<th class="center">序号</th>
				<th class="center">费用类型</th>
				<th class="center">应收金额</th>
				<th class="center">应收款时间</th>
				<th class="center">滞纳金率</th>
				<th class="center">实际收款时间</th>
				<th class="center">滞纳金</th>
				<th class="center">总应收金额</th>
				<th class="center">本次收款金额</th>
				<th class="center">尚未收款金额</th>
				<th class="center">收款</th>
			</tr>
			<tr id="trskqk">
			</tr>
		</table>
	</div>
</div>

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

	$("#CONTRACTOFNAME").change(function(){
		var CONTRACTOFNAME = $("#CONTRACTOFNAME").find("option:selected").attr("name");
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				CONTRACTOFNAME : CONTRACTOFNAME
			},
			url: '<%=basePath%>contract_notr/getNotContract',
			success: function (data) {
				var listNotInvoice = data.listNotInvoice;
				var listNotUtili = data.listNotUtili;
				var listNotDeposit = data.listNotDeposit;
				var tr = '';
				var count = 1;
				listNotInvoice.forEach(function(value,index,array){
					tr += '<tr class="success center">' ;
					tr += '<td><label>'+count+'</label></td>';
					tr += '<td><label id="ty'+value.INVOICE_ID+'">应收款</label></td>';
					tr += '<td><label id="r'+value.INVOICE_ID+'">'+value.NOT_RECEIVABLE+'</label></td>';
					tr += '<td><label id="pt'+value.INVOICE_ID+'">'+value.PAYTIME+'</label></td>';
					tr += '<td><label id="od'+value.INVOICE_ID+'">'+value.OVERDUE_N+'</label></td>';
					tr += '<td><input type="date" style="width: 150px;height: 31px" onchange=" calculate(\''+value.INVOICE_ID+'\')"' +
							' class="input-text" id="rpt'+value.INVOICE_ID+'"></td>';
					tr += '<td><label><input type="number" style="width: 110px;" onchange="changeOD_cal(\''+value.INVOICE_ID+'\')"' +
							' class="input-text" id="odn'+value.INVOICE_ID+'"></label></td>';
					tr += '<td><label id="rr'+value.INVOICE_ID+'"></label></td>';
					tr += '<td><label><input type="number" style="width: 110px;" onchange="calNP(\''+value.INVOICE_ID+'\')"' +
							' class="input-text" id="nr'+value.INVOICE_ID+'"></label></td>';
					tr += '<td><label id="np'+value.INVOICE_ID+'"></label></td>';
					tr += '<td><label >' +
							'<a style="margin-left: 10px" class="btn btn-success btn-xs" ' +
							'onclick="record_Invoice(\''+value.INVOICE_ID+'\',\''+value.CONTRACT_ID+'\')">' +
							'<i class="ace-icon fa fa-check-square-o bigger-110 nav-search-icon yellow"></i>' +
							'</a></label></td>';
					tr += '</tr>';
					count ++ ;

				});
				listNotUtili.forEach(function(value,index,array){
					tr += '<tr class="info center">' ;
					tr += '<td><label>'+count+'</label></td>';
					tr += '<td><label id="ty'+value.UTILITIESSTATE_ID+'">应收水电费</label></td>';
					tr += '<td><label id="r'+value.UTILITIESSTATE_ID+'">'+value.NOT_RECEIVABLE+'</label></td>';
					tr += '<td><label id="pt'+value.UTILITIESSTATE_ID+'">'+value.PAYTIME+'</label></td>';
					tr += '<td><label id="od'+value.UTILITIESSTATE_ID+'">'+value.OVERDUE+'</label></td>';
					tr += '<td>' +
							'<input type="date" style="width: 150px;height: 31px" onchange=" calculate(\''+value.UTILITIESSTATE_ID+'\')"' +
							' class="input-text" id="rpt'+value.UTILITIESSTATE_ID+'"></td>';
					tr += '<td><label><input type="number" style="width: 110px;" onchange="changeOD_cal(\''+value.UTILITIESSTATE_ID+'\')"' +
							' class="input-text" id="odn'+value.UTILITIESSTATE_ID+'"></label></td>';
					tr += '<td><label id="rr'+value.UTILITIESSTATE_ID+'"></label></td>';
					tr += '<td><label><input type="number" style="width: 110px;" onchange="calNP(\''+value.UTILITIESSTATE_ID+'\')"' +
							' class="input-text" id="nr'+value.UTILITIESSTATE_ID+'"></label></td>';
					tr += '<td><label id="np'+value.UTILITIESSTATE_ID+'"></label></td>';
					tr += '<td><label >' +
							'<a style="margin-left: 10px" class="btn btn-success btn-xs" ' +
							'onclick="record_Utili(\''+value.UTILITIESSTATE_ID+'\',\''+value.CONTRACT_ID+'\')">' +
							'<i class="ace-icon fa fa-check-square-o bigger-110 nav-search-icon yellow"></i>' +
							'</a></label></td>';
					tr += '</tr>';
					count ++ ;
				});
				listNotDeposit.forEach(function(value,index,array){
					tr += '<tr class="warning center">' ;
					tr += '<td><label>'+count+'</label></td>';
					tr += '<td><label id="ty'+value.DEPOSITINFO_ID+'">应押金</label></td>';
					tr += '<td><label id="r'+value.DEPOSITINFO_ID+'">'+value.NOT_RECEIVABLE+'</label></td>';
					tr += '<td><label id="pt'+value.DEPOSITINFO_ID+'">'+value.DWDEPOSITTIME+'</label></td>';
					tr += '<td><label id="od'+value.DEPOSITINFO_ID+'">0</label></td>';
					tr += '<td><label><input type="date" style="width: 150px;height: 31px" onchange=" calculate(\''+value.DEPOSITINFO_ID+'\')"' +
							' class="input-text" id="rpt'+value.DEPOSITINFO_ID+'"></label></td>';
					tr += '<td><label>0.00</label></td>';
					tr += '<td><label id="rr'+value.DEPOSITINFO_ID+'"></label></td>';
					tr += '<td><label><input type="number" style="width: 110px;"  onchange="calNP(\''+value.DEPOSITINFO_ID+'\')" class="input-text"' +
							' id="nr'+value.DEPOSITINFO_ID+'"></label></td>';
					tr += '<td><label id="np'+value.DEPOSITINFO_ID+'"></label></td>';
					tr += '<td><label >' +
							'<a style="margin-left: 10px" class="btn btn-success btn-xs" ' +
							'onclick="record_deposit(\''+value.DEPOSITINFO_ID+'\',\''+value.CONTRACT_ID+'\')">' +
							'<i class="ace-icon fa fa-check-square-o bigger-110 nav-search-icon yellow"></i>' +
							'</a></label></td>';
					tr += '</tr>';
					count ++ ;
					//console.log(value);
				});

				$("#trskqk").before(tr);
				tr = '';
			},
			error: function () {
				alert("请求失败");
			}
		});
	});

	//记录押金收款项
	function record_deposit(DEPOSITINFO_ID,CONTRACT_ID) {
		var RECEIVABLE = $("#r"+DEPOSITINFO_ID).text(); // 未收款
		var NOT_RECEIVABLE = $("#np"+DEPOSITINFO_ID).text(); // 未收款
		var DWDEPOSITTIME = $("#pt"+DEPOSITINFO_ID).text(); //应收时间
		var OVERDUE = $("#od"+Id).text(); //滞纳金率
		var RECEIVABL_PAYTIME = $("#rpt"+DEPOSITINFO_ID).text(); //本次收款时间
		var OVERDUENUM = "0.00";  //滞纳金
		var AMOUNT = $("#rr"+Id).text();  //应收总数
		var RECEIVABLE_N = $("#nr"+Id).text();  //本次收款
		var MODE = $("#MODE").val();  //付款方式
		var TYPE = $("ty"+DEPOSITINFO_ID).text(); //类型
		var PAYER = $("#CONTRACTOFNAME").val();  //付款方
		var ITEMID = DEPOSITINFO_ID;  // 项目id
		var CONTRACT_ID = CONTRACT_ID;  // 合同id
	}

	//记录发票收款项
	function record_Invoice(INVOICE_ID,CONTRACT_ID) {

	}

	//记录水电收款项
	function record_Utili(UTILITIESSTATE_ID,CONTRACT_ID) {

	}

	//当填写本次实际收款金额填写
	function calNP(Id) {
		var rr = $("#rr"+Id).text();
		var nr = $("#nr"+Id).val();
		var differ = parseFloat(rr) - parseFloat(nr);
		if(differ < 0){
			differ = 0.00;
		}
		$("#np"+Id).text(differ.toFixed(2));
	}

	//当滞纳金改变后进行计算
	function changeOD_cal(Id) {
		var RECEIVABLE = $("#r"+Id).text();
		var OVERDUENUM = $("#odn"+Id).val();
		$("#rr"+Id).text((parseFloat(OVERDUENUM) + parseFloat(RECEIVABLE)).toFixed(2));
	}

	//当选择实际收款时间进行计算
	function calculate(Id){
		var RECEIVABLE = $("#r"+Id).text();
		var OVERDUE = $("#od"+Id).text();
		var PAYTIME = $("#pt"+Id).text();
		var RECEIVABL_PAYTIME = $("#rpt"+Id).val();
		var differ = (Date.parse(new Date(RECEIVABL_PAYTIME))-Date.parse(new Date(PAYTIME)))/(1000*60*60*24);
		if(differ > 0){
			var OVERDUENUM = (parseFloat(RECEIVABLE)) * OVERDUE * differ * 0.01;
		}else {
			var OVERDUENUM = 0;
		}
		$("#odn"+Id).val(OVERDUENUM.toFixed(2));
		$("#rr"+Id).text((parseFloat(OVERDUENUM) + parseFloat(RECEIVABLE)).toFixed(2));
	}

	//保存
	function save(){
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

	$(function() {
		$("#sBody").css("height",$(document).height());
		week_init();
		if($("#FCREATETIME").val() == null || $("#FCREATETIME").val() == ""){
			var myDate = new Date();
			var year = myDate.getFullYear();
			var month = myDate.getMonth()+1;
			var day = myDate.getDate();
			$("#FCREATETIME").val(year+"-"+month+"-"+day);
		}

		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	});

	function week_init() {
		$("#weektab li").each(function (i) {
			$(this).click(function () {
				week_click(i);
			}).hover(function () {
				$(this).addClass('hover');
			}, function (event) {
				$(this).removeClass('hover');
			});
		});
		week_click('0');
		//$("#weekcon dl:last").css({"padding-bottom":"0","margin-bottom":"10px"});
	}
	function week_click(num) {
		if (num == "0") {
			$("#spmx").css("display", "");
			$("#xmtd").css("display", "none");
		} else if (num == "1") {
			$("#spmx").css("display", "none");
			$("#xmtd").css("display", "");
		}
		$("#weektab li").removeClass('on').eq(num).addClass('on');
	}
</script>
</body>
</html>