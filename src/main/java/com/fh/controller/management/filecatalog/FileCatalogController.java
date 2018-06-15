package com.fh.controller.management.filecatalog;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.service.management.departmentgroup.DepartmentGroupManager;
import com.fh.service.management.filemeans.FileMeansManager;
import com.fh.service.system.user.UserManager;
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
import com.fh.service.management.filecatalog.FileCatalogManager;

/** 
 * 说明：文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 */
@Controller
@RequestMapping(value="/filecatalog")
public class FileCatalogController extends BaseController {
	
	String menuUrl = "filecatalog/list.do"; //菜单地址(权限用)
	String meanMenuUrl = "filemeans/list.do"; //菜单地址(权限用)

	@Resource(name="filecatalogService")
	private FileCatalogManager filecatalogService;

	@Resource(name="filemeansService")
	private FileMeansManager filemeansService;

	@Resource(name="departmentgroupService")
	private DepartmentGroupManager departmentgroupService;

	@Resource(name="userService")
	private UserManager userService;

	@RequestMapping(value = "/addFile")
	public ModelAndView addFile() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = filecatalogService.findByFitemid(pd);
		mv.addObject("pd",pd);
		mv.setViewName("management/filecatalog/addFile");
		return mv;
	}

	@RequestMapping(value = "/selectFileJurisdiction")
	public ModelAndView selectFileJurisdiction() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = filecatalogService.findByFitemid(pd);
		List<PageData> dept = departmentgroupService.listEmployee(pd);
		//pd.put()Jurisdiction.getUsername());
		pd.put("USERNAME",Jurisdiction.getUsername());
		PageData userPd = userService.findByUsername(pd);
		mv.addObject("dept",dept);
		mv.addObject("pd",pd);
		mv.addObject("userPd",userPd);
		mv.setViewName("management/filecatalog/selectFileJurisdiction");
		return mv;
	}

	@RequestMapping(value = "/wep_open")
	public ModelAndView wep_open() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String FILE_URL = URLDecoder.decode(pd.getString("FILE_URL"), "UTF-8");
		System.out.println(pd.getString("FILE_URL"));
		pd.put("FILE_URL",FILE_URL);
		mv.addObject("pd",pd);
		System.out.println(pd);
		mv.setViewName("management/filecatalog/wep_open");
		return mv;
	}

	// 树
	@RequestMapping(value = "/file_load")
	public ModelAndView file_load(Page page) throws Exception {
		boolean del = Jurisdiction.buttonJurisdiction(meanMenuUrl, "del");
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		PageData pd1 = new PageData();
		pd = this.getPageData();
		String FPARENTID = pd.getString("FPARENTID");
		if(FPARENTID != null && !"".equals(FPARENTID)){
			pd.put("FPARENTID",Integer.parseInt(FPARENTID));
			pd1.put("FILE_CATALOGURL_ID",Integer.parseInt(FPARENTID));
		}else {
			pd.put("FPARENTID",1);
			pd1.put("FILE_CATALOGURL_ID",1);
		}
		page.setPd(pd);
		//System.out.println(pd);
		pd.put("USERNAME",Jurisdiction.getUsername());
		PageData userPd = userService.findByUsername(pd);
		pd1.put("FILE_READUSERS",userPd.getString("USER_ID"));
		pd1.put("USERNAME",Jurisdiction.getUsername());
		List<PageData> list_catalog = filecatalogService.list_catalog(page);//文件夹对象集合
		List<PageData> list_files_NotENCTYPT = filemeansService.listByFILE_CATALOGURL_ID_NotENCTYPT(pd1);//文件集合(不加密）
		List<PageData> list_files_ENCTYPT = filemeansService.listByFILE_CATALOGURL_ID_ENCTYPT(pd1);//文件集合(加密）
		if (del){
			mv.addObject("isdel",0);//当isdel为0时则具有删除功能;1为不具有删除功能
		}else {
			mv.addObject("isdel",1);
		}
		mv.addObject("pd",pd);
		mv.addObject("list_catalog",list_catalog);
		mv.addObject("list_files_NotENCTYPT",list_files_NotENCTYPT);
		mv.addObject("list_files_ENCTYPT",list_files_ENCTYPT);
		mv.setViewName("management/filecatalog/file_load");
		return mv;
	}

	// 树
	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/filecatalog/filecatalog_tree");
		return mv;
	}

	@RequestMapping(value = "/dateTree")
	@ResponseBody
	public JSONArray dateTree(Page page) {
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		JSONArray arr = null;
		try {
			arr = JSONArray.fromObject(filecatalogService.listAll(pd));
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONArray jsStr = JSONArray.fromObject(this.makeTree(arr));
		//System.out.println(jsStr);
		return jsStr;
	}

	@SuppressWarnings("unchecked")
	public String makeTree(JSONArray arr) {
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("[");
			Iterator<Object> it = arr.iterator();
			while (it.hasNext()) {
				JSONObject ob = (JSONObject) it.next();
				sb.append("{id:").append(ob.getString("FITEMID")).append(",pId:")
						.append(ob.getString("FPARENTID")).append(",name:\"")
						.append(ob.getString("FNAME")).append("\"")
						.append(",open:").append("true").append("},");
			}
			return sb.substring(0, sb.length() - 1) + "]";
		}catch (Exception e){
			System.out.println("");
		}

		return "";
	}

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增FileCatalog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FILECATALOG_ID", this.get32UUID());	//主键
		filecatalogService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除FileCatalog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		filecatalogService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改FileCatalog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		filecatalogService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表FileCatalog");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = filecatalogService.list(page);	//列出FileCatalog列表
		mv.setViewName("management/filecatalog/filecatalog_list");
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
		PageData pd1 = filecatalogService.findMax_Fitemid(pd);
		pd = this.getPageData();
		int FITEMID = Integer.parseInt(pd1.get("FITEMID").toString())+1;
		pd.put("FITEMID",FITEMID);
		System.out.println(pd);
		mv.setViewName("management/filecatalog/filecatalog_edit");
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
		pd = filecatalogService.findByNameAndPid(pd);	//根据ID读取
		System.out.println(pd);
		mv.setViewName("management/filecatalog/filecatalog_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除FileCatalog");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			filecatalogService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出FileCatalog到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("FITEMID");	//1
		titles.add("FNUMBER");	//2
		titles.add("名称");	//3
		titles.add("FPARENTID");	//4
		titles.add("备注");	//5
		dataMap.put("titles", titles);
		List<PageData> varOList = filecatalogService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).get("FITEMID").toString());	//1
			vpd.put("var2", varOList.get(i).getString("FNUMBER"));	    //2
			vpd.put("var3", varOList.get(i).getString("FNAME"));	    //3
			vpd.put("var4", varOList.get(i).get("FPARENTID").toString());	//4
			vpd.put("var5", varOList.get(i).getString("FREMAK"));	    //5
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
