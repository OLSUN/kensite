package com.seeyoui.kensite.framework.oa.controller.leave;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Maps;
import com.opensymphony.module.sitemesh.Page;
import com.seeyoui.kensite.common.base.controller.BaseController;
import com.seeyoui.kensite.common.base.persistence.JsonMapper;
import com.seeyoui.kensite.framework.oa.domain.leave.Leave;
import com.seeyoui.kensite.framework.oa.service.leave.LeaveService;
import com.seeyoui.kensite.framework.system.util.UserUtils;

@Controller
@RequestMapping(value = "oa/leave")
public class LeaveController extends BaseController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected LeaveService leaveService;

	@Autowired
	protected RuntimeService runtimeService;

	@Autowired
	protected TaskService taskService;

	@RequiresPermissions("oa:leave:view")
	@RequestMapping(value = {"form"})
	public String form(Leave leave, Model model) {
		model.addAttribute("leave", leave);
		return "modules/oa/leaveForm";
	}

	/**
	 * 启动请假流程
	 * @param leave	
	 */
	@RequiresPermissions("oa:leave:edit")
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String save(Leave leave, RedirectAttributes redirectAttributes) {
		try {
			Map<String, Object> variables = Maps.newHashMap();
			leaveService.save(leave, variables);
//			addMessage(redirectAttributes, "流程已启动，流程ID：" + leave.getProcessInstanceId());
		} catch (Exception e) {
			logger.error("启动请假流程失败：", e);
			addMessage(redirectAttributes, "系统内部错误！");
		}
		return "redirect:/oa/leave/form";
	}

	/**
	 * 任务列表
	 * @param leave	
	 */
	@RequiresPermissions("oa:leave:view")
	@RequestMapping(value = {"list/task",""})
	public String taskList(HttpSession session, Model model) {
		String userId = UserUtils.getUser().getUsername();//ObjectUtils.toString(UserUtils.getUser().getId());
		List<Leave> results = leaveService.findTodoTasks(userId);
		model.addAttribute("leaves", results);
		return "modules/oa/leaveTask";
	}

	/**
	 * 读取所有流程
	 * @return
	 */
	@RequiresPermissions("oa:leave:view")
	@RequestMapping(value = {"list"})
	public String list(Leave leave, HttpServletRequest request, HttpServletResponse response, Model model) {
//        Page<Leave> page = leaveService.find(new Page<Leave>(request, response), leave); 
//        model.addAttribute("page", page);
		return "framework/oa/leave/leaveList";
	}
	
	/**
	 * 读取详细数据
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "detail/{id}")
	@ResponseBody
	public String getLeave(@PathVariable("id") String id) {
		Leave leave = leaveService.get(id);
		return JsonMapper.getInstance().toJson(leave);
	}

	/**
	 * 读取详细数据
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "detail-with-vars/{id}/{taskId}")
	@ResponseBody
	public String getLeaveWithVars(@PathVariable("id") String id, @PathVariable("taskId") String taskId) {
		Leave leave = leaveService.get(id);
		Map<String, Object> variables = taskService.getVariables(taskId);
//		leave.setVariables(variables);
		return JsonMapper.getInstance().toJson(leave);
	}

}
