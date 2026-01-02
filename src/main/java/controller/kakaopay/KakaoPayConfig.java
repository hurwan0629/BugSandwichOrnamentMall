package controller.kakaopay;

// Admin Key, CID 등 설정 관리
public class KakaoPayConfig {

	
	// 테스트용 상점 코드
	// 테스트 CID (1회성 결제)
    //public static final String CID = "";
	
    // Secret Key (개발용)
	//public static final String SECRET_KEY_DEV = "";
	
	// READY_URL
    // 결제 준비 API의 URL입니다. 결제 준비 요청을 카카오페이에 보내기 위한 API 엔드포인트입니다.
    // 카카오페이 결제를 준비하려면 이 URL을 통해 ready API를 호출하고, 결제 준비가 완료되면 TID와 리다이렉트 URL을 반환받습니다.
    public static final String READY_URL = "https://kapi.kakaopay.com/v1/payment/ready";
    
    
    
    // 결제 승인 API의 URL입니다. 결제 준비 후, 사용자가 결제를 승인하면 이 URL을 통해 결제를 승인하고 처리하는 API를 호출합니다.
    // 승인된 결제 정보를 기반으로 결제 완료를 처리하게 됩니다.
    public static final String APPROVE_URL = "https://kapi.kakao.com/v1/payment/approve";

    public static final String SUCCESS_URL = "http://localhost:8088/BugSandwichOrnamentMall/kakaoPaySuccess.do";
    public static final String FAIL_URL    = "http://localhost:8088/BugSandwichOrnamentMall/kakaoPayFail.do";
    public static final String CANCEL_URL  = "http://localhost:8088/BugSandwichOrnamentMall/kakaoPaySuccess.do";

}