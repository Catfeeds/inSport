package com.fh.controller.management.contract;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.contract.ContractManager;
import com.fh.service.management.departmentgroup.DepartmentGroupManager;
import com.fh.service.management.deptno.DeptnoManager;
import com.fh.service.management.invoice.InvoiceManager;
import com.fh.service.management.proceedsreceipts.ProceedsReceiptsManager;
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
@RequestMapping(value="/reports")
public class ReportsController extends BaseController {

	@Resource(name="clientService")
	private ClientManager clientService;

	@Resource(name="contractService")
	private ContractManager contractService;

	@Resource(name="proceedsreceiptsService")
	private ProceedsReceiptsManager proceedsreceiptsService;

	@Resource(name="departmentgroupService")
	private DepartmentGroupManager departmentgroupService;

	@Resource(name="deptnoService")
	private DeptnoManager deptnoService;

	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;

	@Resource(name="utilitiesstateService")
	private UtilitiesStateManager utilitiesstateService;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listBook")
	public ModelAndView listBook(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("USERNAME") == null || "".equals(pd.getString("USERNAME"))){
			pd.put("USERNAME", Jurisdiction.getUsername());
		}
		PageData userpd = departmentgroupService.findUserlogin(pd);

		String DNAME = null;
		try {
			DNAME = userpd.getString("DNAME"); //获取部门名称
		}catch (Exception e){
			System.out.println("-----------该员工还没分配角色，请分配角色------------");
			pd.put("ex","该员工还没分配角色，请分配角色");
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null != TYPE && !"".equals(TYPE)){
			pd.put("TYPE", TYPE.trim());
		}
		String p_treeKey = pd.getString("p_treeKey");				//关键词检索条件
		if(null != p_treeKey && !"".equals(p_treeKey)){
			p_treeKey = URLDecoder.decode(p_treeKey, "UTF-8");
			pd.put("p_treeKey", p_treeKey.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = contractService.list(page);
		List<PageData> listDept = deptnoService.listAll(pd);
		mv.addObject("listDept", listDept);
		/*try{
			if("总经办".equals(DNAME) || "财务部".equals(DNAME) || "综管部".equals(DNAME) ){
				varList = contractService.list(page);	//列出Contract列表

				mv.addObject("isDept", 1);
			}else {
				varList = contractService.datalistPageByDept(page);	//列出Contract列表
			}
		}catch (Exception e){
			System.out.println("-----------该员工还没分配角色，请分配角色------------");
			pd.put("ex","该员工还没分配角色，请分配角色");
		}*/
		mv.setViewName("management/reports/contract_listBook");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}


	@RequestMapping(value="/officelist")
	public ModelAndView officelist(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null != TYPE && !"".equals(TYPE)){
			pd.put("TYPE", TYPE.trim());
		}
		String p_treeKey = pd.getString("p_treeKey");				//关键词检索条件
		if(null != p_treeKey && !"".equals(p_treeKey)){
			p_treeKey = URLDecoder.decode(p_treeKey, "UTF-8");
			pd.put("p_treeKey", p_treeKey.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = invoiceService.officelistPage(page);
		mv.setViewName("management/reports/officelist");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}


	@RequestMapping(value="/officelistProceeds")
	public ModelAndView officelistProceeds(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		List<PageData>	varList = null;
		page.setPd(pd);
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null == TYPE || "".equals(TYPE)  || "z".equals(TYPE)){
			varList = invoiceService.officelistPage(page);
			pd.put("TYPE","z");
		}else {
			varList = utilitiesstateService.utilitilistPage(page);
			pd.put("TYPE","s");
		}
		String p_treeKey = pd.getString("p_treeKey");				//关键词检索条件
		if(null != p_treeKey && !"".equals(p_treeKey)){
			p_treeKey = URLDecoder.decode(p_treeKey, "UTF-8");
			pd.put("p_treeKey", p_treeKey.trim());
		}
		mv.setViewName("management/reports/officelistproceeds");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/officelistNotProceeds")
	public ModelAndView officelistNotProceeds(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		List<PageData>	varList = null;
		pd.put("isNot","get"); // 随便传个值到xml，查询未收款大于0的条件
		page.setPd(pd);
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		String TYPE = pd.getString("TYPE");				//关键词检索条件
		if(null == TYPE || "".equals(TYPE)  || "z".equals(TYPE)){
			varList = invoiceService.officelistPage(page);
			pd.put("TYPE","z");
		}else {
			varList = utilitiesstateService.utilitilistPage(page);
			pd.put("TYPE","s");
		}
		String p_treeKey = pd.getString("p_treeKey");				//关键词检索条件
		if(null != p_treeKey && !"".equals(p_treeKey)){
			p_treeKey = URLDecoder.decode(p_treeKey, "UTF-8");
			pd.put("p_treeKey", p_treeKey.trim());
		}
		mv.setViewName("management/reports/officelistnotproceeds");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
}
