package com.doc.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.doc.dao.ISysRoleDao;

@Transactional(propagation=Propagation.SUPPORTS,readOnly=true)
public class SysRoleServiceImpl implements ISysRoleService{

	@Autowired
	private ISysRoleDao sysRoleDao;
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false)
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
				sysRoleDao.addSysRole(list);
			}
			if(key.equals("updated")){
				sysRoleDao.updateSysRole(list);
			}
			if(key.equals("deleted")){
				sysRoleDao.deleteSysRole(list);
			}
		}
	}
	public List querySysRoleList(Map param) throws Exception {
		return sysRoleDao.queryRoleList(param);
	}
	public List queryRoleMenu(Map param) throws Exception {
		return null;
	}

}
