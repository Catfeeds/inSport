package com.fh.controller.management.contract;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.contractpicture.ContractPictureManager;
import com.fh.util.*;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/** 
 * 说明：合同图片管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-09
 */
@Controller
@RequestMapping(value="/contract_notr")
public class Contract_NotRController extends BaseController {

	@Resource(name="clientService")
	private ClientManager clientService;

	@RequestMapping(value = "/client_proceeds")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> listClients = clientService.listAll(pd);
		mv.setViewName("management/contract/client_proceeds");
		mv.addObject("listClients", listClients);
		return mv;
	}

	@RequestMapping(value="/getOneClient")
	@ResponseBody
	public Map<String, Object> getOneClient(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = clientService.findById(pd);
		json.put("pd",pd);
		return  json;
	}
}
