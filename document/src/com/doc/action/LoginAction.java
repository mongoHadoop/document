package com.doc.action;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.doc.dao.IRoleMenuDao;
import com.doc.pojo.User;
import com.doc.services.ISysMenuService;
import com.doc.services.ISysUserService;
import com.doc.util.PropertiesSingleton;
import com.doc.util.SysInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {

	public String userCode;
	
	public String password;

	@Autowired
	private ISysUserService sysUserService;
	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String Convert(String s){
           String result = null;
           byte[] temp ;
               try {
				temp = s.getBytes("iso-8859-1");
               result =  new String(temp,"utf-8");
       		} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
           return result;
       }
	/**
	 * 登陆验证
	 * @return
	 * @throws Exception 
	 */
	public String doLoginOn() throws Exception{
		try {
			User user = new User ();
			user.setUserName(userCode);
			user.setPwd(password);
			Map userMap = null;
			String superAdmin = PropertiesSingleton.getInstance().getProperty("user.admin");
			
			if(user.getUserName()== null ||user.getUserName().isEmpty()){
				 addActionError("用户名或密码不能为空");
				return LOGIN;
			}
			if(user.getUserName().equals(superAdmin)){
	        	 Map admin = new HashMap();
	        	 admin.put("userName",userCode);
	        	 admin.put("userCode",userCode);
	        	 admin.put("orgId",10);
	        	 admin.put("orgName","成都");
	        	 ActionContext.getContext().getSession().put(SysInfo.userSessionKey, admin);
				 addActionError("用户名或密码不能为空");
				 return SUCCESS;
			}
			
			
			try {
			  Map param = new HashMap();
			  param.put("userCode", userCode);
			  userMap  = 	(Map) sysUserService.querySysUserByCode(param);
			} catch (RuntimeException e) {
				e.printStackTrace();
				addActionError("系统登录异常: ");
				return LOGIN;
			}
			if(userMap != null){
				 ActionContext.getContext().getSession().put(SysInfo.userSessionKey,userMap);
				 addActionMessage("用户名或密码错误");
				return SUCCESS;
			}else{
				 //ActionContext.getContext().put("tip", 1);
				// ActionContext.getContext().put("tipInfo", "\u4F60\u8F93\u5165\u7684\u8D26\u53F7\u6216\u5BC6\u7801\u4E0D\u6B63\u786E");
				addActionError("用户名或密码错,请重新输入!");
				return LOGIN;
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
		return SUCCESS;
		
	}

	
	public String loginOut() throws Exception{
		ActionContext.getContext().getSession().remove("sysuser"); 
		return LOGIN;
	}
	

	public String sessionOut() throws Exception{
		 addActionError("会话超时,请重新登陆");
		return SUCCESS;
	}
}
