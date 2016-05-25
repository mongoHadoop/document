package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface ISysMenuDao {

	public List querySysMenuList(Map param) throws Exception;
	
	public void addSysMenu(final List<Map> map) throws Exception;
	
	public void updateSysMenuData (final List<Map> map) throws Exception;
	
	public void updateSysMenuData (Map map) throws Exception;
	
	public void  deleteSysMenu(List<Map> map)throws Exception;

	public List queryGrantRoleMenuList(Map param) throws Exception;
	
	public List queryNotGrantMenuList(Map param) throws Exception ;
	
}
