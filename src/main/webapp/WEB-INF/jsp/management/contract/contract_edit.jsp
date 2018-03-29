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
					
					<form action="contract/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同名称:</td>
								<td><input type="text" name="CONTRACTNAME" id="CONTRACTNAME" value="${pd.CONTRACTNAME}" maxlength="255" placeholder="这里输入合同名称" title="合同名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同编号:</td>
								<td><input type="text" name="CONTRACTNUM" id="CONTRACTNUM" value="${pd.CONTRACTNUM}" maxlength="255" placeholder="这里输入合同编号" title="合同编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">合同金额:</td>
								<td><input type="number" name="CONTRACTPIC" id="CONTRACTPIC" value="${pd.CONTRACTPIC}" maxlength="32" placeholder="这里输入合同金额" title="合同金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">签约名:</td>
								<td><input type="text" name="CONTRACTOFNAME" id="CONTRACTOFNAME" value="${pd.CONTRACTOFNAME}" maxlength="255" placeholder="这里输入签约名" title="签约名" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">有效期:</td>
								<td><input class="span10 date-picker" name="FDATE" id="FDATE" value="${pd.FDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="有效期" title="有效期" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">其他字段1:</td>
								<td><input type="text" name="ZDONE" id="ZDONE" value="${pd.ZDONE}" maxlength="255" placeholder="这里输入其他字段1" title="其他字段1" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">其他字段2:</td>
								<td><input type="text" name="ZDTWO" id="ZDTWO" value="${pd.ZDTWO}" maxlength="255" placeholder="这里输入其他字段2" title="其他字段2" style="width:98%;"/></td>
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
		            msg:'请输入签约名',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CONTRACTOFNAME").focus();
			return false;
			}
			if($("#FDATE").val()==""){
				$("#FDATE").tips({
					side:3,
		            msg:'请输入有效期',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FDATE").focus();
			return false;
			}
			if($("#ZDONE").val()==""){
				$("#ZDONE").tips({
					side:3,
		            msg:'请输入其他字段1',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZDONE").focus();
			return false;
			}
			if($("#ZDTWO").val()==""){
				$("#ZDTWO").tips({
					side:3,
		            msg:'请输入其他字段2',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ZDTWO").focus();
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