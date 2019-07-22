package com.ja.game;

public class MonsterUnit {
	public int monsterId;
	public String name;
	
	public int x = 0;
	public int y = 0;
	
	public int vx = (int)(Math.random()*50);
	public int vy = (int)(Math.random()*50);
		
	public MonsterUnit(int id , String name) {
		
		this.monsterId = id;
		this.name = name;
		
	}
	
	
	public void move() {
        if (x < 0 || x > PublicData.width) { vx *= -1; }
        if (y < 0 || y > PublicData.height) { vy *= -1; }
		
		x += vx;
		y += vy;
	}
	
	public void printTestCurrentStatus() {
		System.out.println("몬스터  좌표 :" + x + " , " + y);
	}
}
