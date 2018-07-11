package com.fh.controller.management.proceeds_record;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.depositinfo.DepositInfoManager;
import com.fh.service.management.expense.ExpenseManager;
import com.fh.service.management.invoice.InvoiceManager;
import com.fh.service.management.proceedsreceipts.ProceedsReceiptsManager;
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
import com.fh.service.management.proceeds_record.Proceeds_recordManager;

/** 
 * 说明：收款记录管理
 * 创建人：FH Q313596790
 * 创建时间：2018-07-03
 */
@Controller
@RequestMapping(value="/proceeds_record")
public class Proceeds_recordController extends BaseController {
	
	String menuUrl = "proceeds_record/list.do"; //菜单地址(权限用)
	@Resource(name="proceeds_recordService")
	private Proceeds_recordManager proceeds_recordService;

	@Resource(name="utilitiesstateService")
	private UtilitiesStateManager utilitiesstateService;

	@Resource(name="expenseService")
	private ExpenseManager expenseService;

	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;

	@Resource(name="depositinfoService")
	private DepositInfoManager depositinfoService;

	@Resource(name="proceedsreceiptsService")
	private ProceedsReceiptsManager proceedsreceiptsService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Proceeds_record");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PROCEEDS_RECORD_ID", this.get32UUID());	//主键
		proceeds_recordService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	//统一收款
	@RequestMapping(value = "/toProceeds")
	@ResponseBody
	public Map<String, Object> toProceeds(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("PROCEEDSRECEIPTS_ID",this.get32UUID());//主键
		JSONObject job = null;
		PageData pd1 = new PageData();
		pd1.put("RECEIVABL_EMPL",Jurisdiction.getUsername());
		if(pd.getString("strJson").length()>5) {
			JSONArray jsonArray = JSONArray.fromObject(pd.getString("strJson") );
			for (int i = 0; i < jsonArray.size(); i++) {
				job = jsonArray.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
				if("应收押金".equals(job.getString("TYPE"))){
					//查询后，修改
					pd.put("DEPOSITINFO_ID", job.getString("ITEMID"));
					PageData depd = depositinfoService.findById(pd);
					Double REALITY = Double.parseDouble(depd.getString("REALITY"))+Double.parseDouble(job.get("RECEIVABLE_N").toString());
					depd.put("REALITY",REALITY.toString());
					depd.put("NOT_RECEIVABLE",job.getString("NOT_RECEIVABLE"));
					depd.put("REALITYTIME",job.getString("RECEIVABL_PAYTIME"));
					depositinfoService.edit(depd);
				}else if("应收款".equals(job.getString("TYPE")) || "应收租金".equals(job.getString("TYPE"))){
					pd.put("INVOICE_ID", job.getString("ITEMID"));
					PageData invpd = invoiceService.findById(pd);
					Double RECEIVABLE_REALITY = Double.parseDouble(invpd.getString("RECEIVABLE_REALITY"))+Double.parseDouble(job.get("RECEIVABLE_N").toString());
					Double OVERDUENUM = Double.parseDouble(invpd.getString("OVERDUE"))+Double.parseDouble(job.get("OVERDUENUM").toString());
					invpd.put("RECEIVABLE_REALITY",RECEIVABLE_REALITY.toString());
					invpd.put("NOT_RECEIVABLE",job.getString("NOT_RECEIVABLE"));
					invpd.put("RECEIVABL_PAYTIME",job.getString("RECEIVABL_PAYTIME"));
					invpd.put("OVERDUE",OVERDUENUM);
					invoiceService.edit(invpd);
				}else if("应收水电费".equals(job.getString("TYPE"))){
					pd.put("UTILITIESSTATE_ID", job.getString("ITEMID"));
					PageData utpd = utilitiesstateService.findById(pd);
					Double RECEIVABLE_REALITY = Double.parseDouble(utpd.getString("RECEIVABLE_REALITY"))+Double.parseDouble(job.get("RECEIVABLE_N").toString());
					Double OVERDUENUM = Double.parseDouble(utpd.getString("OVERDUENUM"))+Double.parseDouble(job.get("OVERDUENUM").toString());
					utpd.put("RECEIVABLE_REALITY",RECEIVABLE_REALITY.toString());
					utpd.put("NOT_RECEIVABLE",job.getString("NOT_RECEIVABLE"));
					utpd.put("RECEIVABL_PAYTIME",job.getString("RECEIVABL_PAYTIME"));
					utpd.put("OVERDUENUM",OVERDUENUM);
					utilitiesstateService.edit(utpd);
				}
				pd1.put("PROCEEDS_RECORD_ID",this.get32UUID());
				pd1.put("TYPE", job.getString("TYPE"));
				pd1.put("CONTRACT_ID", job.getString("CONTRACT_ID"));
				pd1.put("ITEMID", job.getString("ITEMID"));
				pd1.put("PROCEEDSRECEIPTS_ID",pd.getString("PROCEEDSRECEIPTS_ID"));
				pd1.put("RECEIVABLE",job.getString("RECEIVABLE"));
				pd1.put("MODE",job.getString("MODE"));
				pd1.put("RECEIVABLE_N",job.getString("RECEIVABLE_N"));
				pd1.put("OVERDUE",job.getString("OVERDUE"));
				pd1.put("RECEIVABL_EMPL",Jurisdiction.getUsername());
				pd1.put("NOT_RECEIVABLE",job.getString("NOT_RECEIVABLE"));
				pd1.put("PAYER",pd.getString("PAYER"));
				pd1.put("AMOUNT",job.getString("AMOUNT"));
				pd1.put("OVERDUENUM",job.getString("OVERDUENUM"));
				pd1.put("RECEIVABL_PAYTIME",job.getString("RECEIVABL_PAYTIME"));
				pd1.put("SETIME",job.getString("SETIME"));
				proceeds_recordService.save(pd1);
			}
			pd.put("PROCEEDSDATE",new Date());
			pd.put("PROCEEDSNUM",pd.getString("PROCEEDSNUM")); // 一次收的金额，后面叠加
			pd.put("OVERDUENUM",pd.getString("OVERDUENUM")); //一次收的滞纳金，后面叠加
			pd.put("RECEIVABLE_REALITY",pd.getString("ALLSUM")); // 应收总额，后面不变
			pd.put("NOT_RECEIVABLE",Double.parseDouble(pd.getString("ALLSUM"))+ Double.parseDouble(pd.getString("OVERDUENUM"))  - Double.parseDouble(pd.getString("PROCEEDSNUM")));//未收款，后面叠减
			pd.put("PAYER",pd.getString("PAYER"));
			pd.put("PROCEEDSER",Jurisdiction.getUsername());
			pd.put("ISPRINTLN","0");
			Date noDate = new Date();
			DateFormat df1 = DateFormat.getDateInstance();
			System.out.println(df1.format(noDate));
			PageData pd3 = proceedsreceiptsService.findMaxNo(pd);
			int MAXNO;
			if(pd3.getString("MAXNO") == null || "".equals(pd3.getString("MAXNO"))){
				MAXNO = 1;
			}else {
				MAXNO = Integer.parseInt(pd3.getString("MAXNO").substring(pd3.getString("MAXNO").length()-3,pd3.getString("MAXNO").length())) +1;
			}
			//new DecimalFormat("0.00"
			//System.out.println(df1.format(noDate)+(new DecimalFormat("000").format(MAXNO)));
			pd.put("PROCEEDSNO",("PDJ"+df1.format(noDate)+(new DecimalFormat("000").format(MAXNO))).toString().trim().replaceAll("-", ""));
			proceedsreceiptsService.save(pd);
			json.put("msg","yes");
		}else {
			json.put("msg","no");
		}
		return  json;
	}


	@RequestMapping(value = "/record_deposit")
	@ResponseBody
	public Map<String, Object> record_deposit(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("PROCEEDS_RECORD_ID", this.get32UUID());	//主键
		pd.put("DEPOSITINFO_ID",pd.getString("ITEMID"));
		pd.put("RECEIVABL_EMPL",Jurisdiction.getUsername());
		PageData depd = depositinfoService.findById(pd);
		depd.put("REALITYTIME",pd.getString("RECEIVABL_PAYTIME"));
		if(depd.getString("REALITY") == null || "".equals(depd.getString("REALITY"))){
			depd.put("REALITY","0.00");
		}
		if(depd.getString("OVERDUENUM") == null || "".equals(depd.getString("OVERDUENUM"))){
			depd.put("OVERDUENUM","0.00");
		}
		//判断是否已存在一张单据，没有则新增一张
		PageData pdPR = proceedsreceiptsService.findById(pd);
		if(pdPR == null || "".equals(pdPR)){
			pdPR = new PageData();
			pdPR.put("PROCEEDSRECEIPTS_ID",this.get32UUID());
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",pd.getString("RECEIVABLE_N")); // 一次收的金额，后面叠加
			pdPR.put("OVERDUENUM",pd.getString("OVERDUENUM")); //一次收的滞纳金，后面叠加
			pdPR.put("RECEIVABLE_REALITY",pd.getString("ALLSUM")); // 应收总额，后面不变
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pd.getString("ALLSUM"))+ Double.parseDouble(pd.getString("OVERDUENUM"))  - Double.parseDouble(pd.getString("RECEIVABLE_N")));//未收款，后面叠减
			pdPR.put("PAYER",pd.getString("PAYER"));
			pdPR.put("PROCEEDSER",Jurisdiction.getUsername());
			pdPR.put("ISPRINTLN","0");
			proceedsreceiptsService.save(pdPR);
		}else {
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			pdPR.put("OVERDUENUM",Double.parseDouble(pdPR.get("OVERDUENUM").toString())+Double.parseDouble(pd.get("OVERDUENUM").toString()));
			//pdPR.put("RECEIVABLE_REALITY",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pdPR.get("OVERDUENUM").toString()));
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pdPR.get("NOT_RECEIVABLE").toString())+Double.parseDouble(pd.get("OVERDUENUM").toString()) - Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			proceedsreceiptsService.edit(pdPR);
		}
		Double REALITY = Double.parseDouble(depd.getString("REALITY"))+Double.parseDouble(pd.getString("RECEIVABLE_N"));
		depd.put("REALITY",REALITY.toString());
		depd.put("NOT_RECEIVABLE",pd.getString("NOT_RECEIVABLE"));
		pd.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		depositinfoService.edit(depd);
		proceeds_recordService.save(pd);
		json.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		return  json;
	}

	@RequestMapping(value = "/record_Utili")
	@ResponseBody
	public Map<String, Object> record_Utili(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("PROCEEDS_RECORD_ID", this.get32UUID());	//主键
		pd.put("UTILITIESSTATE_ID",pd.getString("ITEMID"));
		pd.put("RECEIVABL_EMPL",Jurisdiction.getUsername());
		PageData utpd = utilitiesstateService.findById(pd);
		utpd.put("RECEIVABL_PAYTIME",pd.getString("RECEIVABL_PAYTIME"));
		if(utpd.getString("RECEIVABLE_REALITY") == null || "".equals(utpd.getString("RECEIVABLE_REALITY"))){
			utpd.put("RECEIVABLE_REALITY","0.00");
		}
		if(utpd.getString("OVERDUENUM") == null || "".equals(utpd.getString("OVERDUENUM"))){
			utpd.put("OVERDUENUM","0.00");
		}
		//判断是否已存在一张单据，没有则新增一张
		PageData pdPR = proceedsreceiptsService.findById(pd);
		if(pdPR == null || "".equals(pdPR)){
			pdPR = new PageData();
			pdPR.put("PROCEEDSRECEIPTS_ID",this.get32UUID());
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",pd.getString("RECEIVABLE_N")); // 一次收的金额，后面叠加
			pdPR.put("OVERDUENUM",pd.getString("OVERDUENUM")); //一次收的滞纳金，后面叠加
			pdPR.put("RECEIVABLE_REALITY",pd.getString("ALLSUM")); // 应收总额，后面不变
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pd.getString("ALLSUM"))+ Double.parseDouble(pd.getString("OVERDUENUM"))  - Double.parseDouble(pd.getString("RECEIVABLE_N")));//未收款，后面叠减
			pdPR.put("PAYER",pd.getString("PAYER"));
			pdPR.put("PROCEEDSER",Jurisdiction.getUsername());
			pdPR.put("ISPRINTLN","0");
			proceedsreceiptsService.save(pdPR);
		}else {
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			pdPR.put("OVERDUENUM",Double.parseDouble(pdPR.get("OVERDUENUM").toString())+Double.parseDouble(pd.get("OVERDUENUM").toString()));
			//pdPR.put("RECEIVABLE_REALITY",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pdPR.get("OVERDUENUM").toString()));
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pdPR.get("NOT_RECEIVABLE").toString()) +Double.parseDouble(pd.get("OVERDUENUM").toString())- Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			proceedsreceiptsService.edit(pdPR);
		}
		Double RECEIVABLE_REALITY = Double.parseDouble(utpd.getString("RECEIVABLE_REALITY"))+Double.parseDouble(pd.getString("RECEIVABLE_N"));
		Double OVERDUENUM = Double.parseDouble(utpd.getString("OVERDUENUM"))+Double.parseDouble(pd.getString("OVERDUENUM"));
		utpd.put("RECEIVABLE_REALITY",RECEIVABLE_REALITY.toString());
		utpd.put("NOT_RECEIVABLE",pd.getString("NOT_RECEIVABLE"));
		pd.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		utpd.put("OVERDUENUM",OVERDUENUM);
		utilitiesstateService.edit(utpd);
		proceeds_recordService.save(pd);
		json.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		return  json;
	}

	@RequestMapping(value = "/record_Invoice")
	@ResponseBody
	public Map<String, Object> record_Invoice(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		pd.put("PROCEEDS_RECORD_ID", this.get32UUID());	//主键

		pd.put("INVOICE_ID",pd.getString("ITEMID"));
		pd.put("RECEIVABL_EMPL",Jurisdiction.getUsername());
		PageData invpd = invoiceService.findById(pd);
		invpd.put("RECEIVABL_PAYTIME",pd.getString("RECEIVABL_PAYTIME"));
		if(invpd.getString("RECEIVABLE_REALITY") == null || "".equals(invpd.getString("RECEIVABLE_REALITY"))){
			invpd.put("RECEIVABLE_REALITY","0.00");
		}
		if(invpd.getString("OVERDUE") == null || "".equals(invpd.getString("OVERDUE"))){
			invpd.put("OVERDUE","0.00");
		}
		//判断是否已存在一张单据，没有则新增一张
		PageData pdPR = proceedsreceiptsService.findById(pd);
		if(pdPR == null || "".equals(pdPR)){
			pdPR = new PageData();
			pdPR.put("PROCEEDSRECEIPTS_ID",this.get32UUID());
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",pd.getString("RECEIVABLE_N")); // 一次收的金额，后面叠加
			pdPR.put("OVERDUENUM",pd.getString("OVERDUENUM")); //一次收的滞纳金，后面叠加
			pdPR.put("RECEIVABLE_REALITY",pd.getString("ALLSUM")); // 应收总额，后面不变
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pd.getString("ALLSUM")) + Double.parseDouble(pd.getString("OVERDUENUM")) - Double.parseDouble(pd.getString("RECEIVABLE_N")));//未收款，后面叠减
			pdPR.put("PAYER",pd.getString("PAYER"));
			pdPR.put("PROCEEDSER",Jurisdiction.getUsername());
			pdPR.put("ISPRINTLN","0");
			proceedsreceiptsService.save(pdPR);
		}else {
			pdPR.put("PROCEEDSDATE",pd.getString("RECEIVABL_PAYTIME"));
			pdPR.put("PROCEEDSNUM",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			pdPR.put("OVERDUENUM",Double.parseDouble(pdPR.get("OVERDUENUM").toString())+Double.parseDouble(pd.get("OVERDUENUM").toString()));
			//pdPR.put("RECEIVABLE_REALITY",Double.parseDouble(pdPR.get("PROCEEDSNUM").toString())+Double.parseDouble(pdPR.get("OVERDUENUM").toString()));
			pdPR.put("NOT_RECEIVABLE",Double.parseDouble(pdPR.get("NOT_RECEIVABLE").toString())+Double.parseDouble(pd.get("OVERDUENUM").toString()) - Double.parseDouble(pd.get("RECEIVABLE_N").toString()));
			proceedsreceiptsService.edit(pdPR);
		}
		Double RECEIVABLE_REALITY = Double.parseDouble(invpd.getString("RECEIVABLE_REALITY"))+Double.parseDouble(pd.getString("RECEIVABLE_N"));
		Double OVERDUENUM = Double.parseDouble(invpd.getString("OVERDUE"))+Double.parseDouble(pd.getString("OVERDUENUM"));
		invpd.put("RECEIVABLE_REALITY",RECEIVABLE_REALITY.toString());
		invpd.put("NOT_RECEIVABLE",pd.getString("NOT_RECEIVABLE"));
		pd.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		invpd.put("OVERDUE",OVERDUENUM);
		invoiceService.edit(invpd);
		proceeds_recordService.save(pd);
		json.put("PROCEEDSRECEIPTS_ID",pdPR.getString("PROCEEDSRECEIPTS_ID"));
		return  json;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Proceeds_record");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		proceeds_recordService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Proceeds_record");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceeds_recordService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Proceeds_record");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = proceeds_recordService.list(page);	//列出Proceeds_record列表
		mv.setViewName("management/proceeds_record/proceeds_record_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	@RequestMapping(value="/record_show")
	public ModelAndView record_show() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> listByProReceiptsID = proceeds_recordService.listByProReceiptsID(pd);
		mv.setViewName("management/proceeds_record/proceeds_record_show");
		mv.addObject("listByProReceiptsID", listByProReceiptsID);
		mv.addObject("pd", pd);
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
		mv.setViewName("management/proceeds_record/proceeds_record_edit");
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
		pd = proceeds_recordService.findById(pd);	//根据ID读取
		mv.setViewName("management/proceeds_record/proceeds_record_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Proceeds_record");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			proceeds_recordService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Proceeds_record到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("类型");	//1
		titles.add("合同id");	//2
		titles.add("项目id");	//3
		titles.add("本次应收金额");	//4
		titles.add("滞纳金率");	//5
		titles.add("滞纳金");	//6
		titles.add("本次收款金额");	//7
		titles.add("本次尚未收款金额");	//8
		titles.add("本次收款时间");	//9
		titles.add("收款人");	//10
		titles.add("收款方式");	//11
		titles.add("付款方名称");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = proceeds_recordService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("TYPE"));	    //1
			vpd.put("var2", varOList.get(i).getString("CONTRACTID"));	    //2
			vpd.put("var3", varOList.get(i).getString("ITEMID"));	    //3
			vpd.put("var4", varOList.get(i).getString("RECEIVABLE"));	    //4
			vpd.put("var5", varOList.get(i).getString("OVERDUE"));	    //5
			vpd.put("var6", varOList.get(i).getString("OVERDUENUM"));	    //6
			vpd.put("var7", varOList.get(i).getString("RECEIVABLE_N"));	    //7
			vpd.put("var8", varOList.get(i).getString("NOT_RECEIVABLE"));	    //8
			vpd.put("var9", varOList.get(i).getString("RECEIVABL_PAYTIME"));	    //9
			vpd.put("var10", varOList.get(i).getString("RECEIVABL_EMPL"));	    //10
			vpd.put("var11", varOList.get(i).getString("MODE"));	    //11
			vpd.put("var12", varOList.get(i).getString("PAYER"));	    //12
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
