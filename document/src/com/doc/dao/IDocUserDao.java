package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IDocUserDao {

	public void addDocUser( List<Map> mapList)throws Exception;
	
	public List queryDocUserList(Map param) throws Exception;
	
	public void updateDocUserData(List<Map> mapList) throws Exception;
	
	public void deleteDocUserData(List<Map> mapList) throws Exception;
}
