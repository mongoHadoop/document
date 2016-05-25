package com.doc.util;

public class TFilePath {
	
	public static final String id ="id";
	public static final String docId ="docId";
	public static final String filePath ="filePath";
	public static final String fileType="fileType";
	
	public enum FileType {
		/**
		 * 1 图片类型 2 其他文件类型
		 */
		JPG("image/jpeg", 1), BMP("image/bmp", 1), PNG("image/png", 1), OTHERFILE("zip", 2);
		// 成员变量
		private String name;
		private int index;
		// 构造方法
		private FileType(String name, int index) {
			this.name = name;
			this.index = index;
		}
		// 普通方法
		public static String getName(int index) {
			for (FileType c : FileType.values()) {
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
