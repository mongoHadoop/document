package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapExecutor;

@Repository(value="docUserDao")
public class DocUserDaoImpl  extends BaseDao  implements IDocUserDao{


	public List queryDocUserList(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList(
				"docuser.queryDocUser", param);
	}
	
	public void addDocUser(final List<Map> mapList)throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : mapList) {
					executor.insert("docuser.insertDocUser", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	
		
	}

	public void deleteDocUserData(final List<Map> mapList) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : mapList) {
					executor.delete("docuser.deleteDocUserById", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	
	}
	
	public void updateDocUserData(final List<Map> mapList) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : mapList) {
					executor.update("docuser.updateDocUserById", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	
	}

}
