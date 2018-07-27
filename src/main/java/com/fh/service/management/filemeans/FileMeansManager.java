package com.fh.service.management.filemeans;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 资料文件管理接口
 * 创建人：FH Q313596790
 * 创建时间：2018-04-23
 * @version
 */
public interface FileMeansManager{

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

	public void deleteByUrl(PageData pd)throws Exception;

	public void deletePassUser(PageData pd)throws Exception;

	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;

	public void editName(PageData pd)throws Exception;

	public void editPassUser(PageData pd)throws Exception;

	public void editJurisdiction(PageData pd)throws Exception;

	public void resetPassWord(PageData pd)throws Exception;

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
	//无加密、有权限查阅的
	public List<PageData> listByFILE_CATALOGURL_ID_NotENCTYPT(PageData pd)throws Exception;
	//加密，有权限，未加密的
	public List<PageData> listByFILE_CATALOGURL_ID_ENCTYPT(PageData pd)throws Exception;
	//自己加密的
	public List<PageData> listENCTYPTByYourself(PageData pd)throws Exception;
	//自己不加密的
	public List<PageData> listNot_EnctyptByYourself(PageData pd)throws Exception;
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

