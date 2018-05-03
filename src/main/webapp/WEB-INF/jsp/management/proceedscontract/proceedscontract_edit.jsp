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
					
					<form action="proceedscontract/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="PROCEEDSCONTRACT_ID" id="PROCEEDSCONTRACT_ID" value="${pd.PROCEEDSCONTRACT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">负责人:</td>
								<td><input type="text" name="PRINCIPAL" id="PRINCIPAL" value="${pd.PRINCIPAL}" maxlength="255" placeholder="这里输入负责人" title="负责人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收金额:</td>
								<td><input type="number" name="RECEIVABLE" id="RECEIVABLE" value="${pd.RECEIVABLE}" maxlength="32" placeholder="这里输入应收金额" title="应收金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方名称:</td>
								<td><input type="text" name="PAYERNAME" id="PAYERNAME" value="${pd.PAYERNAME}" maxlength="255" placeholder="这里输入付款方名称" title="付款方名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付款时间:</td>
								<td><input class="span10 date-picker" name="PAYTIME" id="PAYTIME" value="${pd.PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应付款时间" title="应付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否收款:</td>
								<td><input type="number" name="ISPAY" id="ISPAY" value="${pd.ISPAY}" maxlength="32" placeholder="这里输入是否收款" title="是否收款" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额:</td>
								<td><input type="number" name="RECEIVABLE_REALITY" id="RECEIVABLE_REALITY" value="${pd.RECEIVABLE_REALITY}" maxlength="32" placeholder="这里输入实际付款金额" title="实际付款金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票名称:</td>
								<td><input type="text" name="INVOICENAME" id="INVOICENAME" value="${pd.INVOICENAME}" maxlength="255" placeholder="这里输入发票名称" title="发票名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开票时间:</td>
								<td><input class="span10 date-picker" name="INVOICETIME" id="INVOICETIME" value="${pd.INVOICETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开票时间" title="开票时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应收押金:</td>
								<td><input type="number" name="RECEIVABLECASH" id="RECEIVABLECASH" value="${pd.RECEIVABLECASH}" maxlength="32" placeholder="这里输入应收押金" title="应收押金" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方（押金）:</td>
								<td><input type="number" name="PAYERNAME2" id="PAYERNAME2" value="${pd.PAYERNAME2}" maxlength="32" placeholder="这里输入付款方（押金）" title="付款方（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款时间（押金）:</td>
								<td><input class="span10 date-picker" name="PAYTIME2" id="PAYTIME2" value="${pd.PAYTIME2}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="付款时间（押金）" title="付款时间（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款金额（押金）:</td>
								<td><input type="number" name="RECEIVABLE_REALITY2" id="RECEIVABLE_REALITY2" value="${pd.RECEIVABLE_REALITY2}" maxlength="32" placeholder="这里输入实际付款金额（押金）" title="实际付款金额（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME" id="RECEIVABL_PAYTIME" value="${pd.RECEIVABL_PAYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间" title="实际付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款时间（押金）:</td>
								<td><input class="span10 date-picker" name="RECEIVABL_PAYTIME2" id="RECEIVABL_PAYTIME2" value="${pd.RECEIVABL_PAYTIME2}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际付款时间（押金）" title="实际付款时间（押金）" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">进场时间:</td>
								<td><input class="span10 date-picker" name="ENTERTIME" id="ENTERTIME" value="${pd.ENTERTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="进场时间" title="进场时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办进场手续:</td>
								<td><input type="number" name="ISENTERPROCEDURE" id="ISENTERPROCEDURE" value="${pd.ISENTERPROCEDURE}" maxlength="32" placeholder="这里输入是否已办进场手续" title="是否已办进场手续" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">撤场时间:</td>
								<td><input class="span10 date-picker" name="WITHDRAWALTIME" id="WITHDRAWALTIME" value="${pd.WITHDRAWALTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="撤场时间" title="撤场时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">是否已办撤场手续:</td>
								<td><input type="number" name="ISDRAWALPROCEDURE" id="ISDRAWALPROCEDURE" value="${pd.ISDRAWALPROCEDURE}" maxlength="32" placeholder="这里输入是否已办撤场手续" title="是否已办撤场手续" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">退押金金额:</td>
								<td><input type="number" name="RETURNCASH" id="RETURNCASH" value="${pd.RETURNCASH}" maxlength="32" placeholder="这里输入退押金金额" title="退押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">结转收入金额:</td>
								<td><input type="number" name="TRAINCOAMOUNT" id="TRAINCOAMOUNT" value="${pd.TRAINCOAMOUNT}" maxlength="32" placeholder="这里输入结转收入金额" title="结转收入金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">发票名称:</td>
								<td><input type="text" name="INVOICENAME2" id="INVOICENAME2" value="${pd.INVOICENAME2}" maxlength="255" placeholder="这里输入发票名称" title="发票名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">开票时间:</td>
								<td><input class="span10 date-picker" name="INVOICETIME2" id="INVOICETIME2" value="${pd.INVOICETIME2}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开票时间" title="开票时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同主id:</td>
								<td><input type="text" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}" maxlength="255" placeholder="这里输入合同主id" title="合同主id" style="width:98%;"/></td>
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
			if($("#PRINCIPAL").val()==""){
				$("#PRINCIPAL").tips({
					side:3,
		            msg:'请输入负责人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PRINCIPAL").focus();
			return false;
			}
			if($("#RECEIVABLE").val()==""){
				$("#RECEIVABLE").tips({
					side:3,
		            msg:'请输入应收金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE").focus();
			return false;
			}
			if($("#PAYERNAME").val()==""){
				$("#PAYERNAME").tips({
					side:3,
		            msg:'请输入付款方名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME").focus();
			return false;
			}
			if($("#PAYTIME").val()==""){
				$("#PAYTIME").tips({
					side:3,
		            msg:'请输入应付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME").focus();
			return false;
			}
			if($("#ISPAY").val()==""){
				$("#ISPAY").tips({
					side:3,
		            msg:'请输入是否收款',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISPAY").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY").val()==""){
				$("#RECEIVABLE_REALITY").tips({
					side:3,
		            msg:'请输入实际付款金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY").focus();
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
			if($("#RECEIVABLECASH").val()==""){
				$("#RECEIVABLECASH").tips({
					side:3,
		            msg:'请输入应收押金',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLECASH").focus();
			return false;
			}
			if($("#PAYERNAME2").val()==""){
				$("#PAYERNAME2").tips({
					side:3,
		            msg:'请输入付款方（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYERNAME2").focus();
			return false;
			}
			if($("#PAYTIME2").val()==""){
				$("#PAYTIME2").tips({
					side:3,
		            msg:'请输入付款时间（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#PAYTIME2").focus();
			return false;
			}
			if($("#RECEIVABLE_REALITY2").val()==""){
				$("#RECEIVABLE_REALITY2").tips({
					side:3,
		            msg:'请输入实际付款金额（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABLE_REALITY2").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME").val()==""){
				$("#RECEIVABL_PAYTIME").tips({
					side:3,
		            msg:'请输入实际付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME").focus();
			return false;
			}
			if($("#RECEIVABL_PAYTIME2").val()==""){
				$("#RECEIVABL_PAYTIME2").tips({
					side:3,
		            msg:'请输入实际付款时间（押金）',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RECEIVABL_PAYTIME2").focus();
			return false;
			}
			if($("#ENTERTIME").val()==""){
				$("#ENTERTIME").tips({
					side:3,
		            msg:'请输入进场时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ENTERTIME").focus();
			return false;
			}
			if($("#ISENTERPROCEDURE").val()==""){
				$("#ISENTERPROCEDURE").tips({
					side:3,
		            msg:'请输入是否已办进场手续',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISENTERPROCEDURE").focus();
			return false;
			}
			if($("#WITHDRAWALTIME").val()==""){
				$("#WITHDRAWALTIME").tips({
					side:3,
		            msg:'请输入撤场时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#WITHDRAWALTIME").focus();
			return false;
			}
			if($("#ISDRAWALPROCEDURE").val()==""){
				$("#ISDRAWALPROCEDURE").tips({
					side:3,
		            msg:'请输入是否已办撤场手续',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ISDRAWALPROCEDURE").focus();
			return false;
			}
			if($("#RETURNCASH").val()==""){
				$("#RETURNCASH").tips({
					side:3,
		            msg:'请输入退押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RETURNCASH").focus();
			return false;
			}
			if($("#TRAINCOAMOUNT").val()==""){
				$("#TRAINCOAMOUNT").tips({
					side:3,
		            msg:'请输入结转收入金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TRAINCOAMOUNT").focus();
			return false;
			}
			if($("#INVOICENAME2").val()==""){
				$("#INVOICENAME2").tips({
					side:3,
		            msg:'请输入发票名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICENAME2").focus();
			return false;
			}
			if($("#INVOICETIME2").val()==""){
				$("#INVOICETIME2").tips({
					side:3,
		            msg:'请输入开票时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#INVOICETIME2").focus();
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