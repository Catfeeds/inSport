package com.fh.controller.management.contract;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.contract.ContractManager;
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

	@Resource(name="contractService")
	private ContractManager contractService;

	@RequestMapping(value = "/client_proceeds")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CONTRACTTYPES","收款合同");
		List<PageData> listConToName = contractService.listConToName(pd);
		mv.setViewName("management/contract/client_proceeds");
		mv.addObject("listConToName", listConToName);
		return mv;
	}

	@RequestMapping(value="/getNotContract")
	@ResponseBody
	public Map<String, Object> getNotContract(Page page) throws Exception{
		Map<String, Object> json = new HashMap<String, Object>();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> listNotInvoice = contractService.listNotInvoice(pd);
		List<PageData> listNotUtili = contractService.listNotUtili(pd);
		List<PageData> listNotDeposit = contractService.listNotDeposit(pd);
		json.put("listNotInvoice",listNotInvoice);
		json.put("listNotUtili",listNotUtili);
		json.put("listNotDeposit",listNotDeposit);
		json.put("pd",pd);
		return  json;
	}
}
