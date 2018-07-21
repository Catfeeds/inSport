package com.fh.controller.management.filecatalog;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.filecatalog.FileCatalogManager;
import com.fh.service.management.filemeans.FileMeansManager;
import com.fh.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 */
@Controller
@RequestMapping(value="/fileupata")
public class FileUpDataController extends BaseController {

	@Resource(name="filemeansService")
	private FileMeansManager filemeansService;

	@Resource(name="filecatalogService")
	private FileCatalogManager filecatalogService;
	/*
	去增加图片页面
	 */
	@RequestMapping(value="/goAddPic")
	public ModelAndView goAddPic() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd);
		mv.setViewName("management/fileupdata/pictures_add");
		mv.addObject("pd", pd);
		return mv;
	}

	/*
	去增加图片页面
	 */
	@RequestMapping(value="/goAddFile")
	public ModelAndView goAddFile() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd);
		mv.setViewName("management/fileupdata/file_add");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/savePic")
	@ResponseBody
	public Object savePic(
			@RequestParam(required=false) MultipartFile file, @RequestParam(value="FNAME",required=false)String FNAME
			, @RequestParam(value="FITEMID",required=false)String FITEMID
			, @RequestParam(value="FILE_READUSERS",required=false)String FILE_READUSERS
			, @RequestParam(value="FILE_PASSWORD",required=false)String FILE_PASSWORD
			, @RequestParam(value="FILE_ISENCTYPT",required=false)String FILE_ISENCTYPT
			, @RequestParam(value="FILE_ISPRIVATE",required=false)String FILE_ISPRIVATE
	) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String fileOriginalName = file.getOriginalFilename();
		String fileType = file.getContentType();
		//System.out.println("---------------文件目录："+FNAME);
		//System.out.println("原文件名字："+fileOriginalName+"，文件类别："+fileType);
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		String filePath = "";
		if (null != file && !file.isEmpty()) {
			filePath = PathUtil.getClasspath() + Const.FILEPATH + FNAME;		//文件上传路径
			System.out.println(PathUtil.getClasspath());
			//filePath = "static/images/contract/" + ffile;		//文件上传路径
			//fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			fileName = FileUpload.fileUpNotType(file, filePath, fileOriginalName);				//执行上传
		}else{
			System.out.println("上传失败");
		}
		String urlPrefix = filePath.substring(0,filePath.lastIndexOf("WEB-INF/classes/"));
		pd.put("FILEMEANS_ID", this.get32UUID());
		pd.put("FILENAME", fileOriginalName);
		pd.put("FILE_URL", filePath.substring(urlPrefix.length(),filePath.length())+"/"+fileOriginalName);
		pd.put("FILE_CREATETIME", new Date());
		pd.put("FILE_JURISDICTION", "1");
		pd.put("FILE_TYPE", fileType);
		pd.put("FILE_CREATEUSER", Jurisdiction.getUsername());
		pd.put("FILE_DOWNLOAD", 0);
		pd.put("FILE_READ", 0);
		pd.put("FILE_CATALOGURL", FNAME);
		pd.put("FILE_CATALOGURL_ID",Integer.parseInt(FITEMID));
		pd.put("FILE_READUSERS", FILE_READUSERS);
		pd.put("FILE_PASSWORD", FILE_PASSWORD);
		pd.put("FILE_ISENCTYPT", FILE_ISENCTYPT);
		pd.put("FILE_ISPRIVATE", FILE_ISPRIVATE);
		filemeansService.save(pd);
		//contractpictureService.save(pd);
		//Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}

	@RequestMapping(value="/deleteFile")
	@ResponseBody
	public Map<String,String> deleteFile(Page page) throws Exception{
		Map<String,String> json = new HashMap<String,String>();
		PageData pd = this.getPageData();
		//System.out.println(pd.getString("FILE_URL"));
		String fileUrl= "D:/【源码】maven_sqlsever_版本/MVNFHS/target/inSport/"+pd.getString("FILE_URL");
		File file = new File(fileUrl);
		file.delete();
		filemeansService.deleteByUrl(pd);
		json.put("result", "ok");
		return json;
	}

	@RequestMapping(value="/deleteFileCatalog")
	@ResponseBody
	public Map<String,String> deleteFileCatalog(Page page) throws Exception{
		Map<String,String> json = new HashMap<String,String>();
		PageData pd = this.getPageData();
		//System.out.println(pd);
		filecatalogService.deleteByItemid(pd);
		filecatalogService.deleteByPid(pd);
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
		/*String fileUrl= "D:/【源码】maven_sqlsever_版本/MVNFHS/target/inSport/"+pd.getString("FILE_URL");
		File file = new File(fileUrl);
		file.delete();
		filemeansService.deleteByUrl(pd);*/
		json.put("result", "ok");
		return json;
	}

	@RequestMapping(value="/goEditName")
	public ModelAndView goEditName() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//System.out.println(pd);
		mv.setViewName("management/fileupdata/fileEditName");
		mv.addObject("pd", pd);
		return mv;
	}

	@RequestMapping(value="/editFile")
	public ModelAndView editFile(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		//System.out.println("pd------------------>"+pd);
		String oldName = pd.getString("FILE_URL");
		String qz = PathUtil.getClasspath();
		String fileUrl= qz + pd.getString("FILE_URL");
		File file = new File(fileUrl);
		String newName =pd.getString("FNAME") + oldName.substring(oldName.lastIndexOf("."),oldName.length());
		String newUrl = oldName.substring(0,oldName.lastIndexOf("/")+1) + newName;
		pd.put("FILENAME",newName);
		pd.put("newUrl",newUrl);
		//System.out.println("pd："+pd);
		file.renameTo(new File(qz + newUrl));
		filemeansService.editName(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
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
}
