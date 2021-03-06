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
	<link rel="stylesheet" href="static/silviomore/bootstrap-select.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<link rel="stylesheet" href="static/css/fo.css" />
	<script src="static/js/dialog-plus.js"></script>
	<link rel="stylesheet" href="static/css/doc.css" />
	<script src="static/js/doc.js"></script>

	<script src="static/silviomore/bootstrap-select.js"></script>
</head>
<body id="sBody" class="no-skin" onclick="calProceeds()">
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
						<form action="contract_notr/paytoclient.do" name="Form" id="Form" method="post">
							<input type="hidden" name="FSTATE" id="FSTATE" value="${pd.FSTATE}"/>
							<input type="hidden" name="MODES" id="MODES" value="${pd.MODES}"/>
							<input  name="FCREATERID" id="FCREATERID" value="${pd.FCREATERID}"
									type="hidden"  />
							<div id="zhongxin" style="padding-top: 13px;">
								<div style="padding-top: 5px; background-color: #2e6589; height:35px;border-radius: 10px 10px 0px 0px;">
									<p style="margin-left:20px;font-size: 22px;color: white">付款信息</p>
								</div>
								<table id="table_report" class="table table-striped table-bordered table-hover">
									<tbody>
									<tr class="warning">
										<th class="center"><label style="color: red">*</label><label>客户名称:</label></th>
										<th class="center">
											<%--<select name="CONTRACTOFNAME" id="CONTRACTOFNAME" data-placeholder=""
													style="vertical-align:top;width: 150px;">
												<option value="${pd.CONTRACTOFNAME}" name="${pd.CONTRACTOFNAME}">${pd.CONTRACTOFNAME}</option>
												<c:forEach items="${listConToName}" var="var" varStatus="vs">
													<option value="${var.CONTRACTOFNAME}" name="${var.CONTRACTOFNAME}">${var.CONTRACTOFNAME}</option>
												</c:forEach>
											</select>--%>
												<select name="CONTRACTOFNAME" id="CONTRACTOFNAME" class="selectpicker bla bla bli"
														data-style="btn-info" data-live-search="true" title="请选择客户" >
													<option value="${pd.CONTRACTOFNAME}" name="${pd.CONTRACTOFNAME}">${pd.CONTRACTOFNAME}</option>
													<c:forEach items="${listnotPay}" var="var" varStatus="vs">
														<option value="${var.CONTRACTOFNAME}"
																<c:if test="${var.CONTRACTOFNAME == pd.CONTRACTOFNAME}">
																	selected
																</c:if>
																name="${var.CONTRACTOFNAME}">${var.CONTRACTOFNAME}</option>
													</c:forEach>
													</optgroup>
												</select>
										</th>
										<th style="width: 50%">
										</th>
										<%--<th class="center"><label>本次付款总额：</label></th>
										<th class="center" >
											<input type="text" style="width: 150px" readonly
												   class="input-text" name="PAYNUM"  &lt;%&ndash;name="PROCEEDSNUM"&ndash;%&gt;
												   id="PAYNUM">
										</th>
										<th class="center"><label style="color: red">*</label><label>金额合计：</label></th>
										<th class="center" >
											<input type="text" style="width: 150px" readonly
												   class="input-text"  name="ALLSUM"
												   id="ALLSUM"></th>
										<th class="center" >
											<a class="btn btn-primary" onclick="toProceeds()">
												<i class="ace-icon glyphicon glyphicon-ok align-top bigger-125">确定付款</i>
											</a>
										</th>--%>
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
	<div class="box01_c" style="height: 90%" id="skqk">
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
				<th class="center">应付金额</th>
				<th class="center">付款所属时间</th>
				<th class="center">实际付款时间</th>
				<th class="center">本次付款金额</th>
				<th class="center">尚未付款金额</th>
				<th class="center">付款方式</th>
				<th class="center">付款</th>
			</tr>
			<c:if test="${not empty  listnotPayByName}">
			<c:forEach items="${listnotPayByName}" var="var" varStatus="vs">
			<tr class="success center">
				<td><label>${vs.index+1}</label></td>
				<td><label name="TYPE" id="ty${var.PAYDETAIL_ID}">应付款</label></td>
				<td><label name="SHPAY" id="sp${var.PAYDETAIL_ID}">${var.SHPAY}</label></td>
				<td><label name="SETIME" id="se${var.PAYDETAIL_ID}">
					<c:if test="${var.SHPAYTIME == null && var.SHPAYTIMEENT == null}">
						- -:- -
					</c:if>
					<c:if test="${var.SHPAYTIME != null || var.SHPAYTIMEENT != null}">
						(${var.SHPAYTIME}至${var.SHPAYTIMEENT})
					</c:if>
				</label></td>
				<td><input name="REALITYPAYTIME" type="date" style="width: 150px;height: 31px"
						   class="input-text" id="rpt${var.PAYDETAIL_ID}"></td>
				<td><label><input name="REALITYPAY" type="number" style="width: 110px;"
				class="input-text" id="rp${var.PAYDETAIL_ID}"></label></td>
				<td><label name="ONPAYPIC" id="np${var.PAYDETAIL_ID}">${var.ONPAYPIC}</label></td>
				<td id="mo${var.PAYDETAIL_ID}">
					<select name="MODE"  style="width: 150px" data-style="btn-info"  class="selectpicker bla bla bli"
						title="请选择付款方式"  multiple data-live-search="true" >
						<option value="现金" name="现金">现金</option>
						<option value="支票" name="支票">支票</option>
						<option value="转账" name="转账">转账</option>
						<option value="信用卡" name="信用卡">信用卡</option>
					</select>
				</td>
				<td><a class="btn btn-primary" onclick="editPay('${var.PAYPRIMARY_ID}','${var.PAYDETAIL_ID}')">
				<i class="ace-icon glyphicon glyphicon-ok align-top bigger-125">确定付款</i></a>
				<td style="display: none"><label name="ITEMID" >${var.PAYDETAIL_ID}</label></td>
				<td style="display: none">
					<input type="date" style="width: 150px;height: 31px" value="${var.SHPAYTIME}"
												 class="input-text"  name="SHPAYTIME" id="spt${var.PAYDETAIL_ID}">
					<input type="date" style="width: 150px;height: 31px" value="${var.SHPAYTIMEENT}"
							class="input-text"  name="SHPAYTIMEENT" id="spte${var.PAYDETAIL_ID}"></td>
				<td style="display: none"><input type="text" style="width: 150px;height: 31px" value="${var.FNOTE}"
												 class="input-text"  name="FNOTE" id="no${var.PAYDETAIL_ID}"></td>
				<td style="display: none"><label name="CONTRACT_ID" >'+value.CONTRACT_ID+'</label></td>
			</c:forEach>
			</c:if>
			<tr id="trskqk">
			</tr>
		</table>
	</div>
</div>
<%--<div class="row">
	<div class="col-xs-12">
		<table class="table table-border table-bg table-bordered">
			<tbody>
			<tr class="warning">
				<td class='center' colspan="1000"><label>最近收款单据</label></td>
			</tr>
			<c:if test="${not empty listTop2}">
			<c:forEach items="${listTop2}" var="var" varStatus="vs">
			<tr class="warning" ondblclick="record_Show('${var.PROCEEDSRECEIPTS_ID}')">
				<td class='center'><label>收款编号：</label></td>
				<td class='center'>${var.PROCEEDSNO}</td>
				<td class='center'><label>收款总额：</label></td>
				<td class='center'>${var.PROCEEDSNUM}</td>
				<td  class='center'><label>收款日期</label></td>
				<td class='center' >${fn:substring(var.PROCEEDSDATE, 0, 10)}</td>
				<td class='center' >
					<a class="btn btn-xs btn-info" title="打印" onclick="print('${var.PROCEEDSRECEIPTS_ID}');">
						<i class="ace-icon glyphicon glyphicon-print bigger-120" title="打印">打印</i>
					</a>
				</td>
			</tr>
			</c:forEach>
			</c:if>
			</tbody>
		</table>
	</div>
</div>--%>

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

	function editPay(PAYPRIMARY_ID,PAYDETAIL_ID){
		var MODE = '';
		var PAYDETAIL_ID = PAYDETAIL_ID;
		var SHPAY = $("#sp"+PAYDETAIL_ID).text();
		var SHPAYTIME = $("#spt"+PAYDETAIL_ID).val();
		var SHPAYTIMEENT = $("#spte"+PAYDETAIL_ID).val();
		var FNOTE = $("#no"+PAYDETAIL_ID).val();
		var REALITYPAYTIME = $("#rpt"+PAYDETAIL_ID).val();
		var REALITYPAY = $("#rp"+PAYDETAIL_ID).val();
		if(SHPAY < REALITYPAY){
			alert("付款金额不能大于应付金额");
			return false;
		}
		$("#mo"+PAYDETAIL_ID).find("[name='MODE'] option:selected").each(function () {
			MODE += $(this).val() +",";
		});
		MODE = MODE.substr(0,MODE.length -1);
		if(MODE == "" || MODE == null){
			alert("请选择付款方式");
			return false;
		}
		//var FNOTE = $("#no"+PAYDETAIL_ID).val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>paydetail/editPayDetailInfo',
			async: false,
			data: {
				PAYPRIMARY_ID : PAYPRIMARY_ID,
				PAYDETAIL_ID : PAYDETAIL_ID,
				SHPAY : SHPAY,
				SHPAYTIME : SHPAYTIME,
				SHPAYTIMEENT : SHPAYTIMEENT,
				FNOTE : FNOTE,
				MODE : MODE,
				REALITYPAYTIME : REALITYPAYTIME,
				REALITYPAY : REALITYPAY
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				save();
			}
		});
	}

	function  record_Show(PROCEEDSRECEIPTS_ID) {
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="收款记录明细";
		diag.URL = '<%=basePath%>proceeds_record/record_show.do?PROCEEDSRECEIPTS_ID='+PROCEEDSRECEIPTS_ID;
		diag.Width = window.innerWidth * 0.8;
		diag.Height = window.innerHeight * 0.8;
		diag.Modal = true;				//有无遮罩窗口
		diag. ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function(){ //关闭事件
			diag.close();
		};
		diag.show();
	}

	function print(PROCEEDSRECEIPTS_ID) {
		window.open("<%=basePath%>proceedsreceipts/toPrint.do?PROCEEDSRECEIPTS_ID="+PROCEEDSRECEIPTS_ID, "", 'left=250,top=150,width=1250,height=750,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes');
	}

	function calProceeds(){
		//alert("kaishi");
		var PAYNUM = 0.00;
		var REALITYPAY ;
		$('#taskqk tr').each(function(i){                   // 遍历 tr
			if(i > 0 && i < ($('#taskqk tr').length - 1) ){
				$(this).children('td').each(function(j){  // 遍历 tr 的各个 td
					if(j == 0){
						if(!$(this).find("[name='ids']").is(':checked')){
							return false;
						}
					}else if(j == 6){
						REALITYPAY = $(this).find("[name='REALITYPAY']").val();
						//alert(REALITYPAY);
						if(REALITYPAY == "" || REALITYPAY == null){
							PAYNUM += 0.00;
						}else {
							PAYNUM += parseFloat(REALITYPAY);
						}
					}
				});
			}
		});
		//alert(PAYNUM);
		$("#PAYNUM").val(PAYNUM.toFixed(2));
	}

	function toProceeds(){
		//var tahtmx = $("#tahtmx");
		var modeCount = 0;
		var RECEIVABLE_N ;  //本次收款
		var ALLSUM = $("#ALLSUM").val(); //未收款总额
		var RECEIVABLE ; // 本次应收款
		var NOT_RECEIVABLE ; // 未收款
		var PAYTIME ; //应收时间
		var OVERDUE ; //滞纳金率
		var RECEIVABL_PAYTIME ; //本次收款时间
		var OVERDUENUM ;  //滞纳金
		var AMOUNT ;  //应收总数
		var TYPE ; //类型
		var ITEMID ;  // 项目id
		var CONTRACT_ID ;  // 合同id
		var SETIME;
		var strJson = '';
		var PAYER = $("#CONTRACTOFNAME").val();  //付款方
		var PROCEEDSNUM = 0.00;
		var OVERDUENUM_ALL = 0.00;
		var NOT_RECEIVABLE_ALL = 0.00;
		var isJson;
		//(parseFloat(OVERDUENUM)
		var CONTEXT = "<div align='center'>";
		strJson += '[';
		$('#taskqk tr').each(function(i){                   // 遍历 tr
			var MODE = "";
			if(i > 0 && i < ($('#taskqk tr').length - 1) ){
				MODE = "";
				isJson = '1';
				$(this).children('td').each(function(j){  // 遍历 tr 的各个 td
					if(j == 0){
						//alert($(this).find("[name='ids']").is(':checked'));
						if(!$(this).find("[name='ids']").is(':checked')){
							isJson = '0';
							return false;
						}
					}else if(j == 2){
						TYPE = $(this).find("[name='TYPE']").text();
						CONTEXT += "<p>收款项:"+ TYPE+";";
					}else if(j == 3){
						RECEIVABLE = $(this).find("[name='RECEIVABLE']").text();
						SETIME = $(this).find("[name='SETIME']").text();
						CONTEXT += RECEIVABLE+SETIME+";</p>";
					}else if(j == 4){
						PAYTIME = $(this).find("[name='PAYTIME']").text();
					}else if(j == 5){
						OVERDUE = $(this).find("[name='OVERDUE']").text();
					}else if(j == 6){
						RECEIVABL_PAYTIME = $(this).find("[name='RECEIVABL_PAYTIME']").val();
						if(RECEIVABL_PAYTIME == "" || RECEIVABL_PAYTIME == null){
							isJson = '0';
							alert("请选择实际收款时间！！");
						}
					}else if(j == 7){
						OVERDUENUM = $(this).find("[name='OVERDUENUM']").val();
						if(OVERDUENUM == null || OVERDUENUM == ""){
							OVERDUENUM = 0.00;
						}
						OVERDUENUM_ALL += parseFloat(OVERDUENUM);
						CONTEXT += "<p>滞纳金:"+OVERDUENUM+";";
					}else if(j == 8){
						AMOUNT = $(this).find("[name='AMOUNT']").text();
					}else if(j == 9){
						RECEIVABLE_N = $(this).find("[name='RECEIVABLE_N']").val();
						if(RECEIVABLE_N == "" || RECEIVABLE_N == null){
							isJson = '0';
							alert("请输入本次收款金额！！");
						}else {
							CONTEXT += "本次还款:"+RECEIVABLE_N+";";
							PROCEEDSNUM += parseFloat(RECEIVABLE_N);
						}
					}else if(j == 10){
						NOT_RECEIVABLE = $(this).find("[name='NOT_RECEIVABLE']").text();
						CONTEXT += "未收款:"+NOT_RECEIVABLE+";";
					}else if(j == 11){
						$(this).find("[name='MODE'] option:selected").each(function () {
							MODE += $(this).val() +",";
						});
						MODE = MODE.substr(0,MODE.length -1);
						if(MODE == "" || MODE == null){
							modeCount ++ ;
						}
						CONTEXT += "收款方式:"+MODE+"。</p>";
					}else if(j == 12){
						ITEMID = $(this).find("[name='ITEMID']").text();
					}else if(j == 13){
						CONTRACT_ID = $(this).find("[name='CONTRACT_ID']").text();
					}
				});
				if(isJson == '1'){
					strJson += '{"TYPE":"'+TYPE+'",';
					strJson += '"RECEIVABLE":"'+RECEIVABLE+'",';
					strJson += '"SETIME":"'+SETIME+'",';
					strJson += '"PAYTIME":"'+PAYTIME+'",';
					strJson += '"MODE":"'+MODE+'",';
					strJson += '"NOT_RECEIVABLE":"'+NOT_RECEIVABLE+'",';
					strJson += '"RECEIVABLE_N":"'+RECEIVABLE_N+'",';
					strJson += '"AMOUNT":"'+AMOUNT+'",';
					strJson += '"OVERDUENUM":"'+OVERDUENUM+'",';
					strJson += '"OVERDUE":"'+OVERDUE+'",';
					strJson += '"ITEMID":"'+ITEMID+'",';
					strJson += '"CONTRACT_ID":"'+CONTRACT_ID+'",';
					strJson += '"RECEIVABL_PAYTIME":"'+RECEIVABL_PAYTIME+'"},';
				}
			}
		});
			strJson = strJson.substring(0, strJson.length - 1);
			strJson += ']';
			CONTEXT += "<p>收款总额:" + PROCEEDSNUM.toFixed(2) + ";";
			CONTEXT += "产生滞纳金:" + OVERDUENUM_ALL.toFixed(2) + "。</p>";
			CONTEXT += "</div>";
		if(modeCount > 0){
			alert("存在"+modeCount+"项未选择收款方式，请选择后在确认收款...");
			return false;
		}
			var d = dialog({
				title: '消息',
				content: CONTEXT,
				button: [
					{
						value: '取消',
						cancel: function () {
							this.remove();
						}
					},
					{
						value: '确定',
						callback: function () {
							$.ajax({
								type: "POST",
								url: '<%=basePath%>proceeds_record/toProceeds',
								async: false,
								data: {
									strJson: strJson,
									PROCEEDSNUM: PROCEEDSNUM.toFixed(2),
									OVERDUENUM: OVERDUENUM_ALL.toFixed(2),
									PAYER: PAYER,
									ALLSUM: ALLSUM
								},
								dataType: 'json',
								//beforeSend: validateData,
								cache: false,
								success: function (data) {
									if(data.msg == "yes"){
										alert("收款成功");
										save();
									}else {
										alert("未产生收款数据");
									}
								}
							});
							this.remove();
						},
						autofocus: true
					}

				]

			});
			/*d.addEventListener('close', function () {
			 alert(value);
			 });*/
			d.show();
			console.log(strJson);
	}

	function toLoad(){
		var CONTRACTOFNAME = $("#CONTRACTOFNAME").find("option:selected").attr("name");
		window.location.href='<%=basePath%>contract_notr/getNotPay?CONTRACTOFNAME='+CONTRACTOFNAME;
	}

	/*function toAjax_load(){
		var CONTRACTOFNAME = $("#CONTRACTOFNAME").find("option:selected").attr("name");
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				CONTRACTOFNAME : CONTRACTOFNAME
			},
			url: '<%=basePath%>contract_notr/getNotPay',
			success: function (data) {
				var listnotPayByName = data.listnotPayByName;
				console.log(listnotPayByName);
				var tr = '';
				var count = 1;
				listnotPayByName.forEach(function(value,index,array){
					tr += '<tr class="success center">' ;
					tr += '<td><label>'+count+'</label></td>';
					tr += '<td><label name="TYPE" id="ty'+value.PAYDETAIL_ID+'">应付款</label></td>' ;
					tr += '<td><label name="SHPAY" id="r'+value.PAYDETAIL_ID+'">'+value.SHPAY+'</label></td>';
					tr += '<td><label name="SETIME" id="se'+value.PAYDETAIL_ID+'">（'+value.SHPAYTIME+'  至  '+value.SHPAYTIMEENT+'）</label></td>';
					tr += '<td><input name="REALITYPAYTIME" type="date" style="width: 150px;height: 31px"' +
							' class="input-text" id="rpt'+value.PAYDETAIL_ID+'"></td>';
					tr += '<td><label><input name="REALITYPAY" type="number" style="width: 110px;"' +
							' class="input-text" id="rp'+value.PAYDETAIL_ID+'"></label></td>';
					tr += '<td><label name="ONPAYPIC" id="np'+value.PAYDETAIL_ID+'">'+value.ONPAYPIC+'</label></td>';
					tr += '<td>';
					tr += '<select name="MODE" style="width: 150px" data-style="btn-info"  class="selectpicker bla bla bli" title="请选择付款方式"  multiple data-live-search="true" >'
					tr += '<option value="现金" name="现金">现金</option><option value="支票" name="支票">支票</option>'
					tr += '<option value="转账" name="转账">转账</option><option value="信用卡" name="信用卡">信用卡</option></select>'
					tr += '</td>';
					tr += '<td><a class="btn btn-primary" onclick="editPay(\''+PAYPRIMARY_ID\',\'PAYDETAIL_ID+'\')">' +
							'<i class="ace-icon glyphicon glyphicon-ok align-top bigger-125">确定付款</i></a>';

					tr += '<td style="display: none"><label name="ITEMID" >'+value.PAYDETAIL_ID+'</label></td>';
					tr += '<td style="display: none"><label name="CONTRACT_ID" >'+value.CONTRACT_ID+'</label></td>';
					tr += '</tr>';
					count ++ ;
				});
				$("#trskqk").before(tr);
				tr = '';
				var ALLSUM = 0.00;
				$("[name='SHPAY']").each(function(index,item){
					ALLSUM += parseFloat($(this).text());
				});
				$("#ALLSUM").val(ALLSUM.toFixed(2));
			},
			error: function () {
				alert("请求失败");
			}
		});
	}*/

	$("#CONTRACTOFNAME").change(function(){
		$("#PROCEEDSRECEIPTS_ID").val("");
		save();
		//toAjax_load();
	});

	//记录押金收款项
	function record_deposit(DEPOSITINFO_ID,CONTRACT_ID) {
		var Is = $("#is"+DEPOSITINFO_ID).val();
		/*if(Is == "yes"){
			alert("已保存，无需重复保存");
			return;
		}*/
		var MODE = "";
		$("#MODE option:selected").each(function () {
			MODE += $(this).val() +",";
		});
		MODE = MODE.substr(0,MODE.length -1);
		if(MODE.length < 1){
			alert("请选择收款方式！！");
			return;
		}
		$("#MODES").val(MODE);
		//alert(MODE);
		//var MODE = $("#MODE").val();  //付款方式
		var con = confirm("是否确定付款方式为:"+MODE+"?"); //在页面上弹出对话框
		if(con == true){
		}
		else {
			return;
		}
		var RECEIVABLE_N = $("#nr"+DEPOSITINFO_ID).val();  //本次收款
		if(RECEIVABLE_N == null || RECEIVABLE_N == ""){
			return;
		}
		var str = [];
		for(var i=0;i < document.getElementsByName('ids').length;i++){
			if(document.getElementsByName('ids')[i].checked){
				str.push(document.getElementsByName('ids')[i].value);
			}
		}
		if(str.length < 1){
			var PROCEEDSRECEIPTS_ID = $("#PROCEEDSRECEIPTS_ID").val();
		}else if(str.length > 1){
			alert("您的选择内容必须要单项!");
			return false;
		}else {
			var PROCEEDSRECEIPTS_ID = str[0];
		}
		var ALLSUM = $("#ALLSUM").val(); //未收款总额
		var RECEIVABLE = $("#r"+DEPOSITINFO_ID).text(); // 本次应收款
		var NOT_RECEIVABLE = $("#np"+DEPOSITINFO_ID).text(); // 未收款
		var PAYTIME = $("#pt"+DEPOSITINFO_ID).text(); //应收时间
		var OVERDUE = $("#od"+DEPOSITINFO_ID).text(); //滞纳金率
		var RECEIVABL_PAYTIME = $("#rpt"+DEPOSITINFO_ID).val(); //本次收款时间
		var OVERDUENUM = "0.00";  //滞纳金
		var AMOUNT = $("#rr"+DEPOSITINFO_ID).text();  //应收总数
		var TYPE = $("#ty"+DEPOSITINFO_ID).text(); //类型
		var PAYER = $("#CONTRACTOFNAME").val();  //付款方
		var ITEMID = DEPOSITINFO_ID;  // 项目id
		var CONTRACT_ID = CONTRACT_ID;  // 合同id
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceeds_record/record_deposit',
			async: false,
			data: {
				ALLSUM : ALLSUM,
				PROCEEDSRECEIPTS_ID : PROCEEDSRECEIPTS_ID,
				CONTRACT_ID : CONTRACT_ID,
				TYPE : TYPE,
				MODE : MODE,
				RECEIVABLE_N : RECEIVABLE_N,
				AMOUNT : AMOUNT,
				OVERDUENUM : OVERDUENUM,
				RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
				OVERDUE : OVERDUE,
				PAYTIME : PAYTIME,
				NOT_RECEIVABLE : NOT_RECEIVABLE,
				RECEIVABLE : RECEIVABLE,
				ITEMID : ITEMID,
				PAYER : PAYER
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				alert("收款成功");
				//$("#is"+DEPOSITINFO_ID).val("yes");
				$("#PROCEEDSRECEIPTS_ID").val(data.PROCEEDSRECEIPTS_ID);
				save();
			}
		});
	}

	//记录发票收款项
	function record_Invoice(INVOICE_ID,CONTRACT_ID) {
		var Is = $("#is"+INVOICE_ID).val();
		/*if(Is == "yes"){
			alert("已保存，无需重复保存");
			return;
		}*/
		var MODE = "";
		$("#MODE option:selected").each(function () {
			MODE += $(this).val() +",";
		});  //付款方式
		if(MODE.length < 1){
			alert("请选择收款方式！！");
			return;
		}
		MODE = MODE.substr(0,MODE.length -1);
		$("#MODES").val(MODE);
		var con = confirm("是否确定付款方式为:"+MODE+"?"); //在页面上弹出对话框
		if(con == true){
		}
		else {
			return;
		}
		var RECEIVABLE_N = $("#nr"+INVOICE_ID).val();  //本次收款
		if(RECEIVABLE_N == null || RECEIVABLE_N == ""){
			return;
		}
		var ALLSUM = $("#ALLSUM").val(); //未收款总额
		var str = [];
		for(var i=0;i < document.getElementsByName('ids').length;i++){
			if(document.getElementsByName('ids')[i].checked){
				str.push(document.getElementsByName('ids')[i].value);
			}
		}
		if(str.length < 1){
			var PROCEEDSRECEIPTS_ID = $("#PROCEEDSRECEIPTS_ID").val();
		}else if(str.length > 1){
			alert("您的选择内容必须要单项!");
			return false;
		}else {
			var PROCEEDSRECEIPTS_ID = str[0];
		}
		var RECEIVABLE = $("#r"+INVOICE_ID).text(); // 本次应收款
		var NOT_RECEIVABLE = $("#np"+INVOICE_ID).text(); // 未收款
		var PAYTIME = $("#pt"+INVOICE_ID).text(); //应收时间
		var OVERDUE = $("#od"+INVOICE_ID).text(); //滞纳金率
		var RECEIVABL_PAYTIME = $("#rpt"+INVOICE_ID).val(); //本次收款时间
		var OVERDUENUM = $("#odn"+INVOICE_ID).val();  //滞纳金
		var AMOUNT = $("#rr"+INVOICE_ID).text();  //应收总数
		var TYPE = $("#ty"+INVOICE_ID).text(); //类型
		var PAYER = $("#CONTRACTOFNAME").val();  //付款方
		var ITEMID = INVOICE_ID;  // 项目id
		var CONTRACT_ID = CONTRACT_ID;  // 合同id
		var SETIME = $("#se"+INVOICE_ID).text();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceeds_record/record_Invoice',
			async: false,
			data: {
				ALLSUM : ALLSUM,
				PROCEEDSRECEIPTS_ID : PROCEEDSRECEIPTS_ID,
				CONTRACT_ID : CONTRACT_ID,
				TYPE : TYPE,
				MODE : MODE,
				SETIME : SETIME,
				RECEIVABLE_N : RECEIVABLE_N,
				AMOUNT : AMOUNT,
				OVERDUENUM : OVERDUENUM,
				RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
				OVERDUE : OVERDUE,
				PAYTIME : PAYTIME,
				NOT_RECEIVABLE : NOT_RECEIVABLE,
				RECEIVABLE : RECEIVABLE,
				ITEMID : ITEMID,
				PAYER : PAYER
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				alert("收款成功");
				/*$("#is"+INVOICE_ID).val("yes");*/
				$("#PROCEEDSRECEIPTS_ID").val(data.PROCEEDSRECEIPTS_ID);
				save();
			}
		});
	}

	//记录水电收款项
	function record_Utili(UTILITIESSTATE_ID,CONTRACT_ID) {
		var Is = $("#is"+UTILITIESSTATE_ID).val();
		/*if(Is == "yes"){
			alert("已保存，无需重复保存");
			return;
		}*/
		var MODE = "";
		$("#MODE option:selected").each(function () {
			MODE += $(this).val() +",";
		});  //付款方式
		if(MODE.length < 1){
			alert("请选择收款方式！！");
			return;
		}
		MODE = MODE.substr(0,MODE.length -1);
		$("#MODES").val(MODE);
		var con = confirm("是否确定付款方式为:"+MODE+"?"); //在页面上弹出对话框
		if(con == true){
		}
		else {
			return;
		}
		var RECEIVABLE_N = $("#nr"+UTILITIESSTATE_ID).val();  //本次收款
		if(RECEIVABLE_N == null || RECEIVABLE_N == ""){
			return;
		}
		var ALLSUM = $("#ALLSUM").val(); //未收款总额
		var str = [];
		for(var i=0;i < document.getElementsByName('ids').length;i++){
			if(document.getElementsByName('ids')[i].checked){
				str.push(document.getElementsByName('ids')[i].value);
			}
		}
		if(str.length < 1){
			var PROCEEDSRECEIPTS_ID = $("#PROCEEDSRECEIPTS_ID").val();
		}else if(str.length > 1){
			alert("您的选择内容必须要单项!");
			return false;
		}else {
			var PROCEEDSRECEIPTS_ID = str[0];
		}
		var RECEIVABLE = $("#r"+UTILITIESSTATE_ID).text(); // 本次应收款
		var NOT_RECEIVABLE = $("#np"+UTILITIESSTATE_ID).text(); // 未收款
		var PAYTIME = $("#pt"+UTILITIESSTATE_ID).text(); //应收时间
		var OVERDUE = $("#od"+UTILITIESSTATE_ID).text(); //滞纳金率
		var RECEIVABL_PAYTIME = $("#rpt"+UTILITIESSTATE_ID).val(); //本次收款时间
		var OVERDUENUM = $("#odn"+UTILITIESSTATE_ID).val();  //滞纳金
		var AMOUNT = $("#rr"+UTILITIESSTATE_ID).text();  //应收总数
		var TYPE = $("#ty"+UTILITIESSTATE_ID).text(); //类型
		var PAYER = $("#CONTRACTOFNAME").val();  //付款方
		var ITEMID = UTILITIESSTATE_ID;  // 项目id
		var CONTRACT_ID = CONTRACT_ID;  // 合同id
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceeds_record/record_Utili',
			async: false,
			data: {
				ALLSUM : ALLSUM,
				PROCEEDSRECEIPTS_ID : PROCEEDSRECEIPTS_ID,
				CONTRACT_ID : CONTRACT_ID,
				TYPE : TYPE,
				MODE : MODE,
				RECEIVABLE_N : RECEIVABLE_N,
				AMOUNT : AMOUNT,
				OVERDUENUM : OVERDUENUM,
				RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
				OVERDUE : OVERDUE,
				PAYTIME : PAYTIME,
				NOT_RECEIVABLE : NOT_RECEIVABLE,
				RECEIVABLE : RECEIVABLE,
				ITEMID : ITEMID,
				PAYER : PAYER
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				alert("收款成功");
				$("#PROCEEDSRECEIPTS_ID").val(data.PROCEEDSRECEIPTS_ID);
				save();
			}
		});
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
		/*$("#zhongxin").hide();
		$("#zhongxin2").show();*/
	}

	$(function() {
		$("#sBody").css("height",$(document).height());
		week_init();
		//toAjax_load();
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

	$(window).on('load', function () {
		$('.selectpicker').selectpicker({
			'selectedText': 'cat'
		});
		// $('.selectpicker').selectpicker('hide');
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