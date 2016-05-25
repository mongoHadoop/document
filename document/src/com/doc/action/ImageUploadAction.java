package com.doc.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.doc.services.IDocFileService;
import com.doc.services.IDocInfoService;
import com.doc.services.IDocSubjectService;
import com.doc.services.IDocUserService;
import com.doc.util.DeleteFileUtil;
import com.doc.util.SysInfo;
import com.doc.util.TDocUser;
import com.doc.util.TFilePath;
import com.doc.util.TSysUser;
import com.doc.util.TdocInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ImageUploadAction extends ActionSupport{

	private List<File> image; // 上传的文件
    
	private List<String> imageFileName; // 文件名称
    
    private List<String> imageContentType; // 文件类型
    
    private String savePath;
    
    private  HashMap <String,String> param;//参数 
    
    private HashMap<String, Object> jsonMap;
    
    private String jsonString;
    
    public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

	public HashMap<String, Object> getJsonMap() {
		return jsonMap;
	}

	public void setJsonMap(HashMap<String, Object> jsonMap) {
		this.jsonMap = jsonMap;
	}
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
	private IDocInfoService docInfoService;
    
    public void setDocInfoService(IDocInfoService docInfoService) {
		this.docInfoService = docInfoService;
	}
	
	public void setDocSubjectService(IDocSubjectService docSubjectService) {
		this.docSubjectService = docSubjectService;
	}
	private IDocSubjectService docSubjectService;

	public String uploadImage() throws Exception{
        try {
			ServletActionContext.getRequest().setCharacterEncoding("UTF-8");
			// 取得需要上传的文件数组
			List<File> files = getImage();
			String docId = param.get("docId");
			
			if (files != null && files.size() > 0) {
				List<Map> listFilePath = new ArrayList<Map> ();
				
			    for (int i = 0; i < files.size(); i++) {
			    	String str = getImageFileName().get(i);
			    	String fileType = getImageContentType().get(i);
			    	int fileTypeIndex = 0;
			    	if(fileType.equals(TFilePath.FileType.JPG.getName())){
			    		fileTypeIndex = TFilePath.FileType.JPG.getIndex();
			    	//	fileTypeList.add(fileTypeIndex);
			    	}else if(fileType.equals(TFilePath.FileType.BMP.getName())){
			    		fileTypeIndex = TFilePath.FileType.BMP.getIndex();
			    		//fileTypeList.add(fileTypeIndex);
			    	}else if(fileType.equals(TFilePath.FileType.PNG.getName())){
			    		fileTypeIndex = TFilePath.FileType.PNG.getIndex();
			    		//fileTypeList.add(fileTypeIndex);
			    	}else{
			    		fileTypeIndex = TFilePath.FileType.OTHERFILE.getIndex();
			    		//fileTypeList.add(fileTypeIndex);
			    	}
			    	
			    	String relativeSavePath = getSavePath();
			    	String newFileName = genFileName(str);
			        FileOutputStream fos = new FileOutputStream(ServletActionContext.getServletContext()
			        		.getRealPath(savePath+"/"+relativeSavePath)+ "\\"+newFileName );
			        FileInputStream fis = new FileInputStream(files.get(i));
			       
			        StringBuffer filePath  = new StringBuffer();
			        filePath.append(relativeSavePath);
			        filePath.append("/");
			        filePath.append(newFileName);
			        
			        System.out.println("文件路径:"+filePath.toString());
			        
			        Map bean = new HashMap();
			        bean.put(TFilePath.docId, docId);
			        bean.put(TFilePath.filePath,filePath.toString());
			        bean.put(TFilePath.fileType,fileTypeIndex);
			        listFilePath.add(bean);
			        
			        
			        byte[] buffer = new byte[1024];
			        int len = 0;
			        while ((len = fis.read(buffer)) > 0) {
			            fos.write(buffer, 0, len);
			        }
			        fis.close();
			        fos.close();
			    }
			    docFileService.addDocFilePath(listFilePath);
			    List<Map> filePathList = docFileService.queryFilePathList(param);
			    List fileTypeList = new ArrayList();
			    for(Map bean:filePathList){
			    	fileTypeList.add((Integer)bean.get(TFilePath.fileType));
			    }
			    
			    String fileTypes = JSONUtil.serialize(fileTypeList).toString();
			    param.put(TdocInfo.fileType, fileTypes);
			}
			
			docInfoService.updateDocInfo(param);
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msgsuccess);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msuploadFileError);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msuploadFileError);
		} catch (IOException e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msuploadFileError);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap = new HashMap();
			jsonMap.put("msg", SysInfo.msuploadFileError);
		}
		return SUCCESS;
    }
    

	public String getPrefix(String fileName){
    	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
    	return prefix;
    }
    
    public String genFileName(String fileName){
    	String prefix=fileName.substring(fileName.lastIndexOf(".")+1);
    	StringBuffer newName = new StringBuffer();
    	Date date = new Date();
	    SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMM");
	    String ymonth = dateformat.format(date);
	    newName.append(ymonth);
	    newName.append("_");
	    String uid =  UUID.randomUUID().toString().replace("-","");
	    newName.append("id_");
	    newName.append(uid);
	    newName.append(".");
	    newName.append(prefix);
    	return newName.toString();
    }
    public File makeDir(String realpath){
    	 Date date = new Date();
	     SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMM");
	     String dirDate = dateformat.format(date);
    	 
	     File savedir=new File(realpath);
         if(!savedir.getParentFile().exists())
             savedir.getParentFile().mkdirs();
         return savedir;
    }

    public List<File> getImage() {
        return image;
    }

    public void setImage(List<File> image) {
        this.image = image;
    }

    public List<String> getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(List<String> imageFileName) {
        this.imageFileName = imageFileName;
    }

    public List<String> getImageContentType() {
        return imageContentType;
    }

    public void setImageContentType(List<String> imageContentType) {
        this.imageContentType = imageContentType;
    }

    /**
     * 返回上传文件保存的位置
     * 
     * @return
     * @throws Exception
     */
    public String getSavePath() throws Exception {
    	Date date = new Date();
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMM");
        String dirDate = dateformat.format(date);
        createDir(ServletActionContext.getServletContext().getRealPath(savePath+"/"+dirDate));
        return dirDate;
    }

    public static boolean createDir(String destDirName) {
        File dir = new File(destDirName);
        if (dir.exists()) {
            //System.out.println("目录" + destDirName + "目标目录已经存在");
            return false;
        }
        if (!destDirName.endsWith(File.separator)) {
            destDirName = destDirName + File.separator;
        }
        //创建目录
        if (dir.mkdirs()) {
            System.out.println("创建目录" + destDirName + "成功！");
            return true;
        } else {
            return false;
        }
    }
    
    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }
    @Autowired
    private IDocUserService docUserService;
    
    public String doUploadFile() throws Exception{
    	HttpServletRequest request = ServletActionContext.getRequest();
    	try {
			Map sysUser  = (Map) ActionContext.getContext().getSession().get(SysInfo.userSessionKey);		
    		String docId = param.get("docId");
    		List<Map> docinfoList = docInfoService.queryDocList(param);
    		Map docInfo = (Map)docinfoList.get(0);
			List docSubjectList  = docSubjectService.queryDocSubject(param);
			
			Map bean = new HashMap();
			bean.put(TDocUser.orgId, sysUser.get(TSysUser.orgId));
			List docUserList  = docUserService.queryDocUserList(bean);
			
			List docfileList = docInfoService.queryFilePathList(param);
			int fileNum = docfileList.size();
			request.setAttribute("fileNum", fileNum);
			request.setAttribute("docId", docId);
			request.setAttribute("docInfo", docInfo);
			request.setAttribute("docSubjectList", docSubjectList);
			request.setAttribute("docUserList", docUserList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw e;
		}
    	
    	return SUCCESS;
    }
    
    public String doviewImage() throws Exception{
    	HttpServletRequest request = ServletActionContext.getRequest();
    	try {
    		String docId = param.get("docId");
    		//set only query image type file
    		param.put(TFilePath.fileType, String.valueOf(TFilePath.FileType.JPG.getIndex()));
			List list  = docInfoService.queryFilePathList(param);
			request.setAttribute("imageList", list);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
    	
    	return SUCCESS;
    }
    
    IDocFileService docFileService;
    
    public void setDocFileService(IDocFileService docFileService) {
		this.docFileService = docFileService;
	}

	public String doPreViewFile()throws Exception{
		String docId = param.get("docId");
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("docId", docId);
		
    	return SUCCESS;
    }
	
	public String querFilePathList()throws Exception{
		jsonList = docFileService.queryFilePathList(param);
    	return SUCCESS;
    }
	public String changeRows()throws Exception{
		try {
			System.out.println(jsonString);
			HashMap map = (HashMap) JSONUtil.deserialize(jsonString);
			String filePath = ServletActionContext.getServletContext().getRealPath(savePath+"\\");
			docFileService.changeRowsList(map,filePath);
			jsonMap = new HashMap();
			jsonMap.put("msg",SysInfo.msgsuccess);
			this.setJsonMap(jsonMap);
		} catch (Exception e) {
			e.printStackTrace();
			jsonMap.put("msg",SysInfo.msuploadFileError);
			this.setJsonMap(jsonMap);
		}
		this.setJsonMap(jsonMap);
		return SUCCESS;
	}
	
}
