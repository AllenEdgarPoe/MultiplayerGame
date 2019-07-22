package com.ja.game;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import com.ja.game.*;


/**
 * Application Lifecycle Listener implementation class InitGame
 *
 */
@WebListener
public class InitGame implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public InitGame() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    	// 게임 시작....
    	System.out.println("dddddd");
    	Game g = new Game();
    	g.start();
    	
    	arg0.getServletContext().setAttribute("game1", g);
    	
    }
	
}















