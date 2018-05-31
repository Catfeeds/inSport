package com.fh.controller.management.officecontract;

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
import com.fh.service.management.officecontract.OfficeContractManager;

/** 
 * 说明：写字楼合同信息管理
 * 创建人：FH Q313596790
 * 创建时间：2018-05-31
 */
@Controller
@RequestMapping(value="/officecontract")
public class OfficeContractController extends BaseController {
	
	String menuUrl = "officecontract/list.do"; //菜单地址(权限用)
	@Resource(name="officecontractService")
	private OfficeContractManager officecontractService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增OfficeContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("OFFICECONTRACT_ID", this.get32UUID());	//主键
		officecontractService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除OfficeContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		officecontractService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改OfficeContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		officecontractService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表OfficeContract");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = officecontractService.list(page);	//列出OfficeContract列表
		mv.setViewName("management/officecontract/officecontract_list");
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
		mv.setViewName("management/officecontract/officecontract_edit");
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
		pd = officecontractService.findById(pd);	//根据ID读取
		mv.setViewName("management/officecontract/officecontract_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除OfficeContract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			officecontractService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出OfficeContract到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("负责人1");	//1
		titles.add("应收金额1");	//2
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
		titles.add("应收押金金额1");	//24
		titles.add("应付款时间（押金）1");	//25
		titles.add("实际付款金额（押金）1");	//26
		titles.add("实际付款时间（押金）1");	//27
		titles.add("付款方名称（押金）1");	//28
		titles.add("进场时间1");	//29
		titles.add("是否已办理进场手续1");	//30
		titles.add("撤场时间1");	//31
		titles.add("是否已办理撤场手续");	//32
		titles.add("滞纳金率");	//33
		titles.add("备注");	//34
		titles.add("退押金金额");	//35
		titles.add("结转收入金额");	//36
		titles.add("发票名称");	//37
		titles.add("开票时间");	//38
		dataMap.put("titles", titles);
		List<PageData> varOList = officecontractService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PRINCIPAL_O"));	    //1
			vpd.put("var2", varOList.get(i).get("RECEIVABLE_O").toString());	//2
			vpd.put("var3", varOList.get(i).getString("PAYERNAME_O"));	    //3
			vpd.put("var4", varOList.get(i).getString("PAYTIME_O"));	    //4
			vpd.put("var5", varOList.get(i).get("ISPAY_O").toString());	//5
			vpd.put("var6", varOList.get(i).get("RECEIVABLE_REALITY_O").toString());	//6
			vpd.put("var7", varOList.get(i).getString("INVOICENAME_O"));	    //7
			vpd.put("var8", varOList.get(i).getString("INVOICETIME_O"));	    //8
			vpd.put("var9", varOList.get(i).get("RECEIVABLECASH_O").toString());	//9
			vpd.put("var10", varOList.get(i).get("PAYERNAME2_O").toString());	//10
			vpd.put("var11", varOList.get(i).getString("PAYTIME2_O"));	    //11
			vpd.put("var12", varOList.get(i).get("RECEIVABLE_REALITY2_O").toString());	//12
			vpd.put("var13", varOList.get(i).getString("RECEIVABL_PAYTIME_O"));	    //13
			vpd.put("var14", varOList.get(i).getString("RECEIVABL_PAYTIME2_O"));	    //14
			vpd.put("var15", varOList.get(i).getString("ENTERTIME_O"));	    //15
			vpd.put("var16", varOList.get(i).get("ISENTERPROCEDURE_O").toString());	//16
			vpd.put("var17", varOList.get(i).getString("WITHDRAWALTIME_O"));	    //17
			vpd.put("var18", varOList.get(i).get("ISDRAWALPROCEDURE_O").toString());	//18
			vpd.put("var19", varOList.get(i).get("RETURNCASH_O").toString());	//19
			vpd.put("var20", varOList.get(i).get("TRAINCOAMOUNT_O").toString());	//20
			vpd.put("var21", varOList.get(i).getString("INVOICENAME2_O"));	    //21
			vpd.put("var22", varOList.get(i).getString("INVOICETIME2_O"));	    //22
			vpd.put("var23", varOList.get(i).getString("CONTRACT_ID"));	    //23
			vpd.put("var24", varOList.get(i).get("RECEIVABLECASH1_O").toString());	//24
			vpd.put("var25", varOList.get(i).getString("PAYTIME3_O"));	    //25
			vpd.put("var26", varOList.get(i).get("RECEIVABLE_REALITY3_O").toString());	//26
			vpd.put("var27", varOList.get(i).getString("RECEIVABL_PAYTIME3_O"));	    //27
			vpd.put("var28", varOList.get(i).getString("PAYERNAME3_O"));	    //28
			vpd.put("var29", varOList.get(i).getString("ENTERTIME1_O"));	    //29
			vpd.put("var30", varOList.get(i).get("ISENTERPROCEDURE1_O").toString());	//30
			vpd.put("var31", varOList.get(i).getString("WITHDRAWALTIME1_O"));	    //31
			vpd.put("var32", varOList.get(i).get("ISDRAWALPROCEDURE1_O").toString());	//32
			vpd.put("var33", varOList.get(i).getString("OVERDUE_O"));	    //33
			vpd.put("var34", varOList.get(i).getString("REMARK_O"));	    //34
			vpd.put("var35", varOList.get(i).get("RETURNCASH1_O").toString());	//35
			vpd.put("var36", varOList.get(i).get("TRAINCOAMOUNT1_O").toString());	//36
			vpd.put("var37", varOList.get(i).getString("INVOICENAME3_O"));	    //37
			vpd.put("var38", varOList.get(i).getString("INVOICETIME3_O"));	    //38
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
