package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class RoleMenuDaoImpl  extends SqlMapClientDaoSupport implements IRoleMenuDao{


	public void addRoleMenuRelationShip(final List<Map> maplist) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:maplist) {
			     executor.insert("sysrolemenu.addRelation", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 
	}

	public void deleteRoleMenuRelationShip(final List<Map> maplist) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:maplist) {
			     executor.delete("sysrolemenu.deleterelation", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	
	}

	public List queryMenuByRole(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("sysrolemenu.queryGrantMenuByRoleId", param);
	}

}
