package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface ISysUserDao {
	public List querySysUserList(Map param) throws Exception;
	
	public Map querySysUserByCode(Map param) throws Exception;
	
	public void addSysUser(final List<Map> map) throws Exception;
	
	public void updateSysUserData (final List<Map> map) throws Exception;
	
	public void updateSysUserData (Map map) throws Exception;
	
	public void  deleteSysUser(List<Map> map)throws Exception;
}
