package com.fh.controller.management.contract;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.contract.ContractManager;
import com.fh.service.management.invoice.InvoiceManager;
import com.fh.service.management.paydetail.PayDetailManager;
import com.fh.service.management.payprimary.PayPrimaryManager;
import com.fh.service.management.proceedsreceipts.ProceedsReceiptsManager;
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** 
 * 说明：合同图片管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-09
 */
@Controller
@RequestMapping(value="/toexcel")
public class ToExcelController extends BaseController {

	@Resource(name="clientService")
	private ClientManager clientService;

	@Resource(name="contractService")
	private ContractManager contractService;

	@Resource(name="proceedsreceiptsService")
	private ProceedsReceiptsManager proceedsreceiptsService;

	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;

	@Resource(name="utilitiesstateService")
	private UtilitiesStateManager utilitiesstateService;

	@Resource(name="paydetailService")
	private PayDetailManager paydetailService;

	@Resource(name="payprimaryService")
	private PayPrimaryManager payprimaryService;

	/**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel_Contract")
	public ModelAndView excel_Contract() throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		//经办部门	合同编号	客户名称	项目	合同金额	客户联系人	联系电话	经办人
		List<String> titles = new ArrayList<String>();
		titles.add("经办部门");	//1
		titles.add("合同编号");	//2
		titles.add("客户名称");	//3
		titles.add("项目");	//4
		titles.add("合同金额");	//5
		titles.add("客户联系人");	//6
		titles.add("联系电话");	//7
		titles.add("经办人");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = contractService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("DEPTNAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("CONTRACTNUM"));	    //2
			vpd.put("var3", varOList.get(i).getString("CONTRACTOFNAME"));	//3
			vpd.put("var4", varOList.get(i).getString("PROJECT"));	    //4
			vpd.put("var5", varOList.get(i).get("CONTRACTPIC").toString());	    //5
			vpd.put("var6", varOList.get(i).getString("CLIENT"));	    //6
			vpd.put("var7", varOList.get(i).getString("TELEPHONE"));	    //7
			vpd.put("var8", varOList.get(i).getString("OPERATOR"));	//8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}


	//写字楼合同
	@RequestMapping(value="/excel_Office")
	public ModelAndView excel_Office(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		page.setShowCount(1000000);
		Map<String,Object> dataMap = new HashMap<String,Object>();
		//经办部门	合同编号	客户名称	项目	合同金额	客户联系人	联系电话	经办人
		List<String> titles = new ArrayList<String>();
		titles.add("租户名");	//1
		titles.add("合同名称");	//2
		titles.add("合同编号");	//3
		titles.add("租金区间");	//4
		titles.add("租金");	//5
		dataMap.put("titles", titles);
		List<PageData> varOList = invoiceService.officelistPage(page);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).getString("CONTRACTOFNAME"));	    //1
					vpd.put("var2", varOList.get(i).getString("CONTRACTNAME"));	    //2
					vpd.put("var3", varOList.get(i).getString("CONTRACTNUM"));	//3
				}
			}else {
				vpd.put("var1", varOList.get(i).getString("CONTRACTOFNAME"));	    //1
				vpd.put("var2", varOList.get(i).getString("CONTRACTNAME"));	    //2
				vpd.put("var3", varOList.get(i).getString("CONTRACTNUM"));	//3
			}

			vpd.put("var4",varOList.get(i).get("STARTTIME").toString() + " -- " + varOList.get(i).get("ENDTIME").toString());	    //4
			vpd.put("var5", varOList.get(i).getString("RECEIVABLE"));	    //5
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}


	//写字楼缴费情况
	@RequestMapping(value="/excel_OfficeProceeds")
	public ModelAndView excel_OfficeProceeds(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		List<PageData> varOList = null;
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		page.setShowCount(1000000);
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null == TYPE || "".equals(TYPE) || "z".equals(TYPE)){
			varOList = invoiceService.officelistPage(page);
			pd.put("TYPE","z");
			titles.add("租户名");	//1
			titles.add("合同名称");	//2
			titles.add("合同编号");	//3
			titles.add("时间区间");	//4
			titles.add("租金");	//5
			titles.add("缴费时间");	//6
			titles.add("缴费金额 ");	//7
			titles.add("仍欠费金额");	//8
		}else {
			varOList = utilitiesstateService.utilitilistPage(page);
			pd.put("TYPE","s");
			titles.add("租户名");	//1
			titles.add("合同名称");	//2
			titles.add("合同编号");	//3
			titles.add("时间区间");	//4
			titles.add("水电费");	//5
			titles.add("缴费时间");	//6
			titles.add("缴费金额 ");	//7
			titles.add("仍欠费金额");	//8
		}
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTOFNAME").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("CONTRACTNUM").toString());	//3
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTOFNAME").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("CONTRACTNUM").toString());	//3
			}

			vpd.put("var4", varOList.get(i).get("STARTTIME").toString() + " -- " + varOList.get(i).get("ENDTIME").toString());	    //4
			vpd.put("var5", varOList.get(i).get("RECEIVABLE").toString());	    //5
			vpd.put("var6", varOList.get(i).get("RECEIVABL_PAYTIME").toString());	    //6
			vpd.put("var7", varOList.get(i).get("RECEIVABLE_REALITY").toString());	    //7
			vpd.put("var8", varOList.get(i).get("NOT_RECEIVABLE").toString());	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}


	//写字楼未缴费情况
	@RequestMapping(value="/excel_officeNotProceeds")
	public ModelAndView excel_officeNotProceeds(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		List<PageData> varOList = null;
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		pd.put("isNot","get"); // 随便传个值到xml，查询未收款大于0的条件
		page.setPd(pd);
		page.setShowCount(1000000);
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null == TYPE || "".equals(TYPE) || "z".equals(TYPE)){
			varOList = invoiceService.officelistPage(page);
			pd.put("TYPE","z");
			titles.add("租户名");	//1
			titles.add("合同名称");	//2
			titles.add("合同编号");	//3
			titles.add("时间区间");	//4
			titles.add("租金");	//5
			titles.add("缴费时间");	//6
			titles.add("缴费金额 ");	//7
			titles.add("仍欠费金额");	//8
		}else {
			varOList = utilitiesstateService.utilitilistPage(page);
			pd.put("TYPE","s");
			titles.add("租户名");	//1
			titles.add("合同名称");	//2
			titles.add("合同编号");	//3
			titles.add("时间区间");	//4
			titles.add("水电费");	//5
			titles.add("缴费时间");	//6
			titles.add("缴费金额 ");	//7
			titles.add("仍欠费金额");	//8
		}
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTOFNAME").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("CONTRACTNUM").toString());	//3
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTOFNAME").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("CONTRACTNUM").toString());	//3
			}

			vpd.put("var4", varOList.get(i).get("STARTTIME").toString() + " -- " + varOList.get(i).get("ENDTIME").toString());	    //4
			vpd.put("var5", varOList.get(i).get("RECEIVABLE").toString());	    //5
			vpd.put("var6", varOList.get(i).get("RECEIVABL_PAYTIME").toString());	    //6
			vpd.put("var7", varOList.get(i).get("RECEIVABLE_REALITY").toString());	    //7
			vpd.put("var8", varOList.get(i).get("NOT_RECEIVABLE").toString());	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}


	//其他合同缴费情况
	@RequestMapping(value="/excel_otherProceeds")
	public ModelAndView excel_otherProceeds(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		page.setShowCount(1000000);
		List<PageData> varOList = invoiceService.otherlistPage(page);
		pd.put("TYPE","s");
		titles.add("合同编号");	//1
		titles.add("合同名称");	//2
		titles.add("项目");	//3
		titles.add("合同金额");	//4
		titles.add("应收金额");	//5
		titles.add("应收时间");	//6
		titles.add("缴费时间 ");	//7
		titles.add("缴费金额");	//8
		titles.add("仍欠费金额");	//9
		titles.add("开票名称");	//10
		titles.add("开票时间");	//11
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
					vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
				vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
			}

			vpd.put("var5", varOList.get(i).get("RECEIVABLE").toString());	    //5
			vpd.put("var6", varOList.get(i).get("PAYTIME").toString());	    //6
			vpd.put("var7", varOList.get(i).get("RECEIVABL_PAYTIME").toString());	    //7
			vpd.put("var8", varOList.get(i).get("RECEIVABLE_REALITY").toString());	    //8
			vpd.put("var9", varOList.get(i).get("NOT_RECEIVABLE").toString());	    //9
			vpd.put("var10", varOList.get(i).get("INVOICENAME").toString());	    //10
			vpd.put("var11", varOList.get(i).get("INVOICETIME").toString());	    //11
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	//其他合同缴费情况
	@RequestMapping(value="/excel_otherNotProceeds")
	public ModelAndView excel_otherNotProceeds(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		pd.put("isNot","get"); // 随便传个值到xml，查询未收款大于0的条件
		page.setPd(pd);
		page.setShowCount(1000000);
		List<PageData> varOList = invoiceService.otherlistPage(page);
		pd.put("TYPE","s");
		titles.add("合同编号");	//1
		titles.add("合同名称");	//2
		titles.add("项目");	//3
		titles.add("合同金额");	//4
		titles.add("应收金额");	//5
		titles.add("应收时间");	//6
		titles.add("缴费时间 ");	//7
		titles.add("缴费金额");	//8
		titles.add("仍欠费金额");	//9
		titles.add("开票名称");	//10
		titles.add("开票时间");	//11
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
					vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
				vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
			}

			vpd.put("var5", varOList.get(i).get("RECEIVABLE").toString());	    //5
			vpd.put("var6", varOList.get(i).get("PAYTIME").toString());	    //6
			vpd.put("var7", varOList.get(i).get("RECEIVABL_PAYTIME").toString());	    //7
			vpd.put("var8", varOList.get(i).get("RECEIVABLE_REALITY").toString());	    //8
			vpd.put("var9", varOList.get(i).get("NOT_RECEIVABLE").toString());	    //9
			vpd.put("var10", varOList.get(i).get("INVOICENAME").toString());	    //10
			vpd.put("var11", varOList.get(i).get("INVOICETIME").toString());	    //11
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	//付款合同情况
	@RequestMapping(value="/excel_Pay")
	public ModelAndView excel_Pay(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		page.setShowCount(1000000);
		List<PageData> varOList = paydetailService.paylistPage(page);
		titles.add("合同编号");	//1
		titles.add("合同名称");	//2
		titles.add("项目");	//3
		titles.add("合同金额");	//4
		titles.add("应付金额");	//5
		titles.add("应付时间");	//6
		titles.add("付款时间");	//7
		titles.add("付款金额");	//8
		titles.add("未付款金额");	//9
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
			}
			vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
			vpd.put("var5", varOList.get(i).get("SHPAY").toString());	    //5
			if(varOList.get(i).get("SHPAYTIME") == null){
				vpd.put("var6", "");	    //6
			}else {
				vpd.put("var6", varOList.get(i).get("SHPAYTIME").toString());	    //6
			}

			vpd.put("var7", varOList.get(i).get("REALITYPAYTIME").toString());	    //7
			vpd.put("var8", varOList.get(i).get("REALITYPAY").toString());	    //8
			if(varOList.get(i).get("ONPAYPIC") == null){
				vpd.put("var9", "0.00");	    //9
			}else {
				vpd.put("var9", varOList.get(i).get("ONPAYPIC").toString());	    //9
			}
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}

	//未付款合同情况
	@RequestMapping(value="/excel_NotPay")
	public ModelAndView excel_NotPay(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		pd.put("isNot","get"); // 随便传个值到xml，查询未收款大于0的条件
		page.setPd(pd);
		page.setShowCount(1000000);
		List<PageData> varOList = paydetailService.paylistPage(page);
		titles.add("合同编号");	//1
		titles.add("合同名称");	//2
		titles.add("项目");	//3
		titles.add("合同金额");	//4
		titles.add("应付金额");	//5
		titles.add("应付时间");	//6
		titles.add("付款时间 ");	//7
		titles.add("付款金额");	//8
		titles.add("未付款金额");	//9
		dataMap.put("titles", titles);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			if(i>0){
				if(!varOList.get(i).get("CONTRACTNUM").toString().equals(varOList.get(i-1).get("CONTRACTNUM").toString())){
					vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
					vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
					vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
				}
			}else {
				vpd.put("var1", varOList.get(i).get("CONTRACTNUM").toString());	    //1
				vpd.put("var2", varOList.get(i).get("CONTRACTNAME").toString());	    //2
				vpd.put("var3", varOList.get(i).get("PROJECT").toString());	//3
			}
			vpd.put("var4", varOList.get(i).get("CONTRACTPIC").toString());	    //4
			vpd.put("var5", varOList.get(i).get("SHPAY").toString());	    //5
			if(varOList.get(i).get("SHPAYTIME") == null){
				vpd.put("var6", "");	    //6
			}else {
				vpd.put("var6", varOList.get(i).get("SHPAYTIME").toString());	    //6
			}
			vpd.put("var7", varOList.get(i).get("REALITYPAYTIME").toString());	    //7
			vpd.put("var8", varOList.get(i).get("REALITYPAY").toString());	    //8
			if(varOList.get(i).get("ONPAYPIC") == null){
				vpd.put("var9", "0.00");	    //9
			}else {
				vpd.put("var9", varOList.get(i).get("ONPAYPIC").toString());	    //9
			}
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
}
