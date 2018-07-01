package com.fh.service.management.proceedstime.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.proceedstime.ProceedsTimeManager;

/** 
 * 说明： 收款时间区间管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-26
 * @version
 */
@Service("proceedstimeService")
public class ProceedsTimeService implements ProceedsTimeManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProceedsTimeMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProceedsTimeMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProceedsTimeMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsTimeMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsTimeMapper.listAll", pd);
	}

	public List<PageData> listByContractId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsTimeMapper.listByContractId", pd);
	}

	public List<PageData> listByContractIdWithUre(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProceedsTimeMapper.listByContractIdWithUre", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProceedsTimeMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProceedsTimeMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

