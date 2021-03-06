package com.fh.service.management.departmentgroup.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.departmentgroup.DepartmentGroupManager;

/** 
 * 说明： 部门分组管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-01
 * @version
 */
@Service("departmentgroupService")
public class DepartmentGroupService implements DepartmentGroupManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("DepartmentGroupMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("DepartmentGroupMapper.delete", pd);
	}

	public void deleteByDepIDAndUID(PageData pd)throws Exception{
		dao.delete("DepartmentGroupMapper.deleteByDepIDAndUID", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("DepartmentGroupMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentGroupMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentGroupMapper.listAll", pd);
	}

	public List<PageData> listTree(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentGroupMapper.listTree", pd);
	}

	public List<PageData> listEmployee(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("DepartmentGroupMapper.listEmployee", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentGroupMapper.findById", pd);
	}

	public PageData findUserlogin(PageData pd)throws Exception{
		return (PageData)dao.findForObject("DepartmentGroupMapper.findUserlogin", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("DepartmentGroupMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

