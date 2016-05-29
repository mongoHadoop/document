package com.doc.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.doc.dao.IReportDao;


@Transactional(propagation=Propagation.SUPPORTS,readOnly=true)
@Service(value="reportService")
public class ReportServiceImpl implements IReportService{

	@Resource(name="reportDao")
	private IReportDao reportDao;
	
	public Map querySumBySubject(Map param) throws Exception {
		Map mapBean = new HashMap();
		Map bean = reportDao.querySumBySubject(param);	
		return mapBean;
	}
}
