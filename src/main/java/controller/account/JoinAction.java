package controller.account;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.common.Action;
import controller.common.ActionForward;
import model.dao.AccountDAO;
import model.dao.AddressDAO;
import model.dto.AccountDTO;
import model.dto.AddressDTO;



public class JoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {

		// [ 회원가입 수행 로직 ]
		AccountDTO accountDTO = new AccountDTO();
		AccountDAO accountDAO = new AccountDAO();

		// joinForm에서 사용자 정보 받아오기
		// 사용자 : 이름, 아이디, 비번, 이메일, 전화번호
		// 기본배송지 정보 : 배송지명, 우편번호, 기본주소, 상세주소
		accountDTO.setAccountId(request.getParameter("accountId"));
		accountDTO.setAccountPassword(request.getParameter("accountPassword"));
		accountDTO.setAccountName(request.getParameter("accountName"));
		accountDTO.setAccountEmail(request.getParameter("accountEmail"));
		accountDTO.setAccountPhone(request.getParameter("accountPhone"));
		accountDTO.setCondition("ACCOUNT_JOIN");
		
		int accountPk = -999;

		if (accountDAO.insert(accountDTO)) {
			System.out.println("[로그] controller.account.JoinAction | [회원 추가 성공]");
			accountDTO.setCondition("SELECT_ACCOUNT_PK_BY_ACCOUNT_ID");
			accountPk = accountDAO.selectOne(accountDTO).getAccountPk();
		} else {
			System.out.println("[로그] controller.account.JoinAction | [회원 추가 실패]");
		}

		ActionForward forward = new ActionForward();
		if (accountPk != -999) {

			AddressDTO addressDTO = new AddressDTO();
			AddressDAO addressDAO = new AddressDAO();

			// 주소 정보 DTO에 저장
			addressDTO.setAccountPk(accountPk);
			addressDTO.setAddressName(request.getParameter("addressName"));
			addressDTO.setDefaultAddress(true); // 회원가입 시 주소는 기본 배송지
			addressDTO.setPostalCode(request.getParameter("postalCode"));
			addressDTO.setDetailAddress(request.getParameter("address1"));
			addressDTO.setRegionAddress(request.getParameter("address2"));
			
			System.out.println("[로그] controller.ornamentShop.JoinAction | 회원주소 추가 addressDTO:["+addressDTO+"]");
			// M에게 기본배송지 정보 insert 요청
			if (addressDAO.insert(addressDTO)) {
                // 회원가입 성공 후 이메일 전송
                String userEmail = accountDTO.getAccountEmail(); // 가입한 사용자의 이메일 주소
                String subject = "오너블리 가입을 축하합니다!";
                String bodyText = "축하합니다! 회원가입이 성공적으로 완료되었습니다. 이제 서비스를 이용하실 수 있습니다.";

                // 이메일 발송
                try {
                    sendEmail(userEmail, subject, bodyText);  // 사용자의 이메일로 축하 이메일 발송
                    System.out.println("[로그] 회원가입 축하 이메일 발송 성공");
                } catch (Exception e) {
                    System.out.println("[로그] 회원가입 축하 이메일 발송 실패");
                    e.printStackTrace();
                }
                
				System.out.println("[로그] controller.ornamentShop.JoinAction | 회원주소 추가 성공");
				forward.setPath("message.jsp");
				request.setAttribute("location", "mainPage.do");
				request.setAttribute("message", "회원가입 성공");
				
			} else {
				// 회원가입 실패
				System.out.println("[로그] controller.ornamentShop.JoinAction | 회원주소 추가 실패 ");
				forward.setPath("message.jsp");
				request.setAttribute("location", "mainPage.do");
				request.setAttribute("message", "회원가입 성공, 주소 생성 실패. 시스템 오류입니다");
			}
		} else {
			// 회원가입 실패
			System.out.println("[로그] controller.ornamentShop.JoinAction | 회원가입 실패 accountPk : " + accountPk);
			System.out.println("회원테이블에는 insert 되었을 것입니다 ▶ 삭제 처리 필요");
			forward.setPath("message.jsp");
			request.setAttribute("location", "mainPage.do");
			request.setAttribute("message", "회원가입 실패. 시스템 오류입니다");
		}
		forward.setRedirect(false);
		return forward;
	}
	
	
    // 이메일 전송 메서드 (SMTP 사용)
    public static void sendEmail(String toEmail, String subject, String bodyText) throws Exception {
        // Gmail SMTP 서버 설정
        String host = "smtp.gmail.com";
        String tmpFromEmail = null;
        String tmpPassword = null;
        try {
			Properties props = new Properties();
			// 클래스 패스에서 설정 파일 로드
			InputStream is = JoinAction.class.getClassLoader().getResourceAsStream("config.properties");
			props.load(is);
			
			if (is == null) {
	            throw new Exception("config.properties 파일을 찾을 수 없습니다.");
	        }
	        
	        props.load(is);
	        tmpFromEmail = props.getProperty("GMAIL_API_FORM_EMAIL");
	        tmpPassword = props.getProperty("GMAIL_API_PASSWORD");
		} catch (Exception e) {
			e.printStackTrace();
		}
        if(tmpFromEmail==null || tmpPassword==null) {
        		return;
        }
        String fromEmail = tmpFromEmail;  // 발신자 이메일 (자신의 Gmail 주소)
        String password = tmpPassword;  // 발신자 이메일 비밀번호 또는 앱 비밀번호 (2단계 인증이 활성화된 경우 앱 비밀번호 사용)

        // SMTP 서버 설정
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");  // TLS 포트
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");  // TLS 사용 설정

        // 인증 객체 생성
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // 이메일 메시지 생성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(bodyText);

            // 이메일 전송
            Transport.send(message);
            System.out.println("이메일이 성공적으로 발송되었습니다.");
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new Exception("이메일 발송 실패");
        }
    }
}


// Connection의 .commit() 과 .rollback() 를 통해 트랜잭션 처리를 하려 했으나 
// 프로젝트 설계의 구조 한계로 일단 보류 처리 (최프;Spring 때 적용할 예정)
/*
 * @Override public ActionForward execute(HttpServletRequest request,
 * HttpServletResponse response) { Connection conn = JDBCUtil.connect(); //
 * Connection 직접 얻기 ActionForward forward = new ActionForward(); int accountPk =
 * 0;
 * 
 * try { conn.setAutoCommit(false); // 트랜잭션 시작
 * 
 * // [ 회원가입 수행 로직 ] AccountDTO accountDTO = new AccountDTO(); AccountDAO
 * accountDAO = new AccountDAO(); // joinForm에서 사용자 정보 받아오기 // 사용자 : 이름, 아이디,
 * 비번, 이메일, 전화번호 // 기본배송지 정보 : 배송지명, 우편번호, 기본주소, 상세주소
 * accountDTO.setAccountId(request.getParameter("accountId"));
 * accountDTO.setAccountPassword(request.getParameter("accountPassword"));
 * accountDTO.setAccountName(request.getParameter("accountName"));
 * accountDTO.setAccountEmail(request.getParameter("accountEmail"));
 * accountDTO.setAccountPhone(request.getParameter("accountPhone"));
 * 
 * // M에게 회원 insert ▶ 성공 시 회원 PK 리턴 accountPk = accountDAO.insert(conn,
 * accountDTO); // conn 넘김
 * 
 * if(accountPk == 0) { conn.rollback(); request.setAttribute("location",
 * "joinPage.do"); forward.setRedirect(false); return forward; }
 * 
 * 
 * // 주소 등록 AddressDTO addressDTO = new AddressDTO(); AddressDAO addressDAO =
 * new AddressDAO();
 * 
 * // 주소 정보 DTO에 저장 addressDTO.setAccountPk(accountPk);
 * addressDTO.setAddressName(request.getParameter("addressName"));
 * addressDTO.setAddressIsDefault(true); // 회원가입 시 주소는 기본 배송지
 * addressDTO.setAddressPostalCode(request.getParameter("postalCode"));
 * addressDTO.setAddressLine1(request.getParameter("address1"));
 * addressDTO.setAddressLine2(request.getParameter("address2"));
 * 
 * if(!addressDAO.insert(addressDTO)) { conn.rollback();
 * request.setAttribute("location", "joinPage.do"); forward.setRedirect(false);
 * return forward; } conn.commit(); // 둘 다 성공하면 commit
 * 
 * request.setAttribute("location", "mainPage.do"); forward.setRedirect(false);
 * return forward;
 * 
 * } catch(Exception e) { try { conn.rollback(); } catch(Exception ignore) {
 * 
 * } // 회원가입 실패 System.out.
 * println("[로그] controller.ornamentShop.JoinAction | 회원가입 실패 accountPk : " +
 * accountPk);
 * 
 * request.setAttribute("location", "joinPage.do"); forward.setRedirect(false);
 * return forward;
 * 
 * } finally { JDBCUtil.disconnect(conn); } }
 */
