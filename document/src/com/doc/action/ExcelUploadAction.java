package com.doc.action;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;


import com.doc.services.IDocInfoService;
import com.doc.services.IDocUserService;
import com.doc.services.ISysOrgService;
import com.doc.services.ISysUserService;
import com.doc.util.SysInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ExcelUploadAction extends ActionSupport {
	
	private IDocInfoService docInfoService;
	
	
	private ISysUserService sysUserService;
	
	public void setSysUserService(ISysUserService sysUserService) {
		this.sysUserService = sysUserService;
	}


	private HashMap<String, Object> jsonMap;

	public HashMap<String, Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}


	public void setDocInfoService(IDocInfoService docInfoService) {
		this.docInfoService = docInfoService;
	}


	private String username;

	// 注意，file并不是指前端jsp上传过来的文件本身，而是文件上传过来存放在临时文件夹下面的文件

	private File file;

	// 提交过来的file的名字

	private String fileFileName;

	// 提交过来的file的MIME类型

	private String fileContentType;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String uploadDocInfoExcel() throws Exception {/*
		try {
			String root = ServletActionContext.getServletContext().getRealPath(
					"/upload");

			InputStream is = new FileInputStream(file);

			OutputStream os = new FileOutputStream(new File(root, fileFileName));

			System.out.println("fileFileName: " + fileFileName);
			// 因为file是存放在临时文件夹的文件，我们可以将其文件名和文件路径打印出来，看和之前的fileFileName是否相同
			System.out.println("file: " + file.getName());
			System.out.println("temp file: " + file.getPath());

			byte[] buffer = new byte[500];
			int length = 0;

			while (-1 != (length = is.read(buffer, 0, buffer.length))) {
				os.write(buffer);
			}

			os.close();
			is.close();

			return SUCCESS;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
	*/
		try {
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);			
			jsonMap = (HashMap) docInfoService.importDocInfoExcelSheet(file, sysUser);
			this.setJsonMap(jsonMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msguploadExcelfail);
			this.setJsonMap(jsonMap);
		}
		return SUCCESS;
	}
	
	public String uploadUserExcel() throws Exception {
		try {
			jsonMap = (HashMap)sysUserService.importExcelSheet(file);
			this.setJsonMap(jsonMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msguploadExcelfail);
			this.setJsonMap(jsonMap);
		}
		return SUCCESS;
	}
	@Autowired
	private IDocUserService docUserService;
	
	public String uploadDocUserExcel() throws Exception {
		try {
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);	
			jsonMap = (HashMap)docUserService.importExcelSheet(file,sysUser );
			this.setJsonMap(jsonMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msguploadExcelfail);
			this.setJsonMap(jsonMap);
		}
		return SUCCESS;
	}
	
	private ISysOrgService sysOrgService;
	
	public void setSysOrgService(ISysOrgService sysOrgService) {
		this.sysOrgService = sysOrgService;
	}

	public String uploadOrgExcel() throws Exception {
		try {
			jsonMap = (HashMap)sysOrgService.importExcelSheet(file);
			this.setJsonMap(jsonMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msguploadExcelfail);
			this.setJsonMap(jsonMap);
		}
		return SUCCESS;
	}
}
