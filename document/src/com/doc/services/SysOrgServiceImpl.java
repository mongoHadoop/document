package com.doc.services;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.doc.dao.ISysOrgDao;
import com.doc.util.SysInfo;
import com.doc.util.TSysOrg;
import com.doc.util.TSysUser;

public class SysOrgServiceImpl  implements ISysOrgService {



	// Excel 中单元格数据为空的替代符号
	private String defaultValue = null;

	private ISysOrgDao sysOrgDao;
	
	public void setSysOrgDao(ISysOrgDao sysOrgDao) {
		this.sysOrgDao = sysOrgDao;
	}
	
	public void changeRowsList(Map map) throws Exception {


		ArrayList<Map> insertlist = (ArrayList)map.get("inserted");
		updateChangeRowsList(insertlist,"inserted");
		ArrayList<Map> updatelist = (ArrayList)map.get("updated");
		updateChangeRowsList(updatelist,"updated");
		ArrayList<Map> deletelist = (ArrayList)map.get("deleted");
		updateChangeRowsList(deletelist,"deleted");
			
	
	}
	
	private void updateChangeRowsList(List<Map> list,String key) throws Exception{
		if(list!=null&& list.size()>0){
			if(key.equals("inserted")){
				sysOrgDao.addSysOrg(list);
			}
			if(key.equals("updated")){
				sysOrgDao.updateSysOrgData(list);
			}
			if(key.equals("deleted")){
				sysOrgDao.deleteSysOrg(list);
			}
		}
	}

	public Map importExcelSheet(File file) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(file));
		Map mapstatus = new HashMap();
		boolean flag = checkExcelNumFile(file, workbook, TSysUser.cellNum);
		if (flag) {
			Map map = parseWrokbook(workbook);
			List list1 = (List) map.get("list1");
			addSysOrg(list1);
			mapstatus.put("msg", SysInfo.msgsuccess);
			return mapstatus;
		} else {
			mapstatus.put("msg", SysInfo.excelErroInfo1);
			return mapstatus;
		}
	}

	public boolean checkExcelNumFile(File file, HSSFWorkbook workbook,
			int cellNum) throws FileNotFoundException, IOException {
		workbook = new HSSFWorkbook(new FileInputStream(file));
		HSSFSheet sheet = workbook.getSheetAt(0);
		int cellNo = sheet.getRow(0).getPhysicalNumberOfCells();// 首行列数
		if (cellNo == cellNum) {
			return true;
		} else {
			return false;
		}

	}

	public Map parseWrokbook(HSSFWorkbook workbook)
			throws FileNotFoundException, IOException {
		Map mapList = new HashMap();
		List list1 = new ArrayList();
		HSSFSheet sheet = workbook.getSheetAt(0);
		int cellNo = sheet.getRow(0).getPhysicalNumberOfCells();// 首行列数

		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			HSSFRow row = sheet.getRow(i);// 获取行对象
			int rowNo = i + 1;
			// System.out.print("第" + rowNo + "行   ");
			if (row == null) {// 如果为空，不处理
				continue;
			}
			Map normalbean = new HashMap();
			try {
				getCellValue(cellNo, row, normalbean);
			} catch (ParseException e) {
				continue;
			}
			list1.add(normalbean);
		}
		mapList.put("list1", list1);
		return mapList;
	}

	/**
	 * 遍历单元格
	 * 
	 * @throws ParseException
	 */
	private void getCellValue(int cellNo, HSSFRow row, Map normalbean)
			throws ParseException {
		// 循环遍历单元格
		for (int j = 0; j < cellNo; j++) {
			String value = getStringCellValue(row.getCell(j));
			setBean(normalbean, j, value);
		}
	}

	private void setBean(Map normalbean, int j, String value)
			throws NumberFormatException {
		switch (j) {
		case 0:
			normalbean.put(TSysOrg.orgName, value);
			break;
		case 1:
			normalbean.put(TSysOrg.remark, value);
			break;
		default:
			break;
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

	public List querySysOrgList(Map param) throws Exception {
		return sysOrgDao.querySysUserList(param);
	}
	
	public void addSysOrg(List list) throws Exception {
		sysOrgDao.addSysOrg(list);
	}
}
