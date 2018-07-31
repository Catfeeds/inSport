package com.fh.controller.management.utilitiesstate;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.expense.ExpenseManager;
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
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;

/** 
 * 说明：水电费收款情况
 * 创建人：FH Q313596790
 * 创建时间：2018-06-30
 */
@Controller
@RequestMapping(value="/utilitiesstate")
public class UtilitiesStateController extends BaseController {
	
	String menuUrl = "utilitiesstate/list.do"; //菜单地址(权限用)
	@Resource(name="utilitiesstateService")
	private UtilitiesStateManager utilitiesstateService;

	@Resource(name="expenseService")
	private ExpenseManager expenseService;

	//打印页面
	@RequestMapping(value="/printPage")
	public ModelAndView printPage() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = utilitiesstateService.findByIdWithPname(pd);	//根据ID读取
		List<PageData> listEl = expenseService.listElByUtilitiesId(pd);
		List<PageData> listWa = expenseService.listWaByUtilitiesId(pd);
		mv.setViewName("management/utilitiesstate/printPage");
		mv.addObject("pd", pd);
		mv.addObject("listWa", listWa);
		mv.addObject("listEl", listEl);
		return mv;
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增UtilitiesState");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("UTILITIESSTATE_ID", this.get32UUID());	//主键
		utilitiesstateService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value = "/saveUtilitiesState")
	@ResponseBody
	public Map<String, Object> saveUtilitiesState(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		if("".equals(pd.getString("RECEIVABLE")) || pd.getString("RECEIVABLE") == null){
			pd.put("RECEIVABLE","");
		}
		pd.put("UTILITIESSTATE_ID", this.get32UUID());	//主键
		pd.put("NOT_RECEIVABLE",pd.getString("RECEIVABLE"));
		utilitiesstateService.save(pd);
		return json;
	}

	@RequestMapping(value = "/editUtilitiesState")
	@ResponseBody
	public Map<String, Object> editUtilitiesState(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("NOT_RECEIVABLE",pd.getString("RECEIVABLE"));
		utilitiesstateService.edit(pd);
		return json;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除UtilitiesState");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		utilitiesstateService.delete(pd);
		expenseService.deleteByUtiliID(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改UtilitiesState");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		utilitiesstateService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表UtilitiesState");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = utilitiesstateService.list(page);	//列出UtilitiesState列表
		mv.setViewName("management/utilitiesstate/utilitiesstate_list");
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
		mv.setViewName("management/utilitiesstate/utilitiesstate_edit");
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
		pd = utilitiesstateService.findById(pd);	//根据ID读取
		mv.setViewName("management/utilitiesstate/utilitiesstate_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除UtilitiesState");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			utilitiesstateService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出UtilitiesState到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("付款方名称(水电费)");	//1
		titles.add("应收款时间(水电费)");	//2
		titles.add("应收金额(水电费)");	//3
		titles.add("滞纳金率");	//4
		titles.add("实际收款时间(水电费)");	//5
		titles.add("实际收款金额(水电费)");	//6
		titles.add("上个月总电量读数");	//7
		titles.add("本月总电量读数");	//8
		titles.add("本月总用电量");	//9
		titles.add("本月电费");	//10
		titles.add("实总价");	//11
		titles.add("上个月水量总读数");	//12
		titles.add("本月水量总读数");	//13
		titles.add("本月总用水量");	//14
		titles.add("本月水费费用");	//15
		titles.add("本月水费总费用");	//16
		titles.add("滞纳金");	//17
		titles.add("合同id");	//18
		titles.add("时间段id");	//19
		titles.add("发票项id");	//20
		dataMap.put("titles", titles);
		List<PageData> varOList = utilitiesstateService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PAYERNAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("PAYTIME"));	    //2
			vpd.put("var3", varOList.get(i).get("RECEIVABLE").toString());	//3
			vpd.put("var4", varOList.get(i).get("OVERDUE").toString());	//4
			vpd.put("var5", varOList.get(i).getString("RECEIVABL_PAYTIME"));	    //5
			vpd.put("var6", varOList.get(i).get("RECEIVABLE_REALITY").toString());	//6
			vpd.put("var7", varOList.get(i).get("LASTMONTH_SUM_E").toString());	//7
			vpd.put("var8", varOList.get(i).get("THISMONTH_SUM_E").toString());	//8
			vpd.put("var9", varOList.get(i).get("NUMBER_SUM_E").toString());	//9
			vpd.put("var10", varOList.get(i).get("TOTAL_SUM_E").toString());	//10
			vpd.put("var11", varOList.get(i).get("REALITY_TOTAL_SUM_E").toString());	//11
			vpd.put("var12", varOList.get(i).get("LASTMONTH_SUM_W").toString());	//12
			vpd.put("var13", varOList.get(i).get("THISMONTH_SUM_W").toString());	//13
			vpd.put("var14", varOList.get(i).get("NUMBER_SUM_W").toString());	//14
			vpd.put("var15", varOList.get(i).get("TOTAL_SUM_W").toString());	//15
			vpd.put("var16", varOList.get(i).get("REALITY_TOTAL_SUM_W").toString());	//16
			vpd.put("var17", varOList.get(i).get("OVERDUENUM").toString());	//17
			vpd.put("var18", varOList.get(i).getString("CONTRACT_ID"));	    //18
			vpd.put("var19", varOList.get(i).getString("PROCEEDSTIME_ID"));	    //19
			vpd.put("var20", varOList.get(i).getString("INVOICE_ID"));	    //20
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
