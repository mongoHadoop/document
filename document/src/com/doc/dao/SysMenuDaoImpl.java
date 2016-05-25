package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class SysMenuDaoImpl  extends SqlMapClientDaoSupport implements ISysMenuDao{

	public void addSysMenu(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("sysmenu.insertSysMenu", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 
	
	}

	public void deleteSysMenu(final List<Map> map) throws Exception {

		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("sysmenu.deleteSysMenuById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
			
	}

	public List querySysMenuList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysmenu.querySysMenu", param);
	}

	public void updateSysMenuData(final List<Map> map) throws Exception {

		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("sysmenu.updateSysMenuById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	
	}

	public void updateSysMenuData(Map map) throws Exception {

		 this.getSqlMapClientTemplate().update("sysmenu.updateSysMenuById", map);		
			
	}

	public List queryGrantRoleMenuList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysmenu.queryGrantMenu", param);
	}

	public List queryNotGrantMenuList(Map param) throws Exception {
		return null;
	}

	
}
