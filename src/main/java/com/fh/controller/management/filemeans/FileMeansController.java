package com.fh.controller.management.filemeans;

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

import com.fh.service.system.user.UserManager;
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
import com.fh.service.management.filemeans.FileMeansManager;

/** 
 * 说明：资料文件管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 */
@Controller
@RequestMapping(value="/filemeans")
public class FileMeansController extends BaseController {
	
	String menuUrl = "filemeans/list.do"; //菜单地址(权限用)
	@Resource(name="filemeansService")
	private FileMeansManager filemeansService;

    @Resource(name="userService")
    private UserManager userService;

	@RequestMapping(value = "/writePw")
	@ResponseBody
	public Map<String, Object> writePw(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		String pw = pd.getString("FILE_PASSWORD");
		PageData oneFile = filemeansService.findById(pd);
		if(pw.equals(oneFile.getString("FILE_PASSWORD"))){
			json.put("result","ture");
			//输入密码，正确，把该用户保存到可以查阅的字段中
            StringBuffer FILE_PASSUSER = new StringBuffer();
            if(oneFile.getString("FILE_PASSUSER") != null && !"".equals(oneFile.getString("FILE_PASSUSER"))){
                FILE_PASSUSER.append(oneFile.getString("FILE_PASSUSER"));
            }
            pd.put("USERNAME",Jurisdiction.getUsername());
            PageData userPd = userService.findByUsername(pd);
            if (oneFile.getString("FILE_PASSUSER") != null || !"".equals(oneFile.getString("FILE_PASSUSER"))){
                FILE_PASSUSER.append(","+userPd.getString("USER_ID"));
            }else {
                FILE_PASSUSER.append(userPd.getString("USER_ID"));
            }
            pd.put("FILE_PASSUSER",FILE_PASSUSER.toString());
            filemeansService.editPassUser(pd);
		}else {
			json.put("result","false");
		}
		//PageData maxNo = contractService.findMaxNo(pd);
		//System.out.println(maxNo);
		return  json;
	}
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增FileMeans");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("FILEMEANS_ID", this.get32UUID());	//主键
		filemeansService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除FileMeans");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		filemeansService.delete(pd);
		out.write("success");
		out.close();
	}

	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改FileMeans");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		filemeansService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	@RequestMapping(value="/openByPW")
	public ModelAndView openByPW() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/filemeans/openbypw");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表FileMeans");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = filemeansService.list(page);	//列出FileMeans列表
		mv.setViewName("management/filemeans/filemeans_list");
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
		mv.setViewName("management/filemeans/filemeans_edit");
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
		pd = filemeansService.findById(pd);	//根据ID读取
		mv.setViewName("management/filemeans/filemeans_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除FileMeans");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			filemeansService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出FileMeans到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("文件名称");	//1
		titles.add("文件路径");	//2
		titles.add("文件创建时间");	//3
		titles.add("文件权限");	//4
		titles.add("文件类型");	//5
		titles.add("文件创建人员");	//6
		titles.add("文件下载次数");	//7
		titles.add("文件查阅次数");	//8
		titles.add("备注");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = filemeansService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("FILENAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("FILE_URL"));	    //2
			vpd.put("var3", varOList.get(i).getString("FILE_CREATETIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("FILE_JURISDICTION"));	    //4
			vpd.put("var5", varOList.get(i).getString("FILE_TYPE"));	    //5
			vpd.put("var6", varOList.get(i).getString("FILE_CREATEUSER"));	    //6
			vpd.put("var7", varOList.get(i).get("FILE_DOWNLOAD").toString());	//7
			vpd.put("var8", varOList.get(i).get("FILE_READ").toString());	//8
			vpd.put("var9", varOList.get(i).getString("FILE_REMARK"));	    //9
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
