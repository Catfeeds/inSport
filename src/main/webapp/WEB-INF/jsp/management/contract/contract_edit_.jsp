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
					<a class="btn btn-primary  btn-xs" onclick="top.Dialog.close();">
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
							<input type="hidden" name="ISENTERPROCEDURE" id="ISENTERPROCEDURE" value="${pd2.ISENTERPROCEDURE}"/>
							<input type="hidden" name="ISDRAWALPROCEDURE1_O" id="ISDRAWALPROCEDURE1_O" value="${pd3.ISDRAWALPROCEDURE1_O}"/>
							<input type="hidden" name="ISENTERPROCEDURE1_O" id="ISENTERPROCEDURE1_O" value="${pd3.ISENTERPROCEDURE_O}"/>
							<input type="hidden" name="OFFICECONTRACT_ID" id="OFFICECONTRACT_ID" value="${pd3.OFFICECONTRACT_ID}"/>
							<input type="hidden" name="ISENTERPROCEDURE_O" id="ISENTERPROCEDURE_O" value="${pd3.ISENTERPROCEDURE_O}"/>
							<input type="hidden" name="ISDRAWALPROCEDURE_O" id="ISDRAWALPROCEDURE_O" value="${pd3.ISDRAWALPROCEDURE_O}"/>
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
									<th ><input type="text" style="width: 150px" value="${pd.CONTRACTOFNAME}"
												class="input-text"  name="CONTRACTOFNAME"
												id="CONTRACTOFNAME"></th>
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
									<th ><input type="text" style="width: 150px" value="${pd.CLIENT}"
												class="input-text"  name="CLIENT"
												id="CLIENT"></th>
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
										<select name="STAMPDUTYMONTH" id="STAMPDUTYMONTH" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.STAMPDUTYMONTH}" name="${pd.STAMPDUTYMONTH}">${pd.STAMPDUTYMONTH}</option>
											<c:forEach items="${listmonth}" var="var" varStatus="vs">
												<option id="${var}" value="${var}" name="${var}">${var}</option>
											</c:forEach>
										</select>
										<%--<input type="text" style="width: 150px" value="${pd.STAMPDUTYMONTH}"
														   class="input-text"  name="STAMPDUTYMONTH"
														   id="STAMPDUTYMONTH">--%>
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
									</th>
									<th  ><label></label></th>
									<th  ></th>
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
								<tr class="success">
									<%--<th width="15%"><label>项目负责人：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd2.PRINCIPAL}"
														   class="input-text"  name="PRINCIPAL"
														   id="PRINCIPAL"></th>--%>
									<th width="15%"><label>应收金额：</label></th>
									<th width="10%"><input type="number" style="width: 150px" value="${pd2.RECEIVABLE}"
														   class="input-text"  name="RECEIVABLE"
														   id="RECEIVABLE"></th>
									<th ><label>应付款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${pd2.PAYTIME}"
												class="input-text"  name="PAYTIME"
												id="PAYTIME"></th>
									<th  ><label></label></th>
									<th  ></th>

								</tr>
								<tr class="success">
									<th width="15%"><label>实际付款金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd2.RECEIVABLE_REALITY}"
														   class="input-text"  name="RECEIVABLE_REALITY"
														   id="RECEIVABLE_REALITY"></th>
									<th ><label>实际付款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${pd2.RECEIVABL_PAYTIME}"
												class="input-text"  name="RECEIVABL_PAYTIME"
												id="RECEIVABL_PAYTIME"></th>
									<th width="15%"><label>付款方名称：</label></th>
									<th width="20%"><input type="text" style="width: 150px" value="${pd2.PAYERNAME}"
														   class="input-text"  name="PAYERNAME"
														   id="PAYERNAME"></th>

									<%--<th  ><label>是否收款：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio1" id="form-field-radio3" onclick="isPAY('1');" <c:if test="${pd2.ISPAY == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio1" id="form-field-radio4" onclick="isPAY('0');" <c:if test="${pd2.ISPAY == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>--%>

								</tr>
								<tr class="success">

									<th ><label>发票名称：</label></th>
									<th  ><input type="text" style="width: 150px;height: 31px" value="${pd2.INVOICENAME}"
												 class="input-text"  name="INVOICENAME"
												 id="INVOICENAME"></th>
									<th  ><label>开票时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd2.INVOICETIME}"
												 class="input-text"  name="INVOICETIME"
												 id="INVOICETIME"></th>
									<th  ><label></label></th>
									<th  ></th>

								</tr>
								<tr class="danger">
									<th width="10%" ><label>应收押金金额：</label></th>
									<th  ><input type="number" style="width: 150px" value="${pd2.RECEIVABLECASH}"
												 class="input-text"  name="RECEIVABLECASH"
												 id="RECEIVABLECASH"></th>
									<th width="15%"><label>应付款时间（押金）：</label></th>
									<th width="10%"><input type="date" style="width: 150px" value="${pd2.PAYTIME2}"
														   class="input-text"  name="PAYTIME2"
														   id="PAYTIME2"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="danger">
									<th width="15%"><label>实际付款金额（押金）：</label></th>
									<th width="10%">
										<input type="number" style="width: 150px" value="${pd2.RECEIVABLE_REALITY2}"
											   class="input-text"  name="RECEIVABLE_REALITY2"
											   id="RECEIVABLE_REALITY2">
									</th>
									<th  ><label>实际付款时间（押金）：</label></th>
									<th  ><input type="date" style="width: 150px" value="${pd2.RECEIVABL_PAYTIME2}"
												 class="input-text"  name="RECEIVABL_PAYTIME2"
												 id="RECEIVABL_PAYTIME2"></th>
									<th width="15%"><label>付款方名称（押金）：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd2.PAYERNAME2}"
														   class="input-text"  name="PAYERNAME2"
														   id="PAYERNAME2"></th>
								</tr>
								<tr class="warning">
									<th ><label>进场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd2.ENTERTIME}"
												   class="input-date"  name="ENTERTIME"
												   id="ENTERTIME">
										</label>
									</th>
									<th ><label>是否已办进场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio2" id="form-field-radio5" onclick="isENTERPROCEDURE('1');" <c:if test="${pd2.ISENTERPROCEDURE == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio2" id="form-field-radio6" onclick="isENTERPROCEDURE('0');" <c:if test="${pd2.ISENTERPROCEDURE == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th  ><label>撤场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd2.WITHDRAWALTIME}"
												   class="input-date"  name="WITHDRAWALTIME"
												   id="WITHDRAWALTIME">
										</label>
									</th>
									<th ><label>是否已办撤场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio3" id="form-field-radio7" onclick="isDRAWALPROCEDURE('1');" <c:if test="${pd2.ISDRAWALPROCEDURE == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio3" id="form-field-radio8" onclick="isDRAWALPROCEDURE('0');" <c:if test="${pd2.ISDRAWALPROCEDURE == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th ><label>退押金金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd2.RETURNCASH}"
												   class="input-date"  name="RETURNCASH"
												   id="RETURNCASH">
										</label>
									</th>
									<th  ><label>结转收入金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd2.TRAINCOAMOUNT}"
												   class="input-date"  name="TRAINCOAMOUNT"
												   id="TRAINCOAMOUNT">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th ><label>发票名称：</label></th>
									<th >
										<label>
											<input type="text" style="width: 140px;height: 31px" value="${pd2.INVOICENAME2}"
												   class="input-date"  name="INVOICENAME2"
												   id="INVOICENAME2">
										</label>
									</th>
									<th ><label>开票时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd2.INVOICETIME2}"
												   class="input-date"  name="INVOICETIME2"
												   id="INVOICETIME2">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
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
							<!-- --------------------------------------------------------------------------- -->
							<table id="paymentContarct" style="display: none" class="table table-border table-bg table-bordered">
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
							</table>
							<!-- --------------------------------------------------------------------------- -->
							<table id="officeContract" style="display: none;" class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="success">
									<%--<th width="15%"><label>项目负责人：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd3.PRINCIPAL}"
														   class="input-text"  name="PRINCIPAL"
														   id="PRINCIPAL"></th>--%>
									<th width="15%"><label>应收金额：</label></th>
									<th width="10%"><input type="number" style="width: 150px" value="${pd3.RECEIVABLE_O}"
														   class="input-text"  name="RECEIVABLE_O"
														   id="RECEIVABLE_O"></th>
									<th ><label>应付款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${pd3.PAYTIME_O}"
												class="input-text"  name="PAYTIME_O"
												id="PAYTIME_O"></th>
									<th  ><label></label></th>
									<th  ></th>

								</tr>
								<tr class="success">
									<th width="15%"><label>实际付款金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd3.RECEIVABLE_REALITY_O}"
														   class="input-text"  name="RECEIVABLE_REALITY_O"
														   id="RECEIVABLE_REALITY_O"></th>
									<th ><label>实际付款时间：</label></th>
									<th ><input type="date" style="width: 150px;height: 31px" value="${pd3.RECEIVABL_PAYTIME_O}"
												class="input-text"  name="RECEIVABL_PAYTIME_O"
												id="RECEIVABL_PAYTIME_O"></th>
									<th width="15%"><label>付款方名称：</label></th>
									<th width="20%"><input type="text" style="width: 150px" value="${pd3.PAYERNAME_O}"
														   class="input-text"  name="PAYERNAME_O"
														   id="PAYERNAME_O"></th>

									<%--<th  ><label>是否收款：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio1" id="form-field-radio3" onclick="isPAY('1');" <c:if test="${pd3.ISPAY == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio1" id="form-field-radio4" onclick="isPAY('0');" <c:if test="${pd3.ISPAY == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>--%>

								</tr>
								<tr class="success">

									<th ><label>发票名称：</label></th>
									<th  ><input type="text" style="width: 150px;height: 31px" value="${pd3.INVOICENAME_O}"
												 class="input-text"  name="INVOICENAME_O"
												 id="INVOICENAME_O"></th>
									<th  ><label>开票时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd3.INVOICETIME_O}"
												 class="input-text"  name="INVOICETIME_O"
												 id="INVOICETIME_O"></th>
									<th  ><label>滞纳金率：</label></th>
									<th  ><input type="number" style="width: 150px;height: 31px" value="${pd3.OVERDUE_O}"
												 class="input-text"  name="OVERDUE_O"
												 id="OVERDUE_O"></th>

								</tr>
								<tr class="danger">
									<th width="10%" ><label>应收押金金额：</label></th>
									<th  ><input type="number" style="width: 150px" value="${pd3.RECEIVABLECASH_O}"
												 class="input-text"  name="RECEIVABLECASH_O"
												 id="RECEIVABLECASH_O"></th>
									<th width="15%"><label>应付款时间（押金）：</label></th>
									<th width="10%"><input type="date" style="width: 150px;height: 31px" value="${pd3.PAYTIME2_O}"
														   class="input-text"  name="PAYTIME2_O"
														   id="PAYTIME2_O"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="danger">
									<th width="15%"><label>实际付款金额（押金）：</label></th>
									<th width="10%">
										<input type="number" style="width: 150px" value="${pd3.RECEIVABLE_REALITY2_O}"
											   class="input-text"  name="RECEIVABLE_REALITY2_O"
											   id="RECEIVABLE_REALITY2_O">
									</th>
									<th  ><label>实际付款时间（押金）：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd3.RECEIVABL_PAYTIME2_O}"
												 class="input-text"  name="RECEIVABL_PAYTIME2_O"
												 id="RECEIVABL_PAYTIME2_O"></th>
									<th width="15%"><label>付款方名称（押金）：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd3.PAYERNAME2_O}"
														   class="input-text"  name="PAYERNAME2_O"
														   id="PAYERNAME2_O"></th>
								</tr>
								<tr class="warning">
									<th ><label>进场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.ENTERTIME_O}"
												   class="input-date"  name="ENTERTIME_O"
												   id="ENTERTIME_O">
										</label>
									</th>
									<th ><label>是否已办进场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio4" id="form-field-radio5" onclick="isENTERPROCEDURE_O('1');" <c:if test="${pd3.ISENTERPROCEDURE_O == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio4" id="form-field-radio6" onclick="isENTERPROCEDURE_O('0');" <c:if test="${pd3.ISENTERPROCEDURE_O == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th  ><label>撤场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.WITHDRAWALTIME_O}"
												   class="input-date"  name="WITHDRAWALTIME_O"
												   id="WITHDRAWALTIME_O">
										</label>
									</th>
									<th ><label>是否已办撤场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio5" id="form-field-radio7"  onclick="isDRAWALPROCEDURE_O('1');" <c:if test="${pd3.ISDRAWALPROCEDURE_O == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio5" id="form-field-radio8" onclick="isDRAWALPROCEDURE_O('0');" <c:if test="${pd3.ISDRAWALPROCEDURE_O == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th ><label>退押金金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd3.RETURNCASH_O}"
												   class="input-date"  name="RETURNCASH_O"
												   id="RETURNCASH_O">
										</label>
									</th>
									<th  ><label>结转收入金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd3.TRAINCOAMOUNT_O}"
												   class="input-date"  name="TRAINCOAMOUNT_O"
												   id="TRAINCOAMOUNT_O">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th ><label>发票名称：</label></th>
									<th >
										<label>
											<input type="text" style="width: 140px;height: 31px" value="${pd3.INVOICENAME2_O}"
												   class="input-date"  name="INVOICENAME2_O"
												   id="INVOICENAME2_O">
										</label>
									</th>
									<th ><label>开票时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.INVOICETIME2_O}"
												   class="input-date"  name="INVOICETIME2_O"
												   id="INVOICETIME2_O">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>


								<!-- ------------------------------ 2 -->
								<tr class="danger">
									<th width="10%" ><label>应收押金金额：</label></th>
									<th  ><input type="number" style="width: 150px" value="${pd3.RECEIVABLECASH1_O}"
												 class="input-text"  name="RECEIVABLECASH1_O"
												 id="RECEIVABLECASH1_O"></th>
									<th width="15%"><label>应付款时间（押金）：</label></th>
									<th width="10%"><input type="date" style="width: 150px;height: 31px" value="${pd3.PAYTIME3_O}"
														   class="input-text"  name="PAYTIME3_O"
														   id="PAYTIME3_O"></th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="danger">
									<th width="15%"><label>实际付款金额（押金）：</label></th>
									<th width="10%">
										<input type="number" style="width: 150px" value="${pd3.RECEIVABLE_REALITY3_O}"
											   class="input-text"  name="RECEIVABLE_REALITY3_O"
											   id="RECEIVABLE_REALITY3_O">
									</th>
									<th  ><label>实际付款时间（押金）：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd3.RECEIVABL_PAYTIME3_O}"
												 class="input-text"  name="RECEIVABL_PAYTIME3_O"
												 id="RECEIVABL_PAYTIME3_O"></th>
									<th width="15%"><label>付款方名称（押金）：</label></th>
									<th width="10%"><input type="number" style="width: 150px" value="${pd3.PAYERNAME3_O}"
														   class="input-text"  name="PAYERNAME3_O"
														   id="PAYERNAME3_O"></th>
								</tr>
								<tr class="warning">
									<th ><label>退押金金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd3.RETURNCASH1_O}"
												   class="input-date"  name="RETURNCASH1_O"
												   id="RETURNCASH1_O">
										</label>
									</th>
									<th  ><label>结转收入金额：</label></th>
									<th >
										<label>
											<input type="number" style="width: 140px;height: 31px" value="${pd3.TRAINCOAMOUNT1_O}"
												   class="input-date"  name="TRAINCOAMOUNT1_O"
												   id="TRAINCOAMOUNT1_O">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>

								<tr class="warning">
									<th ><label>进场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.ENTERTIME1_O}"
												   class="input-date"  name="ENTERTIME1_O"
												   id="ENTERTIME1_O">
										</label>
									</th>
									<th ><label>是否已办进场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio6" id="form-field-radio9" onclick="isENTERPROCEDURE1_O('1');" <c:if test="${pd3.ISENTERPROCEDURE1_O == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio6" id="form-field-radio10" onclick="isENTERPROCEDURE1_O('0');" <c:if test="${pd3.ISENTERPROCEDURE1_O == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th  ><label>撤场时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.WITHDRAWALTIME1_O}"
												   class="input-date"  name="WITHDRAWALTIME1_O"
												   id="WITHDRAWALTIME1_O">
										</label>
									</th>
									<th ><label>是否已办撤场手续：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio7" id="form-field-radio11" onclick="isDRAWALPROCEDURE1_O('1');" <c:if test="${pd3.ISDRAWALPROCEDURE1_O == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio7" id="form-field-radio12" onclick="isDRAWALPROCEDURE1_O('0');" <c:if test="${pd3.ISDRAWALPROCEDURE1_O == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th ><label>发票名称：</label></th>
									<th >
										<label>
											<input type="text" style="width: 140px;height: 31px" value="${pd3.INVOICENAME3_O}"
												   class="input-date"  name="INVOICENAME3_O"
												   id="INVOICENAME3_O">
										</label>
									</th>
									<th ><label>开票时间：</label></th>
									<th >
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd3.INVOICETIME3_O}"
												   class="input-date"  name="INVOICETIME3_O"
												   id="INVOICETIME3_O">
										</label>
									</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<!-- ------------------------------  -->

								<tr class="info">
									<th ><label>备注：</label></th>
									<th colspan="5">
										<label>
											<input type="text" style="width: 880px;height: 31px" value="${pd3.REMARK_O}"
												   class="input-date"  name="REMARK_O"
												   id="REMARK_O">
										</label>
									</th>
								</tr>
								</tbody>
							</table>
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

	$(function () {
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
			$("#proceedsContract").css("display","none");
			$("#officeContract").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"
				&& $("#CONTRACTCLASSIFY").find("option:selected").attr("value") !="写字楼"){
			$("#proceedsContract").css("display","");
			$("#paymentContarct").css("display","none");
			$("#officeContract").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"
				&& $("#CONTRACTCLASSIFY").find("option:selected").attr("value") =="写字楼"){
			$("#proceedsContract").css("display","none");
			$("#paymentContarct").css("display","none");
			$("#officeContract").css("display","");
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
		if (FNAME == "写字楼" || FNAME == "写字楼"){
			$("#proceedsContract").css("display","none");
			$("#paymentContarct").css("display","none");
			$("#officeContract").css("display","");
		}else {
			$("#proceedsContract").css("display","");
			$("#officeContract").css("display","none");
			$("#paymentContarct").css("display","none");
		}
	})

	$("#CONTRACTTYPES").change(function(){
		var FPARENTID = $("#CONTRACTTYPES").find("option:selected").attr("name");
		//alert($("#CONTRACTTYPES").find("option:selected").attr("value"));
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
			$("#proceedsContract").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"){
			$("#proceedsContract").css("display","");
			$("#paymentContarct").css("display","none");
		}
		//paymentContarct
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				FPARENTID : FPARENTID
			},
			//dataType:"String",
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
		//alert($("#pselect").find("option:selected").attr("name"));
	});
	
	/*function selectType(value) {
		alert(value.id);
	}*/

	$("#TAXITEMS").change(function(){
		//var FNAME = $("#TAXITEMS").find("option:selected").text();
		var coe = $("#TAXITEMS").find("option:selected").attr("name");
		var CONTRACTPIC = $("#CONTRACTPIC").val();
		if (CONTRACTPIC !=null || CONTRACTPIC != ""){
			$("#STAMPDUTY").val((CONTRACTPIC * coe).toFixed(2));
		}
	});
	function changeStampduty() {
		//var FNAME = $("#TAXITEMS").find("option:selected").attr("name");
		var coe = $("#TAXITEMS").find("option:selected").attr("name");
		var CONTRACTPIC = $("#CONTRACTPIC").val();
		if (CONTRACTPIC !=null || CONTRACTPIC != ""){
			$("#STAMPDUTY").val((CONTRACTPIC * coe).toFixed(2));
		}
	}

	function isENTERPROCEDURE(value) {
		$("#ISENTERPROCEDURE").val(value);
	}

	function isDRAWALPROCEDURE_O(value){
		$("#ISDRAWALPROCEDURE_O").val(value);
	}

	function isENTERPROCEDURE1_O(value) {
		$("#ISENTERPROCEDURE1_O").val(value);
	}

	function isENTERPROCEDURE_O(value){
		$("#ISENTERPROCEDURE_O").val(value);
	}

	function isDRAWALPROCEDURE1_O(value){
		$("#ISDRAWALPROCEDURE1_O").val(value);
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

	function save(){

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
		/*if($("#DEPOSIT").attr("readonly") != "readonly"){
			if($("#DEPOSIT").val()==""){
				$("#DEPOSIT").tips({
					side:3,
					msg:'请输入押金',
					bg:'#AE81FF',
					time:2
				});
				$("#DEPOSIT").focus();
				return false;
			}
		}*/
		/*if($("#STAMPDUTY").val()==""){
			$("#STAMPDUTY").tips({
				side:3,
				msg:'请输入印花税',
				bg:'#AE81FF',
				time:2
			});
			$("#STAMPDUTY").focus();
			return false;
		}*/
		/*if($("#STAMPDUTYMONTH").val()==""){
			$("#STAMPDUTYMONTH").tips({
				side:3,
				msg:'请输入印花税计提月份',
				bg:'#AE81FF',
				time:2
			});
			$("#STAMPDUTYMONTH").focus();
			return false;
		}*/
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
		/*if($("#INVITATIONTICKET").val()==""){
			$("#INVITATIONTICKET").tips({
				side:3,
				msg:'请输入招待票',
				bg:'#AE81FF',
				time:2
			});
			$("#INVITATIONTICKET").focus();
			return false;
		}*/
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}


</script>


</body>
</html>