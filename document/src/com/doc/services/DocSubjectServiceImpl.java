package com.doc.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.doc.dao.IDocInfoDao;
import com.doc.dao.IDocSubjectDao;

public class DocSubjectServiceImpl implements IDocSubjectService {

	private IDocSubjectDao docSubjectDao;
	
	@Autowired
	private IDocInfoDao docInfoDao;
	
	public void setDocSubjectDao(IDocSubjectDao docSubjectDao) {
		this.docSubjectDao = docSubjectDao;
	}

	public List queryDocSubject(Map param) throws Exception {

		return docSubjectDao.queryDocSubject(param);
	}

	public void changeRowsList(Map param) throws Exception{
		ArrayList<Map> insertlist = (ArrayList)param.get("inserted");
		updateChangeRowsList(insertlist,"inserted");
		ArrayList<Map> updatelist = (ArrayList)param.get("updated");
		updateChangeRowsList(updatelist,"updated");
		ArrayList<Map> deletelist = (ArrayList)param.get("deleted");
		updateChangeRowsList(deletelist,"deleted");
	}
	private void updateChangeRowsList(List<Map> list,String key) throws Exception{
		List<Map> objectList = new ArrayList();
		List<Map> objectList2 = new ArrayList();
		if(list!=null&& list.size()>0){
			if(key.equals("inserted")){
				docSubjectDao.addDocSubjectData(list);
			}
			if(key.equals("updated")){
				docSubjectDao.updateDocSubjectData(list);
			}
			if(key.equals("deleted")){
				docSubjectDao.deleteDocSubjectData(list);
			}
		}
	}

	public HashMap<String, Object> doChartData(Map param) throws Exception {
		try {
			String subjectIds = (String) param.get("subjectIds");
			Map map = (Map) JSONUtil.deserialize(subjectIds);
			ArrayList<String> subjectList = (ArrayList)map.get("subject");
			System.out.println("subjectIds== "+subjectList);
			for (String subjectId:subjectList){
				System.out.println(subjectId);
				Map param1 = new HashMap();
				param1.put("subject", subjectId);
				param1.put("subject", subjectId);
				
				docInfoDao.queryDocInfoMoney(param1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
