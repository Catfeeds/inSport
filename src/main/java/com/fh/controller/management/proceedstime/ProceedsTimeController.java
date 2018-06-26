package com.fh.controller.management.proceedstime;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.invoice.InvoiceManager;
import com.fh.service.management.proceedsdetail.ProceedsDetailManager;
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
import com.fh.service.management.proceedstime.ProceedsTimeManager;

/** 
 * 说明：收款时间区间管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-26
 */
@Controller
@RequestMapping(value="/proceedstime")
public class ProceedsTimeController extends BaseController {
	
	String menuUrl = "proceedstime/list.do"; //菜单地址(权限用)
	@Resource(name="proceedstimeService")
	private ProceedsTimeManager proceedstimeService;

	@Resource(name="proceedsdetailService")
	private ProceedsDetailManager proceedsdetailService;

	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;

	@RequestMapping(value = "/saveTime")
	@ResponseBody
	public Map<String, Object> saveTime(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("PROCEEDSTIME_ID", this.get32UUID());	//主键
		proceedstimeService.save(pd);
		return  json;
	}

	@RequestMapping(value = "/editTime")
	@ResponseBody
	public Map<String, Object> editTime(Page page)throws Exception {
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedstimeService.edit(pd);
		return  json;
	}

	@RequestMapping(value = "/deleteTime")
	@ResponseBody
	public Map<String, Object> deleteTime() throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedstimeService.delete(pd);
		invoiceService.deleteByTimeID(pd);
		return  json;
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ProceedsTime");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PROCEEDSTIME_ID", this.get32UUID());	//主键
		proceedstimeService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除ProceedsTime");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedstimeService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ProceedsTime");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedstimeService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表ProceedsTime");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = proceedstimeService.list(page);	//列出ProceedsTime列表
		mv.setViewName("management/proceedstime/proceedstime_list");
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
		mv.setViewName("management/proceedstime/proceedstime_edit");
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
		pd = proceedstimeService.findById(pd);	//根据ID读取
		mv.setViewName("management/proceedstime/proceedstime_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProceedsTime");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			proceedstimeService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ProceedsTime到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("合同id");	//1
		titles.add("开始时间");	//2
		titles.add("结束时间");	//3
		titles.add("备注");	//4
		titles.add("排序");	//5
		dataMap.put("titles", titles);
		List<PageData> varOList = proceedstimeService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("CONTRACT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("STARTTIME"));	    //2
			vpd.put("var3", varOList.get(i).getString("ENTTIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("REMARK"));	    //4
			vpd.put("var5", varOList.get(i).get("NUM").toString());	//5
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
