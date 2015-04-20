<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<title>平台</title>
	<script type="text/javascript" src="${ctx_common}/js/jquery-1.7.2.min.js"></script>
	<%@ include file="/WEB-INF/view/common/easyui.jsp" %>

	<style type="text/css">
	body {
		font: 12px/20px "微软雅黑", "宋体", Arial, sans-serif, Verdana, Tahoma;
		padding: 0;
		margin: 0;
	}
	a:link {
	 text-decoration: none;
	}
	a:visited {
	 text-decoration: none;
	}
	a:hover {
	 text-decoration: underline;
	}
	a:active {
	 text-decoration: none;
	}
	.cs-north {
		height:60px;background:#B3DFDA;
	}
	.cs-north-bg {
		width: 100%;
		height: 100%;
		background: url('') repeat-x;
	}
	.cs-north-logo {
		height: 40px;
		padding: 15px 0px 0px 5px;
		color:#fff;font-size:22px;font-weight:bold;text-decoration:none
	}
	.cs-west {
		width:200px;padding:0px;border-left:1px solid #99BBE8;
	}
	.cs-center {
		width:200px;padding:0px;border-left:1px solid #99BBE8;
	}
	.cs-south {
		height:25px;background:url('') repeat-x;padding:0px;text-align:center;
	}
	.cs-navi-tab {
		padding: 5px;
	}
	.cs-tab-menu {
		width:120px;
	}
	.cs-home-remark {
		padding: 10px;
	}
	</style>
	<script type="text/javascript">
	function addTab(title, url){
		if ($('#tabs').tabs('exists', title)){
			$('#tabs').tabs('select', title);//选中并刷新
			var currTab = $('#tabs').tabs('getSelected');
			var url = $(currTab.panel('options').content).attr('src');
			if(url != undefined && currTab.panel('options').title != 'Home') {
				$('#tabs').tabs('update',{
					tab:currTab,
					options:{
						content:createFrame(url)
					}
				});
			}
		} else {
			var content = createFrame(url);
			if(title != "首页") {
				$('#tabs').tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			} else {
				$('#tabs').tabs('add',{
					title:title,
					content:content,
					closable:false
				});
			}
		}
		tabClose();
	}
	function createFrame(url) {
		var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		return s;
	}
			
	function tabClose() {
		/*双击关闭TAB选项卡*/
		$(".tabs-inner").dblclick(function(){
			var subtitle = $(this).children(".tabs-closable").text();
			$('#tabs').tabs('close',subtitle);
		});
		/*为选项卡绑定右键*/
		$(".tabs-inner").bind('contextmenu',function(e){
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
	
			var subtitle =$(this).children(".tabs-closable").text();
	
			$('#mm').data("currtab",subtitle);
			$('#tabs').tabs('select',subtitle);
			return false;
		});
	}		
	//绑定右键菜单事件
	function tabCloseEven() {
		//刷新
		$('#mm-tabupdate').click(function(){
			var currTab = $('#tabs').tabs('getSelected');
			var url = $(currTab.panel('options').content).attr('src');
			if(url != undefined && currTab.panel('options').title != 'Home') {
				$('#tabs').tabs('update',{
					tab:currTab,
					options:{
						content:createFrame(url)
					}
				});
			}
		});
		//关闭当前
		$('#mm-tabclose').click(function(){
			var currtab_title = $('#mm').data("currtab");
			$('#tabs').tabs('close',currtab_title);
		});
		//全部关闭
		$('#mm-tabcloseall').click(function(){
			$('.tabs-inner span').each(function(i,n){
				var t = $(n).text();
				if(t != 'Home') {
					$('#tabs').tabs('close',t);
				}
			});
		});
		//关闭除当前之外的TAB
		$('#mm-tabcloseother').click(function(){
			var prevall = $('.tabs-selected').prevAll();
			var nextall = $('.tabs-selected').nextAll();		
			if(prevall.length>0){
				prevall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != 'Home') {
						$('#tabs').tabs('close',t);
					}
				});
			}
			if(nextall.length>0) {
				nextall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != 'Home') {
						$('#tabs').tabs('close',t);
					}
				});
			}
			return false;
		});
		//关闭当前右侧的TAB
		$('#mm-tabcloseright').click(function(){
			var nextall = $('.tabs-selected').nextAll();
			if(nextall.length==0){
				//msgShow('系统提示','后边没有啦~~','error');
				alert('后边没有啦~~');
				return false;
			}
			nextall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tabs').tabs('close',t);
			});
			return false;
		});
		//关闭当前左侧的TAB
		$('#mm-tabcloseleft').click(function(){
			var prevall = $('.tabs-selected').prevAll();
			if(prevall.length==0){
				alert('到头了，前边没有啦~~');
				return false;
			}
			prevall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				$('#tabs').tabs('close',t);
			});
			return false;
		});
	
		//退出
		$("#mm-exit").click(function(){
			$('#mm').menu('hide');
		});
	}
	
	$(function() {
		addTab('首页', '');
		tabCloseEven();
		$('.cs-navi-tab').click(function() {
			var $this = $(this);
			var href = $this.attr('src');
			var title = $this.text();
			addTab(title, href);
		});
	});
	</script>
</head>
<body class="easyui-layout">
	<div id="noth" name="noth" region="north" border="true" class="cs-north">
		<div class="cs-north-bg">
			<div style="width:120px; float:left;"><img src="${ctx_page}/common/img/logo.png" style="height: 55px;"/></div>
			<div style="width:70px; height:50px; float:right; vertical-align:bottom;">
				<!-- <img title="用户信息维护" src="${ctx_page}/img/icon/blacks/32x32/contact_card.png" onclick="javascript:sysUserInfo();"/> -->
				<img title="修改密码" src="${ctx_page}/common/img/icon/blacks/16x16/key.png" onclick="javascript:sysUserPwd();"/>
				<img title="退出" src="${ctx_page}/common/img/icon/blacks/16x16/on-off.png" onclick="javascript:exit();"/>
			</div>
			<div style="width:110px; height:50px; float:right; vertical-align:bottom;">
				<font>欢迎你，<font size="2" color="red">${currentUser.name}</font></font>
			</div>
		</div>
	</div>
	<div region="west" border="true" title="  " collapsible="fasle" split="false" class="cs-west">
		<ul id="menuTree" class="easyui-tree"></ul>		
	</div>
	<div id="mainPanle" region="center" border="false">
		<div id="tabs" class="easyui-tabs" fit="true" border="false" >
        </div>
	</div>
	<!-- 
	<div region="south" border="true" class="cs-south">Manstro</div>
	 -->
		<div id="sysUserInfoWin" class="easyui-window" title="信息维护" data-options="modal:true,closed:true,iconCls:'icon-save',resizable:false" style="width:250px;height:120px;padding:10px;">
	        <form id="sysUserInfoForm" method="post" enctype="multipart/form-data">
	            <div class="fitem">
	                <label>用户名称:</label>
	                <input name="name" class="easyui-validatebox textbox" required="true">
	            </div>
	            <br/>
				<input type="hidden" id="sysUserAccount" name="account" value="${sysUserCache.sysUser.account}"/>
			</form>
			
		    <div id="departmentWin-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveInfo()" style="width:90px">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#userInfoWin').window('close')" style="width:90px">取消</a>
		    </div>
	    </div>
	    <div id="sysUserPwdWin" class="easyui-window" title="信息维护" data-options="modal:true,closed:true,iconCls:'icon-save',resizable:false" style="width:250px;height:180px;padding:10px;">
	        <form id="sysUserPwdForm" method="post" enctype="multipart/form-data">
	            <div class="fitem">
	                <label>原始密码:</label>
	                <input id="oldPwd" type="password" name="oldPwd" class="easyui-validatebox textbox" required="true">
	            </div>
	            <div class="fitem">
	                <label>修改密码:</label>
	                <input id="newPwd" type="password" name="newPwd" class="easyui-validatebox textbox" required="true">
	            </div>
	            <div class="fitem">
	                <label>修改密码:</label>
	                <input id="newPwd2" name="newPwd2" type="password" class="easyui-validatebox textbox" required="true">
	            </div>
	            <br/>
				<input type="hidden" id="sysUserAccount" name="account" value="${sysUserCache.sysUser.account}"/>
			</form>
			
		    <div id="departmentWin-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="savePwd()" style="width:90px">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#userInfoWin').window('close')" style="width:90px">取消</a>
		    </div>
	    </div>
	<div id="mm" class="easyui-menu cs-tab-menu">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseother">关闭其他</div>
		<div id="mm-tabcloseall">关闭全部</div>
	</div>
	<script type="text/javascript">
	 	$(document).ready(function(){
	    	loadTreeData();
	    	$('#menuTree').tree({
	    		onClick: function(node){
	    			if(node.attributes.url != null && node.attributes.url != "" && node.attributes.url != "/") {
	    				addTab(node.text ,"${ctx}"+node.attributes.url);
	    			}
	    		}
	    	});
	    });
		function loadTreeData() {
	    	$.ajax({
				type: "POST",
				url: "${ctx}/sysMenu/getTreeData.do",
				data: "username=${currentUser.username}",
				dataType: "json",
				success: function(info){
					$("#menuTree").tree("loadData", info);
				}
			});
	    }
		function exit() {
			window.location.href="${ctx}/login/logout.do";
		}
		var url;
		function sysUserInfo(){
            $('#sysUserInfoWin').window('open');
            url = '${ctx}/sysUser/updateSysUserName.do';
        }
		function sysUserPwd(){
            $('#sysUserPwdWin').window('open');
            url = '${ctx}/sysUser/updatePassword.do';
        }
		function savePwd() {
			if($('#newPwd').val() != $('#newPwd2').val()) {
				$.messager.show({
                    title: 'Error',
                    msg: '密码不一致！',
                    showType:'fade',
                    style:{
                        right:'',
                        bottom:''
                    }
                });
				$('#newPwd').val('');
				$('#newPwd2').val('');
				return;
			}
			$.ajax({
				type: "POST",
				url: url,
				data: "account=${sysUserCache.sysUser.account}&oldPwd="+$('#oldPwd').val()+"&newPwd="+$('#newPwd').val(),
				dataType: "html",
				success: function(info){
					var result = eval('('+info+')');
                    if (result.success){
                        $('#sysUserPwdWin').window('close'); 
                        $.messager.show({
                            title: 'Success',
                            msg: result.message,
                            showType:'fade',
                            style:{
                                right:'',
                                bottom:''
                            }
                        });
                    } else {
                    	$.messager.show({
                            title: 'Error',
                            msg: result.message,
                            showType:'fade',
                            style:{
                                right:'',
                                bottom:''
                            }
                        });
                    }
				}
			});
		}
		function saveInfo(){
            $('#sysUserInfoForm').form('submit',{
                url: url,
                onSubmit: function(param){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
                    if (result.success){
                        $('#sysUserInfoWin').window('close'); 
                        $.messager.show({
                            title: 'Success',
                            msg: result.message,
                            showType:'fade',
                            style:{
                                right:'',
                                bottom:''
                            }
                        });
                    } else {
                    	$.messager.show({
                            title: 'Error',
                            msg: result.message,
                            showType:'fade',
                            style:{
                                right:'',
                                bottom:''
                            }
                        });
                    }
                }
            });
        }
	</script>
</body>
</html>