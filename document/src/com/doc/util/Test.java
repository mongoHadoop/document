package com.doc.util;

import java.util.ArrayList;

import net.sf.json.JSONArray;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		ArrayList list = new ArrayList();
		list.add("1");
		list.add("1");
		list.add("1");
		String s  = JSONArray.fromObject(list).toString();
		System.out.println(s);
	}

}
