/*
 * Powered By cuichen
 * Since 2014 - 2015
 */
package com.seeyoui.kensite.framework.system.domain;  

import com.seeyoui.kensite.common.base.domain.Pager;

/**
 * @author cuichen
 * @version 1.0
 * @since 1.0
 */
public class SysRole extends Pager {  
    private static final long serialVersionUID = 5454155825314635342L;  
      
    private String id;  
    private String name;  
    private String shiro;  
 
    public void setId(String id) {  
        this.id = id;  
    }  
      
    public String getId() {  
        return this.id;  
    }  
    public void setName(String name) {  
        this.name = name;  
    }  
      
    public String getName() {  
        return this.name;  
    }  
    public void setShiro(String shiro) {  
        this.shiro = shiro;  
    }  
      
    public String getShiro() {  
        return this.shiro;  
    }  
}