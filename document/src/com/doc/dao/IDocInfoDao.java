package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IDocInfoDao {

	
	public List queryDocList(Map map)throws Exception;
	
	public List queryDocInfoByLeftJoin(Map map)throws Exception;
	
	
	public List queryFilePathList(Map map)throws Exception;
	
	public void  addDocData(List<Map> map)throws Exception;
	
	public void  updateDocData(List<Map> map)throws Exception;
	
	public void  addDocImagePath(List<Map> map)throws Exception;
	
	public void  deleteDocData(List<Map> map)throws Exception;
	
	public void  addDocData(Map map)throws Exception;
	
	public void  updateDocData(Map map)throws Exception;
	
	public void  deleteDocData(Map map)throws Exception;
	
	
	public List queryDocTypeList(Map map)throws Exception;
	
	public void  addDocTypeData(List<Map> map)throws Exception;
	
	public void  updateDocTypeData(List<Map> map)throws Exception;
	
	public void  deleteDocTypeData(List<Map> map)throws Exception;
	
	
	public void  addDocTypeData(Map map)throws Exception;
	
	public void  updateDocTypeData(Map map)throws Exception;
	
	public void  deleteDocTypeData(Map map)throws Exception;
	
	public Map queryDocInfoMoney(Map map) throws Exception ;
}
