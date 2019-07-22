<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ja.gameData.*" %>
<%
	Game g = (Game)application.getAttribute("game1");
	

	int vx = Integer.parseInt(request.getParameter("vx"));
	int vy = Integer.parseInt(request.getParameter("vy"));
	
	String sessionId = session.getId();
	
	for(PlayerUnit u: g.getPlayerList()){
		if(u.name.equals(sessionId)){
			u.vx = vx;
			u.vy = vy;
		}
	}
%>
