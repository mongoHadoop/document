package com.doc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.doc.dao.IRoleMenuDao;
import com.doc.services.ISysMenuService;
import com.doc.services.ISysUserService;
import com.doc.util.PropertiesSingleton;
import com.doc.util.SysInfo;
import com.doc.util.TSysRoleMenu;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class SysMenuAction   extends ActionSupport{

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

	public String querySysMenuList() throws Exception{
    	
    	
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
			
			List listcount = sysMenuService.querySysMenuList(param);
			jsonMap.put("total",listcount.size() );// total  存放总记录数
			
			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			
			List list = sysMenuService.querySysMenuList(param);
			
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
			sysMenuService.changeRowsList(map);
			jsonMap = new HashMap();
			jsonMap.put("info", 1);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		this.setJsonMap(jsonMap);
		return SUCCESS;
	}

	@Autowired
	private ISysMenuService sysMenuService;

	
	public String doLeftMenuInit() throws Exception{
		Map  user =  (Map<String,String>) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);
		String userCode =  (String) user.get("userCode");
		String superAdmin = PropertiesSingleton.getInstance().getProperty("user.admin");
		if(userCode.equals(superAdmin)){
			List menuList = sysMenuService.querySuperAdminSysMenuList(null);
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("menuList", JSONUtil.serialize(menuList));
		}else{
			Map param1 = new HashMap();
			param1.put(TSysRoleMenu.roleId, user.get(TSysRoleMenu.roleId));
			List menuList = sysMenuService.queryMenuByRole(param1);
			HttpServletRequest request = ServletActionContext.getRequest();
			request.setAttribute("menuList", JSONUtil.serialize(menuList));
		}
		return SUCCESS;
	}
	
	private List jsonList;
	
	public List getJsonList() {
		return jsonList;
	}

	public void setJsonList(List jsonList) {
		this.jsonList = jsonList;
	}

	public String loadMenu() throws Exception{
		Map  user =  (Map<String,String>) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);
		String userCode =  (String) user.get("userCode");
		String superAdmin = PropertiesSingleton.getInstance().getProperty("user.admin");
		if(userCode.equals(superAdmin)){
			jsonList = sysMenuService.querySuperAdminSysMenuList(null);
			//request.setAttribute("menuList", JSONUtil.serialize(menuList));
		}else{
			Map param1 = new HashMap();
			param1.put(TSysRoleMenu.roleId, user.get(TSysRoleMenu.roleId));
			jsonList = sysMenuService.queryMenuByRole(param1);
		//	request.setAttribute("menuList", JSONUtil.serialize(menuList));
		}
		return SUCCESS;
	}
}
