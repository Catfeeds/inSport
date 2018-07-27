package com.fh.service.management.contract;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 合同管理接口
 * 创建人：FH Q313596790
 * 创建时间：2018-04-08
 * @version
 */
public interface ContractManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;

	public void editRelevance(PageData pd)throws Exception;

	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;

	/*
	获取现有签约的公司
	 */
	public List<PageData> listConToName(PageData pd)throws Exception;

	/**
	 * 未付款发票项
	 * @param
	 * @return
	 * @throws Exception
     */
	public List<PageData> listNotInvoice(PageData pd)throws Exception;

	/**
	 * 未付款水电项
	 * @param
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listNotUtili(PageData pd)throws Exception;

	/**
	 * 未付款押金项
	 * @param
	 * @return
	 * @throws Exception
     */
	public List<PageData> listNotDeposit(PageData pd)throws Exception;

	/**
	 *提醒时间段需收款合同
	 * @param pd
	 * @return
	 * @throws Exception
     */
	public List<PageData> listTimeToContract(PageData pd)throws Exception;

	public List<PageData> datalistPageByDept(Page page)throws Exception;

	public List<PageData> listRelevance(String[] ArrayDATA_IDS)throws Exception;

	public List<PageData> listNotPayTime(String[] ArrayDATA_IDS)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;

	public PageData findMaxNo(PageData pd)throws Exception;

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

