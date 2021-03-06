package com.fh.service.management.proceedsdetail.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.proceedsdetail.ProceedsDetailManager;

/** 
 * 说明： 收款合同明细管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-09
 * @version
 */
@Service("proceedsdetailService")
public class ProceedsDetailService implements ProceedsDetailManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProceedsDetailMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProceedsDetailMapper.delete", pd);
	}

	public void deleteByProceedsPrimary(PageData pd)throws Exception{
		dao.delete("ProceedsDetailMapper.deleteByProceedsPrimary", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProceedsDetailMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsDetailMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsDetailMapper.listAll", pd);
	}

	public List<PageData> listByContractId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsDetailMapper.listByContractId", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProceedsDetailMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProceedsDetailMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

