<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="ornably"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>오너블리 - 함꼐 크리스마스를 즐겨요</title>
<link rel="icon" href="images/ORNABLY.jpg">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500;600;700&family=Roboto:wght@400;500;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">

<link href="css/style.css" rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">-->
<!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">-->
</head>

<body>


	<ornably:header />

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6 wow fadeInUp"
			data-wow-delay="0.1s">마이페이지</h1>
	</div>
	<!-- Single Page Header End -->

	<!-- 회원정보 Start -->
	<div class="container-fluid bg-light overflow-hidden py-5 content mx-auto rounded" style="max-width: 720px;margin: 80px">
		<div class="container py-5 d-flex justify-content-center">
			<div class="col-md-8 col-lg-8">
				<div class="member-info p-4 rounded">
					<h2 class="mb-4 text-center">회원 정보</h2>

					<div class="row mb-3">
						<div class="col-4">
							<strong>ID</strong>
						</div>
						<div class="col-8">${accountData.accountId}</div>
					</div>
					<%-- 
					<c:set var="accountPasswordLength"
						value="${fn:length(accountData.accountPassword)}" />
					<div class="row mb-3">
						<div class="col-4">
							<strong>Password</strong>
						</div>
						<div class="col-8">
							<!-- 비밀번호 글자 수 만큼 *로 변경해서 출력 -->
							<c:forEach begin="1" end="${accountPasswordLength}" var="i">*</c:forEach>
						</div>
					</div>
					 --%>
					<div class="row mb-3">
						<div class="col-4">
							<strong>Name</strong>
						</div>
						<div class="col-8">${accountData.accountName}</div>
					</div>

					<div class="row mb-3">
						<div class="col-4">
							<strong>Mobile</strong>
						</div>
						<div class="col-8">
							<c:set var="phone" value="${accountData.accountPhone }" />
							${fn:substring(phone,0,3)}-${fn:substring(phone,3,7)}-${fn:substring(phone,7,11)}
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-4">
							<strong>Email</strong>
						</div>
						<div class="col-8">${accountData.accountEmail}</div>
					</div>
				</div>
				<!-- 테두리 박스 End -->
			</div>
		</div>
	</div>
	<style>
.member-info {
	border: 1px solid #ccc; /* 테두리 */
	background-color: #fff; /* 배경 흰색 */
}
</style>
	<!-- 회원정보 End -->



	<!-- 마이페이지 메뉴 Start -->
	<div class="container py-5">
		<div class="row g-4 justify-content-center text-center content">

			<!-- 내 배송지 목록 보기 -->
			<div class="col-6 col-md-3 col-lg-2">
				<a href="deliveryAddressListPage.do" class="menu-card"> <i
					class="fas fa-map-marker-alt fa-2x mb-2"></i>
					<h6>Address</h6>
					<p class="small">배송지 목록 보기</p>
				</a>
			</div>

			<!-- Order -->
			<div class="col-6 col-md-3 col-lg-2">
				<a href="orderHistoryListPage.do" class="menu-card"> <i
					class="fas fa-file-alt fa-2x mb-2"></i>
					<h6>Order</h6>
					<p class="small">주문내역 조회</p>
				</a>
			</div>

			<!-- My Reviews -->
			<div class="col-6 col-md-3 col-lg-2">
				<a href="myReviewListPage.do" class="menu-card"> <i
					class="fas fa-comment-dots fa-2x mb-2"></i>
					<h6>Reviews</h6>
					<p class="small">작성한 리뷰</p>
				</a>
			</div>

			<!-- Like it -->
			<div class="col-6 col-md-3 col-lg-2">
				<a href="wishlistPage.do" class="menu-card"> <i
					class="fas fa-thumbs-up fa-2x mb-2"></i>
					<h6>Like it</h6>
					<p class="small">좋아요</p>
				</a>
			</div>

			<!-- 회원 탈퇴 -->
			<div class="col-6 col-md-3 col-lg-2">
				<a href="signOutPage.do" class="menu-card"> <i
					class="fas fa-user-slash fa-2x mb-2"></i>
					<h6>회원 탈퇴</h6>
					<p class="small">계정 삭제</p>
				</a>
			</div>
		</div>
	</div>
	<!-- 마이페이지 메뉴 End -->

	<link rel="stylesheet" href="${pageContext.request.contextPath}/customResource/style.css">

	<style>
.menu-card {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
	background-color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	text-decoration: none;
	color: #000;
	transition: 0.3s;
}

.menu-card:hover {
	background-color: #f8f9fa;
	border-color: #aaa;
	transform: translateY(-3px);
}

.menu-card i {
	color: #000;
}

.menu-card h6 {
	margin: 5px 0;
	font-weight: 600;
}

.menu-card p {
	margin: 0;
	font-size: 0.85rem;
	color: #555;
}
</style>


	<!-- footer 태그 호출 -->
	<ornably:footer />

</body>

</html>