package com.fh.controller.management.departmentgroup;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

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
import com.fh.service.management.departmentgroup.DepartmentGroupManager;

/** 
 * 说明：部门分组管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-01
 */
@Controller
@RequestMapping(value="/departmentgroup")
public class DepartmentGroupController extends BaseController {
	
	String menuUrl = "departmentgroup/list.do"; //菜单地址(权限用)
	@Resource(name="departmentgroupService")
	private DepartmentGroupManager departmentgroupService;

	@Resource(name="userService")
	private UserManager userService;

	// 树
	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/departmentgroup/departmentgroup_tree");
		return mv;
	}

	@RequestMapping(value = "/dateTree")
	@ResponseBody
	public JSONArray dateTree(Page page) {
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PID", "0");
		page.setPd(pd);
		JSONArray arr = null;
		try {
			arr = JSONArray.fromObject(departmentgroupService.listTree(pd));
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
				sb.append("{id:").append(ob.getString("UID")).append(",pId:")
						.append(ob.getString("PID")).append(",name:\"")
						.append(ob.getString("DNAME")).append("\"")
						.append(",open:").append("true").append("},");
			}
			return sb.substring(0, sb.length() - 1) + "]";
		}catch (Exception e){
			System.out.println("");
		}

		return "";
	}

	@RequestMapping(value = "/goAddDept")
	public ModelAndView goAddDept() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/departmentgroup/addDept");
		return mv;
	}

	@RequestMapping(value="/saveDept")
	public ModelAndView saveDept() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增DepartmentGroup");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd+"-----------");
		pd.put("DEPARTMENTGROUP_ID",get32UUID());
		pd.put("UID",(int)(Math.random()*1003));
		pd.put("PID","0");
		departmentgroupService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增DepartmentGroup");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("USERS").length()>2){
			JSONArray jsStr = JSONArray.fromObject(pd.getString("USERS"));
			PageData pd1 = new PageData();
			for (int i = 0; i < jsStr.size(); i++) {
				JSONObject job = jsStr.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
				pd1.put("DEPARTMENTGROUP_ID", this.get32UUID());
				pd1.put("UID", job.getString("UID"));
				pd1.put("DNAME",job.getString("DNAME"));
				pd1.put("PID",pd.getString("pid"));
				departmentgroupService.save(pd1);
			}
		}
		if(pd.getString("USERS_NOT").length()>5){
			JSONArray jsStr = JSONArray.fromObject(pd.getString("USERS_NOT"));
			PageData pd1 = new PageData();
			for (int i = 0; i < jsStr.size(); i++) {
				JSONObject job = jsStr.getJSONObject(i);  // 遍历 jsonarray 数组，把每一个对象转成 json 对象
				pd1.put("UID",job.getString("USER_ID"));
				pd1.put("PID",pd.getString("pid"));
				departmentgroupService.deleteByDepIDAndUID(pd1);
			}
		}
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
		logBefore(logger, Jurisdiction.getUsername()+"删除DepartmentGroup");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		departmentgroupService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改DepartmentGroup");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		departmentgroupService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value="/listDept")
	public ModelAndView listDept(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表DepartmentGroup");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PID", "0");
		List<PageData>	varList = departmentgroupService.listTree(pd);	//列出DepartmentGroup列表
		mv.setViewName("management/departmentgroup/department_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表DepartmentGroup");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PID","0");
		String DNAME = pd.getString("DNAME");
		if(null != DNAME && !"".equals(DNAME)){
			pd.put("DNAME", DNAME.trim());
		}
		String keywords = pd.getString("keywords");				//关键词检索条件
		String p_treeKey = pd.getString("p_treeKey");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", URLDecoder.decode(keywords, "UTF-8").trim());
		}
		if(null != p_treeKey && !"".equals(p_treeKey)){
			pd.put("p_treeKey", URLDecoder.decode(p_treeKey, "UTF-8").trim());
		}
		page.setPd(pd);
		List<PageData>	varList = departmentgroupService.list(page);	//列出DepartmentGroup列表
		mv.setViewName("management/departmentgroup/departmentgroup_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}

	@RequestMapping(value="/goAddUser")
	public ModelAndView goAddUser(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		/*List<PageData> varList = departmentgroupService.list(page);*/
		List<PageData> listUsers = userService.listAll(pd);
		List<PageData> listUsersIn = userService.listAllIn(pd);
		mv.setViewName("management/departmentgroup/goAddUser");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.addObject("listUsers", listUsers);
		mv.addObject("listUsersIn", listUsersIn);
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
		mv.setViewName("management/departmentgroup/departmentgroup_edit");
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
		pd = departmentgroupService.findById(pd);	//根据ID读取
		mv.setViewName("management/departmentgroup/departmentgroup_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/goEditDept")
	public ModelAndView goEditDept()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = departmentgroupService.findById(pd);	//根据ID读取
		mv.setViewName("management/departmentgroup/department_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除DepartmentGroup");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			departmentgroupService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出DepartmentGroup到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("名称");	//1
		titles.add("uid");	//2
		titles.add("父id");	//3
		titles.add("备注");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = departmentgroupService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("DNAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("UID"));	    //2
			vpd.put("var3", varOList.get(i).getString("PID"));	    //3
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
