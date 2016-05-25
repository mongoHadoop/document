package com.doc.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.doc.dao.IRoleMenuDao;
import com.doc.dao.ISysMenuDao;

@Transactional(propagation = Propagation.SUPPORTS,readOnly=true)
public class SysMenuServiceImpl implements ISysMenuService {

	@Autowired
	ISysMenuDao sysMenuDao;
	@Autowired
	IRoleMenuDao roleMenuDao;
	
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
				sysMenuDao.addSysMenu(list);
			}
			if(key.equals("updated")){
				sysMenuDao.updateSysMenuData(list);
			}
			if(key.equals("deleted")){
				sysMenuDao.deleteSysMenu(list);
			}
		}
	}
	
	public List querySysMenuList(Map param) throws Exception {
		return sysMenuDao.querySysMenuList(param);
	}

	public List querySuperAdminSysMenuList(Map param) throws Exception {
		
		List nodes = new ArrayList();
		List<Map> menuList  = sysMenuDao.querySysMenuList(param);
		Map rootNode = new HashMap();
	    rootNode.put("id", 1);
	    rootNode.put("pId", 0);
	    rootNode.put("name", "菜单授权");
	    rootNode.put("open", true);
	    rootNode.put("iconOpen", "../resources/ztree/css/zTreeStyle/img/diy/1_open.png");
	    rootNode.put("iconClose", "../resources/ztree/css/zTreeStyle/img/diy/1_close.png");
	    if(menuList!=null && menuList.size()>0){
	    	rootNode.put("isParent", true);
	    }
	    nodes.add(rootNode);
	    
	    for(Map map :menuList){
			Map node = new HashMap();
			node.put("id", map.get("menuId"));
			node.put("pId", 1);
			node.put("url", map.get("url"));
			node.put("name", map.get("menuName"));
			node.put("icon", "../resources/ztree/css/zTreeStyle/img/diy/2.png");
			node.put("isParent", false);
			nodes.add(node);
		}
		return nodes;
	}
	
	public List queryMenuByRole(Map param) throws Exception {
		List<Map> menuList  = roleMenuDao.queryMenuByRole(param);
		List nodes = new ArrayList();
		
		Map rootNode = new HashMap();
	    rootNode.put("id", 1);
	    rootNode.put("pId", 0);
	    rootNode.put("name", "菜单授权");
	    rootNode.put("open", true);
	    rootNode.put("iconOpen", "../resources/ztree/css/zTreeStyle/img/diy/1_open.png");
	    rootNode.put("iconClose", "../resources/ztree/css/zTreeStyle/img/diy/1_close.png");
	    if(menuList!=null && menuList.size()>0){
	    	rootNode.put("isParent", true);
	    }
	    nodes.add(rootNode);
	    
	    for(Map map :menuList){
			Map node = new HashMap();
			node.put("id", map.get("menuId"));
			node.put("pId", 1);
			node.put("url", map.get("url"));
			node.put("name", map.get("menuName"));
			node.put("icon", "../resources/ztree/css/zTreeStyle/img/diy/2.png");
			node.put("isParent", false);
			nodes.add(node);
		}
		return nodes;
	}

	
}
