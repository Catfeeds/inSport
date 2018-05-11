package com.fh.service.management.paytable.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.paytable.PayTableManager;

/** 
 * 说明： 供应商付款表格
 * 创建人：FH Q313596790
 * 创建时间：2018-05-10
 * @version
 */
@Service("paytableService")
public class PayTableService implements PayTableManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("PayTableMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("PayTableMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("PayTableMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PayTableMapper.datalistPage", page);
	}

	public List<PageData> findByContractId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PayTableMapper.findByContractId", pd);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PayTableMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PayTableMapper.findById", pd);
	}

	public PageData findtime_max(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PayTableMapper.findtime_max", pd);
	}

	public PageData findPay_sum(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PayTableMapper.findPay_sum", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PayTableMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

