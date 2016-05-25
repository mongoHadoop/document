package com.doc.dao;

import java.util.List;
import java.util.Map;

public interface ISysOrgDao {


	public List querySysUserList(Map param) throws Exception;
	
	public void addSysOrg(final List<Map> map) throws Exception;
	
	public void updateSysOrgData (final List<Map> map) throws Exception;
	
	public void  deleteSysOrg(List<Map> map)throws Exception;

	
}
