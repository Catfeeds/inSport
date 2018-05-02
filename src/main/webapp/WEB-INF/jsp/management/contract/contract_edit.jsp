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
					<!-- </td> -->
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
						<!-- ------------------------------------------------------------------------------- -->
						<form action="contract/${msg }.do" name="Form" id="Form" method="post">
							<input type="hidden" name="CONTRACT_ID" id="CONTRACT_ID" value="${pd.CONTRACT_ID}"/>
							<input type="hidden" name="ISSTAMPDUTY" id="ISSTAMPDUTY" value="${pd.ISSTAMPDUTY}"/>
							<input type="hidden" name="PAYMENTCONTRACT_ID" id="PAYMENTCONTRACT_ID" value="${pd1.PAYMENTCONTRACT_ID}"/>
							<table class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="warning">
									<th width="15%"><label>合同名称：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd.CONTRACTNAME}"
														   class="input-text"  name="CONTRACTNAME"
														   id="CONTRACTNAME"></th>
									<%--<th width="10%">
										<select name="FDEPTID" id="FDEPTID" data-placeholder=""  style="vertical-align:top;width: 150px;" onchange="selectType(this.value)">
											<c:forEach items="${varOList}" var="var" varStatus="vs">
												<option value="${var.FITEMID}">${var.FNAME}</option>
												<!-- <option value="single">单表</option>
												<option value="tree">树形</option>
												<option value="fathertable">主表</option>
												<option value="sontable">明细表</option> -->
											</c:forEach>
										</select>
									</th>--%>
									<th width="15%"><label>合同编号：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd.CONTRACTNUM}"
														   class="input-text"  name="CONTRACTNUM"
														   id="CONTRACTNUM"></th>
									<th width="15%"><label>合同金额：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd.CONTRACTPIC}"
														   class="input-text"  name="CONTRACTPIC"
														   id="CONTRACTPIC"></th>
								</tr>
								<tr class="active">
									<th ><label>签约方：</label></th>
									<th ><input type="text" style="width: 150px" value="${pd.CONTRACTOFNAME}"
												class="input-text"  name="CONTRACTOFNAME"
												id="CONTRACTOFNAME"></th>
									<th  ><label>是否有押金：</label></th>
									<th  >
										<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="isSTAMPDUTY('1');" <c:if test="${pd.ISSTAMPDUTY == '1' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
										<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio" id="form-field-radio2" onclick="isSTAMPDUTY('0');" <c:if test="${pd.ISSTAMPDUTY == '0' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
									</th>
									<th width="15%"><label>押金：</label></th>
									<th width="20%"><input type="number" style="width: 150px" value="${pd.DEPOSIT}"
														   class="input-text"  name="DEPOSIT"
														   id="DEPOSIT"></th>
								</tr>
								<tr class="success">
									<th ><label>签约时间：</label></th>
									<th  ><input type="date" style="width: 150px;height: 31px" value="${pd.FDATE}"
												 class="input-text"  name="FDATE"
												 id="FDATE"></th>
									<th  ><label>项目：</label></th>
									<th  ><input type="text" style="width: 150px" value="${pd.PROJECT}"
												 class="input-text"  name="PROJECT"
												 id="PROJECT"></th>
									<th width="10%" ><label>印花税：</label></th>
									<th  ><input type="text" style="width: 150px" value="${pd.STAMPDUTY}"
												 class="input-text"  name="STAMPDUTY"
												 id="STAMPDUTY"></th>
								</tr>
								<tr class="warning">
									<th width="15%"><label>印花税计提月份：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd.STAMPDUTYMONTH}"
														   class="input-text"  name="STAMPDUTYMONTH"
														   id="STAMPDUTYMONTH"></th>
									<th width="15%"><label>税目：</label></th>
									<th width="10%"><input type="text" style="width: 150px" value="${pd.TAXITEMS}"
														   class="input-text"  name="TAXITEMS"
														   id="TAXITEMS"></th>
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
								</tr>
								<tr class="active">
									<th ><label>经办人：</label></th>
									<th ><input type="text" style="width: 150px" value="${pd.OPERATOR}"
												class="input-text"  name="OPERATOR"
												id="OPERATOR"></th>

									<th  ><label>招待票：</label></th>
									<th  ><input type="text" style="width: 150px" value="${pd.INVITATIONTICKET}"
												 class="input-text"  name="INVITATIONTICKET"
												 id="INVITATIONTICKET"></th>
								</tr>
								<tr class="success">
									<th  ><label>合同签订使用时间：</label></th>
									<th  colspan="2">
										<label>
											<input type="date" style="width: 140px;height: 31px" value="${pd.FUSEDATESTART}"
												   class="input-date"  name="FUSEDATESTART"
												   id="FUSEDATESTART">
											- <input type="date" style="width: 140px;height: 31px" value="${pd.FUSEDATEENT}"
													 class="input-date"  name="FUSEDATEENT"
													 id="FUSEDATEENT">
										</label>
									</th>
									<th  ><label>合同类型：</label></th>
									<th colspan="2" >
										<select name="CONTRACTTYPES" id="CONTRACTTYPES" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.CONTRACTTYPES}" name="${pd.CONTRACTTYPES}">${pd.CONTRACTTYPES}</option>
											<c:forEach items="${listPIdClassify}" var="var" varStatus="vs">
												<option id="${var.FITEMID}" value="${var.FNAME}" name="${var.FITEMID}">${var.FNAME}</option>
											</c:forEach>
										</select> -
										<select name="CONTRACTCLASSIFY" id="CONTRACTCLASSIFY" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value); ">
											<option  value="${pd.CONTRACTCLASSIFY}" name="${pd.CONTRACTCLASSIFY}">${pd.CONTRACTCLASSIFY}</option>
											<%--<c:forEach items="${listClassify}" var="var" varStatus="vs">
												<option value="${var.FNAME}" name="${var.FITEMID}">${var.FNAME}</option>
											</c:forEach>--%>
										</select>
									</th>
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
									<th width="10%" ><label>备注：</label></th>
									<th colspan="3" ><input type="text" style="width: 550px" value="${pd1.REMARK}"
												 class="input-text"  name="REMARK"
												 id="REMARK"></th>
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
		}else {
			$("#paymentContarct").css("display","none");
		}
	})

	$("#CONTRACTTYPES").change(function(){
		var FPARENTID = $("#CONTRACTTYPES").find("option:selected").attr("name");
		//alert($("#CONTRACTTYPES").find("option:selected").attr("value"));
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
		}else {
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
		if($("#DEPOSIT").attr("readonly") != "readonly"){
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
		}
		if($("#STAMPDUTY").val()==""){
			$("#STAMPDUTY").tips({
				side:3,
				msg:'请输入印花税',
				bg:'#AE81FF',
				time:2
			});
			$("#STAMPDUTY").focus();
			return false;
		}
		if($("#STAMPDUTYMONTH").val()==""){
			$("#STAMPDUTYMONTH").tips({
				side:3,
				msg:'请输入印花税计提月份',
				bg:'#AE81FF',
				time:2
			});
			$("#STAMPDUTYMONTH").focus();
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
		if($("#INVITATIONTICKET").val()==""){
			$("#INVITATIONTICKET").tips({
				side:3,
				msg:'请输入招待票',
				bg:'#AE81FF',
				time:2
			});
			$("#INVITATIONTICKET").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}


</script>


</body>
</html>