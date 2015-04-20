/*
 * Powered By cuichen
 * Since 2014 - 2015
 */package com.seeyoui.kensite.framework.system.controller;  
 
import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seeyoui.kensite.common.base.controller.BaseController;

import com.seeyoui.kensite.common.constants.StringConstant;
import com.seeyoui.kensite.common.base.domain.EasyUIDataGrid;
import com.seeyoui.kensite.common.base.controller.BaseController;
import com.seeyoui.kensite.common.util.RequestResponseUtil;

import com.seeyoui.kensite.framework.system.domain.SysRoleModule;
import com.seeyoui.kensite.framework.system.service.SysRoleModuleService;
/**
 * @author cuichen
 * @version 1.0
 * @since 1.0
 */
@Controller
@RequestMapping(value = "sysRoleModule")
public class SysRoleModuleController extends BaseController {
	
	@Autowired
	private SysRoleModuleService sysRoleModuleService;
	
	/**
	 * 展示列表页面
	 * @param modelMap
	 * @param module
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sysRoleModule:view")
	@RequestMapping(value = "/showPageList")
	public ModelAndView showSysRoleModulePageList(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		return new ModelAndView("framework/system/sysRoleModule", modelMap);
	}
	
	/**
	 * 获取列表展示数据
	 * @param modelMap
	 * @param sysRoleModule
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sysRoleModule:select")
	@RequestMapping(value = "/getListData", method=RequestMethod.POST)
	@ResponseBody
	public String getListData(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, SysRoleModule sysRoleModule) throws Exception{
		List<SysRoleModule> sysRoleModuleList = sysRoleModuleService.findSysRoleModuleList(sysRoleModule);
		EasyUIDataGrid eudg = sysRoleModuleService.findSysRoleModuleListTotal(sysRoleModule);
		eudg.setRows(sysRoleModuleList);
		JSONObject jsonObj = JSONObject.fromObject(eudg);
		RequestResponseUtil.putResponseStr(session, response, request, jsonObj);
		return null;
	}
	
	/**
	 * 保存新增的数据
	 * @param modelMap
	 * @param sysRoleModule
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sysRoleModule:insert")
	@RequestMapping(value = "/saveByAdd", method=RequestMethod.POST)
	@ResponseBody
	public String saveSysRoleModuleByAdd(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, SysRoleModule sysRoleModule) throws Exception{
		sysRoleModuleService.saveSysRoleModule(sysRoleModule);
		RequestResponseUtil.putResponseStr(session, response, request, StringConstant.TRUE);
		return null;
	}
	
	/**
	 * 保存修改的数据
	 * @param modelMap
	 * @param sysRoleModule
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sysRoleModule:update")
	@RequestMapping(value = "/saveByUpdate", method=RequestMethod.POST)
	@ResponseBody
	public String saveSysRoleModuleByUpdate(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, SysRoleModule sysRoleModule) throws Exception{
		sysRoleModuleService.updateSysRoleModule(sysRoleModule);
		RequestResponseUtil.putResponseStr(session, response, request, StringConstant.TRUE);
		return null;
	}
	
	/**
	 * 删除数据库
	 * @param modelMap
	 * @param sysRoleModuleId
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("sysRoleModule:delete")
	@RequestMapping(value = "/delete", method=RequestMethod.POST)
	@ResponseBody
	public String delete(HttpSession session,
			HttpServletResponse response, HttpServletRequest request,
			ModelMap modelMap, String delDataId) throws Exception {
		List<String> listId = Arrays.asList(delDataId.split(","));
		sysRoleModuleService.deleteSysRoleModule(listId);
		RequestResponseUtil.putResponseStr(session, response, request, StringConstant.TRUE);
		return null;
	}
}