<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 보조 함수 -->
<script>
        // 랜덤한 정수를 생성합니다.
        function nextRandomInteger(limit) {
            return Math.round(Math.random() * limit);
        }

        // 랜덤한 알파벳을 리턴하는 함수입니다.
        var randomAlphabet = (function () {
            var alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            return function () {
                return alphabet.charAt(nextRandomInteger(25));
            }
        })();

        // 양음으로 랜덤한 속도를 생성하는 함수입니다.
        function randomSpeed(maxSpeed) {
            return Math.random() * maxSpeed - Math.random() * maxSpeed;
        }
    </script>
<!-- 생성자 함수 -->
<script>

		var magnification = 0.07;

        // MovingText의 생성자 함수
        var canvasWidth = 10000 * magnification;
        var canvasHeight = 10000 * magnification;

        //텍스트(몬스터 오브젝트) 생성자
        function MovingText(id,name,x,y,vx,vy) {
            // 위치와 속도 속성
            
            this.id = id;
            this.name = name;
            this.x = x * magnification;
            this.y = y * magnification;
            this.vx = vx * magnification;
            this.vy = vy * magnification;

            // 문서 객체를 생성합니다.
            this.body = document.createElement('h1');
            //this.body.innerHTML = this.name;
            this.body.innerHTML = "'" + this.name + "'";
            this.body.style.position = 'absolute';

            // 문서 객체를 document.body에 추가합니다.
            document.body.appendChild(this.body);
        }

        MovingText.prototype.move = function () {
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
    </script>
<!-- window.onload -->
<script>
        window.onload = function () {
            // 변수를 선언합니다.(몬스터 객체 배열)
            var movingTexts = [];

            // 배열에 MovingText 객체 100개를 생성합니다.
            //for (var i = 0; i < 5; i++) {
            //    movingTexts.push(new MovingText());
            //}

            // 움직입니다. (이건 놔두고.... 동작 엔진... 서버 움직임 과 동일 해야됨...)
            //30 Frame
            setInterval(function () {
                for (var i in movingTexts) {
                    movingTexts[i].move();
                }
            }, 1000 / 30);
            
            
            //ajax 시간당 호출... 0.1초 단위로 확인 및.....
            //객체 존재 유무 확인 및 생성, 삭제 작업 
            //서버와 동기화....
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

                            for(var j = 0 ; j < movingTexts.length ; j++){
                                if(movingTexts[j].id == gameData.monsterDataList[i].id){
                                    isExist = true;
                                    break;
                                }
                            }                      
                            
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
                            }

    					}

                        //2.상태 동기화 (vx,vy) 
						for(var i = 0 ; i < gameData.monsterDataList.length ; i++){
							for(var j = 0 ; j < movingTexts.length ; j++){
                                if(movingTexts[j].id == gameData.monsterDataList[i].id){
                                	movingTexts[j].x = gameData.monsterDataList[i].x * magnification;
                                	movingTexts[j].y = gameData.monsterDataList[i].y * magnification;
                                	movingTexts[j].vx = gameData.monsterDataList[i].vx * magnification;
                                	movingTexts[j].vy = gameData.monsterDataList[i].vy * magnification;
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
    </script>
</head>
<body>

</body>
</html>