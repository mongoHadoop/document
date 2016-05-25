package com.doc.services;

import java.io.File;
import java.util.List;
import java.util.Map;

public interface ISysOrgService {

	
	
	public Map importExcelSheet(File file) throws Exception;
	
	public void changeRowsList(Map map) throws Exception;
	
	public List querySysOrgList(Map param) throws Exception;
	

	
}
