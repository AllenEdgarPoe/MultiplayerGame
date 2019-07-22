<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ja.game.*" %>    
<%
	Game g = (Game)application.getAttribute("game1");
%>    
{
	"monsterDataList" : [
<%
	int length = g.getMonsterList().size();

	for(int i = 0; i < length ; i++){
		
		MonsterUnit m = g.getMonsterList().get(i);
		
		out.print("{");	
		out.print("\"id\":"+m.monsterId+",");
		out.print("\"name\": \""+m.name+"\",");
		out.print("\"x\":"+m.x+",");
		out.print("\"y\":"+m.y+",");
		out.print("\"vx\":"+m.vx+",");
		out.print("\"vy\":"+m.vy);
		out.print("}");
		
		if(i != length-1)
			out.print(",");
	}
%>	
	]
	<%--
	,
	userDataList : [{},{}] 
	--%>
}




















