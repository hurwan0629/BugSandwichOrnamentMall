$(function () {

    const addressRegex = /^[a-zA-Z가-힣]{1,20}$/;

    let isAddressSelected = false; // 배송지 선택 여부
    let isAddressValid = false;    // 배송지명 최종 유효 여부

    /* =====================
       배송지 선택 변경
    ===================== */
    $("#addressName").on("change", function () {
        const value = $(this).val();

        $("#msgAddressName").text("");
        $("#addressName").css("border", "");
        $("#customAddressName").css("border", "");

        isAddressSelected = false;
        isAddressValid = false;

        if (value === "customAddress") {
            $("#customAddressName")
                .val("")
                .show()
                .focus();
        } else {
            $("#customAddressName")
                .val("")
                .hide();

            // 집 / 회사 선택은 바로 유효
            isAddressSelected = true;
            isAddressValid = true;
        }
    });

    /* =====================
       직접입력 input 중
    ===================== */
    $("#customAddressName").on("input", function () {
        $("#msgAddressName").text("");
        $(this).css("border", "");
        isAddressValid = false;
    });

    /* =====================
       직접입력 blur 검증
    ===================== */
    $("#customAddressName").on("blur", function () {
        const value = $(this).val().trim();

        $("#msgAddressName").text("");
        isAddressValid = false;

        if (!value) {
            return;
        }

        if (!addressRegex.test(value)) {
            $("#msgAddressName")
                .text("배송지 명은 한글/영문만 가능하며 20자 이내여야 합니다.")
                .css("color", "red");
            return;
        }

        $("#msgAddressName")
            .text("사용 가능한 배송지 명입니다.")
            .css("color", "green");

        isAddressValid = true;
    });

    /* =====================
       submit 버튼 클릭
    ===================== */
    $("#btnSubmit").on("click", function (e) {

        const selectValue = $("#addressName").val();

        // 배송지 선택 안 함
        if (!selectValue) {
            e.preventDefault();
            $("#msgAddressName")
                .text("배송지 명을 선택해 주세요.")
                .css("color", "red");
            $("#addressName").focus().css("border", "2px solid red");
            return;
        }

        // 직접입력인데 유효하지 않음
        if (selectValue === "customAddress" && !isAddressValid) {
            e.preventDefault();
            $("#msgAddressName")
                .text("배송지 명을 다시 확인해 주세요.")
                .css("color", "red");
            $("#customAddressName").focus().css("border", "2px solid red");
            return;
        }

        // 👉 여기까지 오면 통과
        // submit 정상 진행
    });
	
	$("#btnSubmit").on("click", function () {

	    let finalValue = "";

	    if ($("#addressName").val() === "customAddress") {
	        finalValue = $("#customAddressName").val().trim();
	    } else {
	        finalValue = $("#addressName").val();
	    }

	    $("#finalAddressName").val(finalValue);
	});
	
	
	
	
	$("#btnSubmit").on("click", function (e) {

	    const postcode = $("#sample6_postcode").val().trim();
	    const address  = $("#sample6_address").val().trim();

	    if (!postcode || !address) {
	        e.preventDefault();
	        $("#msgAddress").text("우편번호 찾기를 통해 주소를 입력해주세요.").css("color", "red");
			$("#sample6_postcode").focus().css("border", "2px solid red");
			$("#sample6_address").css("border", "2px solid red");
			$("#postcodeBtn").focus();
	        return;
	    }

	    // 정상 submit
	});
	
	$("#postcodeBtn").on("click", function (){
		$("#msgAddress").text("");
		$("#sample6_postcode").css("border", "");
		$("#sample6_address").css("border", "");
	});
});