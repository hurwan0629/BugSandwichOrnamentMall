package controller;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

// 샘플데이터 삽입용 리스너
// 생명주기 : 서버 시작 -> 서버 종료
@WebListener
public class InitListener implements ServletContextListener {

    public InitListener() {
        // TODO Auto-generated constructor stub
    }
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

    public void contextInitialized(ServletContextEvent sce)  { 
    	// 서버 작동 시 itemDAO를 통해 샘플 데이터 추가 예정
    	// 크롤링 할 필요 있음.
    }
	
}
