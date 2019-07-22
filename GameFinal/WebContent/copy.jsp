<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ja.gameData.*"%>
<%
	String sessionIdx = session.getId();
	PlayerUnit user1 = new PlayerUnit(250,250,sessionIdx, 0, 0, 10, 10);
	Game g1 = (Game) application.getAttribute("game1");
	g1.addUser(user1);
%>
<!DOCTYPE HTML>
<html>
<head>
<title>The Canvas Tag</title>
<style>
	#canvas_1 {
		width: 500px;
		height: 500px;
		border: 1px solid black;
	}
	#user{
		background-image: url('./img/trump_face.jpg');
	}
</style>
</HEAD>

<BODY>
<HEADER>
	<P>Press TAB to begin, W, A, S, D keys to move</P>
	<p id="test"></p>
</HEADER>
<div id="canvas_1"></div>
<script>
var magnification = 1;
var movingTexts = [];
var userTexts = [];
var canvasWidth = 10000 * magnification;
var canvasHeight = 10000 * magnification;
var canvas = document.getElementById("canvas_1");

document.body.addEventListener('keydown', doKeyDown, true);

function doKeyDown(e) {
	var vx = 0;
	var vy = 0;

	//====================
	//	THE W KEY
	//====================
	if (e.keyCode == 87) {
		vy = -10;
	}

	//====================
	//	THE S KEY
	//====================
	if (e.keyCode == 83) {
		vy = 10;
		//canvas_context.fillRect(x, y, 50, 30);
	}

	//====================
	//	THE A KEY
	//====================
	if (e.keyCode == 65) {
		vx = -10;
		//canvas_context.fillRect(x, y, 50, 30);
	}

	//====================
	//	THE D KEY
	//====================
	if (e.keyCode == 68) {
		vx = 10;
	}
	
	
	//Ajax 통신으로 vx, vy 를 json 파일에다가 넣어줌. 
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function() { // 요청에 대한 콜백
		if (xmlhttp.readyState === xmlhttp.DONE) { // 요청이 완료되면
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			//console.log(xmlhttp.responseText);
			} else {
			console.error(xmlhttp.responseText);
			}
		}
	};
			
	xmlhttp.open('post', 'getUserData.jsp', true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");

	//console.log("vx=" + vx + "&vy=" + vy);
	xmlhttp.send("vx=" + vx + "&vy=" + vy);

};


//텍스트(몬스터 오브젝트) 생성자
function MovingText(id, name, x, y, vx, vy) {
	// 위치와 속도 속성
	this.id = id;
	this.name = name;
	this.x = x * magnification;
	this.y = y * magnification;
	this.vx = vx * magnification;
	this.vy = vy * magnification;

	// 문서 객체를 생성합니다.
	this.body = document.createElement('div');
	//this.body.innerHTML = this.name;
	//this.body.innerHTML = "<img src='./img/kim_face.jpg'>";
	this.body.innerHTML = "'" + this.name + "'";
	this.body.style.position = 'relative';

	// 문서 객체를 document.body에 추가합니다.
	canvas.appendChild(this.body);
}
		
		
//플레이어 함수 
function MovingUserText(name, x, y, vx, vy) {
	// 위치와 속도 속성
	this.name = name;
	this.x = x * magnification;
	this.y = y * magnification;
	this.vx = vx * magnification;
	this.vy = vy * magnification;

	// 문서 객체를 생성합니다.
	this.body = document.createElement('user');
	this.body.innerHTML = "<img src='./img/trump_face.jpg'>";
	//this.body.style.color = "#f00"; //red
	this.body.style.position = 'relative';
	//this.body.style.border = "3px solid yellow"
	//this.body.style.borderStyle = "dotted";
	//this.body.style.borderRadius="5px";
				
	// 문서 객체를 document.body에 추가합니다.
	canvas.appendChild(this.body);
}

//movingText 함수 
MovingText.prototype.move = function() {
	if (this.x < 0 || this.x > 500) { this.vx *= -1; }
	if (this.y < 0 || this.y > 500) { this.vy *= -1; }

	this.x += this.vx;
	this.y += this.vy;
	// 화면에 이동 표시
	this.body.style.left = this.x + 'px';
	this.body.style.top = this.y + 'px';
};
		
//movingUserText 함수		
MovingUserText.prototype.move = function() {
	// 범위 검사
	//if (this.x < 0 || this.x > canvasWidth) { this.vx *= -1; }
	//if (this.y < 0 || this.y > canvasHeight) { this.vy *= -1; }
	
	// 이동
	this.x += this.vx;
	this.y += this.vy;
		// 화면에 이동 표시
		this.body.style.left = this.x + 'px';
		this.body.style.top = this.y + 'px';
	};
		
		
setInterval(function() {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			//console.log(xmlhttp.responseText);
			var gameData = JSON.parse(xmlhttp.responseText);
						
			//1.객체 존재 유무 확인... 및 생성, 삭제....
			//몬스터 생성
			for(var i = 0 ; i < gameData.monsterDataList.length ; i++){
				//console.log(gameData.monsterDataList[i].id);
		        var isExist = false;
		        for(var j = 0 ; j < movingTexts.length ; j++){
		        	if(movingTexts[j].id == gameData.monsterDataList[i].id){
		        		isExist = true;
		                break;
		            };
		        };
		        
		        if(isExist == false){
		        	//function MovingText(id,name,x,y,vx,vy)
		            movingTexts.push(new MovingText(
		            		gameData.monsterDataList[i].id,
		            		gameData.monsterDataList[i].name,
		                    gameData.monsterDataList[i].x,
		                    gameData.monsterDataList[i].y,
		                    gameData.monsterDataList[i].vx,
		                    gameData.monsterDataList[i].vy
		            ));
		        };
		        
			};
							
			
			for(var i=0;i<gameData.userDataList.length;i++){
				//console.log(gameData.userDataList[i].name);
				var isExist = false;
				for(var j = 0 ; j < userTexts.length ; j++){
					if(userTexts[j].name== gameData.userDataList[i].name){
						isExist = true;
		                console.log("aaa");
		                break;
		            };
		            console.log("bbb");
		           
				};
				
				if(isExist == false){
					//function MovingUserText(name,x,y,vx,vy)
		            userTexts.push(new MovingUserText(
		            gameData.userDataList[i].name,
		            gameData.userDataList[i].x,
		            gameData.userDataList[i].y,
		            gameData.userDataList[i].vx,
		            gameData.userDataList[i].vy
		            ));
		         }; 
		         
			};								

			
			//2.상태 동기화 (vx,vy)
			/////몬스터
			for(var i = 0 ; i < gameData.monsterDataList.length ; i++){
				for(var j = 0 ; j < movingTexts.length ; j++){
					if(movingTexts[j].id == gameData.monsterDataList[i].id){
						movingTexts[j].x = gameData.monsterDataList[i].x * magnification;
		                movingTexts[j].y = gameData.monsterDataList[i].y * magnification;
		                movingTexts[j].vx = gameData.monsterDataList[i].vx * magnification;
		                movingTexts[j].vy = gameData.monsterDataList[i].vy * magnification;
		                };
					};
					
			};
							
			/////플레이어
			for(var i = 0 ; i < gameData.userDataList.length ; i++){
				for(var j = 0 ; j < userTexts.length ; j++){
					if(userTexts[j].name == gameData.userDataList[i].name){
						userTexts[j].x = gameData.userDataList[i].x * magnification;
		                userTexts[j].y = gameData.userDataList[i].y * magnification;
		                userTexts[j].vx = gameData.userDataList[i].vx * magnification;
		                userTexts[j].vy= gameData.userDataList[i].vy * magnification;
		                };
					};
			};
			
		};
		
	};

	xmlhttp.open("get", "./getCurrentGameData.jsp", true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	//xmlhttp.send("id=" + id);
	xmlhttp.send();
	
	}, 100);
		
		
		
setInterval(function() {
	for (var i in movingTexts) {
		movingTexts[i].move();
	}
	
	for (var i in userTexts) {
		userTexts[i].move();
	}
}, 1000 / 30);
		
</script>
</body>
</html>