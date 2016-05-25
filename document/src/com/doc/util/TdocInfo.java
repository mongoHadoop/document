package com.doc.util;


public class TdocInfo {
	public static final String id ="id";
	public static final String docId ="docId";
	public static final String docName ="docName";
	public static final String subject ="subject";
	public static final String money ="money";
	public static final String recordUser ="recordUser";
	public static final String orgId ="orgId";
	public static final String orgName ="orgName";
	public static final String recordTime ="recordTime";
	public static final String fileType ="fileType";
	public static final String remark ="remark";
	public static final String status = "status";
	public static final int cellNum =3;
	public static final String dateFormate ="yyyy-MM-dd HH:mm:ss";
	public enum LendType {
		/**
		 * 收支 类型
		 * 1收入
		 * 2 支出
		 */
		debit("收入", 1), credit("支出", 2);
		// 成员变量
		private String name;
		private int index;
		// 构造方法
		private LendType(String name, int index) {
			this.name = name;
			this.index = index;
		}
		// 普通方法
		public static String getName(int index) {
			for (LendType c : LendType.values()) {
				if (c.getIndex() == index) {
					return c.name;
				}
			}
			return null;
		}
		// get set 方法
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getIndex() {
			return index;
		}
		public void setIndex(int index) {
			this.index = index;
		}
	}
	
	public enum DocStatus {
		/**
		 * 文档提交状态
		 * 1 未提交
		 * 2 已提交(待审核)
		 * 3 审核办结
		 * 4
		 */
		UNSubmit("未提交", 1), Auditing("待审核", 2),Audited("审核办结", 3);
		
		// 成员变量
		private String name;
		private int index;
		// 构造方法
		private DocStatus(String name, int index) {
			this.name = name;
			this.index = index;
		}
		// 普通方法
		public static String getName(int index) {
			for (LendType c : LendType.values()) {
				if (c.getIndex() == index) {
					return c.name;
				}
			}
			return null;
		}
		// get set 方法
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getIndex() {
			return index;
		}
		public void setIndex(int index) {
			this.index = index;
		}
	}
}
