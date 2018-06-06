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
	<link rel="stylesheet" href="static/dist/jquery.magnify.min.css"/>
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
				<div class="" style="text-align: left;">
					<!-- <td style="text-align: center;" colspan="10"> -->
					<a class="btn btn-primary  btn-xs" onclick="downs();">
						<i class="ace-icon fa  fa-cloud-download bigger-110 nav-search-icon "></i>下载附件
					</a>
					<a  class="btn btn-success btn-xs" onclick="edit('${pd.CONTRACT_ID}')">
						<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon yellow"></i>修改
					</a>
					<a class="btn btn-primary  btn-xs" onclick="top.Dialog.close();">
						<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
					</a>
				</div>
				<br>
				<div class="row">
					<div class="col-xs-12">
						<!-- ------------------------------------------------------------------------------- -->
							<table class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="warning">
									<th width="15%"><label>合同编号：</label></th>
									<th width="10%">${pd.CONTRACTNUM}</th>
									<th width="15%"><label>合同名称：</label></th>
									<th width="10%">${pd.CONTRACTNAME}</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="active">
									<th ><label>签约方：</label></th>
									<th >${pd.CONTRACTOFNAME}</th>
									<th  ><label>项目名称：</label></th>
									<th  >
										${pd.PROJECT}</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="success">
									<th ><label>客户联系人姓名：</label></th>
									<th >${pd.CLIENT}</th>
									<th  ><label>联系电话：</label></th>
									<th  >
										${pd.TELEPHONE}</th>
									<th  ><label></label></th>
									<th  ></th>
								</tr>
								<tr class="warning">
									<th width="15%"><label>合同金额：</label></th>
									<th width="20%">
										${pd.CONTRACTPIC}
									</th>
									<th  ><label>合同签订使用时间：</label></th>
									<th  colspan="3">
											${pd.FUSEDATESTART}
											--- ${pd.FUSEDATEENT}
									</th>
								</tr>
								<tr class="active">
									<th  ><label>是否有押金：</label></th>
									<th  >
										<c:if test="${pd.ISSTAMPDUTY == '1' }">是</c:if>
										<c:if test="${pd.ISSTAMPDUTY == '0' }">否</c:if>
									</th>
									<th width="15%"><label>押金：</label></th>
									<th width="20%">${pd.DEPOSIT}</th>
									<th ><label>签约时间：</label></th>
									<th  >${pd.FDATE}</th>
								</tr>
								<tr>
									<th width="15%"><label>税目：</label></th>
									<th width="10%">
										${pd.TAXITEMS}
									</th>
									<th width="10%" ><label>印花税：</label></th>
									<th  >${pd.STAMPDUTY}</th>
									<th width="15%"><label>印花税计提月份：</label></th>
									<th width="10%">
										${pd.STAMPDUTYMONTH}
									</th>
								</tr>
								<tr class="success">
									<th ><label>经办人：</label></th>
									<th >
										${pd.OPERATOR}
									</th>
									<th width="15%"><label>方式：</label></th>
									<th width="10%">
										${pd.MODE}
									</th>
									<th  ><label>招待票：</label></th>
									<th  >${pd.INVITATIONTICKET}</th>
								</tr>
								<tr class="active">
									<th  ><label>合同类型：</label></th>
									<th colspan="3" >
										<select name="CONTRACTTYPES" id="CONTRACTTYPES" data-placeholder=""
												style="vertical-align:top;width: 150px;" onchange="selectType(this.value);">
											<option value="${pd.CONTRACTTYPES}" name="${pd.CONTRACTTYPES}">${pd.CONTRACTTYPES}</option>
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
							<br />
							<!-- --------------------------------------------------------------------------- -->
							<table id="proceedsContract" style="display: none;" class="table table-border table-bg table-bordered">
								<tbody>
								<tr class="success">
									<th width="15%"><label>应收金额：</label></th>
									<th width="10%">${pd2.RECEIVABLE}</th>
									<th ><label>应付款时间：</label></th>
									<th >${pd2.PAYTIME}</th>
									<th  ><label>滞纳金率：</label></th>
									<th  >${pd2.OVERDUE}</th>

								</tr>
								<tr class="success">
									<th width="15%"><label>实际付款金额：</label></th>
									<th width="20%">${pd2.RECEIVABLE_REALITY}</th>
									<th ><label>实际付款时间：</label></th>
									<th >${pd2.RECEIVABL_PAYTIME}</th>
									<th width="15%"><label>付款方名称：</label></th>
									<th width="20%">${pd2.PAYERNAME}</th>

								</tr>
								<c:if test="${not empty listInvoice }">
									<c:forEach items="${listInvoice}" var="var" varStatus="vs">
										<tr id="tr${var.INVOICE_ID}" class="success">
											<th ><label>发票名称：</label></th>
											<th  >${var.INVOICENAME}</th>
											<th  ><label>开票时间：</label></th>
											<th  >${var.INVOICETIME}</th>
											<th  >
											</th>
											<th></th>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${not empty listDepositInfo }">
									<c:forEach items="${listDepositInfo}" var="var" varStatus="vs">
										<tbody id="tb${var.DEPOSITINFO_ID}">
										<tr  class="danger">
											<th width="10%" ><label>应收押金金额：</label></th>
											<th  >${var.DWDEPOSIT}</th>
											<th width="15%"><label>应付款时间（押金）：</label></th>
											<th width="10%">${var.DWDEPOSITTIME}</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="danger">
											<th width="15%"><label>实际付款金额（押金）：</label></th>
											<th width="10%">
												"${var.REALITY}
											</th>
											<th  ><label>实际付款时间（押金）：</label></th>
											<th  >${var.REALITYTIME}</th>
											<th width="15%"><label>付款方名称（押金）：</label></th>
											<th width="10%">${var.DEPOSITPAYER}</th>
										</tr>
										<tr class="warning">
											<th ><label>进场时间：</label></th>
											<th >
												<label>
													${var.ENTERTIME}
												</label>
											</th>
											<th ><label>是否已办进场手续：</label></th>
											<th  >
												<c:if test="${var.ISENTERPROCEDURE == '1' }">是</c:if>
												<c:if test="${var.ISENTERPROCEDURE == '0' }">否</c:if>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th  ><label>撤场时间：</label></th>
											<th >
												<label>
													${var.WITHDRAWALTIME}
												</label>
											</th>
											<th ><label>是否已办撤场手续：</label></th>
											<th  >
												<c:if test="${var.ISDRAWALPROCEDURE == '1' }">是</c:if>
												<c:if test="${var.ISDRAWALPROCEDURE == '0' }">否</c:if>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th ><label>退押金金额：</label></th>
											<th >
												<label>
													${var.RETURNDEPOSIT}
												</label>
											</th>
											<th  ><label>结转收入金额：</label></th>
											<th >
												<label>
													${var.TRAINCOAMOUNT}
												</label>
											</th>
											<th  ><label></label></th>
											<th  ></th>
										</tr>
										<tr class="warning">
											<th ><label>发票名称：</label></th>
											<th >
												<label>
													${var.INVOICENAME}
												</label>
											</th>
											<th ><label>开票时间：</label></th>
											<th >
												<label>
													${var.INVOICETIME}
												</label>
											</th>
											<th  >
											</th>
											<th  ></th>
										</tr>
									</tbody>
									</c:forEach>
								</c:if>
								<tr class="info">
									<th ><label>备注：</label></th>
									<th colspan="5">
										<label>
											${pd2.FREMARK}
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
									<th >${pd1.AMOUNT}</th>
									<th width="15%"><label>应付款金额：</label></th>
									<th width="20%">${pd1.DUE_AMOUNT}</th>
									<th ><label>实际付款时间：</label></th>
									<th  >${pd1.REALITYTIME}</th>
								</tr>
								<tr class="success">

									<th  ><label>实际付款金额：</label></th>
									<th  >${pd1.REALITY_AMOUNT}</th>
									<th  ><label>付款日：</label></th>
									<th  >${pd1.PAYDAY}</th>
									<th width="10%" ><label>备注：</label></th>
									<th >${pd1.REMARK}</th>
								</tr>
								</tbody>
							</table>
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
	<div align="center" style="width: 100%;height: 30px;-moz-border-radius: 10px;-webkit-border-radius: 10px; border-radius:10px;background-color: #00CCFF;">
		<strong style="font-size: 18px">合同附件</strong>
	</div>
	<br>
	<div align="center" style="margin-left: 2%;margin-right: 2%; border:1px solid #bbe1f1;background:#eefaff" >
		<ul align="center" class="ace-thumbnails clearfix" id="imgList">
			<!-- #section:pages/gallery -->
			<li style="display: none;">
				<a href="" data-rel="colorbox">
					<img width="150" height="150" alt="150x150" src=""/>
				</a>
			</li>
		</ul>
	</div>

	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up"
	   class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
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

<script src="static/dist/jquery.magnify.js"></script>
<script type="text/javascript">
	$(top.hangge());

	$(function () {
		if($("#CONTRACTTYPES").find("option:selected").attr("value") == "付款合同"){
			$("#paymentContarct").css("display","");
			$("#proceedsContract").css("display","none");
		}else if($("#CONTRACTTYPES").find("option:selected").attr("value") == "收款合同"){
			$("#proceedsContract").css("display","");
			$("#paymentContarct").css("display","none");
		}
		var FNAME = $("#CONTRACTCLASSIFY").find("option:selected").attr("name");
		if (FNAME == "大型体育赛事场地租赁" || FNAME == "文艺演出场地租赁"){
			$("#INVITATIONTICKET").removeAttr("readonly");
		}else {
			$("#INVITATIONTICKET").attr("readonly","readonly");
		}
		var CONTRACT_ID = '${pd.CONTRACT_ID}';
		showPic(CONTRACT_ID);
	});

	//修改
	function edit(Id) {
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = "编辑";
		diag.URL = '<%=basePath%>contract/goEdit.do?CONTRACT_ID=' + Id;
		diag.Width = window.innerWidth * 0.9;
		diag.Height = window.innerHeight * 0.9;
		diag.Modal = true;				//有无遮罩窗口
		diag.ShowMaxButton = true;	//最大化按钮
		diag.ShowMinButton = true;		//最小化按钮
		diag.CancelEvent = function () { //关闭事件
			diag.close();
			//tosearch();
		};
		diag.show();
	}

	function showPic(CONTRACT_ID) {
		$.ajax({
			type: "POST",
			url: '<%=basePath%>contractpicture/listOneContractPic',
			data: {CONTRACT_ID: CONTRACT_ID},
			dataType: 'json',
			cache: false,
			success: function (data) {
				$("#imgList").html('');
				var count = 0;	//总数
				var html = '';
				var res = data.listOnePic;
				for (var i = 0; i < res.length; i++) {
					html += '<li>' +
							'<a data-magnify="gallery"' +
							' data-caption="Paraglider flying over Aurlandfjord, Norway by framedbythomas" href="<%=basePath%>' + res[i].URL_PIC + '">' +
							'<img width="200;" name="' + res[i].URL_PIC + '" height="200";   src="<%=basePath%>' + res[i].URL_PIC + '" alt="">' +
							'</a>' +
							'<p width="180;" class="center">'+res[i].NAME+'</p>'+
							'<div style="width: 100%;height: 25px" align="center" >' +
							'<button  onclick="delPic('+"'"+res[i].CONTRACTPICTURE_ID+"','"+CONTRACT_ID+"'"+')" style="width: 45px;height: 20px;margin-top:2px" >删除</button>' +
							'</div>'+
							'</li>'+ ''
				}
				var pdf = data.listOnePdf;
				for (var i = 0; i < pdf.length; i++) {
					html += '<li>' +
							'<a ' +
							' href="<%=basePath%>' + pdf[i].URL_PIC + '">' +
							'<img width="200;" name="' + pdf[i].URL_PIC + '" height="200";   src="<%=basePath%>static/filecatalog/images/application-pdf.png" alt="">' +
							'</a>' +
							'<p width="180;" class="center">'+pdf[i].NAME+'</p>'+
							'<div style="width: 100%;height: 25px" align="center" >' +
							'<button  onclick="delPic('+"'"+pdf[i].CONTRACTPICTURE_ID+"','"+CONTRACT_ID+"'"+')" style="width: 45px;height: 20px;margin-top:2px" >删除</button>' +
							'</div>'+
							'</li>'+ ''
				}
				$("#imgList").append(html);

			}
		});
	}

	//执行下载任务
	function downs() {
		var file = [];
		$("#imgList img").each(function () {
			if ($(this).css("display") != "none") {
				file.push($(this).attr("name"));
			}
		});
		alert(file.length);
		for (var index = 0; index < file.length; index++) {
			var index1 = file[index].lastIndexOf("/");
			var url = "<%=basePath%>"+file[index];
			//alert(file[index].substring(index1 + 1, file[index].length)+"-------------"+url);
			download(file[index].substring(index1 + 1, file[index].length), url);
		}
	}

	function download(name, href) {
		var a = document.createElement("a"), //创建a标签
				e = document.createEvent("MouseEvents"); //创建鼠标事件对象
		e.initEvent("click", false, false); //初始化事件对象
		a.href = href; //设置下载地址
		a.download = name; //设置下载文件名
		a.dispatchEvent(e); //给指定的元素，执行事件click事件
	}

	function delPic(CONTRACTPICTURE_ID, CONTRACT_ID) {
		bootbox.confirm("确定要删除该相片吗?", function (result) {
			if (result) {
				$.ajax({
					type: "POST",
					url: '<%=basePath%>contractpicture/delete.do?tm=' + new Date().getTime(),
					data: {CONTRACTPICTURE_ID: CONTRACTPICTURE_ID},
					dataType: 'json',
					//beforeSend: validateData,
					cache: false,
					success: function (data) {
						showPic(CONTRACT_ID);
					}
				});
			}
		});
	}

</script>


</body>
</html>