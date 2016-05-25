package com.doc.services;

import java.util.List;
import java.util.Map;

public interface ISysRoleService {

	public void changeRowsList(Map map) throws Exception;
	
	public List querySysRoleList(Map param) throws Exception;
	
	public List queryRoleMenu(Map param)throws Exception;
	

}
