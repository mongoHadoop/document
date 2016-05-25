package com.doc.services;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.json.JSONUtil;

import com.doc.dao.IDocFileDao;
import com.doc.dao.IDocInfoDao;
import com.doc.util.DeleteFileUtil;

public class DocFileServiceImpl implements IDocFileService{

	private IDocFileDao docFileDao;
	
	private IDocInfoDao docInfoDao;
	
	public void setDocInfoDao(IDocInfoDao docInfoDao) {
		this.docInfoDao = docInfoDao;
	}

	public void setDocFileDao(IDocFileDao docFileDao) {
		this.docFileDao = docFileDao;
	}

	public List queryFilePathList(Map param) throws Exception {
		
		return docFileDao.queryFilePathList(param);
	}

	public void addDocFilePath(List<Map> map) throws Exception {
		docFileDao.addDocFilePath(map);
	}

	public void changeRowsList(Map param,String fiePath) throws Exception {
		ArrayList<Map> insertlist = (ArrayList)param.get("inserted");
		updateChangeRowsList(insertlist,"inserted",fiePath);
		ArrayList<Map> updatelist = (ArrayList)param.get("updated");
		updateChangeRowsList(updatelist,"updated",fiePath);
		ArrayList<Map> deletelist = (ArrayList)param.get("deleted");
		updateChangeRowsList(deletelist,"deleted",fiePath);
	}

	private void updateChangeRowsList(List<Map> list,String key,String filePath) throws Exception{
		if(list!=null&& list.size()>0){
			if(key.equals("inserted")){
				docFileDao.addDocFilePath(list);
			}
			if(key.equals("deleted")){
				docFileDao.deleteDocFilePath(list);
				String docId = null;
				
				for(Map bean:list){
					String filePath2 = (String) bean.get("filePath");
					docId = (String) bean.get("docId");
					StringBuffer deleteFile = new StringBuffer();
					deleteFile.append(filePath);
					deleteFile.append("\\");
					deleteFile.append(filePath2);
					DeleteFileUtil.deleteFile(deleteFile.toString());
				}
				
				Map param = new HashMap();
				param.put("docId", docId);
			 	List<Map> list1 = docFileDao.queryFilePathList(param);
			 	
			 	List  fileTypeList = new ArrayList ();
				if(list1!=null && list1.size()>0){
					for(Map bean :list1){
						Integer fileType = (Integer) bean.get("fileType");
						fileTypeList.add(fileType);
					}
					String fileTypes = JSONUtil.serialize(fileTypeList).toString();
					param.put("fileType", fileTypes);
				}else{
					param.put("fileTypeIsNull", "fileTypeIsNull");
				}
				docInfoDao.updateDocData(param);
			}
		}
	}

	public void updateFilePath(Map param, List[] files) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
