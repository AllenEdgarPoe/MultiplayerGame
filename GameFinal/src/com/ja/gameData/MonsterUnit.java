package com.ja.gameData;

import com.ja.gameData.CanvasData;

public class MonsterUnit {
	public int monsterId;
	public String name;
	public int monsterSpeed = 10;
	
	public int x = 1;
	public int y = 1;
	
	public int vx = (int)(Math.random()*monsterSpeed);
	public int vy = (int)(Math.random()*monsterSpeed);
		
	public MonsterUnit(int id , String name, int monsterSpeed) {
		
		this.monsterId = id;
		this.name = name;
		this.monsterSpeed = monsterSpeed;
	}
	
	public void move() {
        if (x < 0 || x > CanvasData.width) { vx *= -1; }
        if (y < 0 || y > CanvasData.height) { vy *= -1; }
		x += vx;
		y += vy;
	}
	
	public void printTestCurrentStatus() {
		System.out.println("몬스터  좌표"+name+":" + x + " , " + y);
	}
}
