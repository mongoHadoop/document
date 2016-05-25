package com.doc.services;

import java.util.List;
import java.util.Map;

public interface ISysMenuService {

	public List querySysMenuList(Map param) throws Exception;
	
	public void changeRowsList(Map map) throws Exception;

	public List queryMenuByRole(Map param) throws Exception;
	
	public List querySuperAdminSysMenuList(Map param) throws Exception;
}
