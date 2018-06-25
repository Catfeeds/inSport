package com.fh.controller.management.paydetail;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.payprimary.PayPrimaryManager;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.management.paydetail.PayDetailManager;

/** 
 * 说明：付款合同明细
 * 创建人：FH Q313596790
 * 创建时间：2018-05-28
 */
@Controller
@RequestMapping(value="/paydetail")
public class PayDetailController extends BaseController {
	
	String menuUrl = "paydetail/list.do"; //菜单地址(权限用)
	@Resource(name="paydetailService")
	private PayDetailManager paydetailService;

	@Resource(name="payprimaryService")
	private PayPrimaryManager payprimaryService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增PayDetail");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PAYDETAIL_ID", this.get32UUID());	//主键
		paydetailService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value = "/saveDetail")
	@ResponseBody
	public Map<String, Object> saveDetail(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		if(pd.getString("SHPAY") == null || "".equals(pd.getString("SHPAY"))){
			pd.put("SHPAY",0);
		}
		if(pd.getString("REALITYPAY") == null || "".equals(pd.getString("REALITYPAY"))){
			pd.put("REALITYPAY",0);
		}
		pd.put("PAYDETAIL_ID", this.get32UUID());	//主键
		paydetailService.save(pd);
		Double ca = 0.00;
		//通过合同id获取到明细表，进行计算
		PageData pd1 = new PageData();
		PageData payprimary = payprimaryService.findById(pd); //主表
		List<PageData> listPayDetail = paydetailService.listByPayPrimaryId(pd);  //明细
		for (int i = 0; i < listPayDetail.size(); i++) {
			if (i == 0){
				ca = Double.parseDouble(payprimary.getString("CONTRACTPIC"))-Double.parseDouble(listPayDetail.get(i).getString("REALITYPAY"));
				pd1.put("REALITYPAY",ca);
				pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
				paydetailService.editNoPay(pd1);
			}
			ca = ca -Double.parseDouble(listPayDetail.get(i).getString("REALITYPAY"));
			pd1.put("REALITYPAY",ca);
			pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
			paydetailService.editNoPay(pd1);
		}
		return  json;
	}

	/**删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteDetail")
	@ResponseBody
	public Map<String, Object> deleteDetail() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		paydetailService.delete(pd);
		Double ca = 0.00;
		//通过合同id获取到明细表，进行计算
		PageData pd1 = new PageData();
		PageData payprimary = payprimaryService.findById(pd); //主表
		List<PageData> listPayDetail = paydetailService.listByPayPrimaryId(pd);  //明细
		for (int i = 0; i < listPayDetail.size(); i++) {
			if (i == 0){
				ca = Double.parseDouble(payprimary.getString("CONTRACTPIC"))-Double.parseDouble(listPayDetail.get(i).getString("REALITYPAY"));
				pd1.put("REALITYPAY",ca);
				pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
				paydetailService.editNoPay(pd1);
			}
			ca = ca -Double.parseDouble(listPayDetail.get(i).getString("REALITYPAY"));
			pd1.put("REALITYPAY",ca);
			pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
			paydetailService.editNoPay(pd1);
		}
		return  json;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除PayDetail");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		paydetailService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改PayDetail");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		paydetailService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value = "/editPayDetailInfo")
	@ResponseBody
	public Map<String, Object> editPayDetailInfo(Page page)throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		paydetailService.edit(pd);
		Double ca = 0.00;
		//通过合同id获取到明细表，进行计算
		PageData pd1 = new PageData();
		PageData payprimary = payprimaryService.findById(pd); //主表
		List<PageData> listPayDetail = paydetailService.listByPayPrimaryId(pd);  //明细
		for (int i = 0; i < listPayDetail.size(); i++) {
			//System.out.println(listPayDetail.get(i).get("REALITYPAY"));
			if (i < 1){
				ca = Double.parseDouble(payprimary.get("CONTRACTPIC").toString())-Double.parseDouble(listPayDetail.get(i).get("REALITYPAY").toString());
				pd1.put("ONPAYPIC",ca);
				pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
				paydetailService.editNoPay(pd1);
			}else {
				ca = ca -Double.parseDouble(listPayDetail.get(i).get("REALITYPAY").toString());
				pd1.put("ONPAYPIC",ca);
				pd1.put("PAYDETAIL_ID",listPayDetail.get(i).getString("PAYDETAIL_ID"));
				paydetailService.editNoPay(pd1);
			}

		}
		return  json;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表PayDetail");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = paydetailService.list(page);	//列出PayDetail列表
		mv.setViewName("management/paydetail/paydetail_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/paydetail/paydetail_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = paydetailService.findById(pd);	//根据ID读取
		mv.setViewName("management/paydetail/paydetail_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除PayDetail");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			paydetailService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出PayDetail到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主表id");	//1
		titles.add("合同id");	//2
		titles.add("付款所属时间");	//3
		titles.add("应付款金额");	//4
		titles.add("实际付款时间");	//5
		titles.add("实际付款金额");	//6
		titles.add("尚没付款金额");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = paydetailService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PAYPRIMARY_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("CONTRACT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("SHPAYTIME"));	    //3
			vpd.put("var4", varOList.get(i).get("SHPAY").toString());	//4
			vpd.put("var5", varOList.get(i).getString("REALITYPAYTIME"));	    //5
			vpd.put("var6", varOList.get(i).get("REALITYPAY").toString());	//6
			vpd.put("var7", varOList.get(i).get("ONPAYPIC").toString());	//7
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
