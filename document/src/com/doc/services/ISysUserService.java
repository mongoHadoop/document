package com.doc.services;

import java.io.File;
import java.util.List;
import java.util.Map;

public interface ISysUserService {
	
	
	public Map importExcelSheet(File file) throws Exception;
	
	public void changeRowsList(Map map) throws Exception;
	
	public List querySysUserList(Map param) throws Exception;
	
	public Map querySysUserByCode(Map param) throws Exception;
	
	public void updateUser(Map param)throws Exception;
	
}
