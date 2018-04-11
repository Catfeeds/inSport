package com.fh.controller.management.contract;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import com.fh.service.management.classify.ClassifyManager;
import com.fh.service.management.contractpicture.ContractPictureManager;
import com.fh.util.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.contract.ContractManager;

/** 
 * 说明：合同管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-08
 */
@Controller
@RequestMapping(value="/contract")
public class ContractController extends BaseController {
	
	String menuUrl = "contract/list.do"; //菜单地址(权限用)
	@Resource(name="contractService")
	private ContractManager contractService;

	@Resource(name="classifyService")
	private ClassifyManager classifyService;

	@Resource(name="contractpictureService")
	private ContractPictureManager contractpictureService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Contract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.put("CONTRACT_ID", this.get32UUID());	//主键
		contractService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**去新增页面
	 * @return
	 */
	@RequestMapping(value="/goAddPic")
	public ModelAndView goAddPic() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("management/contract/pictures_add");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/savePic")
	@ResponseBody
	public Object savePic(
			@RequestParam(required=false) MultipartFile file, @RequestParam(value="CONTRACT_ID",required=false)String CONTRACT_ID
	) throws Exception{
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		String filePath = "";
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			if (null != file && !file.isEmpty()) {
				filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
				//filePath = "static/images/contract/" + ffile;		//文件上传路径
				fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			}else{
				System.out.println("上传失败");
			}
			pd.put("CONTRACTPICTURE_ID", this.get32UUID());
			pd.put("NAME", fileName);
			pd.put("URL_PIC", filePath.substring(61,filePath.length())+"/"+fileName);
			pd.put("CONTRACT_ID", CONTRACT_ID);
			contractpictureService.save(pd);
			//Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
		}
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Contract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		contractService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/editInfo")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Contract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		contractService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Contract");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = contractService.list(page);	//列出Contract列表
		mv.setViewName("management/contract/contract_list");
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
		pd.put("CONTRACT_ID",this.get32UUID());
		List<PageData> listClassify = classifyService.listAll(pd);
		mv.setViewName("management/contract/contract_edit");
		mv.addObject("msg", "save");
		mv.addObject("listClassify", listClassify);
		mv.addObject("pd", pd);
		System.out.println(pd);
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
		pd = contractService.findById(pd);	//根据ID读取
		List<PageData> listClassify = classifyService.listAll(pd);
		mv.setViewName("management/contract/contract_edit");
		mv.addObject("msg", "editInfo");
		mv.addObject("listClassify", listClassify);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Contract");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			contractService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Contract到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("合同名称");	//1
		titles.add("合同编号");	//2
		titles.add("合同金额");	//3
		titles.add("签约方");	//4
		titles.add("合同签订使用时间");	//5
		titles.add("项目");	//6
		titles.add("签约时间");	//7
		titles.add("押金");	//8
		titles.add("印花税");	//9
		titles.add("印花税计提月份");	//10
		titles.add("税目");	//11
		titles.add("方式");	//12
		titles.add("经办人");	//13
		titles.add("合同类型");	//14
		titles.add("招待票");	//15
		dataMap.put("titles", titles);
		List<PageData> varOList = contractService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("CONTRACTNAME"));	    //1
			vpd.put("var2", varOList.get(i).getString("CONTRACTNUM"));	    //2
			vpd.put("var3", varOList.get(i).get("CONTRACTPIC").toString());	//3
			vpd.put("var4", varOList.get(i).getString("CONTRACTOFNAME"));	    //4
			vpd.put("var5", varOList.get(i).getString("FUSEDATE"));	    //5
			vpd.put("var6", varOList.get(i).getString("PROJECT"));	    //6
			vpd.put("var7", varOList.get(i).getString("FDATE"));	    //7
			vpd.put("var8", varOList.get(i).get("DEPOSIT").toString());	//8
			vpd.put("var9", varOList.get(i).get("STAMPDUTY").toString());	//9
			vpd.put("var10", varOList.get(i).getString("STAMPDUTYMONTH"));	    //10
			vpd.put("var11", varOList.get(i).getString("TAXITEMS"));	    //11
			vpd.put("var12", varOList.get(i).getString("MODE"));	    //12
			vpd.put("var13", varOList.get(i).getString("OPERATOR"));	    //13
			vpd.put("var14", varOList.get(i).getString("CONTRACTTYPES"));	    //14
			vpd.put("var15", varOList.get(i).getString("INVITATIONTICKET"));	    //15
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
