package com.doc.dao;

import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

import javax.annotation.PostConstruct;
/**
 * BaseDao,Dao需继承此Dao
 */
public class BaseDao extends SqlMapClientDaoSupport{
	@Resource(name = "sqlMapClient")
	private SqlMapClient sqlMapClient;
	@PostConstruct
	public void initSqlMapClient(){
	     super.setSqlMapClient(sqlMapClient);
	} 
}

