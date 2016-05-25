package com.doc.services;

import java.io.File;
import java.util.List;
import java.util.Map;

public interface IDocUserService {
	
	public List queryDocUserList(Map param)throws Exception;
	
	public void changeRowsList(Map param) throws Exception;
	
	public Map importExcelSheet(File file,Map sysUser) throws Exception;
	
}
