package com.doc.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapExecutor;

public class DocInfoDaoImpl  extends SqlMapClientDaoSupport implements IDocInfoDao  {

	
	public void addDocData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.insert("doc.insertDocInfo", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public List queryDocList(Map map) throws Exception {
	 return this.getSqlMapClientTemplate().queryForList("doc.queryDocInfo",map); 
	}

	public void addDocImagePath(final List<Map> map) throws Exception {
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

	public void updateDocData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("doc.updateDocInfoById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void deleteDocData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("doc.deleteDocInfo", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void addDocData(Map map) throws Exception {
		this.getSqlMapClientTemplate().insert("doc.insertDoc", map);
	}
	public void updateDocData(Map map) throws Exception {
		this.getSqlMapClientTemplate().update("doc.updateDocInfoById", map);
	}
	public void deleteDocData(Map map) throws Exception {
		this.getSqlMapClientTemplate().delete("doc.deleteDocInfo", map);
	}

	public void addDocTypeData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			    	
			     executor.insert("doctype.insertDocType", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void addDocTypeData(Map map) throws Exception {
		this.getSqlMapClientTemplate().insert("doctype.insertDocType", map);		
	}

	public void deleteDocTypeData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.delete("doctype.deleteDocType", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void deleteDocTypeData(Map map) throws Exception {
		this.getSqlMapClientTemplate().delete("doctype.insertDocType", map);		
	}

	public List queryDocTypeList(Map map) throws Exception {
		return  this.getSqlMapClientTemplate().queryForList("doctype.queryDocType",map);
	}

	public void updateDocTypeData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() { 
			   public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException { 
			    executor.startBatch(); 
			    for (Map map2:map) {
			     executor.update("doctype.updateDocTypeById", map2); 
			    }  
			    executor.executeBatch(); 
			    return null; 
			   } 
			  }); 		
	}

	public void updateDocTypeData(Map map) throws Exception {
		this.getSqlMapClientTemplate().update("doctype.updateDocTypeById", map);				
	}

	public List queryFilePathList(Map map) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("filepath.queryFilePath",map);
	}

	public List queryDocInfoByLeftJoin(Map map) throws Exception {
		return this.getSqlMapClientTemplate().queryForList("doc.queryDocInfoleftJoin",map); 
	}

	@Override
	public Map queryDocInfoMoney(Map map) throws Exception {
		return (Map)this.getSqlMapClientTemplate().queryForObject("doc.staticsDocInfo",map);
	}
	
}
