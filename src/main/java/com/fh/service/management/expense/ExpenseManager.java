package com.fh.service.management.expense;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 水电费接口
 * 创建人：FH Q313596790
 * 创建时间：2018-06-27
 * @version
 */
public interface ExpenseManager{

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

	public void deleteByEWAndINvID(PageData pd)throws Exception;

	public void deleteByUtiliID(PageData pd)throws Exception;

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;

	public void editState(PageData pd)throws Exception;

	public void editThisMonth(PageData pd)throws Exception;

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

	public List<PageData> listWaByUtilitiesId(PageData pd)throws Exception;

	public List<PageData> listElByUtilitiesId(PageData pd)throws Exception;

	/*
	通过合同id，获取最新的水电项明细
	 */
	public List<PageData> listLastExpense(PageData pd)throws Exception;

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
}

