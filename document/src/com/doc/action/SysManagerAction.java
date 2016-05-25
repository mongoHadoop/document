package com.doc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.doc.services.ISysManagerService;
import com.doc.services.ISysOrgService;
import com.doc.services.ISysRoleService;
import com.doc.services.ISysUserService;
import com.doc.util.SysInfo;
import com.doc.util.TSysRoleMenu;
import com.opensymphony.xwork2.ActionSupport;

public class SysManagerAction   extends ActionSupport{
	
	private String rows;//每页显示的记录数  

	private String page;//当前第几页  
	
	
	private HashMap<String, Object> jsonMap;
	
	private  HashMap <String,String> param;//参数
	
	private String jsonString;
	
	private List jsonList;
	
	public List getJsonList() {
		return jsonList;
	}

	public void setJsonList(List jsonList) {
		this.jsonList = jsonList;
	}

	@Autowired
	private  ISysManagerService sysManagerService ;
	
    public void setSysManagerService(ISysManagerService sysManagerService) {
		this.sysManagerService = sysManagerService;
	}

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
	public HashMap<String, Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}

	private ISysUserService sysUserService;

	public void setSysUserService(ISysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}
	
	@Autowired
	private ISysRoleService sysRoleService;

	@Autowired
	private ISysOrgService sysOrgService;
	
	public String queryRoleMenu()  throws Exception{
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
			
			List listcount = sysRoleService.queryRoleMenu(param);
			jsonMap.put("total",listcount.size() );// total  存放总记录数
			
			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			
			List list = sysRoleService.queryRoleMenu(param);
			
			jsonMap.put("rows", list);// rows键 存放每页记录 list
			this.setJsonMap(jsonMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
    }
	
	
	public String doSetUserCode() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			List list =sysUserService.querySysUserList(param);
			Map userBean = (Map)list.get(0);
			request.setAttribute("userBean", userBean);
			List roleList = sysRoleService.querySysRoleList(null);
			request.setAttribute("roleList", roleList);
			List orgList = sysOrgService.querySysOrgList(null);
			request.setAttribute("orgList", orgList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String updateUserRight() throws Exception{
		try {
			sysUserService.updateUser(param);
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msgsuccess);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("msg", SysInfo.msginfofail);
		}
		return SUCCESS;
	}
	
	public String doPreRoleMenu()throws Exception{
		String roleId = param.get("roleId");
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("roleId", roleId);
		
		return SUCCESS;
	}
	
	public String doPrewMenu()throws Exception{
		String roleId = param.get("roleId");
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("roleId", roleId);
		return SUCCESS;
	}
	
	public String doGrantRoleMenu()throws Exception{
		System.out.println(param.get("roleId"));
		System.out.println(jsonString);
		HashMap map = (HashMap) JSONUtil.deserialize(jsonString);
		map.put(TSysRoleMenu.roleId, param.get(TSysRoleMenu.roleId));
		try {
			sysManagerService.updateRoleMenuList(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return SUCCESS;
	}
	
	public String queryTreeMenuList1()throws Exception{
		System.out.println(param.get("roleId"));
		jsonList = sysManagerService.queryGrantRoleMenuList(param);
		return SUCCESS;
	}
	public String queryTreeMenuList2()throws Exception{
		jsonList = sysManagerService.queryMenuList(null);
		return SUCCESS;
	}
}
