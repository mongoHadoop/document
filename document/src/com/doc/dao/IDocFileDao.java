package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IDocFileDao {

	public List queryFilePathList(Map param) throws Exception;
	
	public void addDocFilePath(List<Map> map) throws Exception;
	
	public void  deleteDocFilePath(List<Map> map)throws Exception;
	
	public void  addDocFilePath(Map map)throws Exception;
	
	public void  deleteDocFilePath(Map map)throws Exception;
}
