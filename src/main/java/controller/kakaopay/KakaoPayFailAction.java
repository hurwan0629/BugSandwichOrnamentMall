package controller.kakaopay;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.common.Action;
import controller.common.ActionForward;
import model.dao.ItemDAO;
import model.dao.OrderDAO;
import model.dto.CartDTO;
import model.dto.ItemDTO;
import model.dto.OrderDTO;

public class KakaoPayFailAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [임시 주문 데이터행과 상품 재고 다시 추가시켜주기]");
		// 고스트 레코드 삭제
		
		int accountPk = (Integer) request.getSession().getAttribute("accountPk");
		OrderDAO orderDAO = new OrderDAO();
		OrderDTO orderDTO = new OrderDTO();
		orderDTO.setAccountPk(accountPk);
		orderDTO.setCondition("DELETE_GHOST_ORDERS_BY_ACCOUNT_PK");
		
		System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [고스트 레코드 삭제]");
		System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [orderDAO.delete(orderDTO)] orderDTO:["+orderDTO+"]");
		if(orderDAO.delete(orderDTO)) {
			System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [orderDAO.delete(orderDTO)] - 실패");
		}
		else {
			System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [orderDAO.delete(orderDTO)] - 성공");
		}
		
		
		System.out.println("[로그] controller.kakaopay.KakaoPayFailAction | [선전 재고 복구]");
		// 선점 재고 복구		
		ArrayList<CartDTO> reversedCartDatas = (ArrayList<CartDTO>) request.getSession().getAttribute("reservedCartDatas");

		for (CartDTO cartData : reversedCartDatas) {
			Integer itemPk = cartData.getItemPk();
			Integer count = cartData.getCount();

			ItemDTO itemDTO = new ItemDTO();
			itemDTO.setItemPk(itemPk);
			itemDTO.setItemCount(count);
			itemDTO.setCondition("ROLLBACK_ITEM_STOCK");

			ItemDAO itemDAO = new ItemDAO();
			itemDAO.update(itemDTO);
		}

		ActionForward forward = new ActionForward();
		// 실패 페이지로 이동
		forward.setPath("/paymentFail.jsp"); // JSP 경로에 맞게 수정
		forward.setRedirect(false);
		return forward;
	}
}