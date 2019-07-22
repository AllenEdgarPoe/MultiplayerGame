package com.ja.game;

import java.util.*;

public class Game extends TimerTask{
	private ArrayList<MonsterUnit> monsterList = new ArrayList<MonsterUnit>();
	private ArrayList<UserUnit> userList = new ArrayList<UserUnit>();
	private int count = 0;
	
	public Game() {
		init();
	}

	public ArrayList<MonsterUnit> getMonsterList() {
		return monsterList;		
	}
	
	
	private void init() {
	
		//테스트 코드....
		
		monsterList.add(new MonsterUnit(1,"A"));
		monsterList.add(new MonsterUnit(2,"B"));
		monsterList.add(new MonsterUnit(3,"C"));
		monsterList.add(new MonsterUnit(4,"D"));
		monsterList.add(new MonsterUnit(5,"E"));
		monsterList.add(new MonsterUnit(6,"F"));
		
	}
	
	//몬스터 추가
	public void addMoster() {
		
	}
	
	//유저 추가
	public void addUser() {
		
	}
	
	//게임 시작
	public void start() {
		Timer timer = new Timer();
				
		timer.schedule(this , 0 , 1000*1/30);
		
		
	}

	//틱당 실행될 내용
	@Override
	public void run() {
		// TODO Auto-generated method stub
		count++;
		
		for(MonsterUnit monster : monsterList) {
			if(count%100 == 0) {
				monster.printTestCurrentStatus();
			}
			
			monster.move();
		}		
	}
	
	
}













