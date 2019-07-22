<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ja.gameData.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PlayPage</title>
</head>
<body>
<p id="test"></p>
	<canvas id="ctx" height="<%= CanvasData.height %>" width ="<%=CanvasData.width %>" style="border:1px solid #000000;"></canvas>
	<script>
		var ctx = document.getElementById("ctx").getContext("2d");
		ctx.font = '30px Arial';
		
		var canvasHeight = <%= CanvasData.height %>;
		var canvasWidth = <%=CanvasData.width %>;
		var timeGameStarted = Date.now();
	
		<%
		PlayerUnit user1 = new PlayerUnit("user1",10);
		user1.x = CanvasData.width/2;
		user1.y = CanvasData.height/2;
		%>
		
		var player = {
				x:<%= user1.x%>,
				y:<%= user1.y %>,
				hp: <%= user1.hp %>,
				width:20,
				height:20,
				color:'green',
		};
	
		//마우스 움직일때 
		document.onmousemove = function(mouse){
			var mouseX = mouse.clientX;
			var mouseY = mouse.clientY;
			
			player.x = mouseX;
			player.y = mouseY;
			var coor = "사용자 좌표: (" + player.x + "," + player.y + ")";
			document.getElementById("test").innerHTML = coor;
		}

		document.onmouseout = function() {
			  document.getElementById("test").innerHTML = "";
		}
		
		//네모로 그리는 function
		drawObject = function(object){
			ctx.save();
			ctx.fillStyle = object.color;
			ctx.fillRect(object.x-object.width/2, object.y-object.height/2, something.width,something.height);
			ctx.restore();
		}
		
		
		var magnification = 1;

        // Monster의 생성자 함수
        var canvasWidth = <%= CanvasData.width %> * magnification;
        var canvasHeight = <%= CanvasData.height %> * magnification;

        //텍스트(몬스터 오브젝트) 생성자
        Monster = function(id,name,x,y,vx,vy) {
            var monster{
            id: id,
            name: name,
            x: x * magnification,
            y: y * magnification,
            vx: vx * magnification,
            vy: vy * magnification,
            width:width,
			height:height,
			color:'red',
            }
            
            // 문서 객체를 생성합니다.
            this.body = document.createElement('h1');
            //this.body.innerHTML = this.name;
            this.body.innerHTML = "'" + this.name + "'";
            this.body.style.position = 'absolute';

            // 문서 객체를 document.body에 추가합니다.
            document.body.appendChild(this.body);
            
        }

        Monster.prototype.move = function () {
            // 화면에 이동 표시
            this.x += this.vx;
            this.y += this.vy;
            this.body.style.left = this.x + 'px';
            this.body.style.top = this.y + 'px';
        };
        
        
        <!-- window.onload -->
        window.onload = function () {
            // 변수를 선언합니다.(몬스터 객체 배열)
            var monsterList = [];
            setInterval(function () {
                for (var i in monsterList) {
                    monsterList[i].move();
                }
            }, 1000 / 30);
            
            setInterval(function () {
    			var xmlhttp = new XMLHttpRequest();
    			
    			xmlhttp.onreadystatechange = function(){
    				//...
    				
    				if(xmlhttp.readyState==4 && xmlhttp.status == 200){
    					console.log(xmlhttp.responseText);

    					var gameData = JSON.parse(xmlhttp.responseText);

    					
                        //1.객체 존재 유무 확인... 및 생성, 삭제....
                           					
    					for(var i = 0 ; i < gameData.monsterDataList.length ; i++){
                            //console.log(gameData.monsterDataList[i].id);
                            var isExist = false;

                            for(var j = 0 ; j < monsterList.length ; j++){
                                if(monsterList[j].id == gameData.monsterDataList[i].id){
                                    isExist = true;
                                    break;
                                }
                            }                      
                            
                            if(isExist == false){
                                //function Monster(id,name,x,y,vx,vy)
                                monsterList.push(new Monster(
                                    gameData.monsterDataList[i].id,
                                    gameData.monsterDataList[i].name,
                                    gameData.monsterDataList[i].x,
                                    gameData.monsterDataList[i].y,
                                    gameData.monsterDataList[i].vx,
                                    gameData.monsterDataList[i].vy
                                ));
                            }

    					}

                        //2.상태 동기화 (vx,vy) 
						for(var i = 0 ; i < gameData.monsterDataList.length ; i++){
							for(var j = 0 ; j < monsterList.length ; j++){
                                if(monsterList[j].id == gameData.monsterDataList[i].id){
                                	monsterList[j].x = gameData.monsterDataList[i].x * magnification;
                                	monsterList[j].y = gameData.monsterDataList[i].y * magnification;
                                	monsterList[j].vx = gameData.monsterDataList[i].vx * magnification;
                                	monsterList[j].vy = gameData.monsterDataList[i].vy * magnification;
                                }
                            }							
						}
                        
                        
                        //상황에 따라...x,y도 동기화 해야됨....
                        //제대로 하려면 웹 소켓 이용 되야 정상적으로 될듯..
                        //....ajax 한계....리퀘스트-리스폰스....
    					
    				}
           	           	
    			};

    			xmlhttp.open("get","./getCurrentGameData.jsp" , true);
    			xmlhttp.setRequestHeader("Content-type",
    			"application/x-www-form-urlencoded");
    			//xmlhttp.send("id=" + id);
    			xmlhttp.send();
            	
            }, 100);
        };
       
        
        
        
      //충돌했을 때 
        update = function(){
        	ctx.clearRect(0,0,canvasWidth,canvasHeight);
        	
        	for(var monster in monsterList){
        		drawObject(monsterList[monster]);
        		
        		var isColliding = testCollisionEntity(player,monsterList[monster]);
        		if(isColliding){
        			player.hp = player.hp - 1;
        			if(player.hp <= 0){
        				var timeSurvived = Date.now() - timeWhenGameStarted;
        				
        				console.log("You lost! You survived for " + timeSurvived + " ms.");
        				timeWhenGameStarted = Date.now();
        				player.hp = 10;
        				break;
        			}
        		}
        		
        	}
        	drawObject(player);
        	ctx.fillText(player.hp + " Hp",0,30);
      }
     
      
      setInterval(update,40);
    </script>
</head>
<body>

</body>
</html>