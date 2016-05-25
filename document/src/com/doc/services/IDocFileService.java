package com.doc.services;

import java.util.List;
import java.util.Map;

public interface IDocFileService {

	public List  queryFilePathList (Map param)throws Exception;
	
	public void addDocFilePath(final List<Map> map) throws Exception;
	
	public void changeRowsList(Map map,String filePath) throws Exception;
	
	public void updateFilePath(Map param,List[] files) throws Exception;
}
