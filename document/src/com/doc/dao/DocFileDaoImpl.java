package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class DocFileDaoImpl  extends SqlMapClientDaoSupport   implements IDocFileDao{

	public List queryFilePathList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("filepath.queryFilePath",param);
	}

	public void addDocFilePath(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("filepath.insertFilePath", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void addDocFilePath(Map map) throws Exception {
		this.getSqlMapClientTemplate().insert("filepath.insertFilePath", map);
	}

	public void deleteDocFilePath(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
				   executor.startBatch(); 
				   for (Map map2:map) {
				    	executor.delete("filepath.deleteFilePath", map2); 
				   }  
				   executor.executeBatch(); 
				   return null; 
			   } 
			  }); 		
	}

	public void deleteDocFilePath(Map map) throws Exception {
		this.getSqlMapClientTemplate().delete("filepath.deleteFilePath",map);
	}

}
