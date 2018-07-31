package com.fh.service.management.expense.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.expense.ExpenseManager;

/** 
 * 说明： 水电费
 * 创建人：FH Q313596790
 * 创建时间：2018-06-27
 * @version
 */
@Service("expenseService")
public class ExpenseService implements ExpenseManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ExpenseMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ExpenseMapper.delete", pd);
	}

	public void deleteByEWAndINvID(PageData pd)throws Exception{
		dao.delete("ExpenseMapper.deleteByEWAndINvID", pd);
	}

	public void deleteByUtiliID(PageData pd)throws Exception{
		dao.delete("ExpenseMapper.deleteByUtiliID", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ExpenseMapper.edit", pd);
	}

	public void editState(PageData pd)throws Exception{
		dao.update("ExpenseMapper.editState", pd);
	}

	public void editThisMonth(PageData pd)throws Exception{
		dao.update("ExpenseMapper.editThisMonth", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ExpenseMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ExpenseMapper.listAll", pd);
	}

	public List<PageData> listWaByUtilitiesId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ExpenseMapper.listWaByUtilitiesId", pd);
	}

	public List<PageData> listElByUtilitiesId(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ExpenseMapper.listElByUtilitiesId", pd);
	}

	public List<PageData> listLastExpense(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ExpenseMapper.listLastExpense", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ExpenseMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ExpenseMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

