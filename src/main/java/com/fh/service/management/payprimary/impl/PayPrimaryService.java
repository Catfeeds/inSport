package com.fh.service.management.payprimary.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.payprimary.PayPrimaryManager;

/** 
 * 说明： 付款合同主表
 * 创建人：FH Q313596790
 * 创建时间：2018-05-28
 * @version
 */
@Service("payprimaryService")
public class PayPrimaryService implements PayPrimaryManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("PayPrimaryMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("PayPrimaryMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("PayPrimaryMapper.edit", pd);
	}

	public void editNotPay(PageData pd)throws Exception{
		dao.update("PayPrimaryMapper.editNotPay", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PayPrimaryMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PayPrimaryMapper.listAll", pd);
	}

	public List<PageData> listNotPay(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PayPrimaryMapper.listNotPay", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PayPrimaryMapper.findById", pd);
	}

	public List<PageData> findByContractId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PayPrimaryMapper.findByContractId", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PayPrimaryMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

