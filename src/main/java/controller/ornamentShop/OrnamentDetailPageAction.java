package controller.ornamentShop;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.common.Action;
import controller.common.ActionForward;
import model.dao.ItemDAO;
import model.dao.ReviewDAO;
import model.dao.WishlistDAO;
import model.dto.ItemDTO;
import model.dto.ReviewDTO;
import model.dto.WishlistDTO;

// 아이템 상세 페이지 로드
// 아이템 상세 정보[PK, 이름, 상품평점, 가격, 설명, 이미지, 재고]
// 로그인이 되어있다면 좋아요 눌렀는지 여부까지 보내주기 ( 로그인 안되어있으면 안눌림처리 )
public class OrnamentDetailPageAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [상품상세 페이지 로드]");
		
		ActionForward forward = new ActionForward();
		
		// 상품 정보 가져오기
		Integer itemPk = Integer.parseInt(request.getParameter("itemPk"));
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [execute] - itemPk:["+itemPk+"]");
		if(itemPk==null) {
			request.setAttribute("message", "잘못된 접근입니다. 이상이 있을 시 관리자에게 문의해주세요");
			request.setAttribute("location", "ornamentPage.jsp");
			
			forward.setPath("message.jsp");
			forward.setRedirect(false);
			return forward;
		}
		
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [상품 데이터 불러오기]");
		// 1) 출력할 상품 정보 보내주기
		ItemDAO itemDAO = new ItemDAO();
		ItemDTO itemDTO = new ItemDTO();
		itemDTO.setItemPk(itemPk);
		itemDTO.setCondition("SELECT_ITEM_DETAIL_INFO");
		
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [itemDAO.selectOne(itemDTO)] - itemDTO:["+itemDTO+"]");
		itemDTO = itemDAO.selectOne(itemDTO);
		
		// 만약 상품 데이터가 존재하지 않는다면 상품 목록 다시 보여주기
		if(itemDTO == null) {
			System.out.println("[예외] controller.ornamentShop.OrnamentDetailPageAction | [선택된 아이템 정보가 존재하지 않음 사용자의 문제 또는 서비스의 문제 일 수 있음]");
			request.setAttribute("message", "데이터가 존재하지 않는 상품입니다.");
			request.setAttribute("location", "ornamentListPage.do");
			
			forward.setPath("message.jsp");
			return forward;
		}
		
		// 2) 사용자가 로그인되어있는 상황이라면
		//		찜한 상태 값 보내주기
		Integer accountPk = (Integer) request.getSession().getAttribute("accountPk");
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [사용자 로그인 여부] - accountPk:["+accountPk+"]");
		boolean isWished=false;
		if(accountPk!=null) {
			System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [사용자가 해당 상품 찜했는지 여부 확인]");
			WishlistDAO wishlistDAO = new WishlistDAO();
			WishlistDTO wishlistDTO = new WishlistDTO();
			wishlistDTO.setCondition("SELECT_WISHLIST_BY_ACCOUNT_PK_AND_ITEM_PK");
			wishlistDTO.setAccountPk(accountPk);
			wishlistDTO.setItemPk(itemPk);
			
			System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [wishlistDAO.selectOne(wishlistDTO)] - wishlistDTO:["+wishlistDTO+"]");
			isWished = wishlistDAO.selectOne(wishlistDTO) != null;
		}
		
		/* 폐기 코드
		// 2) 상품에 대한 사용자들의 리뷰 보내주기 - 비동기 처리를 하기로 결정 -> 폐기
		// 리뷰[reviewPk, itmePk, reviewStar, reviewTitle, reviewContent]
		reviewDTO.setCondition("SELECT_ALL_REVIEW_DATAS_BY_ITEM_PK");
		
		System.out.println("[로그] controller.ornamentShop.OrnamentDetailPageAction | [reviewDAO.selectAll(reviewDTO)] - reviewDTO:["+reviewDTO+"]");
		ArrayList<ReviewDTO> reviewDatas = reviewDAO.selectAll(reviewDTO);
		
		request.setAttribute("reviewDatas", reviewDatas);
		*/
		request.setAttribute("isWished", isWished);
		request.setAttribute("itemData", itemDTO);
		
		forward.setPath("ornamentDetailPage.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
