package com.doc.services;

import java.util.List;
import java.util.Map;

public interface ISysManagerService {

	
	public List querySysUserList(Map param) throws Exception;
	
	public List queryNotGrantMenuList(Map param)throws Exception;
	
	public List queryMenuList(Map param)throws Exception;
	
	public List queryGrantRoleMenuList(Map param)throws Exception;
	
	public void updateRoleMenuList(Map param)throws Exception;
}
