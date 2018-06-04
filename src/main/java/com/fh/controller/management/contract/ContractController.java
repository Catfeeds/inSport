package com.fh.controller.management.contract;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.annotation.Resource;

import com.fh.service.management.classify.ClassifyManager;
import com.fh.service.management.contractpicture.ContractPictureManager;
import com.fh.service.management.departmentgroup.DepartmentGroupManager;
import com.fh.service.management.depositinfo.DepositInfoManager;
import com.fh.service.management.deptno.DeptnoManager;
import com.fh.service.management.invoice.InvoiceManager;
import com.fh.service.management.mode.ModeManager;
import com.fh.service.management.officecontract.OfficeContractManager;
import com.fh.service.management.officedetail.OfficeDetailManager;
import com.fh.service.management.officeprimary.OfficePrimaryManager;
import com.fh.service.management.operator.OperatorManager;
import com.fh.service.management.paydetail.PayDetailManager;
import com.fh.service.management.paymentcontract.PaymentContractManager;
import com.fh.service.management.payprimary.PayPrimaryManager;
import com.fh.service.management.paytable.PayTableManager;
import com.fh.service.management.proceedscontract.ProceedsContractManager;
import com.fh.service.management.taxitems.TaxItemsManager;
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

	@Resource(name="paytableService")
	private PayTableManager paytableService;

	@Resource(name="classifyService")
	private ClassifyManager classifyService;

	@Resource(name="contractpictureService")
	private ContractPictureManager contractpictureService;

	@Resource(name="modeService")
	private ModeManager modeService;

	@Resource(name="paymentcontractService")
	private PaymentContractManager paymentcontractService;

	@Resource(name="proceedscontractService")
	private ProceedsContractManager proceedscontractService;

	@Resource(name="taxitemsService")
	private TaxItemsManager taxitemsService;

	@Resource(name="deptnoService")
	private DeptnoManager deptnoService;

	@Resource(name="payprimaryService")
	private PayPrimaryManager payprimaryService;

	@Resource(name="paydetailService")
	private PayDetailManager paydetailService;

	@Resource(name="officecontractService")
	private OfficeContractManager officecontractService;

	@Resource(name="operatorService")
	private OperatorManager operatorService;

	@Resource(name="departmentgroupService")
	private DepartmentGroupManager departmentgroupService;

	@Resource(name="officeprimaryService")
	private OfficePrimaryManager officeprimaryService;

	@Resource(name="officedetailService")
	private OfficeDetailManager officedetailService;

	@Resource(name="depositinfoService")
	private DepositInfoManager depositinfoService;

	@Resource(name="invoiceService")
	private InvoiceManager invoiceService;
	// 树
	@RequestMapping(value = "/listTree")
	public ModelAndView listTree() throws Exception {
		ModelAndView mv = new ModelAndView();
		// mv.addObject("zNodes", jsStr);
		mv.setViewName("management/contract/contract_tree");
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
			arr = JSONArray.fromObject(classifyService.listAll(pd));
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

	@RequestMapping(value="/list_one")
	public ModelAndView list_one(Page page) throws Exception{
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd);
		if("收款合同".equals(pd.getString("CONTRACTTYPES"))){
			PageData pd1 = proceedscontractService.findByContractId(pd);	//列出ProceedsContract列表
			mv.setViewName("management/proceedscontract/proceedscontract_list_one");
			mv.addObject("pd1", pd1);
		}else if("付款合同".equals(pd.getString("CONTRACTTYPES"))){
			PageData pd1 = paymentcontractService.findByContractId(pd);
			mv.setViewName("management/paymentcontract/paymentcontract_list_one");
			mv.addObject("pd1", pd1);
		}
		mv.addObject("pd", pd);
		return mv;
	}
	
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
		/*if ("收款合同".equals(pd.getString("CONTRACTTYPES")) && "写字楼".equals(pd.getString("CONTRACTCLASSIFY"))){
			PageData pd3 = new PageData();
			pd3.put("OFFICECONTRACT_ID",get32UUID());
			pd3.put("RECEIVABLE_O",pd.getString("RECEIVABLE_O"));
			pd3.put("PAYTIME_O",pd.getString("PAYTIME_O"));
			pd3.put("RECEIVABLE_REALITY_O",pd.getString("RECEIVABLE_REALITY_O"));
			pd3.put("RECEIVABL_PAYTIME_O",pd.getString("RECEIVABL_PAYTIME_O"));
			pd3.put("PAYERNAME_O",pd.getString("PAYERNAME_O"));
			pd3.put("INVOICENAME_O",pd.getString("INVOICENAME_O"));
			pd3.put("INVOICETIME_O",pd.getString("INVOICETIME_O"));
			pd3.put("RECEIVABLECASH_O",pd.getString("RECEIVABLECASH_O"));
			pd3.put("RECEIVABLE_REALITY2_O",pd.getString("RECEIVABLE_REALITY2_O"));
			pd3.put("RECEIVABL_PAYTIME2_O",pd.getString("RECEIVABL_PAYTIME2_O"));
			pd3.put("PAYERNAME2_O",pd.getString("PAYERNAME2_O"));
			pd3.put("PAYTIME2_O",pd.getString("PAYTIME2_O"));
			pd3.put("ENTERTIME_O",pd.getString("ENTERTIME_O"));
			pd3.put("ISENTERPROCEDURE_O",pd.getString("ISENTERPROCEDURE_O"));
			pd3.put("WITHDRAWALTIME_O",pd.getString("WITHDRAWALTIME_O"));
			pd3.put("ISDRAWALPROCEDURE_O",pd.getString("ISDRAWALPROCEDURE_O"));
			pd3.put("RETURNCASH_O",pd.getString("RETURNCASH_O"));
			pd3.put("TRAINCOAMOUNT_O",pd.getString("TRAINCOAMOUNT_O"));
			pd3.put("INVOICENAME2_O",pd.getString("INVOICENAME2_O"));
			pd3.put("INVOICETIME2_O",pd.getString("INVOICETIME2_O"));
			pd3.put("RECEIVABLECASH1_O",pd.getString("RECEIVABLECASH1_O"));
			pd3.put("PAYTIME3_O",pd.getString("PAYTIME3_O"));
			pd3.put("RECEIVABLE_REALITY3_O",pd.getString("RECEIVABLE_REALITY3_O"));
			pd3.put("RECEIVABL_PAYTIME3_O",pd.getString("RECEIVABL_PAYTIME3_O"));
			pd3.put("PAYERNAME3_O",pd.getString("PAYERNAME3_O"));
			pd3.put("RETURNCASH1_O",pd.getString("RETURNCASH1_O"));
			pd3.put("TRAINCOAMOUNT1_O",pd.getString("TRAINCOAMOUNT1_O"));
			pd3.put("ENTERTIME1_O",pd.getString("ENTERTIME1_O"));
			pd3.put("ISENTERPROCEDURE1_O",pd.getString("ISENTERPROCEDURE1_O"));
			pd3.put("WITHDRAWALTIME1_O",pd.getString("WITHDRAWALTIME1_O"));
			pd3.put("ISDRAWALPROCEDURE1_O",pd.getString("ISDRAWALPROCEDURE1_O"));
			pd3.put("INVOICENAME3_O",pd.getString("INVOICENAME3_O"));
			pd3.put("INVOICETIME3_O",pd.getString("INVOICETIME3_O"));
			pd3.put("OVERDUE_O",pd.getString("OVERDUE_O"));
			pd3.put("REMARK_O",pd.getString("REMARK_O"));
			pd3.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			officecontractService.save(pd3);
		}*/
		if (pd.getString("CONTRACTTYPES") == "付款合同"){
			PageData pd1 = new PageData();
			pd1.put("PAYMENTCONTRACT_ID",get32UUID());
			pd1.put("AMOUNT",pd.get("AMOUNT").toString());
			pd1.put("DUE_AMOUNT",pd.get("DUE_AMOUNT").toString());
			pd1.put("REALITY_AMOUNT",pd.get("REALITY_AMOUNT").toString());
			pd1.put("REALITYTIME",pd.get("REALITYTIME").toString());
			pd1.put("PAYDAY",pd.getString("PAYDAY"));
			pd1.put("REMARK",pd.getString("REMARK"));
			pd1.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			paymentcontractService.save(pd1);
		}
		if ("收款合同".equals(pd.getString("CONTRACTTYPES"))){
			PageData pd2 = new PageData();
			pd2.put("PROCEEDSCONTRACT_ID",get32UUID());
			pd2.put("PRINCIPAL",pd.getString("PRINCIPAL"));
			pd2.put("RECEIVABLE",pd.get("RECEIVABLE").toString());
			pd2.put("PAYERNAME",pd.getString("PAYERNAME"));
			pd2.put("PAYTIME",pd.getString("PAYTIME"));
			//pd2.put("ISPAY",Integer.parseInt(pd.get("ISPAY").toString()));
			pd2.put("RECEIVABLE_REALITY",pd.get("RECEIVABLE_REALITY").toString());
			pd2.put("RECEIVABL_PAYTIME",pd.getString("RECEIVABL_PAYTIME"));
			pd2.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			pd2.put("OVERDUE",pd.getString("OVERDUE"));
			pd2.put("FREMARK",pd.getString("FREMARK"));
			//pd.put("CONTRACT_ID", this.get32UUID());	//主键
			proceedscontractService.save(pd2);
		}
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

	/**
	 * 打开openPayT供应商付款表格
	 * @param
	 * @return
	 * @throws Exception
     */
	@RequestMapping(value="/openPayT")
	public ModelAndView openPayT(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = contractService.findById(pd);
		List<PageData> listPayprimary = payprimaryService.findByContractId(pd); //主表
		List<PageData> listPayDetail = paydetailService.listByContractId(pd);  //明细
		mv.setViewName("management/contract/contract_openpay");
		if(listPayprimary == null || "".equals(listPayprimary)){
			pd.put("PAYPRIMARY_ID",this.get32UUID());
		}
		mv.addObject("pd", pd);
		mv.addObject("listPayprimary", listPayprimary);
		mv.addObject("count", listPayDetail.size());
		mv.addObject("listPayDetail", listPayDetail);
		return mv;
	}

	@RequestMapping(value="/openOfficeT")
	public ModelAndView openOfficeT(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = contractService.findById(pd);
		List<PageData> listOfficeprimary = officeprimaryService.listByContractId(pd); //主表
		List<PageData> listOfficeDetail = officedetailService.listByContractId(pd);  //明细
		if(listOfficeprimary == null || "".equals(listOfficeprimary)){
			pd.put("OFFICEPRIMARY_ID",this.get32UUID());
		}
		mv.setViewName("management/contract/contract_openoffice");
		mv.addObject("pd", pd);
		mv.addObject("listOfficeprimary", listOfficeprimary);
		mv.addObject("count", listOfficeDetail.size());
		mv.addObject("listOfficeDetail", listOfficeDetail);
		return mv;
	}
	/*@RequestMapping(value="/openPayT")
	public ModelAndView openPayT(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = contractService.findById(pd);
		int start_year = Integer.valueOf(pd.getString("FUSEDATESTART").substring(0,4));
		int end_year = Integer.valueOf(pd.getString("FUSEDATEENT").substring(0,4));
		int start_month = Integer.valueOf(pd.getString("FUSEDATESTART").substring(5,7));
		int end_month = Integer.valueOf(pd.getString("FUSEDATEENT").substring(5,7));
		System.out.println(pd);
		PageData payPd = paymentcontractService.findByContractId(pd);
		List<PageData> listpays = paytableService.findByContractId(pd);
		ArrayList<String> arr = new ArrayList<String>();
		PageData maxpd = paytableService.findtime_max(pd);
		PageData sumPaypd = paytableService.findPay_sum(pd);
		Double everyMonthPay;
		Double onPayPic;
		DecimalFormat df = new DecimalFormat("#0.00");
		DecimalFormat dften=new DecimalFormat("00");
		String payDay = dften.format(Integer.valueOf(payPd.getString("PAYDAY")));
		//当已经存在有付款数据时---
		if(maxpd != null && !"".equals(maxpd)){
			int max_year = Integer.valueOf(maxpd.getString("SHPAYTIME").substring(0,4));
			int max_month = Integer.valueOf(maxpd.getString("SHPAYTIME").substring(5,maxpd.getString("SHPAYTIME").lastIndexOf("-")));
			if((end_year - max_year) == 0){
				for (int i = max_month+1; i <= end_month; i++) {
					arr.add(max_year+"-"+dften.format(i)+"-"+payDay);
				}
			}else {
				for (int i = max_month+1; i <= 12; i++) {
					arr.add(max_year+"-"+dften.format(i)+"-"+payDay);
				}
				for (int i = max_year+1; i < end_year; i++) {
					for (int j = 1; j < 13; j++) {
						arr.add(i+"-"+dften.format(j)+"-"+payDay);
					}

				}
				for (int i = 1; i <= end_month; i++) {
					arr.add(end_year+"-"+dften.format(i)+"-"+payDay);
				}
			}
			mv.addObject("count", arr.size()+listpays.size());
			onPayPic = Double.valueOf(pd.get("CONTRACTPIC").toString()) - Double.valueOf(sumPaypd.get("SUM_REALITYPAY").toString());
		}else {
			if((end_year - start_year) == 0){
				for (int i = start_month; i <= end_month; i++) {
					arr.add(start_year+"-"+dften.format(i)+"-"+payDay);
				}
			}else {
				for (int i = start_month; i <= 12; i++) {
					arr.add(start_year+"-"+dften.format(i)+"-"+payDay);
				}
				for (int i = start_year+1; i < end_year; i++) {
					for (int j = 1; j < 13; j++) {
						arr.add(i+"-"+dften.format(j)+"-"+payDay);
					}

				}
				for (int i = 1; i <= end_month; i++) {
					arr.add(end_year+"-"+dften.format(i)+"-"+payDay);
				}
			}
			onPayPic = Double.valueOf(pd.get("CONTRACTPIC").toString());
			mv.addObject("count", arr.size());
		}
		//未付款金额
		everyMonthPay = onPayPic / arr.size();
		mv.setViewName("management/contract/contract_openpay");
		mv.addObject("listpays", listpays);
		mv.addObject("arr", arr);
		mv.addObject("onPayPic", onPayPic);
		pd.put("PAYPRIMARY_ID",this.get32UUID());
		mv.addObject("pd", pd);
		mv.addObject("everyMonthPay", df.format(everyMonthPay));
		mv.addObject("payPd", payPd);
		return mv;
	}*/

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
		String fileOriginalName = file.getOriginalFilename();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){
			if (null != file && !file.isEmpty()) {
				filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile;		//文件上传路径
				//filePath = "static/images/contract/" + ffile;		//文件上传路径
				fileName = FileUpload.fileUpNotType(file, filePath, fileOriginalName);				//执行上传
			}else{
				System.out.println("上传失败");
			}
			String urlPrefix = filePath.substring(0,filePath.lastIndexOf("WEB-INF/classes/"));
			pd.put("CONTRACTPICTURE_ID", this.get32UUID());
			pd.put("NAME", fileName);
			pd.put("URL_PIC", filePath.substring(urlPrefix.length(),filePath.length())+"/"+fileOriginalName);
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
		/*if ("收款合同".equals(pd.getString("CONTRACTTYPES")) && "写字楼".equals(pd.getString("CONTRACTCLASSIFY"))){
			PageData pd3 = new PageData();
			if(pd.getString("OFFICECONTRACT_ID") == null || "".equals(pd.getString("OFFICECONTRACT_ID"))){
				pd3.put("OFFICECONTRACT_ID",get32UUID());
			}else {
				pd3.put("OFFICECONTRACT_ID",pd.getString("OFFICECONTRACT_ID"));
			}
			pd3.put("RECEIVABLE_O",pd.getString("RECEIVABLE_O"));
			pd3.put("PAYTIME_O",pd.getString("PAYTIME_O"));
			pd3.put("RECEIVABLE_REALITY_O",pd.getString("RECEIVABLE_REALITY_O"));
			pd3.put("RECEIVABL_PAYTIME_O",pd.getString("RECEIVABL_PAYTIME_O"));
			pd3.put("PAYERNAME_O",pd.getString("PAYERNAME_O"));
			pd3.put("INVOICENAME_O",pd.getString("INVOICENAME_O"));
			pd3.put("INVOICETIME_O",pd.getString("INVOICETIME_O"));
			pd3.put("RECEIVABLECASH_O",pd.getString("RECEIVABLECASH_O"));
			pd3.put("RECEIVABLE_REALITY2_O",pd.getString("RECEIVABLE_REALITY2_O"));
			pd3.put("RECEIVABL_PAYTIME2_O",pd.getString("RECEIVABL_PAYTIME2_O"));
			pd3.put("PAYERNAME2_O",pd.getString("PAYERNAME2_O"));
			pd3.put("ENTERTIME_O",pd.getString("ENTERTIME_O"));
			pd3.put("PAYTIME2_O",pd.getString("PAYTIME2_O"));
			pd3.put("ISENTERPROCEDURE_O",pd.getString("ISENTERPROCEDURE_O"));
			pd3.put("WITHDRAWALTIME_O",pd.getString("WITHDRAWALTIME_O"));
			pd3.put("ISDRAWALPROCEDURE_O",pd.getString("ISDRAWALPROCEDURE_O"));
			pd3.put("RETURNCASH_O",pd.getString("RETURNCASH_O"));
			pd3.put("TRAINCOAMOUNT_O",pd.getString("TRAINCOAMOUNT_O"));
			pd3.put("INVOICENAME2_O",pd.getString("INVOICENAME2_O"));
			pd3.put("INVOICETIME2_O",pd.getString("INVOICETIME2_O"));
			pd3.put("RECEIVABLECASH1_O",pd.getString("RECEIVABLECASH1_O"));
			pd3.put("PAYTIME3_O",pd.getString("PAYTIME3_O"));
			pd3.put("RECEIVABLE_REALITY3_O",pd.getString("RECEIVABLE_REALITY3_O"));
			pd3.put("RECEIVABL_PAYTIME3_O",pd.getString("RECEIVABL_PAYTIME3_O"));
			pd3.put("PAYERNAME3_O",pd.getString("PAYERNAME3_O"));
			pd3.put("RETURNCASH1_O",pd.getString("RETURNCASH1_O"));
			pd3.put("TRAINCOAMOUNT1_O",pd.getString("TRAINCOAMOUNT1_O"));
			pd3.put("ENTERTIME1_O",pd.getString("ENTERTIME1_O"));
			pd3.put("ISENTERPROCEDURE1_O",pd.getString("ISENTERPROCEDURE1_O"));
			pd3.put("WITHDRAWALTIME1_O",pd.getString("WITHDRAWALTIME1_O"));
			pd3.put("ISDRAWALPROCEDURE1_O",pd.getString("ISDRAWALPROCEDURE1_O"));
			pd3.put("INVOICENAME3_O",pd.getString("INVOICENAME3_O"));
			pd3.put("INVOICETIME3_O",pd.getString("INVOICETIME3_O"));
			pd3.put("OVERDUE_O",pd.getString("OVERDUE_O"));
			pd3.put("REMARK_O",pd.getString("REMARK_O"));
			pd3.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			officecontractService.edit(pd3);
		}*/
		if ("付款合同".equals(pd.getString("CONTRACTTYPES"))){
			PageData pd1 = new PageData();
			if(pd.getString("PAYMENTCONTRACT_ID") == null || "".equals(pd.getString("PAYMENTCONTRACT_ID"))){
				pd1.put("PAYMENTCONTRACT_ID",get32UUID());
			}else {
				pd1.put("PAYMENTCONTRACT_ID",pd.getString("PAYMENTCONTRACT_ID"));
			}
			pd1.put("AMOUNT",pd.get("AMOUNT").toString());
			pd1.put("DUE_AMOUNT",pd.get("DUE_AMOUNT").toString());
			pd1.put("REALITY_AMOUNT",pd.get("REALITY_AMOUNT").toString());
			pd1.put("PAYDAY",pd.getString("PAYDAY"));
			pd1.put("REALITYTIME",pd.get("REALITYTIME").toString());
			pd1.put("REMARK",pd.getString("REMARK"));
			pd1.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			PageData findPayPd = paymentcontractService.findByContractId(pd);
			if (findPayPd == null){
				paymentcontractService.save(pd1);
			}else {
				paymentcontractService.edit(pd1);
			}
		}
		if ("收款合同".equals(pd.getString("CONTRACTTYPES"))){
			PageData findProPd = proceedscontractService.findByContractId(pd);
			PageData pd2 = new PageData();
			if(pd.getString("PROCEEDSCONTRACT_ID") == null || "".equals(pd.getString("PROCEEDSCONTRACT_ID"))){
				pd2.put("PROCEEDSCONTRACT_ID",get32UUID());
			}else {
				pd2.put("PROCEEDSCONTRACT_ID",pd.getString("PROCEEDSCONTRACT_ID"));
			}
			pd2.put("PRINCIPAL",pd.getString("PRINCIPAL"));
			pd2.put("RECEIVABLE",pd.get("RECEIVABLE").toString());
			pd2.put("PAYERNAME",pd.getString("PAYERNAME"));
			pd2.put("ISPAY",1);
			pd2.put("PAYTIME",pd.getString("PAYTIME"));
			pd2.put("RECEIVABLE_REALITY",pd.get("RECEIVABLE_REALITY").toString());
			pd2.put("RECEIVABL_PAYTIME",pd.getString("RECEIVABL_PAYTIME"));
			pd2.put("CONTRACT_ID",pd.getString("CONTRACT_ID"));
			pd2.put("FREMARK",pd.getString("FREMARK"));
			if (findProPd == null){
				proceedscontractService.save(pd2);
			}else {
				proceedscontractService.edit(pd2);
			}
		}
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
		System.out.println("用户："+Jurisdiction.getUsername());
		if(pd.getString("USERNAME") == null || "".equals(pd.getString("USERNAME"))){
			pd.put("USERNAME",Jurisdiction.getUsername());
		}
		PageData userpd = departmentgroupService.findUserlogin(pd);
		List<PageData>	varList = null;
		String DNAME = userpd.getString("DNAME");
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			keywords = URLDecoder.decode(keywords, "UTF-8");
			pd.put("keywords", keywords.trim());
		}
		String p_treeKey = pd.getString("p_treeKey");				//关键词检索条件
		if(null != p_treeKey && !"".equals(p_treeKey)){
			p_treeKey = URLDecoder.decode(p_treeKey, "UTF-8");
			pd.put("p_treeKey", p_treeKey.trim());
		}
		page.setPd(pd);
		if("总经办".equals(DNAME) || "财务部".equals(DNAME) || "综管部".equals(DNAME) ){
			/*String DEPTNAME = pd.getString("DEPTNAME");				//关键词检索条件
			if(null != DEPTNAME && !"".equals(DEPTNAME)){
				pd.put("DEPTNAME", DEPTNAME.trim());
			}
			String YEAR = pd.getString("YEAR");				//关键词检索条件
			if(null != YEAR && !"".equals(YEAR)){
				pd.put("YEAR", YEAR.trim());
			}*/
			varList = contractService.list(page);	//列出Contract列表
			List<PageData> listDept = deptnoService.listAll(pd);
			mv.addObject("listDept", listDept);
			mv.addObject("isDept", 1);
		}else {
			varList = contractService.datalistPageByDept(page);	//列出Contract列表
		}
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
	public ModelAndView goAdd(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CONTRACT_ID",this.get32UUID());
		List<PageData> listPIdClassify = classifyService.listPIdClassify(page);
		List<PageData> listOperator = operatorService.listAll(pd);
		List<PageData> listMode = modeService.listAll(pd);
		List<PageData> listItems = taxitemsService.listAll(pd);
		ArrayList<String> listmonth = new ArrayList<String>();
		List<PageData> listDeptNo = deptnoService.listAll(pd);
		DecimalFormat dften = new DecimalFormat("00");
		for (int i = 1; i <= 12; i++) {
			listmonth.add(dften.format(i));
		}
		mv.setViewName("management/contract/contract_edit");
		mv.addObject("msg", "save");
		mv.addObject("listDeptNo",listDeptNo);
		mv.addObject("listOperator",listOperator);
		mv.addObject("listPIdClassify", listPIdClassify);
		mv.addObject("listmonth", listmonth);
		mv.addObject("listItems", listItems);
		mv.addObject("listMode", listMode);
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = contractService.findById(pd);	//根据ID读取
		page.setPd(pd);
		List<PageData> listPIdClassify = classifyService.listPIdClassify(page);
		List<PageData> listDepositInfo = depositinfoService.listByContractId(pd);
		List<PageData> listInvoice = invoiceService.listByContractId(pd);
		List<PageData> listMode = modeService.listAll(pd);
		List<PageData> listOperator = operatorService.listAll(pd);
		PageData pd1 = paymentcontractService.findByContractId(pd);
		PageData pd2 = proceedscontractService.findByContractId(pd);
		//PageData pd3 = officecontractService.findByContractId(pd);
		List<PageData> listItems = taxitemsService.listAll(pd);
		ArrayList<String> listmonth = new ArrayList<String>();
		List<PageData> listDeptNo = deptnoService.listAll(pd);
		DecimalFormat dften = new DecimalFormat("00");
		for (int i = 1; i <= 12; i++) {
			listmonth.add(dften.format(i));
		}
		mv.setViewName("management/contract/contract_edit");
		mv.addObject("msg", "editInfo");
		mv.addObject("listDeptNo",listDeptNo);
		mv.addObject("listOperator",listOperator);
		mv.addObject("listmonth", listmonth);
		mv.addObject("listPIdClassify", listPIdClassify);
		mv.addObject("listMode", listMode);
		mv.addObject("listInvoice", listInvoice);
		mv.addObject("listDepositInfo", listDepositInfo);
		mv.addObject("listItems", listItems);
		mv.addObject("pd", pd);
		mv.addObject("pd1", pd1);
		mv.addObject("pd2", pd2);
		//mv.addObject("pd3", pd3);
		return mv;
	}

	@RequestMapping(value = "/findMaxNo")
	@ResponseBody
	public Map<String, Object> findMaxNo(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		page.setPd(pd);
		PageData maxNo = contractService.findMaxNo(pd);
		//System.out.println(maxNo);
		if(maxNo != null && !"".equals(maxNo)){
			DecimalFormat dften = new DecimalFormat("000");
			String maxStr = maxNo.getString("maxNo");
			int max = Integer.parseInt(maxStr.substring(maxStr.length()-2,maxStr.length())) + 1;
			System.out.println("输出最大数:"+dften.format(max));
			json.put("maxNo",dften.format(max));
		}else {
			json.put("maxNo","01");
		}
		return  json;
	}


	@RequestMapping(value = "/listCheClassify")
	@ResponseBody
	public Map<String, Object> listCheClassify(Page page)throws Exception {
		PageData pd = new PageData();
		Map<String, Object> json = new HashMap<String, Object>();
		pd = this.getPageData();
		String FPARENTID = pd.getString("FPARENTID"); // 关键词检索条件
		if (null != FPARENTID && !"".equals(FPARENTID)) {
			pd.put("keywords", FPARENTID.trim());
		}
		page.setPd(pd);
		List<PageData> listCheClassify = classifyService.listIdClassify(page);
		System.out.println(listCheClassify);
		json.put("listCheClassify",listCheClassify);
		return  json;
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
