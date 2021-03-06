package com.fh.service.management.filecatalog.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.filecatalog.FileCatalogManager;

/** 
 * 说明： 文件目录
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 * @version
 */
@Service("filecatalogService")
public class FileCatalogService implements FileCatalogManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FileCatalogMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FileCatalogMapper.delete", pd);
	}

	public void deleteByItemid(PageData pd)throws Exception{
		dao.delete("FileCatalogMapper.deleteByItemid", pd);
	}

	public void deleteByPid(PageData pd)throws Exception{
		dao.delete("FileCatalogMapper.deleteByPid", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FileCatalogMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FileCatalogMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileCatalogMapper.listAll", pd);
	}

	public List<PageData> list_catalog(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FileCatalogMapper.list_catalog", page);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileCatalogMapper.findById", pd);
	}

	public PageData findByNameAndPid(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileCatalogMapper.findByNameAndPid", pd);
	}

	public PageData findByFitemid(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileCatalogMapper.findByFitemid", pd);
	}

	public PageData findMax_Fitemid(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileCatalogMapper.findMax_Fitemid", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FileCatalogMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

