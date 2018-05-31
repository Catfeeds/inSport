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
					
					<form action="officecontract/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="OFFICECONTRACT_ID" id="OFFICECONTRACT_ID" value="${pd.OFFICECONTRACT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">负责人1:</td>
								<td><input type="text" name="PRINCIPAL_O" id="PRINCIPAL_O" value="${pd.PRINCIPAL_O}" maxlength="255" placeholder="这里输入负责人1" title="负责人1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收金额1:</td>
								<td><input type="number" name="RECEIVABLE_O" id="RECEIVABLE_O" value="${pd.RECEIVABLE_O}" maxlength="32" placeholder="这里输入应收金额1" title="应收金额1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方名称:</td>
								<td><input type="text" name="PAYERNAME_O" id="PAYERNAME_O" value="${pd.PAYERNAME_O}" maxlength="255" placeholder="这里输入付款方名称" title="付款方名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付款时间:</td>
								<td><input class="span10 date-picker" name="PAYTIME_O" id="PAYTIME_O" value="${pd.PAYTIME_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应付款时间" title="应付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否收款:</td>
								<td><input type="number" name="ISPAY_O" id="ISPAY_O" value="${pd.ISPAY_O}" maxlength="32" placeholder="这里输入是否收款" title="是否收款" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额:</td>
								<td><input type="number" name="RECEIVABLE_REALITY_O" id="RECEIVABLE_REALITY_O" value="${pd.RECEIVABLE_REALITY_O}" maxlength="32" placeholder="这里输入实际付款金额" title="实际付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票名称:</td>
								<td><input type="text" name="INVOICENAME_O" id="INVOICENAME_O" value="${pd.INVOICENAME_O}" maxlength="255" placeholder="这里输入发票名称" title="发票名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开票时间:</td>
								<td><input class="span10 date-picker" name="INVOICETIME_O" id="INVOICETIME_O" value="${pd.INVOICETIME_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开票时间" title="开票时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收押金:</td>
								<td><input type="number" name="RECEIVABLECASH_O" id="RECEIVABLECASH_O" value="${pd.RECEIVABLECASH_O}" maxlength="32" placeholder="这里输入应收押金" title="应收押金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方（押金）:</td>
								<td><input type="number" name="PAYERNAME2_O" id="PAYERNAME2_O" value="${pd.PAYERNAME2_O}" maxlength="32" placeholder="这里输入付款方（押金）" title="付款方（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款时间（押金）:</td>
								<td><input class="span10 date-picker" name="PAYTIME2_O" id="PAYTIME2_O" value="${pd.PAYTIME2_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="付款时间（押金）" title="付款时间（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额（押金）:</td>
								<td><input type="number" name="RECEIVABLE_REALITY2_O" id="RECEIVABLE_REALITY2_O" value="${pd.RECEIVABLE_REALITY2_O}" maxlength="32" placeholder="这里输入实际付款金额（押金）" title="实际付款金额（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME_O" id="RECEIVABL_PAYTIME_O" value="${pd.RECEIVABL_PAYTIME_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间" title="实际付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间（押金）:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME2_O" id="RECEIVABL_PAYTIME2_O" value="${pd.RECEIVABL_PAYTIME2_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间（押金）" title="实际付款时间（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">进场时间:</td>
								<td><input class="span10 date-picker" name="ENTERTIME_O" id="ENTERTIME_O" value="${pd.ENTERTIME_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="进场时间" title="进场时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办进场手续:</td>
								<td><input type="number" name="ISENTERPROCEDURE_O" id="ISENTERPROCEDURE_O" value="${pd.ISENTERPROCEDURE_O}" maxlength="32" placeholder="这里输入是否已办进场手续" title="是否已办进场手续" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">撤场时间:</td>
								<td><input class="span10 date-picker" name="WITHDRAWALTIME_O" id="WITHDRAWALTIME_O" value="${pd.WITHDRAWALTIME_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="撤场时间" title="撤场时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办撤场手续:</td>
								<td><input type="number" name="ISDRAWALPROCEDURE_O" id="ISDRAWALPROCEDURE_O" value="${pd.ISDRAWALPROCEDURE_O}" maxlength="32" placeholder="这里输入是否已办撤场手续" title="是否已办撤场手续" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">退押金金额:</td>
								<td><input type="number" name="RETURNCASH_O" id="RETURNCASH_O" value="${pd.RETURNCASH_O}" maxlength="32" placeholder="这里输入退押金金额" title="退押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">结转收入金额:</td>
								<td><input type="number" name="TRAINCOAMOUNT_O" id="TRAINCOAMOUNT_O" value="${pd.TRAINCOAMOUNT_O}" maxlength="32" placeholder="这里输入结转收入金额" title="结转收入金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票名称:</td>
								<td><input type="text" name="INVOICENAME2_O" id="INVOICENAME2_O" value="${pd.INVOICENAME2_O}" maxlength="255" placeholder="这里输入发票名称" title="发票名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开票时间:</td>
								<td><input class="span10 date-picker" name="INVOICETIME2_O" id="INVOICETIME2_O" value="${pd.INVOICETIME2_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开票时间" title="开票时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同主id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="255" placeholder="这里输入合同主id" title="合同主id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收押金金额1:</td>
								<td><input type="number" name="RECEIVABLECASH1_O" id="RECEIVABLECASH1_O" value="${pd.RECEIVABLECASH1_O}" maxlength="32" placeholder="这里输入应收押金金额1" title="应收押金金额1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付款时间（押金）1:</td>
								<td><input class="span10 date-picker" name="PAYTIME3_O" id="PAYTIME3_O" value="${pd.PAYTIME3_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应付款时间（押金）1" title="应付款时间（押金）1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额（押金）1:</td>
								<td><input type="number" name="RECEIVABLE_REALITY3_O" id="RECEIVABLE_REALITY3_O" value="${pd.RECEIVABLE_REALITY3_O}" maxlength="32" placeholder="这里输入实际付款金额（押金）1" title="实际付款金额（押金）1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间（押金）1:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME3_O" id="RECEIVABL_PAYTIME3_O" value="${pd.RECEIVABL_PAYTIME3_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间（押金）1" title="实际付款时间（押金）1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方名称（押金）1:</td>
								<td><input type="text" name="PAYERNAME3_O" id="PAYERNAME3_O" value="${pd.PAYERNAME3_O}" maxlength="255" placeholder="这里输入付款方名称（押金）1" title="付款方名称（押金）1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">进场时间1:</td>
								<td><input class="span10 date-picker" name="ENTERTIME1_O" id="ENTERTIME1_O" value="${pd.ENTERTIME1_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="进场时间1" title="进场时间1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办理进场手续1:</td>
								<td><input type="number" name="ISENTERPROCEDURE1_O" id="ISENTERPROCEDURE1_O" value="${pd.ISENTERPROCEDURE1_O}" maxlength="32" placeholder="这里输入是否已办理进场手续1" title="是否已办理进场手续1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">撤场时间1:</td>
								<td><input class="span10 date-picker" name="WITHDRAWALTIME1_O" id="WITHDRAWALTIME1_O" value="${pd.WITHDRAWALTIME1_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="撤场时间1" title="撤场时间1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办理撤场手续:</td>
								<td><input type="number" name="ISDRAWALPROCEDURE1_O" id="ISDRAWALPROCEDURE1_O" value="${pd.ISDRAWALPROCEDURE1_O}" maxlength="32" placeholder="这里输入是否已办理撤场手续" title="是否已办理撤场手续" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">滞纳金率:</td>
								<td><input type="text" name="OVERDUE_O" id="OVERDUE_O" value="${pd.OVERDUE_O}" maxlength="255" placeholder="这里输入滞纳金率" title="滞纳金率" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="REMARK_O" id="REMARK_O" value="${pd.REMARK_O}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">退押金金额:</td>
								<td><input type="number" name="RETURNCASH1_O" id="RETURNCASH1_O" value="${pd.RETURNCASH1_O}" maxlength="32" placeholder="这里输入退押金金额" title="退押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">结转收入金额:</td>
								<td><input type="number" name="TRAINCOAMOUNT1_O" id="TRAINCOAMOUNT1_O" value="${pd.TRAINCOAMOUNT1_O}" maxlength="32" placeholder="这里输入结转收入金额" title="结转收入金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票名称:</td>
								<td><input type="text" name="INVOICENAME3_O" id="INVOICENAME3_O" value="${pd.INVOICENAME3_O}" maxlength="255" placeholder="这里输入发票名称" title="发票名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开票时间:</td>
								<td><input class="span10 date-picker" name="INVOICETIME3_O" id="INVOICETIME3_O" value="${pd.INVOICETIME3_O}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开票时间" title="开票时间" style="width:98%;"/></td>
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
			if($("#PRINCIPAL_O").val()==""){
				$("#PRINCIPAL_O").tips({
					side:3,
		            msg:'请输入负责人1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRINCIPAL_O").focus();
			return false;
			}
			if($("#RECEIVABLE_O").val()==""){
				$("#RECEIVABLE_O").tips({
					side:3,
		            msg:'请输入应收金额1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_O").focus();
			return false;
			}
			if($("#PAYERNAME_O").val()==""){
				$("#PAYERNAME_O").tips({
					side:3,
		            msg:'请输入付款方名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME_O").focus();
			return false;
			}
			if($("#PAYTIME_O").val()==""){
				$("#PAYTIME_O").tips({
					side:3,
		            msg:'请输入应付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME_O").focus();
			return false;
			}
			if($("#ISPAY_O").val()==""){
				$("#ISPAY_O").tips({
					side:3,
		            msg:'请输入是否收款',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISPAY_O").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY_O").val()==""){
				$("#RECEIVABLE_REALITY_O").tips({
					side:3,
		            msg:'请输入实际付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY_O").focus();
			return false;
			}
			if($("#INVOICENAME_O").val()==""){
				$("#INVOICENAME_O").tips({
					side:3,
		            msg:'请输入发票名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENAME_O").focus();
			return false;
			}
			if($("#INVOICETIME_O").val()==""){
				$("#INVOICETIME_O").tips({
					side:3,
		            msg:'请输入开票时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICETIME_O").focus();
			return false;
			}
			if($("#RECEIVABLECASH_O").val()==""){
				$("#RECEIVABLECASH_O").tips({
					side:3,
		            msg:'请输入应收押金',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLECASH_O").focus();
			return false;
			}
			if($("#PAYERNAME2_O").val()==""){
				$("#PAYERNAME2_O").tips({
					side:3,
		            msg:'请输入付款方（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME2_O").focus();
			return false;
			}
			if($("#PAYTIME2_O").val()==""){
				$("#PAYTIME2_O").tips({
					side:3,
		            msg:'请输入付款时间（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME2_O").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY2_O").val()==""){
				$("#RECEIVABLE_REALITY2_O").tips({
					side:3,
		            msg:'请输入实际付款金额（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY2_O").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME_O").val()==""){
				$("#RECEIVABL_PAYTIME_O").tips({
					side:3,
		            msg:'请输入实际付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME_O").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME2_O").val()==""){
				$("#RECEIVABL_PAYTIME2_O").tips({
					side:3,
		            msg:'请输入实际付款时间（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME2_O").focus();
			return false;
			}
			if($("#ENTERTIME_O").val()==""){
				$("#ENTERTIME_O").tips({
					side:3,
		            msg:'请输入进场时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ENTERTIME_O").focus();
			return false;
			}
			if($("#ISENTERPROCEDURE_O").val()==""){
				$("#ISENTERPROCEDURE_O").tips({
					side:3,
		            msg:'请输入是否已办进场手续',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISENTERPROCEDURE_O").focus();
			return false;
			}
			if($("#WITHDRAWALTIME_O").val()==""){
				$("#WITHDRAWALTIME_O").tips({
					side:3,
		            msg:'请输入撤场时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WITHDRAWALTIME_O").focus();
			return false;
			}
			if($("#ISDRAWALPROCEDURE_O").val()==""){
				$("#ISDRAWALPROCEDURE_O").tips({
					side:3,
		            msg:'请输入是否已办撤场手续',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISDRAWALPROCEDURE_O").focus();
			return false;
			}
			if($("#RETURNCASH_O").val()==""){
				$("#RETURNCASH_O").tips({
					side:3,
		            msg:'请输入退押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RETURNCASH_O").focus();
			return false;
			}
			if($("#TRAINCOAMOUNT_O").val()==""){
				$("#TRAINCOAMOUNT_O").tips({
					side:3,
		            msg:'请输入结转收入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TRAINCOAMOUNT_O").focus();
			return false;
			}
			if($("#INVOICENAME2_O").val()==""){
				$("#INVOICENAME2_O").tips({
					side:3,
		            msg:'请输入发票名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENAME2_O").focus();
			return false;
			}
			if($("#INVOICETIME2_O").val()==""){
				$("#INVOICETIME2_O").tips({
					side:3,
		            msg:'请输入开票时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICETIME2_O").focus();
			return false;
			}
			if($("#CONTRACT_ID").val()==""){
				$("#CONTRACT_ID").tips({
					side:3,
		            msg:'请输入合同主id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACT_ID").focus();
			return false;
			}
			if($("#RECEIVABLECASH1_O").val()==""){
				$("#RECEIVABLECASH1_O").tips({
					side:3,
		            msg:'请输入应收押金金额1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLECASH1_O").focus();
			return false;
			}
			if($("#PAYTIME3_O").val()==""){
				$("#PAYTIME3_O").tips({
					side:3,
		            msg:'请输入应付款时间（押金）1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME3_O").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY3_O").val()==""){
				$("#RECEIVABLE_REALITY3_O").tips({
					side:3,
		            msg:'请输入实际付款金额（押金）1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY3_O").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME3_O").val()==""){
				$("#RECEIVABL_PAYTIME3_O").tips({
					side:3,
		            msg:'请输入实际付款时间（押金）1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME3_O").focus();
			return false;
			}
			if($("#PAYERNAME3_O").val()==""){
				$("#PAYERNAME3_O").tips({
					side:3,
		            msg:'请输入付款方名称（押金）1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME3_O").focus();
			return false;
			}
			if($("#ENTERTIME1_O").val()==""){
				$("#ENTERTIME1_O").tips({
					side:3,
		            msg:'请输入进场时间1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ENTERTIME1_O").focus();
			return false;
			}
			if($("#ISENTERPROCEDURE1_O").val()==""){
				$("#ISENTERPROCEDURE1_O").tips({
					side:3,
		            msg:'请输入是否已办理进场手续1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISENTERPROCEDURE1_O").focus();
			return false;
			}
			if($("#WITHDRAWALTIME1_O").val()==""){
				$("#WITHDRAWALTIME1_O").tips({
					side:3,
		            msg:'请输入撤场时间1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WITHDRAWALTIME1_O").focus();
			return false;
			}
			if($("#ISDRAWALPROCEDURE1_O").val()==""){
				$("#ISDRAWALPROCEDURE1_O").tips({
					side:3,
		            msg:'请输入是否已办理撤场手续',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISDRAWALPROCEDURE1_O").focus();
			return false;
			}
			if($("#OVERDUE_O").val()==""){
				$("#OVERDUE_O").tips({
					side:3,
		            msg:'请输入滞纳金率',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OVERDUE_O").focus();
			return false;
			}
			if($("#REMARK_O").val()==""){
				$("#REMARK_O").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REMARK_O").focus();
			return false;
			}
			if($("#RETURNCASH1_O").val()==""){
				$("#RETURNCASH1_O").tips({
					side:3,
		            msg:'请输入退押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RETURNCASH1_O").focus();
			return false;
			}
			if($("#TRAINCOAMOUNT1_O").val()==""){
				$("#TRAINCOAMOUNT1_O").tips({
					side:3,
		            msg:'请输入结转收入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TRAINCOAMOUNT1_O").focus();
			return false;
			}
			if($("#INVOICENAME3_O").val()==""){
				$("#INVOICENAME3_O").tips({
					side:3,
		            msg:'请输入发票名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENAME3_O").focus();
			return false;
			}
			if($("#INVOICETIME3_O").val()==""){
				$("#INVOICETIME3_O").tips({
					side:3,
		            msg:'请输入开票时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICETIME3_O").focus();
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