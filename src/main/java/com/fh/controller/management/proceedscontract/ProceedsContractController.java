package com.fh.controller.management.proceedscontract;

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
import com.fh.service.management.proceedscontract.ProceedsContractManager;

/** 
 * 说明：收款合同信息管理
 * 创建人：FH Q313596790
 * 创建时间：2018-05-03
 */
@Controller
@RequestMapping(value="/proceedscontract")
public class ProceedsContractController extends BaseController {
	
	String menuUrl = "proceedscontract/list.do"; //菜单地址(权限用)
	@Resource(name="proceedscontractService")
	private ProceedsContractManager proceedscontractService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ProceedsContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PROCEEDSCONTRACT_ID", this.get32UUID());	//主键
		proceedscontractService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除ProceedsContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedscontractService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ProceedsContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		proceedscontractService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表ProceedsContract");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = proceedscontractService.list(page);	//列出ProceedsContract列表
		mv.setViewName("management/proceedscontract/proceedscontract_list");
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
		mv.setViewName("management/proceedscontract/proceedscontract_edit");
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
		pd = proceedscontractService.findById(pd);	//根据ID读取
		mv.setViewName("management/proceedscontract/proceedscontract_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProceedsContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			proceedscontractService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出ProceedsContract到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("负责人");	//1
		titles.add("应收金额");	//2
		titles.add("付款方名称");	//3
		titles.add("应付款时间");	//4
		titles.add("是否收款");	//5
		titles.add("实际付款金额");	//6
		titles.add("发票名称");	//7
		titles.add("开票时间");	//8
		titles.add("应收押金");	//9
		titles.add("付款方（押金）");	//10
		titles.add("付款时间（押金）");	//11
		titles.add("实际付款金额（押金）");	//12
		titles.add("实际付款时间");	//13
		titles.add("实际付款时间（押金）");	//14
		titles.add("进场时间");	//15
		titles.add("是否已办进场手续");	//16
		titles.add("撤场时间");	//17
		titles.add("是否已办撤场手续");	//18
		titles.add("退押金金额");	//19
		titles.add("结转收入金额");	//20
		titles.add("发票名称");	//21
		titles.add("开票时间");	//22
		titles.add("合同主id");	//23
		dataMap.put("titles", titles);
		List<PageData> varOList = proceedscontractService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PRINCIPAL"));	    //1
			vpd.put("var2", varOList.get(i).get("RECEIVABLE").toString());	//2
			vpd.put("var3", varOList.get(i).getString("PAYERNAME"));	    //3
			vpd.put("var4", varOList.get(i).getString("PAYTIME"));	    //4
			vpd.put("var5", varOList.get(i).get("ISPAY").toString());	//5
			vpd.put("var6", varOList.get(i).get("RECEIVABLE_REALITY").toString());	//6
			vpd.put("var7", varOList.get(i).getString("INVOICENAME"));	    //7
			vpd.put("var8", varOList.get(i).getString("INVOICETIME"));	    //8
			vpd.put("var9", varOList.get(i).get("RECEIVABLECASH").toString());	//9
			vpd.put("var10", varOList.get(i).get("PAYERNAME2").toString());	//10
			vpd.put("var11", varOList.get(i).getString("PAYTIME2"));	    //11
			vpd.put("var12", varOList.get(i).get("RECEIVABLE_REALITY2").toString());	//12
			vpd.put("var13", varOList.get(i).getString("RECEIVABL_PAYTIME"));	    //13
			vpd.put("var14", varOList.get(i).getString("RECEIVABL_PAYTIME2"));	    //14
			vpd.put("var15", varOList.get(i).getString("ENTERTIME"));	    //15
			vpd.put("var16", varOList.get(i).get("ISENTERPROCEDURE").toString());	//16
			vpd.put("var17", varOList.get(i).getString("WITHDRAWALTIME"));	    //17
			vpd.put("var18", varOList.get(i).get("ISDRAWALPROCEDURE").toString());	//18
			vpd.put("var19", varOList.get(i).get("RETURNCASH").toString());	//19
			vpd.put("var20", varOList.get(i).get("TRAINCOAMOUNT").toString());	//20
			vpd.put("var21", varOList.get(i).getString("INVOICENAME2"));	    //21
			vpd.put("var22", varOList.get(i).getString("INVOICETIME2"));	    //22
			vpd.put("var23", varOList.get(i).getString("CONTRACT_ID"));	    //23
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
