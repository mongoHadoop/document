package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IReportDao {
	
	public Map querySumBySubject(Map param) throws Exception;
	public List queryDocInfoMoney(Map map) throws Exception ;
}
