package com.doc.services;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface IDocInfoService {

	public List queryDocList(Map map)throws Exception;
	
	public List queryDocInfoByLeftJoin(Map map)throws Exception;
	

	public List queryDocInfoMoney(Map map,String column) throws Exception ;
	
	public List queryFilePathList(Map map)throws Exception;
	
	public void  addDocData(List map)throws Exception;
	
	public void  addDocImagePath(List map)throws Exception;
	
	public void  uploadImage(List file) throws Exception;
	
	public Map importDocInfoExcelSheet(File file,Map userMap) throws Exception;
	
	public void changeRowsList(Map map,Map userMap) throws Exception;
	
	public void  updateDocInfo(Map map)throws Exception;
	
	public void  updateDocInfoStatus(List<Map> list,int status)throws Exception;
}
