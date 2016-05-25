package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class SysUserDaoImpl   extends SqlMapClientDaoSupport  implements ISysUserDao{

	public List querySysUserList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysuser.querySysUser", param);
	}

	
	public void addSysUser(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("sysuser.insertDocUser", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 
	}
	
	public void updateSysUserData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("sysuser.updateSysUserById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	}



	public void deleteSysUser(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("sysuser.deleteSysUserById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	}


	public void updateSysUserData(Map map) throws Exception {
		 this.getSqlMapClientTemplate().update("sysuser.updateSysUserById", map);		
	}


	public Map querySysUserByCode(Map param) throws Exception {
		return (Map) this.getSqlMapClientTemplate().queryForObject("sysuser.querySysUser", param);
	}
}
