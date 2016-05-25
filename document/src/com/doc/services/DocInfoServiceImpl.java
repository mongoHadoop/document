package com.doc.services;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.doc.dao.IDocInfoDao;
import com.doc.util.SysInfo;
import com.doc.util.TdocInfo;

public class DocInfoServiceImpl implements IDocInfoService{
	
	
	//数据分割符
	private String splitStr = "||";
	//Excel 中单元格数据为空的替代符号
	private String defaultValue = null;

	private static String format1 = "yyyy年MM月";
	
	private String format2 = "yyyy.MM.dd";
	
	
	
	private String erroinfo1 = "[正确格式例子:2013.01.04-2012.01.05";

	private IDocInfoDao docInfoDao;



	public void setDocInfoDao(IDocInfoDao docInfoDao) {
		this.docInfoDao = docInfoDao;
	}

	public void addDocData(List map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public List queryDocList(Map map) throws Exception {
		List list  =docInfoDao.queryDocList(map);
		return list;
	}

	public void uploadImage(List file) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void addDocImagePath(List map) throws Exception {
		docInfoDao.addDocImagePath(map);
	}

	public Map importDocInfoExcelSheet(File file,Map userMap) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(file));
		Map mapstatus = new HashMap();
		boolean flag = checkExcelNumFile(file,workbook,TdocInfo.cellNum);
		if(flag){
			Map map =  parseWrokbook(workbook);
			List list1 = (List) map.get("list1");
			List erroList = (List) map.get("erroList");
			addDocInfoList(list1,userMap);
			mapstatus.put("msg", SysInfo.msgsuccess);
			return mapstatus;
		}else{
			mapstatus.put("msg", SysInfo.excelErroInfo1);
			return mapstatus;
		}
		
	}
	public void addDocInfoList(List<Map> list,Map userMap) throws Exception{
		List list2  = new ArrayList();
		for(Map map :list){
			map.put(TdocInfo.recordTime,getCurrentTime(TdocInfo.dateFormate));
			String userName = (String) userMap.get("userName");
			String orgName = (String) userMap.get("orgName");
			map.put(TdocInfo.recordUser,userName);
			map.put(TdocInfo.orgId,userMap.get("orgId"));
			map.put(TdocInfo.status,TdocInfo.DocStatus.UNSubmit.getIndex());
			map.put(TdocInfo.orgName,orgName);
			list2.add(map);
		}
		docInfoDao.addDocData(list2);
	}
	
	private String  getCurrentTime(String dateFormate){
		SimpleDateFormat df = new SimpleDateFormat(dateFormate);
		return df.format(new Date());
	}
	
	public boolean checkExcelNumFile(File file,HSSFWorkbook workbook,int cellNum) throws FileNotFoundException, IOException{
		workbook = new HSSFWorkbook(new FileInputStream(file));
		HSSFSheet sheet = workbook.getSheetAt(0);
		int cellNo =sheet.getRow(0).getPhysicalNumberOfCells();//首行列数
		if(cellNo == cellNum){
			return true;
		}else{
			return false;
		}
		
	}
	
	public Map parseWrokbook(HSSFWorkbook workbook) throws FileNotFoundException, IOException{
		Map mapList = new HashMap();
		List list1 = new ArrayList();
		List erroList = new ArrayList();
		
		HSSFSheet sheet = workbook.getSheetAt(0);   
		int cellNo =sheet.getRow(0).getPhysicalNumberOfCells();//首行列数
		
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			HSSFRow row = sheet.getRow(i);// 获取行对象 
			int rowNo = i + 1;
			//System.out.print("第" + rowNo + "行   ");
			 if (row == null) {// 如果为空，不处理   
				 continue;   
			}
			 Map  normalbean  = new HashMap();
			 Map  errobean  = new HashMap();
			 try {
				getCellValue(cellNo,row,normalbean,errobean);
			 } catch (ParseException e) {
				erroList.add(errobean);
				 continue;
			 }
			 list1.add(normalbean);
			// customerList.add(customer);
			 //contactList.add(contact);
		}
		mapList.put("list1", list1);
		mapList.put("erroList", erroList);
		
		return mapList;
	}
	/**
	 * 遍历单元格
	 * @throws ParseException 
	 */
	private void getCellValue(int cellNo,HSSFRow row,Map normalbean, Map errobean) throws ParseException{
		// 循环遍历单元格  
		 for (int j = 0; j < cellNo; j++){
			String value =  getStringCellValue(row.getCell(j));
			try {
				setBean(normalbean,j,value);
			} catch (NumberFormatException e) {
				setErrorBean(errobean,row);
				throw e;
			}
		 }
	}
	

	private String getStringCellValue(HSSFCell cell) {
		String value = defaultValue;
		if (cell == null) {
			value = defaultValue;
		} else {
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_STRING:
				value = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC:
				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					// 如果是date类型则 ，获取该cell的date值
					value = HSSFDateUtil
							.getJavaDate(cell.getNumericCellValue()).toString();
				} else {// 纯数字
					value = String.valueOf(cell.getNumericCellValue());
				}
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				value = String.valueOf(cell.getBooleanCellValue());
				break;
			default:
				break;
			}
		}
		return value;
	}
	
	private void setBean(Map normalbean,int j,String value)throws NumberFormatException{
		switch (j) {
		case 0:
			normalbean.put(TdocInfo.docName, value);
			break;
		case 1:
			double  money = formateDouble(value);
			normalbean.put(TdocInfo.money, money);
			break;	
		case 2:
			normalbean.put(TdocInfo.remark, value);
			break;
		default:
			break;
 		}
	}
	
	private double formateDouble(String value)throws NumberFormatException{
		double money = Double.valueOf(value);
		return money;
	}

	/**
	 * 获取错误的行数据
	 * @param errobean
	 * @param row
	 */
	private void setErrorBean(Map errobean,HSSFRow row){
		errobean.put(TdocInfo.docName, getStringCellValue(row.getCell(0)));
		errobean.put(TdocInfo.money, getStringCellValue(row.getCell(1)));
		errobean.put(TdocInfo.remark, getStringCellValue(row.getCell(2)));
	}

	public void changeRowsList(Map map,Map userMap) throws Exception {
		ArrayList<Map> insertlist = (ArrayList)map.get("inserted");
		getChangeRowsList(insertlist,"inserted",userMap);
		ArrayList<Map> updatelist = (ArrayList)map.get("updated");
		getChangeRowsList(updatelist,"updated");
		ArrayList<Map> deletelist = (ArrayList)map.get("deleted");
		getChangeRowsList(deletelist,"deleted");
	}
	
	private void getChangeRowsList(List<Map> list,String key,Map userMap) throws Exception{
		List<Map> objectList = new ArrayList();
		List<Map> objectList2 = new ArrayList();
		if(list!=null&& list.size()>0){
			if(key.equals("inserted")){
				addDocInfoList(list,userMap);
			}
			if(key.equals("updated")){
				docInfoDao.updateDocData(list);
			}
			if(key.equals("deleted")){
				docInfoDao.deleteDocData(list);
			}
		}
	}
	
	private void getChangeRowsList(List<Map> list,String key) throws Exception{
		List<Map> objectList = new ArrayList();
		List<Map> objectList2 = new ArrayList();
		if(list!=null&& list.size()>0){
			if(key.equals("inserted")){
				docInfoDao.addDocData(list);
			}
			if(key.equals("updated")){
				docInfoDao.updateDocData(list);
			}
			if(key.equals("deleted")){
				docInfoDao.deleteDocData(list);
			}
		}
	}
	public void updateDocInfo(Map map) throws Exception {
		docInfoDao.updateDocData(map);
	}

	public List queryFilePathList(Map map) throws Exception {
		return docInfoDao.queryFilePathList(map);
	}

	public List queryDocInfoByLeftJoin(Map map) throws Exception {
		List list  =docInfoDao.queryDocInfoByLeftJoin(map);
		return list;
	}

	public void updateDocInfoStatus(List<Map> list,int status) throws Exception {
		List beanList = new ArrayList();
		for(Map map:list){
			Map bean = new HashMap();
			bean.put(TdocInfo.docId, map.get(TdocInfo.docId));
			bean.put(TdocInfo.status, status);
			beanList.add(bean);
		}
		if(beanList.size()>0){
			docInfoDao.updateDocData( beanList);
		}
	}

	@Override
	public List queryDocInfoMoney(Map map,String column) throws Exception {
		List staticList = new ArrayList(); 
		Map mapbean1 = docInfoDao.queryDocInfoMoney(map);
		mapbean1.put("subject", "总计");
		staticList.add(mapbean1);
		return staticList;
	}
}
