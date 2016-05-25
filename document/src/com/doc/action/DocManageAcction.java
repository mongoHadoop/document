package com.doc.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.doc.pojo.DocInfoColumn;
import com.doc.services.IDocInfoService;
import com.doc.services.IDocSubjectService;
import com.doc.services.ISysOrgService;
import com.doc.util.PropertiesSingleton;
import com.doc.util.SysInfo;
import com.doc.util.TSysOrg;
import com.doc.util.TdocInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class DocManageAcction extends ActionSupport {

	private String rows;// 每页显示的记录数

	private String page;// 当前第几页
	
	private String sort;//排序列
	
	private String order;//排序方式

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	private HashMap<String, Object> jsonMap;

	private HashMap<String, String> param;// 参数

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

	private IDocInfoService docInfoService;

	private IDocSubjectService docSubjectService;

	public void setDocSubjectService(IDocSubjectService docSubjectService) {
		this.docSubjectService = docSubjectService;
	}

	public void setDocInfoService(IDocInfoService docInfoService) {
		this.docInfoService = docInfoService;
	}

	public String doInitDocInfo() throws Exception {
		return SUCCESS;
	}

	public String queryDocList() throws Exception {
		try {
			// 当前页
			int intPage = Integer.parseInt((page == null || page == "0") ? "1"
					: page);
			// 每页显示条数
			int pageSize = Integer
					.parseInt((rows == null || rows == "0") ? "10" : rows);

			// 每页的开始记录 第一页为1 第二页为number +1
			int start = (intPage - 1) * pageSize;
			jsonMap = new HashMap<String, Object>();// 定义map
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);
			param.put(TdocInfo.orgId, String.valueOf(sysUser.get("orgId")));				
			param.put(TdocInfo.status, String.valueOf(TdocInfo.DocStatus.UNSubmit.getIndex()));//未提交标记
			List listcount = docInfoService.queryDocList(param);
			jsonMap.put("total", listcount.size());// total 存放总记录数

			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			param.put("sort", DocInfoColumn.getInstance().getColumName(sort));
			param.put("order", order);
			
			List list = docInfoService.queryDocList(param);

			jsonMap.put("rows", list);// rows键 存放每页记录 list
			this.setJsonMap(jsonMap);
			return SUCCESS;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
	}
	
	public String queryUnSubmitDocInfo()throws Exception{
		try {
			// 当前页
			int intPage = Integer.parseInt((page == null || page == "0") ? "1"
					: page);
			// 每页显示条数
			int pageSize = Integer
					.parseInt((rows == null || rows == "0") ? "10" : rows);

			// 每页的开始记录 第一页为1 第二页为number +1
			int start = (intPage - 1) * pageSize;
			jsonMap = new HashMap<String, Object>();// 定义map
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);
			param.put(TdocInfo.orgId, String.valueOf(sysUser.get("orgId")));				
			param.put(TdocInfo.status, String.valueOf(TdocInfo.DocStatus.UNSubmit.getIndex()));//未提交标记
			List listcount = docInfoService.queryDocInfoByLeftJoin(param);
			jsonMap.put("total", listcount.size());// total 存放总记录数

			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			param.put("sort", DocInfoColumn.getInstance().getColumName(sort));
			param.put("order", order);

			List list = docInfoService.queryDocInfoByLeftJoin(param);

			jsonMap.put("rows", list);// rows键 存放每页记录 list
			this.setJsonMap(jsonMap);
			return SUCCESS;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
	
	}
	

	public String queryDocInfoByLeftJoin() throws Exception {
		try {
			// 当前页
			int intPage = Integer.parseInt((page == null || page == "0") ? "1"
					: page);
			// 每页显示条数
			int pageSize = Integer
					.parseInt((rows == null || rows == "0") ? "10" : rows);

			// 每页的开始记录 第一页为1 第二页为number +1
			int start = (intPage - 1) * pageSize;
			jsonMap = new HashMap<String, Object>();// 定义map
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);		
			String adminOrgId = PropertiesSingleton.getInstance().getProperty("user.admin.regionId");
			Integer adminorgId = Integer.valueOf(adminOrgId);
			Integer orgId =(Integer)sysUser.get("orgId");
			if(adminorgId.intValue()!=orgId.intValue()){
				param.put("orgId", String.valueOf(orgId));
			}			
			List listcount = docInfoService.queryDocInfoByLeftJoin(param);
			jsonMap.put("total", listcount.size());// total 存放总记录数
			String column  ="总计";
			List static1List = docInfoService.queryDocInfoMoney(param, column);
			
			
			param.put("begin", String.valueOf(start));
			param.put("pageSize", String.valueOf(pageSize));
			param.put("sort", DocInfoColumn.getInstance().getColumName(sort));
			param.put("order", order);

			
			List list = docInfoService.queryDocInfoByLeftJoin(param);

			jsonMap.put("rows", list);// rows键 存放每页记录 list
			jsonMap.put("footer", static1List);//页尾
			this.setJsonMap(jsonMap);
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	public String changeRows() throws Exception {
		try {
			System.out.println(jsonString);
			HashMap map = (HashMap) JSONUtil.deserialize(jsonString);
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);		
			docInfoService.changeRowsList(map, sysUser);
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
	private ISysOrgService sysOrgService;
	/***
	 * 凭证查看
	 * @return
	 * @throws Exception
	 */
	public String doDocListView() throws Exception {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);		
			String adminOrgId = PropertiesSingleton.getInstance().getProperty("user.admin.regionId");
			Integer adminorgId = Integer.valueOf(adminOrgId);
			Integer orgId =(Integer)sysUser.get("orgId");
			if(adminorgId.intValue()==orgId.intValue()){
				List orgList  = sysOrgService.querySysOrgList(null);
				request.setAttribute("orgList", orgList);
			}
			List list = docSubjectService.queryDocSubject(param);
			request.setAttribute("docSubjectList", list);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		return SUCCESS;
	}

	public String doComfirmDocList() throws Exception {
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			List list = docSubjectService.queryDocSubject(param);
			request.setAttribute("docSubjectList", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;

		}
		return SUCCESS;
	}

	/**
	 * 提交待审核
	 * @return
	 * @throws Exception
	 */
	public String submitAudit()throws Exception{
		try {
			Map<String, Object> map = (Map<String, Object>) JSONUtil.deserialize(jsonString);
			List listMap = (List )map.get("selected");
			docInfoService.updateDocInfoStatus(listMap,TdocInfo.DocStatus.Auditing.getIndex());
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msgsuccess);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msginfofail);
		}
		return SUCCESS;
	}
	
	public String doAuditDocInfo() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List list = docSubjectService.queryDocSubject(param);
		List orgList  = sysOrgService.querySysOrgList(null);
		request.setAttribute("docSubjectList", list);
		request.setAttribute("orgList", orgList);
		return SUCCESS;
	}
	/**
	 * 提交审核办结状态
	 * @return
	 * @throws Exception
	 */
	
	public String doAuditCompleted()throws Exception{
		try {
			Map<String, Object> map = (Map<String, Object>) JSONUtil.deserialize(jsonString);
			List listMap = (List )map.get("selected");
			docInfoService.updateDocInfoStatus(listMap,TdocInfo.DocStatus.Audited.getIndex());
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msgsuccess);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msginfofail);
		}
		return SUCCESS;
	}
}
