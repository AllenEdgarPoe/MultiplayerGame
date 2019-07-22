package com.ja.gameData;
import com.ja.gameData.CanvasData;

public class PlayerUnit {
	public String name;
	public int x = 250;
	public int y = 250;
	public int vx;
	public int vy;
	public int hp;
	public int speed;
	
	public PlayerUnit(String name,int vx, int vy, int hp, int speed) {
		this.name = name;
		this.vx = vx;
		this.vy = vy;
		this.hp = hp;
		this.speed = speed;
	}
	public void update() {
		int width = CanvasData.width;
		int height = CanvasData.height;
		if (x > width) {
			x-=width;
		}else if( x<0) {
			x+=width;
		}
		if(y>height) {
			y-=height;
		}else if(y<0) {
			y+=height;
		}
		x+=vx;
		y+=vy;
	}
	
	public void printTestCurrentStatus() {
		System.out.println("플레이어  좌표"+name+":" + x + " , " + y+", "+vx+", "+vy);
	}
	
	
	
}

