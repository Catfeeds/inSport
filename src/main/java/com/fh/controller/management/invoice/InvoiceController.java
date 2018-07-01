package com.fh.controller.management.invoice;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
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
import com.fh.service.management.invoice.InvoiceManager;

/** 
 * 说明：发票模块
 * 创建人：FH Q313596790
 * 创建时间：2018-06-03
 */
@Controller
@RequestMapping(value="/invoice")
public class InvoiceController extends BaseController {
	
	String menuUrl = "invoice/list.do"; //菜单地址(权限用)
	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Invoice");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INVOICE_ID", this.get32UUID());	//主键
		invoiceService.save(pd);
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
		pd.put("INVOICE_ID", this.get32UUID());	//主键
		/*if(pd.getString("RECEIVABLE") == null && "".equals(pd.getString("RECEIVABLE"))){
			pd.put("RECEIVABLE","0");
		}else {

		}
		if(pd.getString("RECEIVABLE_REALITY") == null && "".equals(pd.getString("RECEIVABLE_REALITY"))){
			pd.put("RECEIVABLE_REALITY","0");
		}*/
		invoiceService.save(pd);
		return  json;
	}

	@RequestMapping(value = "/editInfo")
	@ResponseBody
	public Map<String, Object> editInfo(Page page)throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("RECEIVABLE") == null && "".equals(pd.getString("RECEIVABLE"))){
			pd.put("RECEIVABLE","0");
		}else {

		}
		if(pd.getString("RECEIVABLE_REALITY") == null && "".equals(pd.getString("RECEIVABLE_REALITY"))){
			pd.put("RECEIVABLE_REALITY","0");
		}
		invoiceService.edit(pd);
		return  json;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Invoice");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		invoiceService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Invoice");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		invoiceService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Invoice");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = invoiceService.list(page);	//列出Invoice列表
		mv.setViewName("management/invoice/invoice_list");
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
		mv.setViewName("management/invoice/invoice_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/addUtilities")
	public ModelAndView addUtilities()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/invoice/addUtilities");
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
		pd = invoiceService.findById(pd);	//根据ID读取
		mv.setViewName("management/invoice/invoice_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Invoice");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			invoiceService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Invoice到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("CONTRACT_ID");	//1
		titles.add("发票名称");	//2
		titles.add("开票时间");	//3
		titles.add("备注");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = invoiceService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("CONTRACT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("INVOICENAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("INVOICETIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("REMARK"));	    //4
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
