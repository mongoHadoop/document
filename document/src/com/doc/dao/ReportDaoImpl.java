package com.doc.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository(value="reportDao")
public  class ReportDaoImpl extends BaseDao implements IReportDao  {

	public Map querySumBySubject(Map param) throws Exception {
	 return (Map) this.getSqlMapClientTemplate().queryForObject("statis.staticsDocInfo", param);
	}

	public List queryDocInfoMoney(Map map) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("doc.staticsDocInfo",map);
	}

}
