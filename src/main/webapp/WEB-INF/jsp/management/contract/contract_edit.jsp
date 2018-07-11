<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">

	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
</head>
<body class="no-skin">

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="hr hr-18 dotted hr-double"></div>
				<div class="" style="text-align: left;margin-left: 10px">
					<!-- <td style="text-align: center;" colspan="10"> -->
					<a  class="btn btn-success btn-xs" onclick="save()">
						<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>保存
					</a>
					<a class="btn btn-primary  btn-xs" onclick="qx();">
						<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
					</a>
					<label style="margin-left: 30px">部门：</label>
					<select name="DEPTNO" id="DEPTNO" data-placeholder=""
							style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
						<option value="${pd.DEPTNAME}" name="${pd.DEPTNAME}">${pd.DEPTNAME}</option>
						<c:forEach items="${listDeptNo}" var="var" varStatus="vs">
							<option id="${var.DEPTNAME}" value="${var.DEPTNAME}" name="${var.FRULE}">${var.DEPTNAME}</option>
						</c:forEach>
					</select>
					<label style="margin-left: 30px">关联合同：</label>
					<c:choose>
						<c:when test="${not empty listRelevance}">
							<label class="nav-search">已关联合同
								<c:forEach items="${listRelevance}" var="var" varStatus="vs">
									<a onclick="show_contract('${var.CONTRACT_ID}')">《${var.CONTRACTNUM}》</a>
								</c:forEach>
							</label>
							<a style="margin-left: 10px" class="btn btn-xs" onclick="toRelevance('${pd.CONTRACT_ID}')">
								<i class="ace-icon fa fa-exchange bigger-110 nav-search-icon yellow"></i>修改关联
							</a>
						</c:when>
						<c:otherwise>
							<label class="nav-search">
								<span class="input-icon">
								<input type="text" placeholder="这里输入关键词" class="nav-search-input"
									   id="nav-search-input" autocomplete="off" name="RELEVANCE_ID" onclick="toRelevance('${pd.CONTRACT_ID}')"
									   value="" placeholder="搜索合同进行关联"/>
								<i class="ace-icon fa fa-search nav-search-icon"></i>
								</span>
							</label>
						</c:otherwise>
					</c:choose>
					<!-- </td> -->
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
						<!-- ------------------------------------------------------------------------------- -->
						<form action="contract/${msg }.do" name="Form" id="Form" method="post">
							<input type="hidden" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}"/>
							<input type="hidden" name="ISSTAMPDUTY" id="ISSTAMPDUTY" value="${pd.ISSTAMPDUTY}"/>
							<input type="hidden" name="ISPAY" id="ISPAY" value="${pd2.ISPAY}"/>
							<input type="hidden" name="DEPTNAME" id="DEPTNAME" value="${pd.DEPTNAME}"/>
							<input type="hidden" name="ISEW" id="ISEW" value="${pd2.ISEW}"/>
							<input type="hidden" name="ISENTERPROCEDURE" id="ISENTERPROCEDURE" value="${pd2.ISENTERPROCEDURE}"/>
							<input type="hidden" name="OFFICECONTRACT_ID" id="OFFICECONTRACT_ID" value="${pd3.OFFICECONTRACT_ID}"/>
							<input type="hidden" name="PROCEEDSCONTRACT_ID" id="PROCEEDSCONTRACT_ID" value="${pd2.PROCEEDSCONTRACT_ID}"/>
							<input type="hidden" name="PAYMENTCONTRACT_ID" id="PAYMENTCONTRACT_ID" value="${pd1.PAYMENTCONTRACT_ID}"/>
							<input type="hidden" name="ISDRAWALPROCEDURE" id="ISDRAWALPROCEDURE" value="${pd2.ISDRAWALPROCEDURE}"/>
							<table class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="warning">
									<th width="15%"><label>合同编号：</label></th>
									<th width="10%"><input type="text" style="width: 180px" value="${pd.CONTRACTNUM}"
														   class="input-text"  name="CONTRACTNUM"
														   id="CONTRACTNUM"></th>
									<th width="15%"><label>合同名称：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd.CONTRACTNAME}"
														   class="input-text"  name="CONTRACTNAME"
														   id="CONTRACTNAME"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="active">
									<th ><label>签约方：</label></th>
									<th >
										<input type="text" style="width: 150px" value="${pd.CONTRACTOFNAME}"
												class="input-text"  name="CONTRACTOFNAME"
												id="CONTRACTOFNAME">
										<%--<select name="CLIENT" id="CLIENT" data-placeholder=""
												style="vertical-align:top;width: 150px;">
											<option value="${pd.CLIENT}" name="${pd.CLIENT}">${pd.FNAME}</option>
											<c:forEach items="${listClients}" var="var" varStatus="vs">
												<option value="${var.CLIENT_ID}" name="${var.CLIENT_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>--%>
									</th>
									<th  ><label>项目名称：</label></th>
									<th  >
										<input type="text" style="width: 150px" value="${pd.PROJECT}"
											   class="input-text"  name="PROJECT"
											   id="PROJECT"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="success">
									<th ><label>客户联系人姓名：</label></th>
									<th >
										<input type="text" style="width: 150px" value="${pd.CLIENT}"
											   class="input-text"  name="CLIENT"
											   id="CLIENT">
									</th>
									<th  ><label>联系电话：</label></th>
									<th  >
										<input type="text" style="width: 150px" value="${pd.TELEPHONE}"
											   class="input-text"  name="TELEPHONE"
											   id="TELEPHONE"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th width="15%"><label>合同金额：</label></th>
									<th width="20%">
										<input type="number" style="width: 150px" value="${pd.CONTRACTPIC}"
											   class="input-text"  name="CONTRACTPIC" onchange="changeStampduty()"
											   id="CONTRACTPIC">
									</th>
									<th  ><label>合同签订使用时间：</label></th>
									<th  colspan="3">
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd.FUSEDATESTART}"
												   class="input-date"  name="FUSEDATESTART"
												   id="FUSEDATESTART">
											--- <input type="date" style="width: 140px;height: 31px" value="${pd.FUSEDATEENT}"
													   class="input-date"  name="FUSEDATEENT"
													   id="FUSEDATEENT">
										</label>
									</th>
								</tr>
								<tr class="active">
									<th  ><label>是否有押金：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="isSTAMPDUTY('1');" <c:if test="${pd.ISSTAMPDUTY == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio" id="form-field-radio2" onclick="isSTAMPDUTY('0');" <c:if test="${pd.ISSTAMPDUTY == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th width="15%"><label>押金：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd.DEPOSIT}"
														   class="input-text"  name="DEPOSIT"
														   id="DEPOSIT"></th>
									<th ><label>签约时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd.FDATE}"
												 class="input-text"  name="FDATE"
												 id="FDATE"></th>
								</tr>
								<tr>
									<th width="15%"><label>税目：</label></th>
									<th width="10%">
										<%--<input type="text" style="width: 150px" value="${pd.TAXITEMS}"
														   class="input-text"  name="TAXITEMS"
														   id="TAXITEMS">--%>
										<select name="TAXITEMS" id="TAXITEMS" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.TAXITEMS}" name="${pd.TAXITEMS}">${pd.TAXITEMS}</option>
											<c:forEach items="${listItems}" var="var" varStatus="vs">
												<option id="${var.FNAME}" value="${var.FNAME}" name="${var.COEFFCIENT}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</th>
									<th width="10%" ><label>印花税：</label></th>
									<th  ><input type="text" style="width: 150px" value="${pd.STAMPDUTY}"
												 class="input-text"  name="STAMPDUTY" readonly="readonly"
												 id="STAMPDUTY"></th>
									<th width="15%"><label>印花税计提月份：</label></th>
									<th width="10%">
										<%--<select name="STAMPDUTYMONTH" id="STAMPDUTYMONTH" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.STAMPDUTYMONTH}" name="${pd.STAMPDUTYMONTH}">${pd.STAMPDUTYMONTH}</option>
											<c:forEach items="${listmonth}" var="var" varStatus="vs">
												<option id="${var}" value="${var}" name="${var}">${var}</option>
											</c:forEach>
										</select>--%>
										<input type="month" style="width: 150px;height: 31px" value="${pd.STAMPDUTYMONTH}"
														   class="input-text"  name="STAMPDUTYMONTH"
														   id="STAMPDUTYMONTH">
									</th>
								</tr>
								<tr class="success">
									<th ><label>经办人：</label></th>
									<th >
										<%--<input type="text" style="width: 150px" value="${pd.OPERATOR}"
												class="input-text"  name="OPERATOR"
												id="OPERATOR">--%>
										<select name="OPERATOR" id="OPERATOR" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.OPERATOR}" name="${pd.OPERATOR}">${pd.OPERATOR}</option>
											<c:forEach items="${listOperator}" var="var" varStatus="vs">
												<option id="${var.ONAME}" value="${var.ONAME}" name="${var.ONAME}">${var.ONAME}</option>
											</c:forEach>
										</select>
									</th>
									<th width="15%"><label>方式：</label></th>
									<th width="10%">
										<select name="MODE" id="MODE" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value)">
											<option value="${pd.MODE}" name="${pd.MODE}">${pd.MODE}</option>
											<c:forEach items="${listMode}" var="var" varStatus="vs">
												<option value="${var.NAME}" name="${var.NAME}">${var.NAME}</option>
											</c:forEach>
										</select>
									</th>
									<th  ><label>招待票：</label></th>
									<th  ><input type="text" readonly="readonly" style="width: 150px" value="${pd.INVITATIONTICKET}"
												 class="input-text"  name="INVITATIONTICKET"
												 id="INVITATIONTICKET"></th>
								</tr>
								<tr class="active">
									<th  ><label>合同类型：</label></th>
									<th colspan="3" >
										<select name="CONTRACTTYPES" id="CONTRACTTYPES" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.CONTRACTTYPES}" name="${pd.CONTRACTTYPES}">${pd.CONTRACTTYPES}</option>
											<c:forEach items="${listPIdClassify}" var="var" varStatus="vs">
												<option id="${var.FITEMID}" value="${var.FNAME}" name="${var.FITEMID}">${var.FNAME}</option>
											</c:forEach>
										</select> ---
										<select name="CONTRACTCLASSIFY" id="CONTRACTCLASSIFY" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value); ">
											<option  value="${pd.CONTRACTCLASSIFY}" name="${pd.CONTRACTCLASSIFY}">${pd.CONTRACTCLASSIFY}</option>
										</select>
										<c:if test="${pd2.ISEW == null}">
										<label id="iswe1" style="display:none;margin-left: 20px" class="control-label" >是否有水电费：</label>
										<label id="iswe2"  style="display:none;margin-top: 5px;margin-right: 15px">
											<input id="iswe"
										    onclick="isWe()"
											name="switch-field" class="ace ace-switch ace-switch-5" type="checkbox">
											<span class="lbl"></span>
										</label>
										</c:if>
									</th>
									<th  ><label style="display: none" id="znj">滞纳金率(%)：</label></th>
									<th  ><input style="display: none" id="znjip" type="number" style="width: 150px;height: 31px" value="${pd2.OVERDUE}"
												 class="input-text"  name="OVERDUE"
												 id="OVERDUE"></th>
								</tr>

								</tbody>
							</table>

							<div align="center" style="width: 100%;height: 30px;-moz-border-radius: 15px;-webkit-border-radius: 15px; border-radius:15px;background-color: yellow;">
								<strong style="font-size: 18px">上传附件图片</strong>
							</div>
							<div style="width: 100%" align="center">
								<br>
								<p>
									<input onclick="selectPic('${pd.CONTRACT_ID}')" style="width: 50%;" value="选择附件" class="btn btn-success btn-block"/>
								</p>
							</div>

							<br />
							<!-- --------------------------------------------------------------------------- -->
							<table id="proceedsContract" style="display: none;" class="table table-border table-bg table-bordered">
								<tbody>

								<!--  -----------------------含水电--------------------------------------->
								<c:if test="${pd2.ISEW == '1'}">
								<c:if test="${not empty listPTime}">
								<c:forEach items="${listPTime}" var="var" varStatus="vs">

								<tr class="warning">
									<th width="15%"><label>时间区间：</label></th>
									<th colspan="5"><input type="date" style="width: 150px;height: 31px" value="${var.STARTTIME}"
																	   id="st${var.PROCEEDSTIME_ID}"  class="input-text"  >
										--- <input type="date" style="width: 150px;height: 31px" value="${var.ENTTIME}"
												   class="input-text" id="et${var.PROCEEDSTIME_ID}">
										<a style="margin-left: 10px" class="btn btn-xs btn-success" title="添加明细"
										   onclick="addTrFp('${pd.CONTRACT_ID}','${var.PROCEEDSTIME_ID}')">
											<i class="ace-icon fa fa-pencil-square-o bigger-120" title="添加明细">添加明细</i></a>
										<a style="margin-left: 10px" class="btn btn-xs btn-success" title="保存修改"
										   onclick="editTime('${var.PROCEEDSTIME_ID}')">
											<i class="ace-icon fa fa-cog bigger-120" title="保存修改">保存修改</i></a>
										<a style="margin-left: 10px" class="btn btn-xs btn-success" title="删除该时间区间"
										   onclick="delTime('${var.PROCEEDSTIME_ID}')">
											<i class="ace-icon fa fa-check-square-o bigger-120" title="删除该时间区间">删除该时间区间</i></a>
										<label style="margin-left: 20px" class="control-label" >显示全部：</label>
										<label style="margin-top: 5px;margin-right: 15px">
											<input id="sw${var.PROCEEDSTIME_ID}" onclick="showDetail('${var.PROCEEDSTIME_ID}')"
												   name="switch-field-1" class="ace ace-switch ace-switch-5" type="checkbox">
											<span class="lbl"></span>
										</label>
									</th>

								</tr>

								<c:if test="${not empty listInvoice }">
								<c:forEach items="${listInvoice}" var="var1" varStatus="vs">
								<c:if test="${var1.PROCEEDSTIME_ID == var.PROCEEDSTIME_ID}">
								<tr style="display: none" name="tr${var.PROCEEDSTIME_ID}" class="success">
									<th width="15%"><label>客户租用周期：</label></th>
									<th colspan="3"><input type="date" style="width: 150px;height: 31px" value="${var1.STARTTIME}"
												class="input-text"
												id="st${var1.INVOICE_ID}">至
										<input type="date" style="width: 150px;height: 31px" value="${var1.ENDTIME}"
											   class="input-text"
											   id="et${var1.INVOICE_ID}">
									</th>
									<th ></th>
									<th ></th>
								</tr>
								<tr style="display: none" name="tr${var.PROCEEDSTIME_ID}" class="success">
									<th width="15%"><label>应收金额：</label></th>
									<th ><input type="number" style="width: 150px" value="${var1.RECEIVABLE}"
														   class="input-text"  name="RECEIVABLE"
														   id="r${var1.INVOICE_ID}"></th>
									<th ><label>应收款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${var1.PAYTIME}"
												class="input-text"  name="PAYTIME"
												id="pt${var1.INVOICE_ID}"></th>
									<th width="15%"><label>付款方名称：</label></th>
									<th width="20%"><input type="text" style="width: 150px" value="${var1.PAYERNAME}"
														   class="input-text"  name="PAYERNAME"
														   id="pn${var1.INVOICE_ID}"></th>
								</tr>
								<tr style="display: none" name="tr${var.PROCEEDSTIME_ID}" class="success">
									<th width="15%"><label>实际收款金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${var1.RECEIVABLE_REALITY}"
														   class="input-text"  name="RECEIVABLE_REALITY" readonly
														   id="rr${var1.INVOICE_ID}"></th>
									<th ><label>实际收款时间：</label></th>
									<th ><input onchange="calOD('${var1.INVOICE_ID}')" type="date" style="width: 150px;height: 31px" value="${var1.RECEIVABL_PAYTIME}"
												class="input-text"  name="RECEIVABL_PAYTIME" readonly
												id="rpt${var1.INVOICE_ID}"></th>
									<th  ><label>滞纳金：</label></th>
									<th  ><input type="number" style="width: 150px;height: 31px" value="${var1.OVERDUE}"
												 class="input-text" readonly
												 id="od${var1.INVOICE_ID}"></th>
								</tr>
								<tr style="display: none" name="tr${var.PROCEEDSTIME_ID}" id="tr${var1.INVOICE_ID}" class="success">
									<th ><label>发票名称：</label></th>
									<th  ><input type="text" style="width: 150px;height: 31px" value="${var1.INVOICENAME}"
												 class="input-text"  name="INVOICENAME"
												 id="ivn${var1.INVOICE_ID}"></th>
									<th  ><label>开票时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${var1.INVOICETIME}"
												 class="input-text"  name="INVOICETIME"
												 id="ivt${var1.INVOICE_ID}" ></th>
									<c:if test="${vs.index} == 0 || ${vs.index} == '0'">
										<c:set var="LINVOICE_ID" value="0"/>
									</c:if>
									<th  colspan="2">
										<a style="margin-left: 10px" class="btn btn-xs btn-success" title="添加水电费项"
										   onclick="addUtilities('${pd.CONTRACT_ID}','${var.PROCEEDSTIME_ID}','${var1.INVOICE_ID}','${LINVOICE_ID}','${pd.CONTRACTOFNAME}','${pd2.OVERDUE}','${var1.PAYERNAME}')">
											<i class="ace-icon fa fa-pencil-square-o bigger-120" title="添加水电费项">查看水电费项</i></a>
										<a class="btn btn-xs blue" title="确认修改"
											 onclick="editInvoice('${var1.INVOICE_ID}');">
										<i class="ace-icon fa fa-cog bigger-120" title="确认修改">确认修改</i></a>
										<a class="btn btn-mini btn-danger" title="删除该明细项"
										   onclick="delInvoice('${var1.INVOICE_ID}');">
											<i class="ace-icon fa fa-trash-o bigger-120" title="删除该明细项">删除该明细项</i></a>
									</th>
									<c:set var="LINVOICE_ID" value="${var1.INVOICE_ID}"/>
								</tr>
								<tr name="tr${var.PROCEEDSTIME_ID}" style="display: none;height: 3px" class="active"><th colspan="6"><label></label></th></tr>
								</c:if>
								</c:forEach>
								</c:if>
								<tr id="fp${var.PROCEEDSTIME_ID}"></tr>
								</c:forEach>
								</c:if>
								</c:if>
								<!--  -----------------------含水电--------------------------------------->
								<!--  -----------------------不含水电--------------------------------------->
								<c:if test="${pd2.ISEW == '0'}">
								<c:forEach items="${listInvoice}" var="var1" varStatus="vs">
								<tr class="success">
									<th width="15%"><label>应收金额：</label></th>
									<th><input type="number" style="width: 150px" value="${var1.RECEIVABLE}"
														   class="input-text"  name="RECEIVABLE"
														   id="r${var1.INVOICE_ID}"></th>
									<th ><label>应收款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${var1.PAYTIME}"
												class="input-text"  name="PAYTIME"
												id="pt${var1.INVOICE_ID}"></th>
									<th width="15%"><label>付款方名称：</label></th>
									<th width="20%"><input type="text" style="width: 150px" value="${var1.PAYERNAME}"
														   class="input-text"  name="PAYERNAME"
														   id="pn${var1.INVOICE_ID}"></th>
								</tr>
								<tr class="success">
									<th width="15%"><label>实际收款金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${var1.RECEIVABLE_REALITY}"
														   class="input-text"  name="RECEIVABLE_REALITY" readonly
														   id="rr${var1.INVOICE_ID}"></th>
									<th ><label>实际收款时间：</label></th>
									<th ><input onchange="calOD('${var1.INVOICE_ID}')" type="date" style="width: 150px;height: 31px" value="${var1.RECEIVABL_PAYTIME}"
												class="input-text"  name="RECEIVABL_PAYTIME" readonly
												id="rpt${var1.INVOICE_ID}"></th>
									<th  ><label>滞纳金：</label></th>
									<th  ><input type="number" style="width: 150px;height: 31px" value="${var1.OVERDUE}"
												 class="input-text" readonly
												 id="od${var1.INVOICE_ID}"></th>
								</tr>
								<tr id="tr${var1.INVOICE_ID}" class="success">
									<th ><label>发票名称：</label></th>
									<th  ><input type="text" style="width: 150px;height: 31px" value="${var1.INVOICENAME}"
												 class="input-text"  name="INVOICENAME"
												 id="ivn${var1.INVOICE_ID}"></th>
									<th  ><label>开票时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${var1.INVOICETIME}"
												 class="input-text"  name="INVOICETIME"
												 id="ivt${var1.INVOICE_ID}" ></th>
									<th  colspan="2">
										<a class="btn btn-xs blue" title="确认修改"
										   onclick="editInvoice('${var1.INVOICE_ID}');">
											<i class="ace-icon fa fa-cog bigger-120" title="确认修改">确认修改</i></a>
										<a class="btn btn-mini btn-danger" title="删除该明细项"
										   onclick="delInvoice('${var1.INVOICE_ID}');">
											<i class="ace-icon fa fa-trash-o bigger-120" title="删除该明细项">删除该明细项</i></a>
									</th>
								</tr>
								<tr style="height: 3px" class="active"><th colspan="6"><label></label></th></tr>
								</c:forEach>
								</c:if>
								<!--  -----------------------不含水电--------------------------------------->
								<tr id="ti${pd.CONTRACT_ID}"></tr>
								<tr id="fp"></tr>
								<tr>
									<c:if test="${pd2.ISEW == '0' || msg == 'save'}">
									<th id="addTrFpNotew">
										<div class="col-md-12"  style="padding-bottom:2em;">
											<a onclick="addTrFpNotew('${pd.CONTRACT_ID}')" class="btn btn-info" id=""><i class="fa fa-plus"></i>新增新的应收款项</a>
										</div>
									</th>
									</c:if>
									<c:if test="${pd2.ISEW == '1' || msg == 'save'}">
									<th style="<c:if test="${pd2.ISEW != '1'}">display:none;</c:if>" id="addTrTime">
										<div class="col-md-12"  style="padding-bottom:2em;">
											<a onclick="addTrTime('${pd.CONTRACT_ID}')" class="btn btn-info" ><i class="fa fa-plus"></i> 添加明细时间区间</a>
										</div>
									</th>
									</c:if>
								</tr>
								<c:if test="${not empty listDepositInfo }">
									<c:forEach items="${listDepositInfo}" var="var" varStatus="vs">
										<tbody id="tb${var.DEPOSITINFO_ID}">
										<tr  class="danger">
											<th width="10%" ><label>应收押金金额：</label></th>
											<th  ><input type="number" style="width: 150px" value="${var.DWDEPOSIT}"
														 class="input-text"  name="DWDEPOSIT"
														id="dd${var.DEPOSITINFO_ID}"></th>
											<th width="15%"><label>应付款时间（押金）：</label></th>
											<th width="10%"><input type="date" style="width: 150px;height: 31px" value="${var.DWDEPOSITTIME}"
																   class="input-text"  name="DWDEPOSITTIME"
																   id="ddt${var.DEPOSITINFO_ID}"></th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="danger">
											<th width="15%"><label>实际收款金额（押金）：</label></th>
											<th width="10%">
												<input type="number" style="width: 150px" value="${var.REALITY}"
													   class="input-text"  name="REALITY" readonly
													   id="r${var.DEPOSITINFO_ID}">
											</th>
											<th  ><label>实际收款时间（押金）：</label></th>
											<th  ><input type="date" style="width: 150px;height: 31px" value="${var.REALITYTIME}"
														 class="input-text"  name="REALITYTIME" readonly
														 id="rt${var.DEPOSITINFO_ID}"></th>
											<th width="15%"><label>付款方名称（押金）：</label></th>
											<th width="10%"><input type="text" style="width: 150px" value="${var.DEPOSITPAYER}"
																   class="input-text"  name="DEPOSITPAYER"
																   id="dp${var.DEPOSITINFO_ID}" ></th>
										</tr>
										<tr class="warning">
											<th ><label>进场时间：</label></th>
											<th >
												<label>
													<input type="date" style="width: 140px;height: 31px" value="${var.ENTERTIME}"
														   class="input-date"  name="ENTERTIME"
														   id="et${var.DEPOSITINFO_ID}" id="ENTERTIME">
												</label>
											</th>
											<th ><label>是否已办进场手续：</label></th>
											<th  >
												<label style="float:left;padding-left: 12px;"><input class="ace" name="field-radio${var.DEPOSITINFO_ID}" id="ise${var.DEPOSITINFO_ID}"  <c:if test="${var.ISENTERPROCEDURE == '1' }">checked="checked"</c:if> type="radio" value="1"><span class="lbl">是</span></label>
												<label style="float:left;padding-left: 5px;"><input class="ace" name="field-radio${var.DEPOSITINFO_ID}"  id="ise1${var.DEPOSITINFO_ID}" <c:if test="${var.ISENTERPROCEDURE == '0' }">checked="checked"</c:if> type="radio" value="0"><span class="lbl">否</span></label>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th  ><label>撤场时间：</label></th>
											<th >
												<label>
													<input type="date" style="width: 140px;height: 31px" value="${var.WITHDRAWALTIME}"
														   class="input-date"  name="WITHDRAWALTIME"
														   id="wt${var.DEPOSITINFO_ID}" >
												</label>
											</th>
											<th ><label>是否已办撤场手续：</label></th>
											<th  >
												<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio${var.DEPOSITINFO_ID}" id="field-radio${var.DEPOSITINFO_ID}"  <c:if test="${var.ISDRAWALPROCEDURE == '1' }">checked="checked"</c:if> type="radio" value="1"><span class="lbl">是</span></label>
												<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio${var.DEPOSITINFO_ID}" id="form-field-radio${var.DEPOSITINFO_ID}"  <c:if test="${var.ISDRAWALPROCEDURE == '0' }">checked="checked"</c:if> type="radio" value="0"><span class="lbl">否</span></label>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th ><label>退押金金额：</label></th>
											<th >
												<label>
													<input type="number" style="width: 140px;height: 31px" value="${var.RETURNDEPOSIT}"
														   class="input-date"  name="RETURNDEPOSIT"
														   id="rd${var.DEPOSITINFO_ID}">
												</label>
											</th>
											<th  ><label>结转收入金额：</label></th>
											<th >
												<label>
													<input type="number" style="width: 140px;height: 31px" value="${var.TRAINCOAMOUNT}"
														   class="input-date"  name="TRAINCOAMOUNT"
														   id="tc${var.DEPOSITINFO_ID}">
												</label>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th ><label>发票名称：</label></th>
											<th >
												<label>
													<input type="text" style="width: 140px;height: 31px" value="${var.INVOICENAME}"
														   class="input-date"  name="INVOICENAME"
														   id="in${var.DEPOSITINFO_ID}">
												</label>
											</th>
											<th ><label>开票时间：</label></th>
											<th >
												<label>
													<input type="date" style="width: 140px;height: 31px" value="${var.INVOICETIME}"
														   class="input-date"  name="INVOICETIME"
														   id="it${var.DEPOSITINFO_ID}">
												</label>
											</th>
											<th>
												<%--<a class="btn btn-xs blue" title="水电费录入"
												   onclick="addUTILITIES('${var.DEPOSITINFO_ID}');">
													<i class="ace-icon fa fa-pencil-square-o bigger-120" title="水电费录入"></i></a>--%>
												<a class="btn btn-xs blue" title="确认修改"
													 onclick="editDepositInfo('${var.DEPOSITINFO_ID}');">
												<i class="ace-icon fa fa-pencil-square-o bigger-120" title="确认修改"></i></a>
												<a class="btn btn-mini btn-danger" title="删除该押金项"
												   onclick="delDepositInfo('${var.DEPOSITINFO_ID}');">
													<i class="ace-icon fa fa-trash-o bigger-120" title="删除该押金项"></i></a>
											</th>
											<th  ></th>
										</tr>
									</tbody>
									</c:forEach>
								</c:if>
								<tr id="yj${pd.CONTRACT_ID}"></tr>
								<tr>
									<th>
										<div class="col-md-12"  style="padding-bottom:2em;">
											<a onclick="addTrYj('${pd.CONTRACT_ID}')" class="btn btn-info" ><i class="fa fa-plus"></i> 添加新的押金项</a>
										</div>
									</th>
								</tr>
								<tr class="info">
									<th ><label>备注：</label></th>
									<th colspan="5">
										<label>
											<input type="text" style="width: 880px;height: 31px" value="${pd2.FREMARK}"
												   class="input-date"  name="FREMARK"
												   id="FREMARK">
										</label>
									</th>
								</tr>
								</tbody>
							</table>
							<!-- -----------------------------------付款合同明细---------------------------------------- -->
							<div id="paymentContarct" style="display: none">
								<div >
									<c:if test="${not empty listPayprimary}">
										<c:forEach items="${listPayprimary}" var="var" varStatus="vs">
											<table id="ta${var.PAYPRIMARY_ID}" class="table table-border table-bg table-bordered" style="margin-top: 10px">
												<tbody id="tb${var.PAYPRIMARY_ID}">
												<tr class="center">
													<td style="padding-left:2px;">时间</td>
													<td style="padding-left:2px;">总应付金额</td>
													<td style="padding-left:2px;">付款所属时间</td>
													<td style="padding-left:2px;">应付款金额</td>
													<td style="padding-left:2px;">实际付款时间</td>
													<td style="padding-left:2px;">实际付款金额</td>
													<td style="padding-left:2px;">尚没付款金额</td>
													<td style="padding-left:2px;">操作</td>
												</tr>
												<tr class="center" id="sum" >
													<td id="td1${var.PAYPRIMARY_ID}" rowspan="${count +1}" style="padding-left:2px;vertical-align:middle;">${var.STARTTIME } -- ${var.ENTTIME }</td>
													<td id="td2${var.PAYPRIMARY_ID}" rowspan="${count +1}"  style="padding-left:2px;vertical-align:middle;">
														<p id="pic${var.PAYPRIMARY_ID}">${var.CONTRACTPIC }</p>
													</td>
												</tr>
												<c:if test="${not empty listPayDetail}">
													<c:forEach items="${listPayDetail}" var="var1" varStatus="vs1">
														<c:if test="${var1.PAYPRIMARY_ID == var.PAYPRIMARY_ID}">
															<tr class="center" style="background-color: #FFFFCC" >
																<td style="padding-left:2px;">
																	<input type="date" style="width: 150px;height: 31px" value="${var1.SHPAYTIME}"
																		   class="input-text"  name="SHPAYTIME" id="spt${var1.PAYDETAIL_ID}"
																	></td>
																<td style="padding-left:2px;">
																	<input type="number" style="width: 150px;height: 31px" value="${var1.SHPAY}"
																		   class="input-text"  name="SHPAY" id="sp${var1.PAYDETAIL_ID}"
																	></td>
																<td style="padding-left:2px;">
																	<input type="date" style="width: 150px;height: 31px" value="${var1.REALITYPAYTIME}"
																		   class="input-text"  name="REALITYPAYTIME" id="rpt${var1.PAYDETAIL_ID}"
																	>
																</td>
																<td style="padding-left:2px;">
																	<input type="number" style="width: 150px" value="${var1.REALITYPAY}"
																		   class="input-text"  name="REALITYPAY" id="rp${var1.PAYDETAIL_ID}"
																	>
																</td>
																<td style="padding-left:2px;">
																	<p>${var1.ONPAYPIC}</p>
																</td>
																<td style="padding-left:2px;">
																	<a class="btn btn-xs btn-success" title="保存修改"
																	   onclick="editPay('${var1.PAYPRIMARY_ID}','${var1.PAYDETAIL_ID}');">
																		<i class="ace-icon fa fa-check-square-o bigger-120"
																		   title="保存修改"></i>
																	</a>
																	<a class="btn btn-xs btn-danger" title="删除"
																	   onclick="delPay('${var1.PAYPRIMARY_ID}','${var1.PAYDETAIL_ID}');">
																		<i class="ace-icon fa fa-trash-o bigger-120"
																		   title="删除"></i>
																	</a>
																</td>
															</tr>

														</c:if>
													</c:forEach>
												</c:if>
												<tr id="${var.PAYPRIMARY_ID}"></tr>
												</tbody>
											</table>
											<div class="col-md-12"  style="padding-bottom:2em;">
												<a onclick="addTr('${var.PAYPRIMARY_ID}')" class="btn btn-info" ><i class="fa fa-plus"></i> 添加新的明细项</a>
											</div>
										</c:forEach>
									</c:if>

								</div>
								<div id="divTable" class="col-md-12"  style="padding-bottom:2em;">
									<a onclick="addTable()" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的主表</a>
								</div>
								<table class="table table-border table-bg table-bordered">
									<tbody>
									<tr class="success">
										<td width="10%" ><label>备注：</label></td>
										<td colspan="5">
											<textarea style="width: 95%;height: 78px" name="REMARK" id="REMARK">${pd1.REMARK}</textarea>
											<%--<input type="text" style="width: 150px" value="${pd1.REMARK}"
													class="input-text"  name="REMARK"
													id="REMARK">--%>
										</td>
									</tr>
									</tbody>
								</table>
							</div>
							<%--<table id="paymentContarct" style="display: none" class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="active">
									<th ><label>总金额：</label></th>
									<th ><input type="number" style="width: 150px" value="${pd1.AMOUNT}"
												class="input-text"  name="AMOUNT"
												id="AMOUNT"></th>
									<th width="15%"><label>应付款金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd1.DUE_AMOUNT}"
														   class="input-text"  name="DUE_AMOUNT"
														   id="DUE_AMOUNT"></th>
									<th ><label>实际付款时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd1.REALITYTIME}"
												 class="input-text"  name="REALITYTIME"
												 id="REALITYTIME"></th>
								</tr>
								<tr class="success">

									<th  ><label>实际付款金额：</label></th>
									<th  ><input type="number" style="width: 150px" value="${pd1.REALITY_AMOUNT}"
												 class="input-text"  name="REALITY_AMOUNT"
												 id="REALITY_AMOUNT"></th>
									<th  ><label>付款日：</label></th>
									<th  ><input type="number" style="width: 150px" value="${pd1.PAYDAY}"
												 class="input-text"  name="PAYDAY"
												 id="PAYDAY"></th>
									<th width="10%" ><label>备注：</label></th>
									<th ><input type="text" style="width: 150px" value="${pd1.REMARK}"
												 class="input-text"  name="REMARK"
												 id="REMARK"></th>
								</tr>
								</tbody>
							</table>--%>
						</form>
						<!-- ------------------------------------------------------------------------------- -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->


	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up"
	   class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!-- 上传控件 -->
<script src="static/ace/js/ace/elements.fileinput.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
	$(top.hangge());

	var editCount = 0;
	var addCount = 0;

	//付款合同明细function---strar
	function delPay(PAYPRIMARY_ID,PAYDETAIL_ID){
		$.ajax({
			type: "POST",
			url: '<%=basePath%>paydetail/deleteDetail',
			async: false,
			data: {
				PAYPRIMARY_ID : PAYPRIMARY_ID,
				PAYDETAIL_ID : PAYDETAIL_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				window.location.reload();
			}
		});
	}

	function editPay(PAYPRIMARY_ID,PAYDETAIL_ID){
		var PAYDETAIL_ID = PAYDETAIL_ID;
		var SHPAYTIME = $("#spt"+PAYDETAIL_ID).val();
		var SHPAY = $("#sp"+PAYDETAIL_ID).val();
		var REALITYPAYTIME = $("#rpt"+PAYDETAIL_ID).val();
		var REALITYPAY = $("#rp"+PAYDETAIL_ID).val();
		//alert("应付时间:"+SHPAYTIME+",应付金额:"+SHPAY+",实际付款时间:"+REALITYPAYTIME+",实际付款金额:"+REALITYPAY+"。");
		$.ajax({
			type: "POST",
			url: '<%=basePath%>paydetail/editPayDetailInfo',
			async: false,
			data: {
				PAYPRIMARY_ID : PAYPRIMARY_ID,
				PAYDETAIL_ID : PAYDETAIL_ID,
				SHPAYTIME : SHPAYTIME,
				SHPAY : SHPAY,
				REALITYPAYTIME : REALITYPAYTIME,
				REALITYPAY : REALITYPAY
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				window.location.reload();
			}
		});
	}

	var newPAYPRIMARY_ID = null;

	function saveTable(tuuid){
		addCount -= 1 ;
		var con = confirm("是否保存时间和总金额?"); //在页面上弹出对话框
		if(con == true){
			//alert("是");
		}
		else {
			// alert("否");
			return;
		}
		if(newPAYPRIMARY_ID == null || newPAYPRIMARY_ID == ""){
			var PAYPRIMARY_ID = "${pd.PAYPRIMARY_ID}";
		}else {
			var PAYPRIMARY_ID = newPAYPRIMARY_ID;
		}
		var CONTRACT_ID = "${pd.CONTRACT_ID}";
		var CONTRACTPIC = $("#pic"+tuuid).val();
		var STARTTIME = $("#st"+tuuid).val();
		var ENTTIME = $("#et"+tuuid).val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>payprimary/saveTable',
			async: false,
			data: {
				PAYPRIMARY_ID : PAYPRIMARY_ID,
				CONTRACT_ID : CONTRACT_ID,
				CONTRACTPIC : CONTRACTPIC,
				STARTTIME : STARTTIME,
				ENTTIME : ENTTIME
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
			}
		});
	}

	function addTable(){
		addCount += 1;
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
				newPAYPRIMARY_ID = data.uuid;
			}
		});
		var table = "";
		table += '<table id="ta'+uuid+'" class="table table-border table-bg table-bordered" style="margin-top: 10px">';
		table += '<tbody id="tb'+uuid+'" ><tr class="center" >';
		table += '<td style="padding-left:2px;">时间</td><td style="padding-left:2px;">总应付金额</td>';
		table += '<td style="padding-left:2px;">付款所属时间</td><td style="padding-left:2px;">应付款金额</td>';
		table += '<td style="padding-left:2px;">实际付款时间</td><td style="padding-left:2px;">实际付款金额</td>';
		table += '<td style="padding-left:2px;">尚没付款金额</td><td style="padding-left:2px;">操作</td>';
		table += '</tr></tbody></table>';
		table += '<div class="col-md-12"  style="padding-bottom:2em;">';
		table += '<a onclick="addTr(\''+uuid+'\')" class="btn btn-info" id="add"><i class="fa fa-plus"></i> 添加新的明细项</a>';
		table += '</div>';
		$("#divTable").before(table);
		table = "";
		uuid = "";
	}

	function addTr(uuid_var) {
		addCount += 1;
		var isname = $("#pic"+uuid_var).length;
		var count =$("#ta"+uuid_var+" tr").length;
		$("#td1"+uuid_var).attr("rowspan",count);
		$("#td2"+uuid_var).attr("rowspan",count);
		var tr = '';
		tr += '<tr style="border: 1px;solid #dddddd;" class="center" >';
		//alert(isname == null ||isname == undefined||isname =="");
		if(isname == 0){
			tr += '<td id="td1'+uuid_var+'"  class="center" style="padding-left:2px;">' +
					'<input id="st'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="STARTTIME" >' +
					' --- <input id="et'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="ENTTIME" >' +
					'</td>';
			tr += '<td id="td2'+uuid_var+'"  class="center" style="padding-left:2px;">' +
					'<input onchange="saveTable(\''+uuid_var+'\')" id="pic'+uuid_var+'" type="number" style="width: 150px" class="input-text"  name="CONTRACTPIC" ></td>';
		}
		tr += '<td style="padding-left:2px;"><input id="spt'+uuid_var+'" type="date" style="width: 150px;height: 31px" '+
				'class="input-text"  name="SHPAYTIME" ></td>'
		tr += '<td style="padding-left:2px;"><input id="sp'+uuid_var+'" type="number" style="width: 150px;height: 31px" ' +
				' class="input-text"  name="SHPAY" ></td>';
		tr += ' <td style="padding-left:2px;">' +
				'<input id="rpt'+uuid_var+'" type="date" style="width: 150px;height: 31px" class="input-text"  name="REALITYPAYTIME" ></td>';
		tr += '<td style="padding-left:2px;">' +
				'<input id="rp'+uuid_var+'" type="number" style="width: 150px" class="input-text"  name="REALITYPAY" ></td>';
		tr += '<td style="padding-left:2px;"></td>';
		tr += '<td style="padding-left:2px;"> ' +
				'<a class="btn btn-xs btn-success" title="保存" onclick="saveDetail(\''+uuid_var+'\');">' +
				'<i class="ace-icon fa fa-check-square-o bigger-120" title="保存"></i>' +
				'</a> ' +
				'</td>';
		tr += '</tr>';
		if(isname == 0){
			tr += '<tr id="'+uuid_var+'"></tr>';
		}
		if(isname == 0) {
			$("#tb" + uuid_var).after(tr);
		}else {
			$("#" + uuid_var).before(tr);
		}
		tr = '';
	}

	function saveDetail(uuid_var){

		var PAYPRIMARY_ID = uuid_var;
		var CONTRACT_ID =  "${pd.CONTRACT_ID}";
		var SHPAYTIME = $("#spt"+uuid_var).val();
		var REALITYPAY = $("#rp"+uuid_var).val();
		var REALITYPAYTIME = $("#rpt"+uuid_var).val();
		var SHPAY =$("#sp"+uuid_var).val();
		var SHPAYTIME = $("#spt"+uuid_var).val();

		$.ajax({
			type: "POST",
			url: '<%=basePath%>paydetail/saveDetail',
			data: {
				CONTRACT_ID: CONTRACT_ID,
				PAYPRIMARY_ID: PAYPRIMARY_ID,
				REALITYPAY: REALITYPAY,
				SHPAYTIME:SHPAYTIME,
				REALITYPAYTIME:REALITYPAYTIME,
				SHPAY:SHPAY,
				SHPAYTIME:SHPAYTIME
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
	//付款合同明细function---ent

	function toRelevance(CONTRACT_ID){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = "关联合同";
		diag.URL = '<%=basePath%>contract/toRelevance?CONTRACT_ID='+CONTRACT_ID;
		diag.Width = window.innerWidth * 0.9;
		diag.Height = window.innerWidth * 0.9;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function () { //关闭事件
			//tosearch();
			diag.close();
			window.location.reload();
		};
		diag.show();
	}

	function calOD(INVOICE_ID) {
		var RECEIVABLE = $("#r"+INVOICE_ID).val();
		var OVERDUE = $("#znjip").val();
		var PAYTIME = $("#pt"+INVOICE_ID).val();
		var RECEIVABL_PAYTIME = $("#rpt"+INVOICE_ID).val();
		var differ = (Date.parse(new Date(RECEIVABL_PAYTIME))-Date.parse(new Date(PAYTIME)))/(1000*60*60*24);
		if(differ > 0){
			var OVERDUENUM = (parseFloat(RECEIVABLE)) * OVERDUE * differ * 0.01;
		}else {
			var OVERDUENUM = 0;
		}
		//alert(parseFloat(RECEIVABLE) +"*"+OVERDUE +"*"+ differ+"*0.01");
		$("#od"+INVOICE_ID).val(OVERDUENUM.toFixed(2));
		$("#rr"+INVOICE_ID).val((parseFloat(OVERDUENUM) + parseFloat(RECEIVABLE)).toFixed(2));
	}

	function isWe(){
		if($("#iswe").prop("checked")){
			$("#addTrFpNotew").css("display","none");
			$("#addTrTime").css("display","");
			$("#ISEW").val("1");
		}else {
			$("#addTrFpNotew").css("display","");
			$("#addTrTime").css("display","none");
			$("#ISEW").val("0");
		}
	}
	
	function showDetail(PROCEEDSTIME_ID) {
		if($("#sw"+PROCEEDSTIME_ID).prop("checked")){
			$("#proceedsContract [name='tr"+PROCEEDSTIME_ID+"']").each(function(index,item){
				$(this).css("display","");
			});
		}else {
			$("#proceedsContract [name='tr"+PROCEEDSTIME_ID+"']").each(function(index,item){
				$(this).css("display","none");
			});
		}
	}

	function addUtilities(CONTRACT_ID,PROCEEDSTIME_ID,INVOICE_ID,LINVOICE_ID,CONTRACTOFNAME,OVERDUE,PAYERNAME){
		//alert(LINVOICE_ID);
		$.ajax({
			type: "POST",
			url: '<%=basePath%>expense/addUtilitiesByCopy',
			async: false,
			data: {
				CONTRACT_ID : CONTRACT_ID,
				INVOICE_ID : INVOICE_ID,
				LINVOICE_ID : LINVOICE_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
			}
		});
		var STARTTIME = $("#st"+INVOICE_ID).val();
		var ENDTIME = $("#et"+INVOICE_ID).val();
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = "添加水电费项";
		diag.URL = '<%=basePath%>expense/goAdd?CONTRACT_ID='+CONTRACT_ID+'&STARTTIME='+STARTTIME+'&ENDTIME='+ENDTIME+'&PROCEEDSTIME_ID='+PROCEEDSTIME_ID+'&INVOICE_ID='+INVOICE_ID+'&CONTRACTOFNAME='+CONTRACTOFNAME+'&OVERDUE='+OVERDUE+'&PAYERNAME='+PAYERNAME;
		diag.Width = window.innerWidth * 1.3;
		diag.Height = 700;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function () { //关闭事件
			//tosearch();
			diag.close();
		};
		diag.show();
	}

	function addTrYj(CONTRACT_ID) {
		addCount += 1;
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
		var num = 1000 * Math.random();
		num = Math.floor(num);
		var num1 = num + 1 ;
		//alert(num);
		var tr = '';
		tr += '<tr class="danger"><th width="10%" ><label>应收押金金额：</label></th>';
		tr += '<th  ><input type="number" style="width: 150px" class="input-text"  name="DWDEPOSIT" id="dd'+uuid+'"></th>';
		tr += '<th width="15%"><label>应付款时间（押金）：</label></th>';
		tr += '<th width="10%"><input type="date" style="width: 150px;height: 31px" class="input-text"  name="DWDEPOSITTIME" id="ddt'+uuid+'"></th>';
		tr += '<th ><label></label></th><th  ></th></tr>';
		tr += '<tr class="danger"><th width="15%"><label>实际付款金额（押金）：</label></th><th width="10%">';
		tr += '<input type="number" readonly style="width: 150px" class="input-text"  name="REALITY" id="r'+uuid+'"></th>';
		tr += '<th  ><label>实际付款时间（押金）：</label></th><th><input type="date" readonly style="width: 150px;height: 31px" class="input-text"  name="REALITYTIME"';
		tr += 'id="rt'+uuid+'"></th>';
		tr += '<th width="15%"><label>付款方名称（押金）：</label></th>';
		tr += '<th width="10%"><input type="text" style="width: 150px" class="input-text"  name="DEPOSITPAYER" id="dp'+uuid+'"></th></tr>';
		tr += '<tr class="warning"><th ><label>进场时间：</label></th>';
		tr += '<th><label><input type="date" style="width: 140px;height: 31px" class="input-date"  name="ENTERTIME" id="et'+uuid+'"></label></th>';
		tr += '<th><label>是否已办进场手续：</label></th><th  >';
		tr += '<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio'+num+'"  type="radio" value="1"><span class="lbl">是</span></label>';
		tr += '<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio'+num+'"  type="radio" value="0"><span class="lbl">否</span></label>';
		tr += '</th><th  ><label></label></th><th  ></th></tr>';
		tr += '<tr class="warning"><th  ><label>撤场时间：</label></th><th ><label>';
		tr += '<input type="date" style="width: 140px;height: 31px" class="input-date"  name="WITHDRAWALTIME" id="wt'+uuid+'">';
		tr += '</label></th><th ><label>是否已办撤场手续：</label></th><th  >';
		tr += '<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio'+num1+'"  type="radio" value="1"><span class="lbl">是</span></label>';
		tr += '<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio'+num1+'"  type="radio" value="0"><span class="lbl">否</span></label>';
		tr += '</th><th  ><label></label></th><th  ></th></tr>';
		tr += '<tr class="warning"><th ><label>退押金金额：</label></th><th ><label>';
		tr += '<input type="number" style="width: 140px;height: 31px" class="input-date"  name="RETURNDEPOSIT" id="rd'+uuid+'">';
		tr += '</label></th>';
		tr += '<th  ><label>结转收入金额：</label></th><th ><label>';
		tr += '<input type="number" style="width: 140px;height: 31px" class="input-date"  name="TRAINCOAMOUNT" id="tc'+uuid+'">';
		tr += '</label></th><th  ><label></label></th><th  ></th></tr>';
		tr += '<tr class="warning"><th ><label>发票名称：</label></th><th ><label>';
		tr += '<input type="text" style="width: 140px;height: 31px" class="input-date"  name="INVOICENAME" id="in'+uuid+'"></label></th>';
		tr += '<th ><label>开票时间：</label></th><th ><label>';
		tr += '<input type="date" style="width: 140px;height: 31px" class="input-date"  name="INVOICETIME" id="it'+uuid+'">';
		tr += '</label></th><th  ><a class="btn btn-xs btn-success" title="保存" onclick="saveDepositInfo(\''+uuid+'\',\''+CONTRACT_ID+'\',\''+num+'\',\''+num1+'\');">' +
				'<i class="ace-icon fa fa-check-square-o bigger-120" title="保存"></i></a></th><th  ></th></tr>';
		$("#yj"+CONTRACT_ID).before(tr);
		tr = "";
		//alert($("input[name='form-field-radio"+num+"']:checked").val());
	}

	function addTrTime(CONTRACT_ID){
		addCount += 1;
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
		var tr = '';
			tr += '<tr class="warning">';
			tr += '<th width="15%"><label>时间区间：</label></th>';
			tr += '<th width="10%" colspan="5"><input type="date" style="width: 150px;height: 31px" class="input-text" id="st'+uuid+'">';
			tr += ' --- <input type="date" style="width: 150px;height: 31px" class="input-text"  id="et'+uuid+'">' +
			' <a style="margin-left: 10px" class="btn btn-xs btn-success" title="保存" onclick="saveTime(\''+CONTRACT_ID+'\',\''+uuid+'\')">' +
					'<i class="ace-icon fa fa-check-square-o bigger-120" title="保存">保存</i></a></th>';
			tr += '</tr>';
		$("#ti"+CONTRACT_ID).before(tr);
		tr = '';
	}

	function addTrFpNotew(CONTRACT_ID) {
		addCount += 1;
		var uuid = "";
		$.ajax({
			type: "POST",
			url: '<%=basePath%>paytable/getUUID',
			async: false,
			data: {},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				uuid = data.uuid;
			}
		});
		var tr = "";
		var CONTRACTCLASSIFY = $("#CONTRACTCLASSIFY").val();
		tr += '<tr class="success"><th width="15%"><label>应收金额：</label></th>';
		tr += '<th width="10%"><input type="number" style="width: 150px" class="input-text"  name="RECEIVABLE" ' +
				'id="r' + uuid + '"></th>';
		tr += '<th ><label>应收款时间：</label></th>';
		tr += ' <th ><input type="date" style="width: 150px;height: 31px" class="input-text"  name="PAYTIME"' +
				'id="pt' + uuid + '"></th>';
		tr += '<th width="15%"><label>付款方名称：</label></th>';
		tr += '<th width="20%"><input type="text" style="width: 150px" class="input-text"  name="PAYERNAME" ' +
				'id="pn' + uuid + '"></th> </tr>';
		tr += '<tr class="success"><th width="15%"><label>实际收款金额：</label></th>';
		tr += '<th width="20%"><input type="number" style="width: 150px" readonly class="input-text"  name="RECEIVABLE_REALITY" ' +
				'id="rr' + uuid + '"></th>';
		tr += '<th ><label>实际收款时间：</label></th>';
		tr += '<th ><input type="date" readonly="readonly" style="width: 150px;height: 31px" class="input-text"  name="RECEIVABL_PAYTIME" ' +
				'id="rpt' + uuid + '"></th>';
		tr += '<th  ><label>滞纳金：</label></th>';
		tr += '<th  ><input type="number" style="width: 150px;" readonly="readonly" class="input-text"  name="OVERDUE" ' +
				'id="od' + uuid + '"></th></tr>';
		tr += '<tr class="success"><th ><label>发票名称：</label></th>';
		tr += '<th><input type="text" style="width: 150px;height: 31px"  class="input-text"  name="INVOICENAME"' +
				'id="in' + uuid + '"></th>';
		tr += '<th><label>开票时间：</label></th>';
		tr += '<th><input type="date" style="width: 150px;height: 31px"  class="input-text"  name="INVOICETIME" id="it' + uuid + '"></th>';
		tr += '<th colspan="2"> <a class="btn btn-xs btn-success" title="保存" onclick="saveInvoice(\'' + CONTRACT_ID + '\',\'' + uuid + '\');">' +
				'<i class="ace-icon fa fa-check-square-o bigger-120" title="保存">保存</i></a></th>';
		tr += '</tr>';
		tr += '<tr style="height: 3px" class="active"><th colspan="6"><label></label></th></tr>'
		$("#fp").before(tr);
		tr = "";
	}

	function addTrFp(CONTRACT_ID,PROCEEDSTIME_ID) {
		addCount += 1;
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
		var CONTRACTCLASSIFY = $("#CONTRACTCLASSIFY").val();
		tr += '<tr class="success"><th width="15%"><label>客户租用周期：</label></th>';
		tr += ' <th colspan="3"><input type="date" style="width: 150px;height: 31px" class="input-text"id="st'+uuid+'">';
		tr += ' 至 <input type="date" style="width: 150px;height: 31px" class="input-text"id="et'+uuid+'">'+
				'</th>';
		tr += '<th ></th>';
		tr += '<th></th> </tr>';


		tr += '<tr class="success"><th width="15%"><label>应收金额：</label></th>';
		tr += '<th width="10%"><input type="number" style="width: 150px" class="input-text"  name="RECEIVABLE" ' +
				'id="r'+uuid+'"></th>';
		tr += '<th ><label>应收款时间：</label></th>';
		tr += ' <th ><input type="date" style="width: 150px;height: 31px" class="input-text"  name="PAYTIME"' +
				'id="pt'+uuid+'"></th>';
		tr += '<th width="15%"><label>付款方名称：</label></th>';
		tr += '<th width="20%"><input type="text" style="width: 150px" class="input-text"  name="PAYERNAME" ' +
				'id="pn'+uuid+'"></th> </tr>';
		tr += '<tr class="success"><th width="15%"><label>实际收款金额：</label></th>';
		tr += '<th width="20%"><input type="number" readonly="readonly" style="width: 150px" class="input-text"  name="RECEIVABLE_REALITY" ' +
				'id="rr'+uuid+'"></th>';
		tr += '<th ><label>实际收款时间：</label></th>';
		tr += '<th ><input type="date" style="width: 150px;height: 31px" readonly="readonly" class="input-text"  name="RECEIVABL_PAYTIME" ' +
				'id="rpt'+uuid+'"></th>';
		tr += '<th  ><label>滞纳金：</label></th>';
		tr += '<th  ><input type="number" style="width: 150px;" class="input-text" readonly  name="OVERDUE" ' +
				'id="od'+uuid+'"></th></tr>';
		tr += '<tr class="success"><th ><label>发票名称：</label></th>';
		tr += '<th><input type="text" style="width: 150px;height: 31px"  class="input-text"  name="INVOICENAME"'+
		'id="in'+uuid+'"></th>';
		tr += '<th><label>开票时间：</label></th>';
		tr += '<th><input type="date" style="width: 150px;height: 31px"  class="input-text"  name="INVOICETIME" id="it'+uuid+'"></th>';
		tr += '<th colspan="2"> <a class="btn btn-xs btn-success" title="保存" onclick="saveInvoice(\''+CONTRACT_ID+'\',\''+uuid+'\',\''+PROCEEDSTIME_ID+'\');">' +
			  '<i class="ace-icon fa fa-check-square-o bigger-120" title="保存">保存</i></a></th>';
		tr += '</tr>';
		tr += '<tr style="height: 3px" class="active"><th colspan="6"><label></label></th></tr>'
		$("#fp"+PROCEEDSTIME_ID).before(tr);
		tr = "";
	}

	function saveTime(CONTRACT_ID,uuid){
		addCount -= 1;
		var STARTTIME = $("#st"+uuid).val();
		var ENTTIME = $("#et"+uuid).val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceedstime/saveTime',
			async: false,
			data: {
				STARTTIME : STARTTIME,
				ENTTIME : ENTTIME,
				CONTRACT_ID : CONTRACT_ID
			},
			dataType: 'json',
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("保存成功!!");
				window.location.reload();
			}
		});
	}
	
	function saveInvoice(CONTRACT_ID,uuid,PROCEEDSTIME_ID) {
		addCount -= 1;
		var RECEIVABLE =$("#r"+uuid).val();
		var PAYTIME = $("#pt"+uuid).val();
		var OVERDUE = "0.00";
		var RECEIVABLE_REALITY = "0.00";
		var RECEIVABL_PAYTIME = $("#rpt"+uuid).val();
		var PAYERNAME = $("#pn"+uuid).val();
		var INVOICENAME = $("#in"+uuid).val();
		var INVOICETIME = $("#it"+uuid).val();
		var STARTTIME  = $("#st"+uuid).val();
		var ENDTIME  = $("#et"+uuid).val();
		var OVERDUE_N = '${pd2.OVERDUE}';
		$.ajax({
			type: "POST",
			url: '<%=basePath%>invoice/saveDetail',
			async: false,
			data: {
				RECEIVABLE : RECEIVABLE,
				PAYTIME : PAYTIME,
				STARTTIME : STARTTIME,
				ENDTIME : ENDTIME,
				OVERDUE : OVERDUE,
				OVERDUE_N : OVERDUE_N,
				RECEIVABLE_REALITY : RECEIVABLE_REALITY,
				RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
				PAYERNAME : PAYERNAME,
				INVOICENAME : INVOICENAME,
				INVOICETIME : INVOICETIME,
				PROCEEDSTIME_ID : PROCEEDSTIME_ID,
				CONTRACT_ID : CONTRACT_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("保存成功!!");
				window.location.reload();
			}
		});
	}

	function editInvoice(INVOICE_ID){
		var RECEIVABLE =$("#r"+INVOICE_ID).val();
		var PAYTIME = $("#pt"+INVOICE_ID).val();
		var OVERDUE = $("#od"+INVOICE_ID).val();
		var RECEIVABLE_REALITY = $("#rr"+INVOICE_ID).val();
		var RECEIVABL_PAYTIME = $("#rpt"+INVOICE_ID).val();
		var PAYERNAME = $("#pn"+INVOICE_ID).val();
		var INVOICENAME = $("#ivn"+INVOICE_ID).val();
		var STARTTIME  = $("#st"+INVOICE_ID).val();
		var ENDTIME  = $("#et"+INVOICE_ID).val();
		var INVOICETIME = $("#ivt"+INVOICE_ID).val();
		var OVERDUE_N = '${pd2.OVERDUE}';
		$.ajax({
			type: "POST",
			url: '<%=basePath%>invoice/editInfo',
			async: false,
			data: {
				RECEIVABLE : RECEIVABLE,
				OVERDUE_N : OVERDUE_N,
				PAYTIME : PAYTIME,
				STARTTIME : STARTTIME,
				ENDTIME : ENDTIME,
				OVERDUE : OVERDUE,
				RECEIVABLE_REALITY : RECEIVABLE_REALITY,
				RECEIVABL_PAYTIME : RECEIVABL_PAYTIME,
				PAYERNAME : PAYERNAME,
				INVOICE_ID : INVOICE_ID,
				INVOICENAME : INVOICENAME,
				INVOICETIME : INVOICETIME
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("修改成功!!");
				//window.location.reload();
			}
		});
	}

	function editTime(PROCEEDSTIME_ID) {
		var STARTTIME = $("#st"+PROCEEDSTIME_ID).val();
		var ENTTIME = $("#et"+PROCEEDSTIME_ID).val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceedstime/editTime',
			async: false,
			data: {
				STARTTIME : STARTTIME,
				ENTTIME : ENTTIME,
				PROCEEDSTIME_ID : PROCEEDSTIME_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("修改成功!!");
				window.location.reload();
			}
		});
	}

	function delTime(PROCEEDSTIME_ID) {
		var con = confirm("是否删除该时间区间，并把明细删除?"); //在页面上弹出对话框
		if(con == true){
		}
		else {
			return;
		}
		$.ajax({
			type: "POST",
			url: '<%=basePath%>proceedstime/deleteTime',
			async: false,
			data: {
				PROCEEDSTIME_ID : PROCEEDSTIME_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("删除成功!!");
				window.location.reload();
			}
		});
	}

	function delInvoice(INVOICE_ID){
		var con = confirm("是否删除该发票项?"); //在页面上弹出对话框
		if(con == true){
		}
		else {
			return;
		}
		$.ajax({
			type: "POST",
			url: '<%=basePath%>invoice/delete',
			async: false,
			data: {
				INVOICE_ID : INVOICE_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("删除成功!!");
				window.location.reload();
			}
		});
		//$("#tr"+INVOICE_ID).css("display","none");
	}

	function saveDepositInfo(uuid,CONTRACT_ID,num,num1) {
		addCount -= 1;
		var INVOICENAME = $("#in"+uuid).val();
		var INVOICETIME = $("#it"+uuid).val();
		var DWDEPOSIT = $("#dd"+uuid).val();
		var DWDEPOSITTIME = $("#ddt"+uuid).val();
		var REALITY =  $("#r"+uuid).val();
		var REALITYTIME =  $("#rt"+uuid).val();
		var DEPOSITPAYER =  $("#dp"+uuid).val();
		var ENTERTIME =  $("#et"+uuid).val();
		var WITHDRAWALTIME =  $("#wt"+uuid).val();
		var RETURNDEPOSIT =  $("#rd"+uuid).val();
		var TRAINCOAMOUNT =  $("#tc"+uuid).val();
		var ISDRAWALPROCEDURE = $("input[name='form-field-radio"+num1+"']:checked").val();
		var ISENTERPROCEDURE = $("input[name='form-field-radio"+num+"']:checked").val();
		//alert(ISDRAWALPROCEDURE);
		$.ajax({
			type: "POST",
			url: '<%=basePath%>depositinfo/saveInfo',
			async: false,
			data: {
				INVOICENAME : INVOICENAME,
				INVOICETIME : INVOICETIME,
				DWDEPOSIT : DWDEPOSIT,
				DWDEPOSITTIME : DWDEPOSITTIME,
				REALITY : REALITY,
				REALITYTIME : REALITYTIME,
				DEPOSITPAYER : DEPOSITPAYER,
				ENTERTIME : ENTERTIME,
				WITHDRAWALTIME : WITHDRAWALTIME,
				RETURNDEPOSIT : RETURNDEPOSIT,
				TRAINCOAMOUNT : TRAINCOAMOUNT,
				ISDRAWALPROCEDURE : ISDRAWALPROCEDURE,
				ISENTERPROCEDURE : ISENTERPROCEDURE,
				CONTRACT_ID : CONTRACT_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("保存成功!!");
				window.location.reload();
			}
		});
	}

	function editDepositInfo(DEPOSITINFO_ID){
		var INVOICETIME = $("#it"+DEPOSITINFO_ID).val();
		var INVOICENAME = $("#in"+DEPOSITINFO_ID).val();
		var TRAINCOAMOUNT = $("#tc"+DEPOSITINFO_ID).val();
		var RETURNDEPOSIT = $("#rd"+DEPOSITINFO_ID).val();
		var WITHDRAWALTIME = $("#wt"+DEPOSITINFO_ID).val();
		var ENTERTIME = $("#et"+DEPOSITINFO_ID).val();
		var DEPOSITPAYER = $("#dp"+DEPOSITINFO_ID).val();
		var REALITYTIME = $("#rt"+DEPOSITINFO_ID).val();
		var REALITY = $("#r"+DEPOSITINFO_ID).val();
		var DWDEPOSITTIME = $("#ddt"+DEPOSITINFO_ID).val();
		var DWDEPOSIT = $("#dd"+DEPOSITINFO_ID).val();
		var ISDRAWALPROCEDURE = $("input[name='form-field-radio"+DEPOSITINFO_ID+"']:checked").val();
		var ISENTERPROCEDURE = $("input[name='field-radio"+DEPOSITINFO_ID+"']:checked").val();
		$.ajax({
			type: "POST",
			url: '<%=basePath%>depositinfo/editInfo',
			async: false,
			data: {
				TRAINCOAMOUNT : TRAINCOAMOUNT,
				RETURNDEPOSIT : RETURNDEPOSIT,
				WITHDRAWALTIME : WITHDRAWALTIME,
				ENTERTIME : ENTERTIME,
				DEPOSITPAYER : DEPOSITPAYER,
				REALITYTIME : REALITYTIME,
				REALITY : REALITY,
				DWDEPOSITTIME : DWDEPOSITTIME,
				DWDEPOSIT : DWDEPOSIT,
				ISDRAWALPROCEDURE : ISDRAWALPROCEDURE,
				ISENTERPROCEDURE : ISENTERPROCEDURE,
				DEPOSITINFO_ID : DEPOSITINFO_ID,
				INVOICENAME : INVOICENAME,
				INVOICETIME : INVOICETIME
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("修改成功!!");
			}
		});
	}

	function delDepositInfo(DEPOSITINFO_ID){
		var con = confirm("是否删除该押金项?"); //在页面上弹出对话框
		if(con == true){
			//alert("是");
		}
		else {
			// alert("否");
			return;
		}
		$.ajax({
			type: "POST",
			url: '<%=basePath%>depositinfo/delete',
			async: false,
			data: {
				DEPOSITINFO_ID : DEPOSITINFO_ID
			},
			dataType: 'json',
			//beforeSend: validateData,
			cache: false,
			success: function (data) {
				//uuid = data.uuid;
				alert("删除成功!!");
			}
		});
		$("#tb"+DEPOSITINFO_ID).css("display","none");
	}

	
	$(function () {
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
			$("#proceedsContract").css("display","none");
			$("#znj").css("display","none");
			$("#znjip").css("display","none");
			$("#iswe2").css("display","none");
			$("#iswe1").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"){
			$("#proceedsContract").css("display","");
			$("#paymentContarct").css("display","none");
			$("#znj").css("display","");
			$("#znjip").css("display","");
			$("#iswe2").css("display","");
			$("#iswe1").css("display","");
		}
		var FNAME = $("#CONTRACTCLASSIFY").find("option:selected").attr("name");
		if (FNAME == "大型体育赛事场地租赁" || FNAME == "文艺演出场地租赁"){
			$("#INVITATIONTICKET").removeAttr("readonly");
		}else {
			$("#INVITATIONTICKET").attr("readonly","readonly");
		}
	})

	$("#DEPTNO").change(function(){
		var DEPTNO = $("#DEPTNO").find("option:selected").attr("name");
		var DEPTNAME = $("#DEPTNO").find("option:selected").attr("id");
		$("#DEPTNAME").val(DEPTNAME);
		//alert($("#DEPTNO").find("option:selected").attr("id"));
		var date = new Date();
		//alert(date.getFullYear());
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				DEPTNO : DEPTNO,
				DEPTNAME : DEPTNAME
			},
			//dataType:"String",
			url: '<%=basePath%>contract/findMaxNo',
			success: function (data) {
				$("#CONTRACTNUM").val(DEPTNO+"-"+date.getFullYear()+"-"+data.maxNo);
			},
			error: function () {
				alert("请求失败");
			}
		});
		/*if (FNAME == "大型体育赛事场地租赁" || FNAME == "文艺演出场地租赁"){
			$("#INVITATIONTICKET").removeAttr("readonly");
		}else {
			$("#INVITATIONTICKET").attr("readonly","readonly");
		}*/
	})

	$("#CONTRACTCLASSIFY").change(function(){
		var FNAME = $("#CONTRACTCLASSIFY").find("option:selected").attr("name");
		if (FNAME == "大型体育赛事场地租赁" || FNAME == "文艺演出场地租赁"){
			$("#INVITATIONTICKET").removeAttr("readonly");
		}else {
			$("#INVITATIONTICKET").attr("readonly","readonly");
		}
	})

	$("#CONTRACTTYPES").change(function(){
		var FPARENTID = $("#CONTRACTTYPES").find("option:selected").attr("name");
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
			$("#proceedsContract").css("display","none");
			$("#znj").css("display","none");
			$("#znjip").css("display","none");
			$("#iswe2").css("display","none");
			$("#iswe1").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"){
			$("#proceedsContract").css("display","");
			$("#paymentContarct").css("display","none");
			$("#znj").css("display","");
			$("#znjip").css("display","");
			$("#iswe2").css("display","");
			$("#iswe1").css("display","");
		}
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				FPARENTID : FPARENTID
			},
			url: '<%=basePath%>contract/listCheClassify',
			success: function (data) {
				var listCheClassify = data.listCheClassify;
				var option = "";
				$("#CONTRACTCLASSIFY").find("option").remove();
				for(var i=0;i < listCheClassify.length;i++){
					option += "<option id="+listCheClassify[i].FITEMID+" value="+listCheClassify[i].FNAME+
							" name="+listCheClassify[i].FNAME+">"+listCheClassify[i].FNAME+"</option>";
				}
				$("#CONTRACTCLASSIFY").append(option);
			},
			error: function () {
				alert("请求失败");
			}
		});
	});
	
	$("#TAXITEMS").change(function(){
		var coe = $("#TAXITEMS").find("option:selected").attr("name");
		var CONTRACTPIC = $("#CONTRACTPIC").val();
		if (CONTRACTPIC !=null || CONTRACTPIC != ""){
			$("#STAMPDUTY").val((CONTRACTPIC * coe).toFixed(2));
		}
	});
	function changeStampduty() {
		var coe = $("#TAXITEMS").find("option:selected").attr("name");
		var CONTRACTPIC = $("#CONTRACTPIC").val();
		if (CONTRACTPIC !=null || CONTRACTPIC != ""){
			$("#STAMPDUTY").val((CONTRACTPIC * coe).toFixed(2));
		}
	}

	function isENTERPROCEDURE(value) {
		$("#ISENTERPROCEDURE").val(value);
	}


	function isPAY(value) {
		$("#ISPAY").val(value);
	}

	function isDRAWALPROCEDURE(value) {
		$("#ISDRAWALPROCEDURE").val(value);
	}

	function isSTAMPDUTY(num){
		$("#ISSTAMPDUTY").val(num);
		if( num == "1"){
			$("#DEPOSIT").removeAttr("readonly");
		}else{
			$("#DEPOSIT").attr("readonly","readonly");
		}

	}


	function selectPic(CONTRACT_ID){
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="新增";
		diag.URL = '<%=basePath%>contract/goAddPic.do?CONTRACT_ID='+CONTRACT_ID;
		diag.Width = 800;
		diag.Height = 490;
		diag.CancelEvent = function(){ //关闭事件

			diag.close();
			//tosearch();
		};
		diag.show();
	}

	//修改
	function edit(Id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag=true;
		diag.Title ="编辑";
		diag.URL = '<%=basePath%>contract/goEdit.do?CONTRACT_ID='+Id;
		diag.Width =  window.innerWidth*0.7;
		diag.Height = window.innerHeight*0.7;
		diag.Modal = true;				//有无遮罩窗口
		diag. ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function(){ //关闭事件
			tosearch();
			diag.close();
		};
		diag.show();
	}

	function qx(){
		if(addCount > 0){
			var con = confirm("还有新增项目未保存，是否放弃保存?"); //在页面上弹出对话框
			if(con == true){
				//alert("是");
			}
			else {
				// alert("否");
				return;
			}
		}
		top.Dialog.close();
	}

	function save(){
		if(addCount > 0){
			var con = confirm("还有新增项目未保存，是否放弃保存?"); //在页面上弹出对话框
			if(con == true){
				//alert("是");
			}
			else {
				// alert("否");
				return;
			}
		}
		if($("#CONTRACTNAME").val()==""){
			$("#CONTRACTNAME").tips({
				side:3,
				msg:'请输入合同名称',
				bg:'#AE81FF',
				time:2
			});
			$("#CONTRACTNAME").focus();
			return false;
		}
		if($("#CONTRACTNUM").val()==""){
			$("#CONTRACTNUM").tips({
				side:3,
				msg:'请输入合同编号',
				bg:'#AE81FF',
				time:2
			});
			$("#CONTRACTNUM").focus();
			return false;
		}
		if($("#CONTRACTPIC").val()==""){
			$("#CONTRACTPIC").tips({
				side:3,
				msg:'请输入合同金额',
				bg:'#AE81FF',
				time:2
			});
			$("#CONTRACTPIC").focus();
			return false;
		}
		if($("#CONTRACTOFNAME").val()==""){
			$("#CONTRACTOFNAME").tips({
				side:3,
				msg:'请输入签约方',
				bg:'#AE81FF',
				time:2
			});
			$("#CONTRACTOFNAME").focus();
			return false;
		}
		if($("#FUSEDATE").val()==""){
			$("#FUSEDATE").tips({
				side:3,
				msg:'请输入合同签订使用时间',
				bg:'#AE81FF',
				time:2
			});
			$("#FUSEDATE").focus();
			return false;
		}
		if($("#PROJECT").val()==""){
			$("#PROJECT").tips({
				side:3,
				msg:'请输入项目',
				bg:'#AE81FF',
				time:2
			});
			$("#PROJECT").focus();
			return false;
		}
		if($("#FDATE").val()==""){
			$("#FDATE").tips({
				side:3,
				msg:'请输入签约时间',
				bg:'#AE81FF',
				time:2
			});
			$("#FDATE").focus();
			return false;
		}
		if($("#TAXITEMS").val()==""){
			$("#TAXITEMS").tips({
				side:3,
				msg:'请输入税目',
				bg:'#AE81FF',
				time:2
			});
			$("#TAXITEMS").focus();
			return false;
		}
		if($("#MODE").val()==""){
			$("#MODE").tips({
				side:3,
				msg:'请输入方式',
				bg:'#AE81FF',
				time:2
			});
			$("#MODE").focus();
			return false;
		}
		if($("#OPERATOR").val()==""){
			$("#OPERATOR").tips({
				side:3,
				msg:'请输入经办人',
				bg:'#AE81FF',
				time:2
			});
			$("#OPERATOR").focus();
			return false;
		}
		if($("#CONTRACTTYPES").val()==""){
			$("#CONTRACTTYPES").tips({
				side:3,
				msg:'请输入合同类型',
				bg:'#AE81FF',
				time:2
			});
			$("#CONTRACTTYPES").focus();
			return false;
		}
		if($("#TAXITEMS").val()==""){
			$("#TAXITEMS").tips({
				side:3,
				msg:'请输入税目',
				bg:'#AE81FF',
				time:2
			});
			$("#TAXITEMS").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

	function show_contract(CONTRACT_ID){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = "查阅合同信息";
		diag.URL = '<%=basePath%>contract/toShowContrct.do?CONTRACT_ID=' + CONTRACT_ID;
		diag.Width = window.innerWidth * 1.2;
		diag.Height = window.innerHeight * 1.2;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function () { //关闭事件
			//tosearch();
			diag.close();
		};
		diag.show();
	}
</script>


</body>
</html>