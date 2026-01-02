

/*
1. 비밀번호 입력 정규식 = const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&])[\S]{8,16}$/;
정규식 통과 못하면 submit 버튼 e.preventDefault
2. 비밀번호 정규식 일치 시 비밀번호 사용 가능 msg 띄우기

3. 비밀번호 확인 시 똑같은 정규식 사용
비밀번호가 위의 비밀번호와 일치하면 통과
하지만 비밀번호가 일치하지 않으면 e.prevenetDefault 

결국 비밀번호 정규식과 비밀번호 확인이 되엇을때만 submit 가능
*/
$(function() {
	const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&])[\S]{8,16}$/;
	let isPasswordValid = false;      // 비밀번호 정규식 통과 여부
	let isPasswordConfirmed = false; // 비밀번호 확인 일치 여부
	
	$("#password1").on("input", function () {
	    $("#msgPasswordCheck1").text(""); // 입력 중일 때 메시지 초기화
		$(this).css("border", "");
		isPasswordValid = false;  // 아이디 확인이 완료되지 않았다고 표시
	});
	
	$("#password2").on("input", function () {
	    $("#msgPasswordCheck2").text(""); // 입력 중일 때 메시지 초기화
		$(this).css("border", "");
		isPasswordConfirmed = false;  // 아이디 확인이 완료되지 않았다고 표시
	});
	
	
	$("#password1").on("blur", function() {
		const pw = $(this).val().trim();
		$("#msgPasswordCheck1").text("");
		isPasswordValid = false;

		if (!pwRegex.test(pw)) {
			$("#msgPasswordCheck1")
				.text("비밀번호는 8~16자, 대소문자/숫자/특수문자를 포함해야 합니다.")
				.css("color", "red");
			return;
		}

		$("#msgPasswordCheck1")
			.text("사용 가능한 비밀번호입니다.")
			.css("color", "green");

		isPasswordValid = true;
	});
	
	// 🔥 비밀번호 변경 시 확인 상태 초기화
	$("#password1").on("input", function () {
	    isPasswordConfirmed = false;
	    $("#msgPasswordCheck2").text("");
	});

	$("#password2").on("blur", function() {
		const pw = $("#password1").val().trim();
		const pwCheck = $(this).val().trim();
		$("#msgPasswordCheck2").text("");
		isPasswordConfirmed = false;

		// 정규식부터 통과해야 비교 의미 있음
		if (!pwRegex.test(pw)) {
			$("#msgPasswordCheck2")
				.text("먼저 비밀번호 형식을 확인하세요.")
				.css("color", "red");
			return;
		}

		if (pw !== pwCheck) {
			$("#msgPasswordCheck2")
				.text("비밀번호가 일치하지 않습니다.")
				.css("color", "red");
			return;
		}

		$("#msgPasswordCheck2")
			.text("비밀번호가 일치합니다.")
			.css("color", "green");

		isPasswordConfirmed = true;
	});

	$("#btnSubmit").on("click", function(e) {

		if (!isPasswordValid) {
			e.preventDefault();
			$("#msgPasswordCheck1")
				.text("비밀번호 형식을 확인 해 주세요!")
				.css("color", "red");
			$("#password1").focus().css("border", "2px solid red");
			return;
		}

		if (!isPasswordConfirmed) {
			e.preventDefault();
			$("#msgPasswordCheck2")
				.text("비밀번호가 일치하지 않습니다!")
				.css("color", "red");
			$("#password2").focus().css("border", "2px solid red");
			return;
		}

		// 👉 여기까지 왔다는 건
		// 비밀번호 정규식 + 확인 모두 통과
		// submit 정상 진행
	});
});