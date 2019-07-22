<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ja.gameData.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<canvas id="ctx" width="<%= CanvasData.width %>" height="<%= CanvasData.height %>" style="border:1px solid #000000;"></canvas>
<p id="test"></p>
<p id="demo"></p>
<script> 
var ctx = document.getElementById("ctx").getContext("2d"); 
ctx.font = '30px Arial';

var HEIGHT = <%= CanvasData.height %>;
var WIDTH = <%= CanvasData.width %>;
var timeWhenGameStarted = Date.now();	//return time in ms

<%
PlayerUnit user1 = new PlayerUnit("user1",10);
user1.x = CanvasData.width/2;
user1.y = CanvasData.height/2;
%>

//player속성
var player = {
		x:<%= user1.x%>,
		y:<%= user1.y %>,
		hp: <%= user1.hp %>,
		width:20,
		height:20,
		color:'green'
};


var monsterList = {};


//충돌감지
testCollisionEntity = function (entity1,entity2){	//return if colliding (true/false)
	var rect1 = {
		x:entity1.x-entity1.width/2,
		y:entity1.y-entity1.height/2,
		width:entity1.width,
		height:entity1.height,
	}
	var rect2 = {
		x:entity2.x-entity2.width/2,
		y:entity2.y-entity2.height/2,
		width:entity2.width,
		height:entity2.height,
	}
	return testCollisionRectRect(rect1,rect2);
	
}

testCollisionRectRect = function(rect1,rect2){
	return rect1.x <= rect2.x+rect2.width 
		&& rect2.x <= rect1.x+rect1.width
		&& rect1.y <= rect2.y + rect2.height
		&& rect2.y <= rect1.y + rect1.height;
}



//텍스트(몬스터 오브젝트) 생성자

monster = function (id,x,y,vx,vy,width,height){
	var monster3 = {
		x:x,
		y:y,
		vx:vx,
		vy:vy,
		id:id,
		width:width,
		height:height,
		color:'red',
	};
	monsterList[id] = monster3;
	
}


document.onmousemove = function(mouse){
	var mouseX = mouse.clientX;
	var mouseY = mouse.clientY;
	var coor = "사용자 좌표: (" + player.x + "," + player.y + ")";
	document.getElementById("test").innerHTML = coor;
	
	player.x = mouseX;
	player.y = mouseY;
}
document.onmouseout = function() {
	  document.getElementById("test").innerHTML = "";
}


updateEntity = function (something){
	updateEntityPosition(something);
	drawEntity(something);
}

updateEntityPosition = function(something){
	something.x += something.vx;
	something.y += something.vy;
			
	if(something.x < 0 || something.x > WIDTH){
		something.vx = -something.vx;
	}
	if(something.y < 0 || something.y > HEIGHT){
		something.vy = -something.vy;
	}
}




drawEntity = function(something){
	ctx.save();
	ctx.fillStyle = something.color;
	ctx.fillRect(something.x-something.width/2,something.y-something.height/2,something.width,something.height);
	ctx.restore();
}



update = function(){
	ctx.clearRect(0,0,WIDTH,HEIGHT);
	
	for(var key in monsterList){
		updateEntity(monsterList[key]);
		
		var isColliding = testCollisionEntity(player,monsterList[key]);
		if(isColliding=0){
			player.hp = player.hp - 1;
			if(player.hp <= 0){
				var timeSurvived = Date.now() - timeWhenGameStarted;
				console.log("You lost! You survived for " + timeSurvived + " ms.");
				timeWhenGameStarted = Date.now();
				player.hp = 10;
			}
		}
		
	}
	
	drawEntity(player);
	ctx.fillText(player.hp + " Hp",0,30);
	
}

monster('E1',150,350,10,15,30,30);
monster('E2',250,350,10,-15,20,20);
monster('E3',250,150,10,-8,40,10);


setInterval(update,40);












</script>
</body>
</html>