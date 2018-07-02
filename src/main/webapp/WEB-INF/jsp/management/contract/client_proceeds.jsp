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
										<th ><label style="color: red">*</label><label>客户编号:</label></th>
										<th>
											<select name="CLIENT" id="CLIENT" data-placeholder=""
													style="vertical-align:top;width: 150px;">
												<option value="${pd.CLIENT_ID}" name="${pd.CLIENT_ID}">${pd.FNUMBER}</option>
												<c:forEach items="${listClients}" var="var" varStatus="vs">
													<option value="${var.CLIENT_ID}" name="${var.CLIENT_ID}">${var.FNUMBER}</option>
												</c:forEach>
											</select>
										</th>
										<th ><label style="color: red">*</label><label>客户名称：</label></th>
										<th  >
											<input type="text" style="width: 150px" value="${pd.FNAME}"
												   class="input-text"  name="FNAME"
												   id="FNAME"></th>
										<th ><label style="color: red">*</label><label>金额合计：</label></th>
										<th  >
											<input type="text" style="width: 150px" value="${pd.FOPPNAME}"
												   class="input-text"  name="FOPPNAME"
												   id="FOPPNAME"></th>
									</tr>
									<tr class="active">
										<th><label style="color: red">*</label><label>经手人:</label></th>
										<th width="10%">
											<input onclick="toCus()" type="text" style="width: 150px;"
												   value="${pd.CUNAME}"
												   class="input-text"  id="CUNAME">
										</th>
										<th><label style="color: red">*</label><label>收款方式：</label></th>
										<th width="10%">
											<select name="FSOURCEID" id="FSOURCEID" data-placeholder=""
													style="vertical-align:top;width: 150px;" >
												<option value="信用卡" name="信用卡">信用卡</option>
												<option value="现金" name="现金">现金</option>
												<option value="支票" name="支票">支票</option>
												<option value="现金券" name="现金券">现金券</option>
												<option value="转账" name="转账">转账</option>
												<option value="免单" name="免单">免单</option>
											</select>
										</th>
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
<div style="margin-bottom: 0px" class="weeks">
	<ul style="margin-left: 0px;margin-bottom: 0px" class="weekItem" id="weektab">
		<li>收款情况</li>
	</ul>
	<div class="box01_c" id="spmx">
		<a style="margin-left: 10px" class="btn btn-success btn-xs" onclick="addItemDetail('${pd.OPPORTUNITY_ID}')">
			<i class="ace-icon fa glyphicon-plus bigger-110 nav-search-icon yellow"></i>新增
		</a>
		<a class="btn btn-primary  btn-xs" onclick="delItemDetail()">
			<i class="ace-icon fa fa-trash-o bigger-120 nav-search-icon "></i>删除
		</a>
		<table id="taspmx" class="table table-striped table-bordered table-hover"
			   style="margin-top:5px;">
			<tr>
				<th class="center">序号</th>
				<th class="center">商品编号</th>
				<th class="center">商品名称</th>
				<th class="center">规格型号</th>
				<th class="center">单位</th>
				<th class="center">标准价格</th>
				<th class="center">数量</th>
				<th class="center">金额</th>
				<th class="center">备注</th>
			</tr>
			<tr id="trspmx">
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

	$("#CLIENT").change(function(){
		var CLIENT_ID = $("#CLIENT").find("option:selected").attr("name");
		$.ajax({
			async: false,
			cache: false,
			type: 'POST',
			data : {
				CLIENT_ID : CLIENT_ID
			},
			//dataType:"String",
			url: '<%=basePath%>contract_notr/getOneClient',
			success: function (data) {
				$("#FNAME").val(data.pd.FNAME);
			},
			error: function () {
				alert("请求失败");
			}
		});
	});

	//保存
	function save(){
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}

	$(function() {
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