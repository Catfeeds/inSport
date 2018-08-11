package com.fh.service.management.filemeans.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.filemeans.FileMeansManager;

/** 
 * 说明： 资料文件管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 * @version
 */
@Service("filemeansService")
public class FileMeansService implements FileMeansManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("FileMeansMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("FileMeansMapper.delete", pd);
	}

	public void deleteByUrl(PageData pd)throws Exception{
		dao.delete("FileMeansMapper.deleteByUrl", pd);
	}

	public void deletePassUser(PageData pd)throws Exception{
		dao.update("FileMeansMapper.deletePassUser", pd);
	}

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("FileMeansMapper.edit", pd);
	}

	public void editName(PageData pd)throws Exception{
		dao.update("FileMeansMapper.editName", pd);
	}

	public void editPassUser(PageData pd)throws Exception{
		dao.update("FileMeansMapper.editPassUser", pd);
	}

	public void editJurisdiction(PageData pd)throws Exception{
		dao.update("FileMeansMapper.editJurisdiction", pd);
	}

	public void resetPassWord(PageData pd)throws Exception{
		dao.update("FileMeansMapper.resetPassWord", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.listAll", pd);
	}

	public List<PageData> listByFILE_CATALOGURL_ID_NotENCTYPT(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.listByFILE_CATALOGURL_ID_NotENCTYPT", pd);
	}

	public List<PageData> listByFILE_CATALOGURL_ID_ENCTYPT(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.listByFILE_CATALOGURL_ID_ENCTYPT", pd);
	}

	public List<PageData> listENCTYPTByYourself(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.listEnctyptByYourself", pd);
	}

	//自己上传的不加密文件
	public List<PageData> listNot_EnctyptByYourself(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FileMeansMapper.listNot_EnctyptByYourself", pd);
	}

	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileMeansMapper.findById", pd);
	}

	public PageData findByUrl(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FileMeansMapper.findByUrl", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FileMeansMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

