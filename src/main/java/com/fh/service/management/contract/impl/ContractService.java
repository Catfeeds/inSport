package com.fh.service.management.contract.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.management.contract.ContractManager;

/** 
 * 说明： 合同管理
 * 创建人：FH Q313596790
 * 创建时间：2018-04-08
 * @version
 */
@Service("contractService")
public class ContractService implements ContractManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ContractMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ContractMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ContractMapper.edit", pd);
	}

	public void editRelevance(PageData pd)throws Exception{
		dao.update("ContractMapper.editRelevance", pd);
	}

	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.datalistPage", page);
	}

	public List<PageData> datalistPageByDept(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.datalistPageByDept", page);
	}

	/**
	 获取现有签约的公司
	 */
	public List<PageData> listConToName(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listConToName", pd);
	}

	/**
	 未付款发票项
	 */
	public List<PageData> listNotInvoice(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listNotInvoice", pd);
	}

	/**
	 未付款水电项
	 */
	public List<PageData> listNotUtili(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listNotUtili", pd);
	}

	/**
	 未付款押金项
	 */
	public List<PageData> listNotDeposit(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listNotDeposit", pd);
	}

	public List<PageData> listTimeToContract(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listTimeToContract", pd);
	}

	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listAll", pd);
	}

	public List<PageData> listRelevance(String[] ArrayDATA_IDS)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listRelevance", ArrayDATA_IDS);
	}

	public List<PageData> listNotPayTime(String[] ArrayDATA_IDS)throws Exception{
		return (List<PageData>)dao.findForList("ContractMapper.listNotPayTime", ArrayDATA_IDS);
	}


	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ContractMapper.findById", pd);
	}

	public PageData findMaxNo(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ContractMapper.findMaxNo", pd);
	}

	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ContractMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

