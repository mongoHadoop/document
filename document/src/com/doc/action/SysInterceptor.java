package com.doc.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.doc.util.SysInfo;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class SysInterceptor extends AbstractInterceptor {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final String LOGIN_PAGE = "login";  
	public static final String SUCCESS = "success";  
  
    @Override  
    public String intercept(ActionInvocation actionInvocation) throws Exception {  
        System.out.println("\u5F00\u59CB\u767B\u9646\u62E6\u622A\u9A8C\u8BC1....");  
        // don't check user login action itself .  
        Object action = actionInvocation.getAction();  
       
        if (action instanceof LoginAction) {  
            System.out  
                    .println("\u9000\u51FA\u767B\u9646\u62E6\u622A\u9A8C\u8BC1,\u6B64\u4E3A\u6B63\u5728\u767B\u9646\u4E2D...");  
/*            if(this.validateAdmin(actionInvocation)){
            	return SUCCESS;
            }*/
            return actionInvocation.invoke();  
        }  
        // check user login session .  
        ActionContext ctx = ActionContext.getContext();  
		Map userSession  = (Map) ctx.getSession().get(SysInfo.userSessionKey);			
        // get session use session name .  
        if (userSession != null) {  
            return actionInvocation.invoke();  
        } else {
        	ctx.put("tip", 1);
        	 //addActionMessage("You are valid user!");
        	//ctx.put("tipInfo", "\u4F60\u7684\u8D26\u53F7\u5931\u6548,\u8BF7\u91CD\u65B0\u767B\u9646");  
            System.out.println("\u4F60\u7684\u8D26\u53F7\u5931\u6548,\u8BF7\u91CD\u65B0\u767B\u9646...");  
            return LOGIN_PAGE;
        }  
  
    }  
}  