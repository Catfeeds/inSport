package com.fh.controller.management.expense;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.contract.ContractManager;
import com.fh.service.management.proceedscontract.ProceedsContractManager;
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;
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
import com.fh.service.management.expense.ExpenseManager;

/** 
 * 说明：水电费
 * 创建人：FH Q313596790
 * 创建时间：2018-06-27
 */
@Controller
@RequestMapping(value="/expense")
public class ExpenseController extends BaseController {
	
	String menuUrl = "expense/list.do"; //菜单地址(权限用)
	@Resource(name="expenseService")
	private ExpenseManager expenseService;

	@Resource(name="utilitiesstateService")
	private UtilitiesStateManager utilitiesstateService;

	@Resource(name="contractService")
	private ContractManager contractService;

	@Resource(name="proceedscontractService")
	private ProceedsContractManager proceedscontractService;

	@RequestMapping(value = "/saveElectricity")
	@ResponseBody
	public Map<String, Object> saveDetail(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("EXPENSE_ID", this.get32UUID());	//主键
		pd.put("ISWATER", "电费");
		pd.put("ISCHANGE", "0");
		String ISLOSS = pd.getString("ISLOSS");
		if(ISLOSS == null && "".equals(ISLOSS)){
			pd.put("ISLOSS",0);
		}
		expenseService.save(pd);
		return json;
	}


	@RequestMapping(value = "/saveWater")
	@ResponseBody
	public Map<String, Object> saveWater(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("EXPENSE_ID", this.get32UUID());	//主键
		pd.put("ISWATER", "水费");
		pd.put("ISCHANGE", "0");
		String ISLOSS = pd.getString("ISLOSS");
		if(ISLOSS == null && "".equals(ISLOSS)){
			pd.put("ISLOSS",0);
		}
		expenseService.save(pd);
		return json;
	}

	@RequestMapping(value = "/editExpense")
	@ResponseBody
	public Map<String, Object> editExpense(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		PageData pd1 = expenseService.findById(pd);
		if(pd1.getString("N_EXPENSE_ID") != null && !"".equals(pd1.getString("N_EXPENSE_ID"))){
			pd.put("ISCHANGE", "1");
		}else {
			pd.put("ISCHANGE", "0");
		}
		expenseService.edit(pd);
		return json;
	}

	@RequestMapping(value = "/delExpense")
	@ResponseBody
	public Map<String, Object> delExpense(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		expenseService.delete(pd);
		return json;
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Expense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("EXPENSE_ID", this.get32UUID());	//主键
		pd.put("ISCHANGE", "0");	//主键
		expenseService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Expense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		expenseService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Expense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		expenseService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Expense");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = expenseService.list(page);	//列出Expense列表
		mv.setViewName("management/expense/expense_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	@RequestMapping(value = "/addUtilitiesByCopy")
	@ResponseBody
	public Map<String, Object> addUtilitiesByCopy(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> listEl; // 上个月电费
		List<PageData> listWa; //  上个月水费
 		String CONTRACT_ID = pd.getString("CONTRACT_ID");
		String INVOICE_ID = pd.getString("INVOICE_ID");
		String LINVOICE_ID = pd.getString("LINVOICE_ID");
		PageData sPd = new PageData(); // 用于修改状态
		if(LINVOICE_ID == null || "".equals(LINVOICE_ID)){
			return  json;
		}else {
			//-------修改----------
			pd.put("ISCHANGE","1"); //0为新增，1为修改，2已经被添加到后期且无修改
			pd.put("INVOICE_ID",LINVOICE_ID);
			listEl = expenseService.listElByUtilitiesId(pd);//搜索上个月的电费项是否有修改
			listWa = expenseService.listWaByUtilitiesId(pd);//搜索上个月的水费项是否有修改
			if(listWa.size() > 0) { // 水费有修改数据
				PageData wPd = new PageData();
				for (int i = 0; i < listWa.size(); i++) {
					wPd.put("EXPENSE_ID", listWa.get(i).getString("N_EXPENSE_ID"));
					wPd.put("LASTMONTH", listWa.get(i).getString("THISMONTH"));
					wPd.put("RATIO", listWa.get(i).getString("RATIO"));
					wPd.put("FVALUE", listWa.get(i).getString("FVALUE"));
					wPd.put("PRICE", listWa.get(i).getString("PRICE"));
					//wPd.put("ISCHANGE", "1");
					wPd.put("ISLOSS",Integer.parseInt(listWa.get(i).get("ISLOSS").toString()));
					wPd.put("METERNUM", listWa.get(i).getString("METERNUM"));
					expenseService.editThisMonth(wPd);
					sPd.put("EXPENSE_ID",listWa.get(i).getString("EXPENSE_ID"));
					sPd.put("N_EXPENSE_ID",wPd.getString("EXPENSE_ID"));
					sPd.put("ISCHANGE","2");
					expenseService.editState(sPd);
				}
			}
			if(listEl.size() > 0){ // 上个月有修改电费数据
				PageData ePd = new PageData();
				for (int i = 0; i < listEl.size(); i++) {
					ePd.put("EXPENSE_ID", listEl.get(i).getString("N_EXPENSE_ID"));
					ePd.put("LASTMONTH", listEl.get(i).getString("THISMONTH"));
					ePd.put("RATIO", listEl.get(i).getString("RATIO"));
					ePd.put("FVALUE", listEl.get(i).getString("FVALUE"));
					ePd.put("PRICE", listEl.get(i).getString("PRICE"));
					//ePd.put("ISCHANGE", "1");
					ePd.put("ISLOSS", Integer.parseInt(listEl.get(i).get("ISLOSS").toString()));
					ePd.put("METERNUM", listEl.get(i).getString("METERNUM"));
					expenseService.editThisMonth(ePd);
					sPd.put("EXPENSE_ID",listEl.get(i).getString("EXPENSE_ID"));
					sPd.put("N_EXPENSE_ID",ePd.getString("EXPENSE_ID"));
					sPd.put("ISCHANGE","2");
					expenseService.editState(sPd);
				}
			}
			//-------新增----------
			pd.put("ISCHANGE","0"); //0为新增，1为修改，2已经被添加到后期且无修改
			pd.put("INVOICE_ID",LINVOICE_ID);
			listEl = expenseService.listElByUtilitiesId(pd);//搜索上个月的电费项是否新增
			listWa = expenseService.listWaByUtilitiesId(pd);//搜索上个月的水费项是否新增
			if(listEl.size() > 0){ // 上个月有新增电费数据
				PageData ePd = new PageData();
				for (int i = 0; i < listEl.size(); i++) {
					ePd.put("EXPENSE_ID", this.get32UUID());
					ePd.put("LASTMONTH", listEl.get(i).getString("THISMONTH"));
					ePd.put("RATIO", listEl.get(i).getString("RATIO"));
					ePd.put("FVALUE", listEl.get(i).getString("FVALUE"));
					ePd.put("PRICE", listEl.get(i).getString("PRICE"));
					ePd.put("ISLOSS", Integer.parseInt(listEl.get(i).get("ISLOSS").toString()));
					ePd.put("METERNUM", listEl.get(i).getString("METERNUM"));
					ePd.put("ISWATER", listEl.get(i).getString("ISWATER"));
					ePd.put("NUMBER", "0");
					ePd.put("TOTAL", "0");
					ePd.put("ISCHANGE", "0");
					ePd.put("REALITY_TOTAL", "0");
					ePd.put("ISCHANGE", "0");
					ePd.put("INVOICE_ID", INVOICE_ID);
					ePd.put("CONTRACT_ID", CONTRACT_ID);
					expenseService.save(ePd);
					sPd.put("EXPENSE_ID",listEl.get(i).getString("EXPENSE_ID"));
					sPd.put("N_EXPENSE_ID",ePd.getString("EXPENSE_ID"));
					sPd.put("ISCHANGE","2");
					expenseService.editState(sPd);
				}
			}
			if(listWa.size() > 0) { // 上个月有新增水费数据
				PageData wPd = new PageData();
				for (int i = 0; i < listWa.size(); i++) {
					wPd.put("EXPENSE_ID", this.get32UUID());
					wPd.put("LASTMONTH", listWa.get(i).getString("THISMONTH"));
					wPd.put("RATIO", listWa.get(i).getString("RATIO"));
					wPd.put("FVALUE", listWa.get(i).getString("FVALUE"));
					wPd.put("PRICE", listWa.get(i).getString("PRICE"));
					wPd.put("ISLOSS",Integer.parseInt(listWa.get(i).get("ISLOSS").toString()));
					wPd.put("METERNUM", listWa.get(i).getString("METERNUM"));
					wPd.put("ISWATER", listWa.get(i).getString("ISWATER"));
					wPd.put("NUMBER", "0");
					wPd.put("TOTAL", "0");
					wPd.put("ISCHANGE", "0");
					wPd.put("REALITY_TOTAL", "0");
					wPd.put("INVOICE_ID", INVOICE_ID);
					wPd.put("CONTRACT_ID", CONTRACT_ID);
					expenseService.save(wPd);
					sPd.put("EXPENSE_ID",listWa.get(i).getString("EXPENSE_ID"));
					sPd.put("N_EXPENSE_ID",wPd.getString("EXPENSE_ID"));
					sPd.put("ISCHANGE","2");
					expenseService.editState(sPd);
				}
			}
		}
		return json;
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
		pd.put("UTILITIESSTATE_ID",this.get32UUID());
		List<PageData> listLastExpense = expenseService.listLastExpense(pd);
		if(listLastExpense.size() > 0){
			PageData ewPd = new PageData();
			for (int i = 0; i < listLastExpense.size(); i++) {
				ewPd.put("EXPENSE_ID", this.get32UUID());
				ewPd.put("LASTMONTH", listLastExpense.get(i).getString("THISMONTH"));
				ewPd.put("RATIO", listLastExpense.get(i).getString("RATIO"));
				ewPd.put("FVALUE", listLastExpense.get(i).getString("FVALUE"));
				ewPd.put("PRICE", listLastExpense.get(i).getString("PRICE"));
				ewPd.put("ISLOSS", Integer.parseInt(listLastExpense.get(i).get("ISLOSS").toString()));
				ewPd.put("METERNUM", listLastExpense.get(i).getString("METERNUM"));
				ewPd.put("ISWATER", listLastExpense.get(i).getString("ISWATER"));
				ewPd.put("NUMBER", "0");
				ewPd.put("TOTAL", "0");
				ewPd.put("ISCHANGE", "0");
				ewPd.put("REALITY_TOTAL", "0");
				ewPd.put("ISCHANGE", "0");
				ewPd.put("CONTRACT_ID", pd.getString("CONTRACT_ID"));
				ewPd.put("UTILITIESSTATE_ID", pd.getString("UTILITIESSTATE_ID"));
				expenseService.save(ewPd);
			}
		}
		PageData conPd = contractService.findById(pd);
		mv.addObject("conPd", conPd);
		PageData proceePd = proceedscontractService.findByContractId(pd);
		pd.put("OVERDUE",proceePd.getString("OVERDUE"));
		pd.put("RECEIVABLE_REALITY","0.00");
		pd.put("OVERDUENUM","0.00");
		pd.put("PAYERNAME",conPd.getString("CONTRACTOFNAME"));
		utilitiesstateService.save(pd);
		PageData utiPd = utilitiesstateService.findById(pd);
		mv.addObject("utiPd", utiPd);
		List<PageData> listEl = expenseService.listElByUtilitiesId(pd);//搜索上个月的电费项是否有修改
		List<PageData> listWa = expenseService.listWaByUtilitiesId(pd);//搜索上个月的水费项是否有修改
		mv.addObject("listWa", listWa);
		mv.addObject("listEl", listEl);
		mv.setViewName("management/expense/expense_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/readUtili")
	public ModelAndView readUtili()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> listEl = expenseService.listElByUtilitiesId(pd);
		List<PageData> listWa = expenseService.listWaByUtilitiesId(pd);
		PageData utiPd = utilitiesstateService.findByInvoiceId(pd);
		mv.setViewName("management/expense/readUtili");
		mv.addObject("listWa", listWa);
		mv.addObject("listEl", listEl);
		mv.addObject("pd", pd);
		mv.addObject("utiPd", utiPd);
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
		PageData utiPd = utilitiesstateService.findById(pd);
		mv.addObject("utiPd", utiPd);
		List<PageData> listEl = expenseService.listElByUtilitiesId(pd);//搜索上个月的电费项是否有修改
		List<PageData> listWa = expenseService.listWaByUtilitiesId(pd);//搜索上个月的水费项是否有修改
		mv.setViewName("management/expense/expense_edit");
		mv.addObject("msg", "edit");
		mv.addObject("listWa", listWa);
		mv.addObject("listEl", listEl);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Expense");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			expenseService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Expense到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("上月读数");	//1
		titles.add("本月度数");	//2
		titles.add("变比");	//3
		titles.add("分表值");	//4
		titles.add("度数");	//5
		titles.add("单价");	//6
		titles.add("总价");	//7
		titles.add("实际总价");	//8
		titles.add("INVOICE_ID");	//9
		titles.add("合同id");	//10
		titles.add("是否水电费");	//11
		titles.add("是否计算10%线损");	//12
		titles.add("表");	//13
		dataMap.put("titles", titles);
		List<PageData> varOList = expenseService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("LASTMONTH").toString());	//1
			vpd.put("var2", varOList.get(i).get("THISMONTH").toString());	//2
			vpd.put("var3", varOList.get(i).getString("RATIO"));	    //3
			vpd.put("var4", varOList.get(i).getString("FVALUE"));	    //4
			vpd.put("var5", varOList.get(i).get("NUMBER").toString());	//5
			vpd.put("var6", varOList.get(i).get("PRICE").toString());	//6
			vpd.put("var7", varOList.get(i).get("TOTAL").toString());	//7
			vpd.put("var8", varOList.get(i).get("REALITY_TOTAL").toString());	//8
			vpd.put("var9", varOList.get(i).getString("INVOICE_ID"));	    //9
			vpd.put("var10", varOList.get(i).getString("CONTRACT_ID"));	    //10
			vpd.put("var11", varOList.get(i).get("ISWATER").toString());	//11
			vpd.put("var12", varOList.get(i).get("ISLOSS").toString());	//12
			vpd.put("var13", varOList.get(i).getString("METERNUM"));	    //13
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
