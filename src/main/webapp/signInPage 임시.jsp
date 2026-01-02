<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tag"%>
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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/customResource/style.css">

<style>
.form-control:focus {
	border-color: #22c55e;
	box-shadow: 0 0 0 0.25rem rgba(34, 197, 94, 0.25) !important;
}
.signup-col {
  min-width: 420px;   /* 너무 좁아지지 않게 */
  max-width: 520px;   /* 너무 넓어지지 않게(원하면 조절) */
}
@media (max-width: 576px) {
  .signup-col {
    min-width: 0;     /* 모바일에서는 꽉 차게 */
    max-width: 100%;
  }
}
</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>

<body>
	<tag:header />
	<div class="content">
		<!-- Single Page Header start -->
		<div class="container-fluid page-header py-5">
			<h1 class="text-center text-white display-6 wow fadeInUp"
				data-wow-delay="0.1s">회원가입</h1>
		</div>
		<!-- Single Page Header End -->
		<!-- 회원가입 페이지 수정 부분 -->
		<div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-6 ">
		<div class="container-fluid bg-light overflow-hidden py-5 content item-card  rounded "  style="margin: 80px auto;">
		
			<div class="container py-5 ">
				<h1 class="row g-5 justify-content-center" data-wow-delay="0.1s">회원가입</h1>

				<form action="join.do" method="POST">
					<div class="row g-2 justify-content-center">
						<div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-5 signup-col" data-wow-delay="0.1s">
							<div class="form-item">
								<label class="form-label my-3"> 아이디 입력<sup>*</sup>
								</label>

								<div class="input-group">
									<input type="text" class="form-control" name="accountId"
										id="userId" required pattern="^(?=.*\d)[a-z][a-z0-9_]{3,15}$"
										minlength="4" maxlength="16"
										title="아이디는 숫자 포함 영소문자로 시작 , 영문/숫자/_만 가능 (4~16자)"
										placeholder="아이디는 숫자 포함 영소문자로 시작, 영문/숫자/_만 가능(4~16자)">

									<button class="btn btn-outline-success" type="button"
										id="btnIdCheck" disabled>중복확인</button>
								</div>

								<div id="msgIdCheck" class="mt-1"></div>
							</div>

							<div class="form-item">
								<label class="form-label my-3">비밀번호 입력<sup>*</sup></label> <input
									type="password" class="form-control" name="accountPassword"
									id="password1" required>
								<div id="msgCheck1"></div>
							</div>

							<div class="form-item">
								<label class="form-label my-3">비밀번호 확인<sup>*</sup></label> <input
									type="password" class="form-control" name="checkPassword"
									id="password2" required>
								<div id="msgCheck2"></div>
							</div>

							<hr class="mt-5">
							<div class="form-item">
								<label class="form-label my-3">이름<sup>*</sup></label> <input
									id="account-name" type="text" class="form-control"
									name="accountName" minlength="2" maxlength="20" required>
							</div>
							<div id="accountNameCheck"></div>

							<div class="form-item">
								<label class="form-label my-3">휴대폰 번호<sup>*</sup></label> <input
									type="tel" class="form-control" name="accountPhone" id="phone"
									required pattern="^010\d{8}$" maxlength="11"
									placeholder="01012345678 (-는 제외)"
									title="휴대폰 번호는 010으로 시작하는 11자리 숫자만 입력하세요">
							</div>
							<div id="msgPhoneCheck"></div>

							<div class="form-item">
								<label class="form-label my-3">이메일 (선택)</label>

								<div class="d-flex gap-2">
									<!-- 이메일 아이디 -->
									<input type="text" class="form-control" id="emailId"
										placeholder="이메일 아이디"> <span class="align-self-center">@</span>
									<!-- 직접입력 도메인 -->
									<input type="text" class="form-control" id="customDomain"
										placeholder="도메인 입력" style="display: none;">
									<!-- 도메인 select -->
									<select class="form-select" id="emailDomain">
										<option value="" disabled selected hidden>선택</option>
										<option value="gmail.com">gmail.com</option>
										<option value="naver.com">naver.com</option>
										<option value="kakao.com">kakao.com</option>
										<option value="daum.com">daum.com</option>
										<option value="custom">직접입력</option>
									</select>
								</div>
								<div id="msgEmail"></div>

								<!-- 숨겨진 이메일 값 (최종 결합된 이메일을 이곳에 설정) -->
								<input type="hidden" id="accountEmail" name="accountEmail">
							</div>
							<!-- 서버로 보낼 실제 이메일 -->
							<!-- 배송지 명 -->
							<div class="form-item">
								<label class="form-label my-3">배송지 명<sup>*</sup></label> <input
									type="text" class="form-control mt-2" id="customAddressName"
									placeholder="배송지 명 입력" maxlength="15" required
									name="addressName">

							</div>

							<!-- 우편번호 및 주소 -->
							<div class="form-item">
								<label class="form-label my-3">주소</label>
								<div class="d-flex gap-2">
									<input type="text" class="form-control" id="sample6_postcode"
										name="postalCode" placeholder="우편번호" readonly required>
									<input type="button" class="btn btn-outline-success"
										id="postcodeBtn" value="우편번호 찾기">
								</div>
								<input type="text" class="form-control mt-2"
									id="sample6_address" name="address1" placeholder="주소" readonly>
								<input type="text" class="form-control mt-2"
									id="sample6_detailAddress" name="address2" placeholder="상세주소"
									required>
							</div>
						</div>
					</div>
					<div class="row justify-content-center mt-5">
						<div class="col-6">
							<button id="try-sign-in" type="submit"
								class="btn btn-success w-100 py-3">회원가입</button>
						</div>
					</div>
			</div>
			</form>
		</div>
		</div></div>
	</div>
	<!-- 회원가입 페이지 부분 수정 완료-->

	<!-- Back to Top -->
	<a href="#" class="btn btn-primary btn-lg-square back-to-top"><i
		class="fa fa-arrow-up"></i></a>

	<tag:footer />
	<!-- JavaScript Libraries -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script> -->
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>


	<!-- Template Javascript -->
	<script src="js/main.js"></script>

	<!-- Custom JavaScript (버그샌드위치) -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		// 확인해야 하는 데이터들
		// 1. 아이디 
		let isIdChecked = false;
		// 2. 비밀번호(올바른 비밀번호 + 중복확인 되었을 때)
		let isPasswordChecked = false;
		// 3. 이름 올바른지
		let isNameChecked = false;
		// 4. 휴대폰 번호
		let isPhoneChecked = false;
		// 5. 이메일 형식과 중복 확인
		let isEmailChecked = false;
		// 6. 배송지 명이 1~15자 인지
		let isAddressNameChecked = false;
		// 7. 주소 [우편번호:5자, 지역주소, 상세주소 가 존재하는지]
		let isAddressRegionChecked = false;
		let isAddressDeatilChecked = false;
		// 이것을 만족 했을때 submit 허락해주기
		/////////////////////////////////////////////////////////////////////////////
		// 1. 아이디 입력할 때 -> 1차로 정규화잡아주고 이게 올바를 떄에만 2차로 중복확인을 잡아줘야함
		// a. 아이디 형식 확인 -> 중복확인 버튼 활성화
		$('#userId').on(
				'input',
				function() {
					// 우선 아이디가 바뀌었으니 아이디체크 false로 바꿔주기
					isIdChecked = false;

					// 1. 숫자 영대소문자 '_' 만 남겨주기
					let value = $(this).val().replace(/[^a-zA-Z0-9_]/g, '');
					$(this).val(value);

					// 2. 영문, 숫자 모두 들어가는지 확인 후 여부에 따라 중복검사 풀어주기
					if (/^(?=.*\d)[a-z][a-z0-9_]{3,15}$/.test(value)) {
						// 중복검사 활성화	
						$('#btnIdCheck').prop('disabled', false);
						$('#msgIdCheck').text('사용 가능한 형식입니다. 중복확인을 해주세요').css(
								'color', 'green');
					} else {
						// 중복검사 비활성화
						$('#btnIdCheck').prop('disabled', true);
						$('#msgIdCheck').text(
								'아이디는 숫자 포함 영소문자로 시작 , 영문/숫자/_만 가능 (4~16자)')
								.css('color', 'red');
					}
				});

		// b. 중복확인 버튼 누를 시 ajax를 통한 요청하기
		$('#btnIdCheck')
				.on(
						'click',
						function(e) {
							$
									.ajax({
										url : '${pageContext.request.contextPath}/CheckIdDuplicateServlet',
										type : 'POST',
										dataType : 'text',
										data : {
											accountId : $('#userId').val()
										},
										success : function(result) {
											console.log('result:[' + result
													+ ']');
											if (result === "accountIdDuplicate") {
												isIdChecked = false;
												$('#msgIdCheck').text(
														'중복된 아이디입니다.').css(
														'color', 'red');
											} else if (result === "accountIdUnique") {
												isIdChecked = true;
												$('#msgIdCheck').text(
														'사용 가능한 아이디입니다.').css(
														'color', 'green');
											}
										},
										error : function(error) {
											console.log('에러 발생:', error);
										}
									});
						});
		// 아이디 검사 파트 종료
		/////////////////////////////////////////////////////////////////////////////
		// 2. 비밀번호(올바른 비밀번호 + 중복확인 되었을 때) 
		// let isPasswordChecked=false; 가 되어있는 상황
		//  비밀번호 형식 체크
		// 비밀번호 입력 될때마다 체크해주기
		$("#password1").on("input", validatePasswords);
		$("#password2").on("input", validatePasswords);

		// 비밀번호 정규식
		const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&])[\S]{8,16}$/;

		// 두 비밀번호 공간 체크해주고 모두 완벽할때 유효성 통과시켜주는 함수	
		function validatePasswords() {
			const p1 = $("#password1").val();
			const p2 = $("#password2").val();

			// 두 비밀번호 칸의 길이가 0인지 확인해주기
			const p1Empty = p1.length === 0;
			const p2Empty = p2.length === 0;

			// 비밀번호가 유효한지 확인해주기
			const p1Valid = pwRegex.test(p1);

			// 비밀번호 유효성 꺼주기
			isPasswordChecked = false;

			// a. 첫번째 비밀번호 안내문구
			// 비밀번호가 비어있으면
			if (p1Empty) {
				$("#msgCheck1").text("").css("color", "");
			}
			// 비밀번호가 조건을 만족하지 않으면
			else if (!p1Valid) {
				$("#msgCheck1")
						.text(
								"비밀번호는 8~16자, 대문자/소문자/숫자/특수문자(!@#$%^&)를 모두 포함하고 공백이 없어야 합니다.")
						.css('color', 'red');
			}
			// 비밀번호가 올바른 형식이면
			else {
				$("#msgCheck1").text("비밀번호 형식이 올바릅니다.").css('color', 'green');
			}

			// b. 비밀번호 확인 안내문구
			// p2가 비어있으면(입력 시작 전) 메시지 비우기
			if (p2Empty) {
				$("#msgCheck2").text("").css('color', '');
				return;
			}
			// 비밀번호1이 형식부터 틀리면, 확인칸에서는 "먼저 형식을 맞춰라"고 해주기
			if (!p1Valid) {
				$("#msgCheck2").text("먼저 비밀번호 형식을 올바르게 입력해주세요").css('color',
						'red');
				return;
			}
			// 형식이 올바르면 일치 여부 검사하기
			if (p1 === p2) {
				$("#msgCheck2").text("비밀번호가 일치합니다.").css('color', 'green');
				isPasswordChecked = true;
			} else {
				$("#msgCheck2").text("비밀번호가 일치하지 않습니다.").css('color', 'red');
				isPasswordChecked = false;
			}
		}
		/////////////////////////////////////////////////////////////////////////////
		// 3. 이름 올바른지
		// let isNameChecked=false;가 되어있는 상태
		// 간단히 input[id=account-name] 부분만 감지해서 이름 형식인지 정규식만 환인해주기

		// 입력 중에는 안내만, 포커스 빠질 때 최종 검증하는 흐름
		$('#account-name').on(
				"input",
				function() {
					console.log('a');
					const name = $('#account-name').val().trim();
					console.log(name);
					// 작성된 내용이 없다면
					if (name.length === 0) {
						$('#accountNameCheck').text("");
					}
					// 한글 이름 2-5자가 아니라면
					else if (!/^[가-힣]{2,5}$/.test(name)) {
						$('#accountNameCheck').text("한글이름 2-5자를 입력해주세요").css(
								'color', 'red');
						isNameChecked = false;
					} else {
						$('#accountNameCheck').text("올바른 이름입니다.").css('color',
								'green');
						isNameChecked = true;
					}
				});
		/////////////////////////////////////////////////////////////////////////////
		// 4. 휴대폰 번호
		// let isPhoneChecked=false;
		$('#phone')
				.on(
						'input blur',
						function() {
							let value = $(this).val().replace(/[^0-9]/g, ''); // 숫자만 남기기
							$(this).val(value);

							if (value.length === 0) {
								$('#msgPhoneCheck').text("").css('color', '');
								isPhoneChecked = false;
								return;
							}

							if (!/^010\d{8}$/.test(value)) {
								$('#msgPhoneCheck').text(
										"휴대폰 번호는 010으로 시작하는 11자리 숫자만 입력하세요.")
										.css('color', 'red');
								isPhoneChecked = false;
							} else {
								$
										.ajax({
											url : "${pageContext.request.contextPath}/CheckPhoneNumberDuplicateServlet",
											type : "POST",
											dataType : "text",
											data : {
												accountPhone : value
											},
											success : function(result) {
												if (result === "accountPhoneUnique") {
													$('#msgPhoneCheck').text(
															"올바른 휴대폰 번호입니다.")
															.css('color',
																	'green');
													isPhoneChecked = true;
												} else if (result === "accountPhoneEmpty") {
													$('#msgPhoneCheck')
															.text(
																	"accountPhoneEmpty")
															.css('color', 'red');
													isPhoneChecked = false;
												} else if (result === "accountPhoneDuplicate") {
													$('#msgPhoneCheck')
															.text(
																	"중복된 핸드폰 번호입니다.")
															.css('color', 'red');
													isPhoneChecked = false;
												}
											},
											error : function(error) {
												console
														.log(
																"CheckPhoneNumberDuplicateServlet ajax 에러:",
																error);
											}
										});

							}
						});

		/////////////////////////////////////////////////////////////////////////////
		// 5. 이메일 형식과 중복 확인
		// let isEmailChecked=false;

		// 직접입력 선택 시 customDomain 만들어주게 설정하기
		$('#emailDomain').on('change', function() {
			if ($(this).val() === 'custom') {
				$('#customDomain').show().val('').focus();
			} else {
				$('#customDomain').hide().val('');
			}
		});
		// 이메일 유효성 검사 함수
		function updateEmailValidation() {
			console.log("$('#emailDomain').val()", $('#emailDomain').val());
			const id = $('#emailId').val().trim();
			const domain = $('#emailDomain').val() === "custom" ? $(
					'#customDomain').val().trim() : $('#emailDomain').val();
			console.log("id", id);
			console.log("domain", domain);

			// 2) 일부만 입력된 경우(아이디만, 도메인만 등) => 실패
			if (id === null || domain === null || id.length === 0
					|| domain.length === 0) {
				$('#msgEmail').text("이메일을 입력하려면 아이디와 도메인을 모두 입력하세요.").css(
						'color', 'red');
				$('#accountEmail').val("");
				isEmailChecked = false;
				return;
			}

			// 3) 조합 후 형식 검사
			const email = id + '@' + domain;
			console.log('email', email);
			$('#accountEmail').val(email);

			if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
				$('#msgEmail').text("이메일 형식이 올바르지 않습니다.").css('color', 'red');
				isEmailChecked = false;
			} else {
				$('#msgEmail').text("사용 가능한 이메일 형식입니다.").css('color', 'green');
				$
						.ajax({
							url : "${pageContext.request.contextPath}/CheckEmailDuplicateServlet",
							type : "POST",
							data : {
								accountEmail : email
							},
							dataType : "text",
							success : function(result) {
								if (result === "accountEmailDuplicate") {
									$('#msgEmail').text("이미 사용중인 이메일입니다.").css(
											'color', 'red');
									isEmailChecked = false;
								} else if (result === "accountEmailUnique") {
									$("#accountEmail").val(email);
									$('#msgEmail').text("사용 가능한 이메일입니다.").css(
											'color', 'green');
									isEmailChecked = true; // 중복체크까지 하려면 여기서 true 말고 ajax 결과로 결정
								} else {
									$('#msgEmail').text("사용할 수 없는 이메일입니다.")
											.css('color', 'red');
									isEmailChecked = false;
								}
							},
							error : function(error) {
								console.log(
										'CheckEmailDuplicateServlet 호출중 에러 발생',
										error);
								isEmailChecked = false;
							}
						});
			}
		}
		$('#emailId').on('input blur', updateEmailValidation);
		$('#customDomain').on('input blur', updateEmailValidation);
		$('#emailDomain').on('change', updateEmailValidation);
		/////////////////////////////////////////////////////////////////////////////
		// 6. 배송지 명이 1~15자 인지
		// let isAddressNameChecked=false;
		/////////////////////////////////////////////////////////////////////////////
		// 7. 주소 [우편번호:5자, 지역주소, 상세주소 가 존재하는지]
		// let isAddressRegionChecked=false;
		// let isAddressDeatilChecked=false;

		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수
							console.log("addr : ", addr);
							console.log("extraAddr : ", extraAddr);
							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample6_postcode').value = data.zonecode;
							document.getElementById("sample6_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample6_detailAddress")
									.focus();
							// 유효성 검사 해주기
							isAddressRegionChecked = true;
						}
					}).open();
		};

		document.getElementById("postcodeBtn").addEventListener("click",
				sample6_execDaumPostcode);

		$("#sample6_detailAddress").on('input', function() {
			console.log("inputed");
			if ($(this).val().trim().length > 0) {
				isAddressDeatilChecked = true;
			} else {
				isAddressDeatilChecked = false;
			}
		});

		/////////////////////////////////////////////////////////////////////////////
		// 회원가입 시도
		$('#try-sign-in')
				.on(
						'click',
						function(e) {
							if (isIdChecked && isPasswordChecked
									&& isPhoneChecked && isEmailChecked
									&& isNameChecked && isAddressRegionChecked
									&& isAddressDeatilChecked) {

								console.log('모두 통과');
								// -> 이제 데이터 가공해서 보내주기
								// accountId accountPassword accountName accountEmail accountPhone 
								// postalCode addressName address1(지역주소) address2(상세주소)

							} else {
								console.log('통과 실패');
								e.preventDefault();
							}
						});
	</script>
</body>

</html>