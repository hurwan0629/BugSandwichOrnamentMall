package controller.common;

import java.util.HashMap;
import java.util.Map;

import controller.account.JoinAction;
import controller.account.KakaoSocialLoginAction;
import controller.account.LoginAction;
import controller.account.LoginPageAction;
import controller.account.LogoutAction;
import controller.account.MyPageAction;
import controller.account.RequestKakaoLoginAction;
import controller.account.SignInPageAction;
import controller.account.SignOutAction;
import controller.account.SignOutPageAction;
import controller.account.WishlistPageAction;
import controller.cart.CartPageAction;
import controller.deliveryAddress.DeliveryAddressListPageAction;
import controller.deliveryAddress.RegistDeliveryAddressAction;
import controller.deliveryAddress.RegistDeliveryAddressPageAction;
import controller.kakaopay.KakaoPayCancelAction;
import controller.kakaopay.KakaoPayFailAction;
import controller.kakaopay.KakaoPayReadyAction;
import controller.kakaopay.KakaoPaySuccessAction;
import controller.mainPage.MainPageAction;
import controller.orderHistory.OrderHistoryDetailPageAction;
import controller.orderHistory.OrderHistoryListPageAction;
import controller.ornamentShop.OrnamentDetailPageAction;
import controller.ornamentShop.OrnamentListPageAction;
import controller.payment.PaymentAction;
import controller.payment.PaymentPageAction;
import controller.review.MyReviewListPageAction;
//import controller.review.ReviewUpdatePageAction;
import controller.review.ReviewWriteAction;
import controller.review.ReviewWritePageAction;

public class ActionFactory {
	private Map<String, Action> map;

	ActionFactory() {
		this.map = new HashMap<>();

		this.map.put("/cartPage.do", new CartPageAction());
		this.map.put("/deliveryAddressListPage.do", new DeliveryAddressListPageAction());
		this.map.put("/login.do", new LoginAction());
		this.map.put("/loginPage.do", new LoginPageAction());
		this.map.put("/logout.do", new LogoutAction());
		this.map.put("/mainPage.do", new MainPageAction());
		this.map.put("/myPage.do", new MyPageAction());
		this.map.put("/myReviewListPage.do", new MyReviewListPageAction());
		this.map.put("/orderHistoryDetailPage.do", new OrderHistoryDetailPageAction());
		this.map.put("/orderHistoryListPage.do", new OrderHistoryListPageAction());
		this.map.put("/ornamentDetailPage.do", new OrnamentDetailPageAction());
		this.map.put("/ornamentListPage.do", new OrnamentListPageAction());
		this.map.put("/payment.do", new PaymentAction());
		this.map.put("/paymentPage.do", new PaymentPageAction());
		this.map.put("/registDiliveryAddress.do", new RegistDeliveryAddressAction());
		this.map.put("/registDiliveryAddressPage.do", new RegistDeliveryAddressPageAction());
		// this.map.put("/reviewUpdatePage.do", new ReviewUpdatePageAction());
		this.map.put("/reviewWrite.do", new ReviewWriteAction());
		this.map.put("/reviewWritePage.do", new ReviewWritePageAction());
		this.map.put("/signInPage.do", new SignInPageAction());
		this.map.put("/join.do", new JoinAction());
		this.map.put("/signOut.do", new SignOutAction());
		this.map.put("/signOutPage.do", new SignOutPageAction());
		this.map.put("/wishlistPage.do", new WishlistPageAction());

		// 카카오결제 페이지
		this.map.put("/kakaoPayReady.do", new KakaoPayReadyAction());
		this.map.put("/kakaoPayCancel.do", new KakaoPayCancelAction());
		this.map.put("/kakaoPayFail.do", new KakaoPayFailAction());
		this.map.put("/kakaoPaySuccess.do", new KakaoPaySuccessAction());

		// 카카오 로그인
		this.map.put("/KakaoSocialLogin.do", new KakaoSocialLoginAction());
		this.map.put("/requestKakaoLogin.do", new RequestKakaoLoginAction());

	}

	public Action getAction(String command) {
		return this.map.get(command);
	}
}
