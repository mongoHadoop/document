package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class SysRoleDaoImpl  extends SqlMapClientDaoSupport implements ISysRoleDao{

	public List queryRoleList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysrole.querySysrole", param);
	}

	public void addSysRole(final List<Map> map) throws Exception {

		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("sysrole.insertSysrole", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 
	
	}

	public void deleteSysRole(final List<Map> map) throws Exception {


		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("sysrole.deleteSysroleById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	
	
	}

	public void updateSysRole(Map map) throws Exception {
		this.getSqlMapClientTemplate().update("sysrole.updateSysroleById", map);
	}

	public void updateSysRole(final List<Map> map) throws Exception {


		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("sysrole.updateSysroleById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	
	
	}

	public List queryRoleMenu(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysrole.queryrolemenu", param);
	}

}
