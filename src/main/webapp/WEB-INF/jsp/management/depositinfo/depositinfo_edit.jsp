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
					
					<form action="depositinfo/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="DEPOSITINFO_ID" id="DEPOSITINFO_ID" value="${pd.DEPOSITINFO_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付押金金额:</td>
								<td><input type="number" name="DWDEPOSIT" id="DWDEPOSIT" value="${pd.DWDEPOSIT}" maxlength="32" placeholder="这里输入应付押金金额" title="应付押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应付押金时间:</td>
								<td><input class="span10 date-picker" name="DWDEPOSITTIME" id="DWDEPOSITTIME" value="${pd.DWDEPOSITTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="应付押金时间" title="应付押金时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际付款押金金额:</td>
								<td><input type="number" name="REALITY" id="REALITY" value="${pd.REALITY}" maxlength="32" placeholder="这里输入实际付款押金金额" title="实际付款押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">实际押金付款时间:</td>
								<td><input class="span10 date-picker" name="REALITYTIME" id="REALITYTIME" value="${pd.REALITYTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="实际押金付款时间" title="实际押金付款时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">付款方:</td>
								<td><input type="text" name="DEPOSITPAYER" id="DEPOSITPAYER" value="${pd.DEPOSITPAYER}" maxlength="255" placeholder="这里输入付款方" title="付款方" style="width:98%;"/></td>
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
								<td><input type="number" name="RETURNDEPOSIT" id="RETURNDEPOSIT" value="${pd.RETURNDEPOSIT}" maxlength="32" placeholder="这里输入退押金金额" title="退押金金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">结转收入金额:</td>
								<td><input type="number" name="TRAINCOAMOUNT" id="TRAINCOAMOUNT" value="${pd.TRAINCOAMOUNT}" maxlength="32" placeholder="这里输入结转收入金额" title="结转收入金额" style="width:98%;"/></td>
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
			if($("#DWDEPOSIT").val()==""){
				$("#DWDEPOSIT").tips({
					side:3,
		            msg:'请输入应付押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DWDEPOSIT").focus();
			return false;
			}
			if($("#DWDEPOSITTIME").val()==""){
				$("#DWDEPOSITTIME").tips({
					side:3,
		            msg:'请输入应付押金时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DWDEPOSITTIME").focus();
			return false;
			}
			if($("#REALITY").val()==""){
				$("#REALITY").tips({
					side:3,
		            msg:'请输入实际付款押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITY").focus();
			return false;
			}
			if($("#REALITYTIME").val()==""){
				$("#REALITYTIME").tips({
					side:3,
		            msg:'请输入实际押金付款时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#REALITYTIME").focus();
			return false;
			}
			if($("#DEPOSITPAYER").val()==""){
				$("#DEPOSITPAYER").tips({
					side:3,
		            msg:'请输入付款方',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPOSITPAYER").focus();
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
			if($("#RETURNDEPOSIT").val()==""){
				$("#RETURNDEPOSIT").tips({
					side:3,
		            msg:'请输入退押金金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#RETURNDEPOSIT").focus();
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