$(function () {
    // 5. 이메일 형식과 중복 확인
    let isEmailChecked = false;
    
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
        const id = $('#emailId').val().trim();
        const domain = $('#emailDomain').val() === "custom" ? $('#customDomain').val().trim() : $('#emailDomain').val();

        // 2) 일부만 입력된 경우(아이디만, 도메인만 등) => 실패
        if (id === null || domain === null || id.length === 0 || domain.length === 0) {
            $('#msgEmail').text("이메일을 입력하려면 아이디와 도메인을 모두 입력하세요.").css('color', 'red');
            $('#accountEmail').val("");
            isEmailChecked = false;
            return;
        }

        // 3) 조합 후 형식 검사
        const email = id + '@' + domain;
        $('#accountEmail').val(email);

        // 이메일 아이디 정규식 (새로운 규칙)
        const emailIdRegex = /^(?=.{4,30}$)[a-zA-Z0-9]+(?:_[a-zA-Z0-9]+)*$/;
        if (!emailIdRegex.test(id)) {
            $('#msgEmail').text("아이디 형식이 올바르지 않습니다.").css('color', 'red');
            isEmailChecked = false;
            return;
        }

        // 도메인 정규식 (새로운 규칙)
        const emailDomainRegex = /^[a-zA-Z0-9.-]+\.(com|net|org|co\.kr|io|co)$/;
        if (!emailDomainRegex.test(domain)) {
            $('#msgEmail').text("도메인 형식이 올바르지 않습니다.").css('color', 'red');
            isEmailChecked = false;
            return;
        }

        $('#msgEmail').text("사용 가능한 이메일 형식입니다.").css('color', 'green');
        
        $.ajax({
            url: contextPath + "/CheckEmailDuplicateServlet",
            type: "POST",
            data: {
                accountEmail: email
            },
            dataType: "text",
            success: function(result) {
                if (result === "accountEmailDuplicate") {
                    $('#msgEmail').text("이미 사용중인 이메일입니다.").css('color', 'red');
                    isEmailChecked = false;
                } else if (result === "accountEmailUnique") {
                    $("#accountEmail").val(email);
                    $('#msgEmail').text("사용 가능한 이메일입니다.").css('color', 'green');
                    isEmailChecked = true; // 중복체크까지 하려면 여기서 true 말고 ajax 결과로 결정
                } else {
                    $('#msgEmail').text("사용할 수 없는 이메일입니다.").css('color', 'red');
                    isEmailChecked = false;
                }
            },
            error: function(error) {
                console.log('CheckEmailDuplicateServlet 호출중 에러 발생', error);
                isEmailChecked = false;
            }
        });
    }

    $('#emailId').on('input blur', updateEmailValidation);
    $('#customDomain').on('input blur', updateEmailValidation);
    $('#emailDomain').on('change', updateEmailValidation);

    $('#btnSubmit').on("click", function(e) {
        if (!isEmailChecked) {
            e.preventDefault();
            $("#emailId").css("border", "2px solid red");
            $("#customDomain").css("border", "2px solid red");
        }
    });

    $('#emailId, #customDomain').on("input", function() {
        $("#emailId").css("border", "");
        $("#customDomain").css("border", "");
    });

    $('#emailDomain').on("change", function() {
        $("#emailId").css("border", "");
        $("#customDomain").css("border", "");
    });
});