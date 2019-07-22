package com.ja.gameData;

import java.util.*;

public class Game extends TimerTask{
	private ArrayList<MonsterUnit> monsterList = new ArrayList<MonsterUnit>();
	private ArrayList<PlayerUnit> playerList = new ArrayList<PlayerUnit>();
	//private int count = 0;
	
	public Game() {
		init();
	}

	public ArrayList<MonsterUnit> getMonsterList() {
		return monsterList;		
	}
	public ArrayList<PlayerUnit> getPlayerList() {
		return playerList;		
	}
	
	private void init() {
		//테스트
		monsterList.add(new MonsterUnit(1,"A",10));
		monsterList.add(new MonsterUnit(2,"B",20));
		monsterList.add(new MonsterUnit(3,"C",30));
		monsterList.add(new MonsterUnit(4,"D",40));
		monsterList.add(new MonsterUnit(5,"E",50));
		monsterList.add(new MonsterUnit(6,"F",60));
	}
	
	//몬스터 추가
	public void addMoster() {
		//난이도에 따라서 자동으로 몬스터 추가 가능하게끔.. 
	}
	
	//유저 추가
	public void addUser(PlayerUnit p) {
		if(playerList.size() == 0) {
			playerList.add(p);
		}
		for(PlayerUnit player:playerList) {
			if(p.name != player.name) {
				playerList.add(p);
				break;
			}
		}
		
	}
	
	//게임 시작
	public void start() {
		Timer timer = new Timer();
		timer.schedule(this , 0 , 1000*1/30);
	}

	//틱당 실행될 내용
	@Override
	public void run() {
		//count++;
		for(MonsterUnit monster : monsterList) {
			//if(count%100 == 0) {
				//monster.printTestCurrentStatus();
				
			//}
			
			monster.move();
			
		}
		for(PlayerUnit player: playerList) {
			//player.printTestCurrentStatus();
			player.update();
		}
	
		
		//Colliding
		
		
		
		
		
		
	}

}










