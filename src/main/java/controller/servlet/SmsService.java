package controller.servlet;

import java.io.InputStream;
import java.util.Properties;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.service.DefaultMessageService;

public class SmsService {
	private DefaultMessageService messageService;
    private String fromNumber;

	public SmsService() {
		try {
			// 키-값 받기위한 객체
			Properties props = new Properties();
			// 클래스 패스에서 설정 파일 로드
			InputStream is = getClass().getClassLoader().getResourceAsStream("config.properties");
			props.load(is);
			// 특정 키에대한 값 받아오기
			String apiKey = props.getProperty("SOLAPI_API_KEY");
			String apiSecret = props.getProperty("SOLAPI_API_SECRET");
			this.fromNumber = props.getProperty("SOLAPI_FROM_NUMBER");
			
			 System.out.println("apiKey:["+apiKey+"]");
			
			this.messageService = NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.solapi.com");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 1. 단순 난수 생성
	public String createRandomNumber() {
		return String.format("%04d", (int) (Math.random() * 10000)); // 4자리 난수
	}

	// 2. 실제 메시지 발송
	public void sendSms(String phoneNumber, String authCode) {
		Message message = new Message();
		message.setFrom(this.fromNumber); // 솔라피에 등록된 발신번호
		message.setTo(phoneNumber);
		message.setText("[쇼핑몰] 인증번호 [" + authCode + "]를 입력해주세요.");

		this.messageService.sendOne(new SingleMessageSendingRequest(message));
	}
}