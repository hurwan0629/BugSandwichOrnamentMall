package controller.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendSmsServlet")
public class SendSmsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SendSmsServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[로그] controller.servlet.SendSmsServlet | [doGet] 잘못된 요청 doPost를 이용해주세요");
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 인증번호 발송 클래스
		System.out.println("[로그] controller.servlet.SendSmsServlet | [시작]");
		
		// Front에서 유효성 검사된 전화번호 문자열을 받게됨
		String phoneNumber = request.getParameter("phoneNumber");		
		
		// 메세지 발송 객체 생성
		SmsService smsService = new SmsService();
		// 4자리 난수(인증번호) 생성
		String authCode = smsService.createRandomNumber();

		// 세션에 인증번호 저장 (비교용)
		HttpSession session = request.getSession();
		
		// 이후 인증번호 확인을 위해 센션에 인증번호 저장
		session.setAttribute("authCode", authCode);

		// 실제 발송
		smsService.sendSms(phoneNumber, authCode);

		response.getWriter().write("success");
	}

}
