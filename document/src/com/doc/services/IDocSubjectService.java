package com.doc.services;

import java.util.List;
import java.util.Map;

public interface IDocSubjectService {

	
	public List queryDocSubject(Map param)throws Exception;
	
	public void changeRowsList(Map param) throws Exception;
	
	public Map  doChartData(Map param)throws Exception;
}
