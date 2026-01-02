<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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


<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/customResource/style.css">
<style>
.custom-btn {
	background-color: #6F4F3A;
	border-color: #6F4F3A;
	color: white; /* 기본 상태 글자 색 */
}

.custom-btn:disabled {
	background-color: #B28B6E; /* 비활성화 상태에서 색상 변경 */
	border-color: #B28B6E;
	opacity: 0.6; /* 흐리게 만들기 */
	cursor: not-allowed; /* 마우스 커서 변경 */
}
</style>
</head>

<body>
	<tag:header />

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6 wow fadeInUp"
			data-wow-delay="0.1s">최종결제 페이지</h1>
	</div>
	<!-- Single Page Header End -->


	<!-- Checkout Page Start -->
	<div class="container-fluid overflow-hidden py-5">
		<div class="container py-5">

			<form id="payment-form" action="payment.do" method="POST">
				<div class="row g-5 align-items-stretch content item-card rounded">

					<!-- 배송지 선택 공간 시작 -->
					<div class="col-12 col-lg-6 wow fadeInUp d-flex flex-column justify-content-center align-items-center" data-wow-delay="0.1s">
						<div
							class="bg-light rounded p-4 h-100 d-flex flex-column align-items-center text-center content item-page rounded"
							style="margin-bottom: 30px; padding-bottom: 30px; width: 100%; max-width: 600px;">
							<h1 class="display-6 mb-4" style="color:black">배송지 선택</h1>

							<select id="select-address" name="addressPk"
								class="form-select text-dark border-0 border-start rounded-0 p-3"
								style="width: 200px;">
								<!-- 배송지가 js에 의해 삽입되는 공간 -->
							</select>

							<div class="mt-auto pt-4">
								<button id="regist-address"
									class="btn custom-btn rounded-pill px-4 py-3 text-uppercase ms-4"
									type="button"
									style="background-color: #6F4F3A; border-color: #6F4F3A;">배송지
									등록하기</button>

							</div>
						</div>
					</div>
					<!-- 배송지 선택 공간 끝 -->
					<!-- 결제하기 버튼 공간 -->
					<div class="col-12 col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
						<div class="d-flex justify-content-center h-100 d-flex flex-column align-items-center">
							<div
								class="bg-light rounded p-4 h-100 d-flex flex-column content item-page rounded"
								style="max-width: 420px; width: 100%; margin-bottom: 30px; padding-bottom: 30px;">
								<div class="text-center">
									<!-- 여기 text-center 클래스를 추가 -->
									<h1 class="display-6 mb-4" style="color:black">
										총 주문금액
									</h1>
								</div>

								<div
									class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
									<h5 class="mb-0">총 금액</h5>
									<p class="mb-0">
										<fmt:formatNumber value="${totalAmount}" pattern="#,###" />
										원
									</p>
								</div>
								<div class="text-center">
								<div class="mt-auto">
									<button id="pay-submit"
										class="btn custom-btn rounded-pill px-4 py-3 text-uppercase ms-4"
										type="button"
										style="background-color: #6F4F3A; border-color: #6F4F3A;">결제하기</button>

								</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 결제버튼 공간 끝 -->
				</div>

			</form>
		</div>
	</div>
	<!-- Checkout Page End -->

	<tag:footer />


	<!-- JavaScript Libraries -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script> -->
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>


	<!-- Template Javascript -->
	<script src="js/main.js"></script>
	<script>
    /*
    <select id="select-address" class="form-select text-dark border-0 border-start rounded-0 p-3" style="width: 200px;">
      <option value="기본배송지">기본배송지</option>
    </select>
    */
    // 배송지 select에 넣어주기

    const select = $("#select-address");
    // 주소 데이터를 받으면
    console.log('${addressDatas}');
    if (typeof ${addressDatas} !== 'undefined') {
    	${addressDatas}.forEach(address => {
    		console.log(address);
    		$("<option>", {
          value: address.addressPk,
          text: address.addressName,
          selected: address.isDefaultAddress === true
        }).appendTo(select);
      });
    }
    // 주소 데이터가 호옥시라도 들어오지 않는다면
    else {
      $("<option>", {
        text: "주소를 로드하지 못했습니다"
      }).appendTo(select);
    }

    // 결제하기 버튼 누를 때 submit 시켜주기
    $('#pay-submit').click(function () {
      $('#payment-form').submit();
    });

    // 배송지 등록 버튼을 눌렀을 때 
    $('#regist-address').click(function () {
    	// select 요소를 선택합니다.
    	let selectElement = document.getElementById("regist-address"); // select-id는 해당 select 요소의 id로 교체해주세요.

    	// option 요소의 개수를 가져옵니다.
    	let optionCount = selectElement.options.length;

	if(optionCount>=10){
		return;
	}
      location.href = '${pageContext.request.contextPath}/registDiliveryAddressPage.do?condition=payment';
    });
  </script>
</body>

</html>