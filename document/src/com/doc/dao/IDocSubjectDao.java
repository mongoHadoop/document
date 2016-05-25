package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IDocSubjectDao {

	public List queryDocSubject(Map param) throws Exception;
	
	public void  addDocSubjectData(List<Map> map)throws Exception;
	
	public void  updateDocSubjectData(List<Map> map)throws Exception;
	
	public void  deleteDocSubjectData(List<Map> map)throws Exception;
	
	
	public void  addDocSubjectData(Map map)throws Exception;
	
	public void  updateDocSubjectData(Map map)throws Exception;
	
	public void  deleteDocSubjectData(Map map)throws Exception;
}
