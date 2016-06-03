package com.doc.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ibatis.sqlmap.client.SqlMapExecutor;


@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
@Repository(value = "docSubjectDao")
public class DocSubjectDaoImpl extends SqlMapClientDaoSupport implements
		IDocSubjectDao {

	public List queryDocSubject(Map param) throws Exception {
		return this.getSqlMapClientTemplate().queryForList(
				"docSubject.queryDocSubject", param);
	}

	public void addDocSubjectData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : map) {
					executor.insert("docSubject.insertDocSubject", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	}

	public void addDocSubjectData(Map map) throws Exception {
		this.getSqlMapClientTemplate().insert("docSubject.insertDocSubject",
				map);
	}

	public void deleteDocSubjectData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : map) {
					executor.delete("docSubject.deleteSubjectId", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	}

	public void deleteDocSubjectData(Map map) throws Exception {
		this.getSqlMapClientTemplate()
				.insert("docSubject.deleteSubjectId", map);
	}

	public void updateDocSubjectData(final List<Map> map) throws Exception {
		this.getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
			public Object doInSqlMapClient(SqlMapExecutor executor)
					throws SQLException {
				executor.startBatch();
				for (Map map2 : map) {
					executor.update("docSubject.updateDocSubjectById", map2);
				}
				executor.executeBatch();
				return null;
			}
		});
	}

	public void updateDocSubjectData(Map map) throws Exception {
		this.getSqlMapClientTemplate().update(
				"docSubject.updateDocSubjectById", map);
	}

	@Override
	public Map queryDocSubjectForObject(Map param) throws Exception {
		return (Map) this.getSqlMapClientTemplate().queryForObject(
				"docSubject.queryDocSubject", param);
	}

}
