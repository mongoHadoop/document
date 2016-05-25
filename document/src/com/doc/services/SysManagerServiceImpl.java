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
import com.doc.dao.ISysOrgDao;
import com.doc.dao.ISysRoleDao;
import com.doc.dao.ISysUserDao;
import com.doc.util.TSysRoleMenu;

@Transactional(propagation=Propagation.SUPPORTS,readOnly=true)
public class SysManagerServiceImpl implements ISysManagerService{

	private ISysRoleDao sysRoleDao;
	
	private ISysUserDao sysUserDao;
	
	private ISysOrgDao sysOrgDao;
	
	@Autowired
	private ISysMenuDao sysMenuDao;
	@Autowired
	private IRoleMenuDao roleMenuDao;

	public void setSysRoleDao(ISysRoleDao sysRoleDao) {
		this.sysRoleDao = sysRoleDao;
	}

	public void setSysUserDao(ISysUserDao sysUserDao) {
		this.sysUserDao = sysUserDao;
	}

	public void setSysOrgDao(ISysOrgDao sysOrgDao) {
		this.sysOrgDao = sysOrgDao;
	}

	public List querySysUserList(Map param) throws Exception {
		return sysUserDao.querySysUserList(param);
	}

	public List queryGrantRoleMenuList(Map param) throws Exception {
		List nodes = new ArrayList();

		List<Map> list  = sysMenuDao.queryGrantRoleMenuList(param);
		Map rootNode = new HashMap();
	    rootNode.put("id", 1);
	    rootNode.put("pId", 0);
	    rootNode.put("name", "角色菜单授权1");
	    rootNode.put("open", true);
	    rootNode.put("iconOpen", "../resources/ztree/css/zTreeStyle/img/diy/1_open.png");
	    rootNode.put("iconClose", "../resources/ztree/css/zTreeStyle/img/diy/1_close.png");
	    if(list!=null && list.size()>0){
	    	rootNode.put("isParent", true);
	    }
	    nodes.add(rootNode);
	    
	    for(Map map :list){
			Map node = new HashMap();
			node.put("id", map.get("menuId"));
			node.put("pId", 1);
			node.put("name", map.get("menuName"));
			node.put("icon", "../resources/ztree/css/zTreeStyle/img/diy/2.png");
			node.put("isParent", false);
			nodes.add(node);
		}
		return nodes;
	}

	public List queryNotGrantMenuList(Map param) throws Exception {
		return sysMenuDao.queryNotGrantMenuList(param);
	}

	public List queryMenuList(Map param) throws Exception {
		List<Map> list  = sysMenuDao.querySysMenuList(param);
		List nodes = new ArrayList();
		Map rootNode = new HashMap();
	    rootNode.put("id", 1);
	    rootNode.put("pId", 0);
	    rootNode.put("nocheck", true);
	    rootNode.put("name", "角色菜单授权2");
	    rootNode.put("open", true);
	    rootNode.put("iconOpen", "../resources/ztree/css/zTreeStyle/img/diy/1_open.png");
	    rootNode.put("iconClose", "../resources/ztree/css/zTreeStyle/img/diy/1_close.png");
	    rootNode.put("isParent", true);
	    nodes.add(rootNode);
	    
	    for(Map map :list){
			Map node = new HashMap();
			node.put("id", map.get("menuId"));
			node.put("pId", 1);
			node.put("name", map.get("menuName"));
			node.put("icon", "../resources/ztree/css/zTreeStyle/img/diy/2.png");
			node.put("isParent", false);
			nodes.add(node);
		}
		return nodes;
	}

	//事务处理
	@Transactional(propagation=Propagation.REQUIRED,readOnly=false)
	public void updateRoleMenuList(Map param) throws Exception {
		String roleId = (String) param.get(TSysRoleMenu.roleId);
		List<Map> list = (List<Map>) param.get("selected");
		List maplist = new ArrayList();
		for (Map<String,Object> map :list){
			Map bean = new HashMap();
			bean.put(TSysRoleMenu.menuId, map.get("id"));
			bean.put(TSysRoleMenu.roleId, roleId);
			maplist.add(bean);
		}
		roleMenuDao.deleteRoleMenuRelationShip(maplist);
		roleMenuDao.addRoleMenuRelationShip(maplist);
	}
	
}
