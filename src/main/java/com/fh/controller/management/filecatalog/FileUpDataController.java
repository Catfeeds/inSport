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
	) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增图片");
		Map<String,String> map = new HashMap<String,String>();
		String fileOriginalName = file.getOriginalFilename();
		String fileType = file.getContentType();
		System.out.println("原文件名字："+fileOriginalName+"，文件类别："+fileType);
		String  ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		String filePath = "";
		if (null != file && !file.isEmpty()) {
			filePath = PathUtil.getClasspath() + Const.FILEPATH + FNAME;		//文件上传路径
			System.out.println(filePath);
			//filePath = "static/images/contract/" + ffile;		//文件上传路径
			//fileName = FileUpload.fileUp(file, filePath, this.get32UUID());				//执行上传
			fileName = FileUpload.fileUpNotType(file, filePath, fileOriginalName);				//执行上传
		}else{
			System.out.println("上传失败");
		}
		pd.put("FILEMEANS_ID", this.get32UUID());
		pd.put("FILENAME", fileOriginalName);
		pd.put("FILE_URL", filePath.substring(47,filePath.length())+"/"+fileOriginalName);
		pd.put("FILE_CREATETIME", new Date());
		pd.put("FILE_JURISDICTION", "1");
		pd.put("FILE_TYPE", fileType);
		pd.put("FILE_CREATEUSER", Jurisdiction.getUsername());
		pd.put("FILE_DOWNLOAD", 0);
		pd.put("FILE_READ", 0);
		pd.put("FILE_CATALOGURL", fileOriginalName);
		pd.put("FILE_CATALOGURL_ID",Integer.parseInt(FITEMID));
		System.out.println(pd);
		filemeansService.save(pd);
		//contractpictureService.save(pd);
		//Watermark.setWatemark(PathUtil.getClasspath() + Const.FILEPATHIMG + ffile + "/" + fileName);//加水印
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}
}
