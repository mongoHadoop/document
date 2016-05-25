package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class SysOrgDaoImpl  extends SqlMapClientDaoSupport implements ISysOrgDao{

	public void addSysOrg(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("sysorg.insertSysOrg", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 
	}

	public void deleteSysOrg(final List<Map> map) throws Exception {

		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("sysorg.deleteSysOrgById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	
	}

	public List querySysUserList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysorg.querySysOrg", param);
	}

	public void updateSysOrgData(final List<Map> map) throws Exception {

		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("sysorg.updateSysOrgById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	
	}

}
