<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<style type="text/css">
		table{
			border-collapse: collapse;/* 边框合并属性  */
		}
		th{
			border: 1px solid #666666;
		}
		td{
			border: 1px solid #666666;
		}
		@page {
			/*size: auto;*/  /* auto is the initial value */
			margin: 5mm; /* this affects the margin in the printer settings */
		}
	</style>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
							<div class="row"  style="margin-right: 6%;margin-left: 6%">
								<br><br>
								<p align="center" style="font-size: 24px;font-family: SimSun"><strong>催收函</strong></p>
								<p align="left" style="font-size: 18.7px;font-family: FangSong;line-height:27px;">${findInv.PAYERNAME}：</p>
								<p align="left" style="font-size: 18.7px;text-indent:2em;line-height:27px;font-family: FangSong">
									${findInv.CONTRACTOFNAME}，贵司与佛山中奥广场管理有限公司（以下简称“我司”）
									签订《${findInv.CONTRACTNAME}》（以下简称“合同”），合同对租金等费用的支付期限有明确的约定。
								</p>
								<p align="left" style="font-size: 18.7px;text-indent:2em;line-height:27px;font-family: FangSong">
									<fmt:parseDate var="i" type="date" value="${findInv.STARTTIME}" />
									<fmt:formatDate value="${i}" pattern="yyyy年MM月dd日" var="time"/>
									现经核查，截止到${pd.dateString}贵司仍欠我司
									<c:out value="${time}" escapeXml="false" />到
									<fmt:parseDate var="i" type="date" value="${findInv.ENDTIME}" />
									<fmt:formatDate value="${i}" pattern="yyyy年MM月dd日" var="time"/>
									<c:out value="${time}" escapeXml="false" />期间的水电费${findInv.URECEIVABLE}元。
									贵司拖欠付款的行为已构成违约，根据合同约定，
									贵司应向我司支付违约金，暂计至${pd.dateString}的违约金为人民币${findInv.OVERDUENUM}元。
								</p>
								<p align="left" style="font-size: 18.7px;text-indent:2em;line-height:27px;font-family: FangSong">
									请贵司本着诚信原则，全面履行合同约定，在${pd.dateString3}前付清上述欠费及违约金共${findInv.NOT_RECEIVABLE}元；
									否则，因此造成的一切损失由贵司自行负责。感谢贵户的理解和配合！
								</p>
								<p align="left" style="font-size: 18.7px;text-indent:2em;line-height:27px;font-family: FangSong">
									特此通知！
								</p>
								<br>
								<div align="right" style="margin-right: 100px">
									<p  style="font-size: 18.7px;line-height:27px;font-family: FangSong">佛山中奥广场管理有限公司</p>
									<p  id="FCREATETIME" style="margin-right:30px;font-size: 18.7px;line-height:27px;font-family: FangSong">${pd.dateString}</p>
								</div>
								<hr>
								<!-- /.col -->
							</div>
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
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
		<div id="print" style="margin-bottom: 10%;margin-right: 20%">
			<button align="right" style="" onClick="printAndNone()">打印</button>&nbsp;</td>
		</div>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		$(top.hangge());

		function printAndNone() {
			$("#print").css("display","none");
			window.print();
			$("#print").css("display","");
		}
	</script>


</body>
</html>