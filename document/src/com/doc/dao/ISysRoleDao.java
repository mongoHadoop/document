package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface ISysRoleDao {
	
	public List queryRoleList(Map param)throws Exception;
	
	public void addSysRole(final List<Map> map) throws Exception;
	
	public void updateSysRole (final List<Map> map) throws Exception;
	
	public void updateSysRole (Map map) throws Exception;
	
	public void  deleteSysRole(List<Map> map)throws Exception;
	
	public List queryRoleMenu(Map param)throws Exception;

}
