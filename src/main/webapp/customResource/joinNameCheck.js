$(function () {
	let isNameChecked = false; // 이름 검증 여부
	let msgName = $("#msgNameCheck");
	
	$("#accountName").on("blur", function () {
		let name = $(this).val().trim();
		const nameRegex = /^[a-zA-Z가-힣\s]{2,20}$/;

		if (!nameRegex.test(name)) {
			msgName
				.text("올바른 이름 형식을 입력해 주세요")
				.css("color", "red");
			isNameChecked = false;
		} else {
			msgName
				.text("이름 형식이 올바릅니다.")
				.css("color", "green");
			isNameChecked = true;
		}
	});

	$("#accountName").on("input", function () {
		msgName.text("");
		isNameChecked = false;
		$(this).css("border", "");
	});

	$("#btnSubmit").on("click", function (e) {
		if (!isNameChecked) {
			e.preventDefault();
			$("#accountName")
				.css("border", "2px solid red")
				.focus();
		}
	});
});