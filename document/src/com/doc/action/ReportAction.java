package com.doc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.doc.services.IDocSubjectService;
import com.doc.services.ISysOrgService;
import com.doc.util.PropertiesSingleton;
import com.doc.util.SysInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

@Controller(value="reportAction")
@Scope("prototype")
public class ReportAction extends ActionSupport {
	
	private HashMap<String, String> param;// 参数
	
	private List jsonList;
	
	public List getJsonList() {
		return jsonList;
	}
	public void setJsonList(List jsonList) {
		this.jsonList = jsonList;
	}
	public HashMap<String, String> getParam() {
		return param;
	}
	public void setParam(HashMap<String, String> param) {
		this.param = param;
	}
	@Autowired
	private IDocSubjectService docSubjectService;
	
	
	@Autowired
	private ISysOrgService sysOrgService;
	public String doMonthReport() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List list = docSubjectService.queryDocSubject(param);
		request.setAttribute("docSubjectList", list);
		request.setAttribute("docSubjectJsonList", JSONUtil.serialize(list));
		Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);		
		String adminOrgId = PropertiesSingleton.getInstance().getProperty("user.admin.regionId");
		Integer adminorgId = Integer.valueOf(adminOrgId);
		Integer orgId =(Integer)sysUser.get("orgId");
		if(adminorgId.intValue()== orgId.intValue()){
			List orgList  = sysOrgService.querySysOrgList(null);
			request.setAttribute("orgList", orgList);
		}
		return SUCCESS;
	}
	
	public String querySubjtctList() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		jsonList = docSubjectService.queryDocSubject(param);
		return SUCCESS;
	}
	public String qryReportChart() throws Exception{
		String subjectIds =  param.get("subjectIds");
		String docstatus =  param.get("docstatus");
		String recordTimeEnd = param.get("recordTimeEnd");
		docSubjectService.doChartData(param);
		return SUCCESS;
	}

}
