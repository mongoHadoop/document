package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface IRoleMenuDao {

	
	public void deleteRoleMenuRelationShip(List<Map> maplist) throws Exception;
	
	public void addRoleMenuRelationShip(List<Map> maplist)throws Exception;
	
	public List queryMenuByRole(Map param)throws Exception;
}
