package com.fh.service.management.utilitiesstate.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.utilitiesstate.UtilitiesStateManager;

/** 
 * 说明： 水电费收款情况
 * 创建人：FH Q313596790
 * 创建时间：2018-06-30
 * @version
 */
@Service("utilitiesstateService")
public class UtilitiesStateService implements UtilitiesStateManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("UtilitiesStateMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("UtilitiesStateMapper.delete", pd);
	}

	public void deleteByContractId(PageData pd)throws Exception{
		dao.delete("UtilitiesStateMapper.deleteByContractId", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("UtilitiesStateMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UtilitiesStateMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UtilitiesStateMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UtilitiesStateMapper.findById", pd);
	}

	public PageData findByInvoiceId(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UtilitiesStateMapper.findByInvoiceId", pd);
	}

	public PageData findByIdWithPname(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UtilitiesStateMapper.findByIdWithPname", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UtilitiesStateMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

