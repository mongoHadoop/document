package com.doc.action;

import java.util.HashMap;
import java.util.List;

import org.apache.struts2.json.JSONUtil;

import com.doc.services.ISysUserService;
import com.opensymphony.xwork2.ActionSupport;

public class SysUserAction   extends ActionSupport{

	private String rows;//每页显示的记录数  

	private String page;//当前第几页  
	
	private HashMap<String, Object> jsonMap;
	
	private  HashMap <String,String> param;//参数
	
	private String jsonString;
	

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

	public HashMap<String, String> getParam() {
		return param;
	}

	public void setParam(HashMap<String, String> param) {
		this.param = param;
	}

	public String getRows() {
		return rows;
	}

	public void setRows(String rows) {
		this.rows = rows;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public HashMap<String, Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	public String querySysUserList() throws Exception{
    	
    	
    	try {
			// 当前页
			int intPage = Integer.parseInt((page == null || page == "0") ? "1"
					: page);
			// 每页显示条数
			int pageSize = Integer.parseInt((rows == null || rows == "0") ? "10"
					: rows);

			// 每页的开始记录 第一页为1 第二页为number +1
			int start = (intPage - 1) * pageSize;
			jsonMap = new HashMap<String, Object>();// 定义map
			
			List listcount = sysUserService.querySysUserList(param);
			jsonMap.put("total",listcount.size() );// total  存放总记录数
			
			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			
			List list = sysUserService.querySysUserList(param);
			
			jsonMap.put("rows", list);// rows键 存放每页记录 list
			this.setJsonMap(jsonMap);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
    }
    
	public String changeRows() throws Exception{
		try {
			HashMap map = (HashMap) JSONUtil.deserialize(jsonString);
			sysUserService.changeRowsList(map);
			jsonMap = new HashMap();
			jsonMap.put("info", 1);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		this.setJsonMap(jsonMap);
		return SUCCESS;
	}

	private ISysUserService sysUserService;

	public void setSysUserService(ISysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}
	public String sessionOut() throws Exception{
		 addActionError("会话超时,请重新登陆");
		return SUCCESS;
	}
}
