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
							<div class="row" >
								<p align="center" style="font-size: 20px">催收函</p>
								<p align="left" style="font-size: 15px">${findInv.PAYERNAME}：</p>
								<p align="left" style="font-size: 15px;text-indent:2em">
									${findInv.COFNAME}，贵司与佛山中奥广场管理有限公司（以下简称“我司”）
									签订《${findInv.CONTRACTNAME}》（以下简称“合同”），合同对租金等费用的支付期限有明确的约定。
								</p>
								<p align="left" style="font-size: 15px;text-indent:2em">
									现经核查，截止到<label style="padding:  0px" id="d1"></label>贵司仍欠我司${findInv.STARTTIME}到${findInv.ENDTIME}期间的租金和管理费${findInv.RECEIVABLE}元，
									以及${findInv.STARTTIME}到${findInv.ENDTIME}期间的水电费${findInv.URECEIVABLE}元。贵司拖欠付款的行为已构成违约，根据合同第     条的约定，
									贵司应按         的标准向我司支付违约金，暂计至   年   月  日的违约金为人民币${findInv.OVERDUENUM}元。
								</p>
								<p align="left" style="font-size: 15px;text-indent:2em">
									请贵司本着诚信原则，全面履行合同约定，在<label id="d2"></label>（根据发单日T+3工作日）前付清上述欠费及违约金共${findInv.SUM_N}元；
									否则，因此造成的一切损失由贵司自行负责。感谢贵户的理解和配合！
								</p>
								<p align="left" style="font-size: 15px;text-indent:2em">
									特此通知！
								</p>
								<br>
								<div align="right" style="margin-right: 100px">
									<p  style="font-size: 15px">佛山中奥广场管理有限公司</p>
									<p  id="FCREATETIME" style="margin-right:30px;font-size: 15px"></p>
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