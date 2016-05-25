package com.doc.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesSingleton extends Properties {

    
    private volatile static PropertiesSingleton instance = null;
    private static InputStream inputStream =null;
    private PropertiesSingleton(){
		  inputStream  = getClass().getResourceAsStream("/app.properties"); 
    }
    public static PropertiesSingleton getInstance(){
        //先检查实例是否存在，如果不存在才进入下面的同步块
        if(instance == null){
            //同步块，线程安全的创建实例
            synchronized (PropertiesSingleton.class) {
                //再次检查实例是否存在，如果不存在才真正的创建实例
                if(instance == null){
                    instance = new PropertiesSingleton();
                    try {
						instance.load(inputStream);
					} catch (IOException e) {
						e.printStackTrace();
					}
                }
            }
        }
        return instance;
    }

    public static void main(String[] args){

    	String username =  PropertiesSingleton.getInstance().getProperty("user.admin"); 
    	String psword =  PropertiesSingleton.getInstance().getProperty("user.psword"); 
    	System.out.println(username) ;
    	System.out.println(psword) ;
    
    }
}