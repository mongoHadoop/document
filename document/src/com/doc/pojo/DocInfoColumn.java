package com.doc.pojo;

import java.util.HashMap;
import java.util.Map;


public class DocInfoColumn {


	
	
	private Map<String,String> map = new HashMap<String,String>(); 
	
	private static DocInfoColumn instance = new DocInfoColumn();
	
	private DocInfoColumn(){
		map.put("id", "id");
		map.put("docName", "doc_name");
		map.put("orgId", "org_id");
		map.put("orgName", "org_name");
		map.put("subject", "subject");
		map.put("lendType", "lend_type");
		map.put("money", "money");
		map.put("recordUser", "record_user");
		map.put("recordTime", "record_time");
		map.put("fileType", "file_type");
		map.put("remark", "remark");
		map.put("status", "status");
	}
	
	public static DocInfoColumn getInstance() {
		return instance;
	 }
	
	
	public String getColumName(String key){
		return map.get(key);
	}


}
