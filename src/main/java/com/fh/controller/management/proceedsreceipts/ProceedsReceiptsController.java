package com.fh.controller.management.proceedsreceipts;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.proceeds_record.Proceeds_recordManager;
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
import com.fh.service.management.proceedsreceipts.ProceedsReceiptsManager;

/** 
 * 说明：收款单据管理
 * 创建人：FH Q313596790
 * 创建时间：2018-07-07
 */
@Controller
@RequestMapping(value="/proceedsreceipts")
public class ProceedsReceiptsController extends BaseController {
	
	String menuUrl = "proceedsreceipts/list.do"; //菜单地址(权限用)
	@Resource(name="proceedsreceiptsService")
	private ProceedsReceiptsManager proceedsreceiptsService;

	@Resource(name="proceeds_recordService")
	private Proceeds_recordManager proceeds_recordService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ProceedsReceipts");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PROCEEDSRECEIPTS_ID", this.get32UUID());	//主键
		proceedsreceiptsService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ProceedsReceipts");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedsreceiptsService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ProceedsReceipts");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedsreceiptsService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value = "/editPrintln")
	@ResponseBody
	public Map<String, Object> editPrintln(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("ISPRINTLN","1");
		pd.put("PRINTLNDATE",new Date());
		proceedsreceiptsService.editPrintln(pd);
		return  json;
	}


	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ProceedsReceipts");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String lastEnd = pd.getString("lastEnd");				//关键词检索条件
		if(null != lastEnd && !"".equals(lastEnd)){
			pd.put("lastEnd", lastEnd.trim());
		}
		String lastStart = pd.getString("lastStart");				//关键词检索条件
		if(null != lastStart && !"".equals(lastStart)){
			pd.put("lastStart", lastStart.trim());
		}
		String picStart = pd.getString("picStart");				//关键词检索条件
		if(null != picStart && !"".equals(picStart)){
			pd.put("picStart", picStart.trim());
		}
		String picEnd = pd.getString("picEnd");				//关键词检索条件
		if(null != picEnd && !"".equals(picEnd)){
			pd.put("picEnd", picEnd.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = proceedsreceiptsService.list(page);	//列出ProceedsReceipts列表
		mv.setViewName("management/proceedsreceipts/proceedsreceipts_list");
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
		mv.setViewName("management/proceedsreceipts/proceedsreceipts_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/toPrint")
	public ModelAndView toPrint()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = proceedsreceiptsService.findById(pd);	//根据ID读取
		List<PageData> listByProReceiptsID = proceeds_recordService.listByProReceiptsID(pd);
		mv.addObject("listByProReceiptsID", listByProReceiptsID);
		mv.setViewName("management/proceedsreceipts/toPrint");
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
		pd = proceedsreceiptsService.findById(pd);	//根据ID读取
		mv.setViewName("management/proceedsreceipts/proceedsreceipts_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProceedsReceipts");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			proceedsreceiptsService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ProceedsReceipts到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("收款日期");	//1
		titles.add("收款金额");	//2
		titles.add("收款滞纳金");	//3
		titles.add("收款总额");	//4
		titles.add("尚未收款金额");	//5
		titles.add("客户名称");	//6
		titles.add("收款人");	//7
		titles.add("是否已经打印");	//8
		titles.add("打印日期");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = proceedsreceiptsService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PROCEEDSDATE"));	    //1
			vpd.put("var2", varOList.get(i).getString("PROCEEDSNUM"));	    //2
			vpd.put("var3", varOList.get(i).getString("OVERDUENUM"));	    //3
			vpd.put("var4", varOList.get(i).getString("RECEIVABLE_REALITY"));	    //4
			vpd.put("var5", varOList.get(i).getString("NOT_RECEIVABLE"));	    //5
			vpd.put("var6", varOList.get(i).getString("PAYER"));	    //6
			vpd.put("var7", varOList.get(i).getString("PROCEEDSER"));	    //7
			vpd.put("var8", varOList.get(i).getString("ISPRINTLN"));	    //8
			vpd.put("var9", varOList.get(i).getString("PRINTLNDATE"));	    //9
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
