package com.fh.service.management.invoice.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.invoice.InvoiceManager;

/** 
 * 说明： 发票模块
 * 创建人：FH Q313596790
 * 创建时间：2018-06-03
 * @version
 */
@Service("invoiceService")
public class InvoiceService implements InvoiceManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("InvoiceMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("InvoiceMapper.delete", pd);
	}

	public void deleteByContractId(PageData pd)throws Exception{
		dao.delete("InvoiceMapper.deleteByContractId", pd);
	}

	public void deleteByTimeID(PageData pd)throws Exception{
		dao.delete("InvoiceMapper.deleteByTimeID", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("InvoiceMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.datalistPage", page);
	}

	public List<PageData> officelistPage(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.officelistPage", page);
	}

	public List<PageData> otherlistPage(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.otherlistPage", page);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.listAll", pd);
	}

	public List<PageData> listByContractId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.listByContractId", pd);
	}

	public List<PageData> listByContractIdWithUre(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InvoiceMapper.listByContractIdWithUre", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InvoiceMapper.findById", pd);
	}

	public PageData findByInvoiceWithUre(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InvoiceMapper.findByInvoiceWithUre", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("InvoiceMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

