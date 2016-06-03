package com.doc.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.json.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.doc.dao.IDocInfoDao;
import com.doc.dao.IDocSubjectDao;
import com.doc.dao.IReportDao;
import com.doc.util.TdocInfo;

@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
@Service(value = "reportService")
public class ReportServiceImpl implements IReportService {

	@Resource(name = "reportDao")
	private IReportDao reportDao;

	public Map querySumBySubject(Map param) throws Exception {
		Map mapBean = new HashMap();
		Map bean = reportDao.querySumBySubject(param);
		return mapBean;
	}

	@Autowired
	private IDocInfoDao docInfoDao;

	@Autowired
	private IDocSubjectDao docSubjectDao;
	public List doChartData(Map param) throws Exception {
		String subjectIds = (String) param.get("subjectIds");
		Map map = (Map) JSONUtil.deserialize(subjectIds);
		ArrayList<String> subjectList = (ArrayList) map.get("subject");
		System.out.println("subjectIds== " + subjectList);
		List chartList = new ArrayList();
		for (String subjectId : subjectList) {
			System.out.println(subjectId);
			Map subject = new HashMap();
			subject.put("id", subjectId);
			Map subjectBean  = docSubjectDao.queryDocSubjectForObject(subject);
			Map param1 = new HashMap();
			param1.put("subject", subjectId);
			param1.put("orgId", param.get("orgId"));
			param1.put("recordTimeBegin", param.get("recordTimeBegin"));
			param1.put("recordTimeEnd", param.get("recordTimeEnd"));
			param1.put("lendType", TdocInfo.LendType.credit.getIndex());
			param1.put("status", param.get("docstatus"));
			
			
			Map creditNum  =  docInfoDao.queryDocInfoMoney(param1);//收
			
			param1.remove("lendType");
			param1.put("lendType", TdocInfo.LendType.debit.getIndex());//支出
			
			Map debitNum  =  docInfoDao.queryDocInfoMoney(param1);
			subjectBean.put("creditNum", creditNum);
			subjectBean.put("debitNum", debitNum);
			chartList.add(subjectBean);
		}
		return chartList;
	}
}
