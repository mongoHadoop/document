package com.doc.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface IReportService {

	public  Map querySumBySubject(Map param) throws Exception;
	public  List doChartData(Map param) throws Exception ;
}
