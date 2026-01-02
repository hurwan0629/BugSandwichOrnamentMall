$(function () {
    console.log("joinPhoneCheck.js 로드됨");

    let isDuplicateChecked = false; // 중복 확인 완료 여부
    let isSmsVerified = false;      // SMS 인증 완료 여부
    let timer;                      // 타이머 변수
    let coolDownTimer;              // 버튼 재발송 제한 타이머

    // [추가] 페이지 로드 시 로컬 스토리지 확인 및 상태 복구
    restoreSmsStatus();

    // 1. 휴대폰 번호 입력 시 숫자 외 문자 제거 및 상태 초기화
    $("#phone").on("input", function() {
        let text = $(this).val();
        if (/[^0-9]/.test(text)) {
            text = text.replace(/[^0-9]/g, "");
            $(this).val(text);
            $("#msgPhoneCheck").text("휴대폰 번호는 숫자만 입력 가능합니다.").css("color", "red");
        } else {
            $("#msgPhoneCheck").text("");
        }

        // 번호가 바뀌면 모든 상태 초기화
        isDuplicateChecked = false;
        isSmsVerified = false;
        $("#phone").css("border", "");
        $("#smsVerifyArea").hide();
        
        // 타이머 중지 및 로컬 스토리지 삭제
        stopAllTimers();
        localStorage.removeItem("smsSentTime");
        localStorage.removeItem("smsPhone");
        $('#btnSendSms').prop('disabled', true).text("인증번호 발송");
    });

    // 2. 휴대폰 번호 중복 체크 (blur 이벤트)
    $("#phone").on("blur", function () {
        let phone = $("#phone").val().trim();
        if (!phone) {
            $("#msgPhoneCheck").text("휴대폰 번호를 입력하세요.").css("color", "red");
            $('#btnSendSms').prop('disabled', true);
            return;
        }

        const phoneRegex = /^010\d{8}$/;
        if (!phoneRegex.test(phone)) {
            $("#msgPhoneCheck").text("휴대폰 번호 형식이 올바르지 않습니다. (010xxxxxxxx)").css("color", "red");
            $('#btnSendSms').prop('disabled', true);
            return;
        }

        // 이미 인증 진행 중(타이머 작동 중)이면 중복 체크 AJAX 생략 가능
        if(coolDownTimer) return;

        $.ajax({
            url: contextPath + "/CheckPhoneNumberDuplicateServlet",
            type: "POST",
            dataType: 'text',
            data: { accountPhone: phone },
            success: function (result) {
                if (result === "accountPhoneDuplicate") {
                    $("#msgPhoneCheck").text("이미 사용 중인 휴대폰 번호입니다.").css("color", "red");
                    $('#btnSendSms').prop('disabled', true);
                    isDuplicateChecked = false;
                } else if (result === "accountPhoneUnique") {
                    $("#msgPhoneCheck").text("사용 가능한 휴대폰 번호입니다. 인증을 진행해주세요.").css("color", "green");
                    $('#btnSendSms').prop('disabled', false);
                    isDuplicateChecked = true;
                }
            }
        });
    });

    // 3. 인증번호 발송 클릭 이벤트
    $('#btnSendSms').click(function() {
        const phone = $('#phone').val();
        if (!isDuplicateChecked) {
            alert("먼저 중복 체크를 완료해주세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: contextPath + "/SendSmsServlet",
            data: { phoneNumber: phone },
            success: function(response) {
                if (response === "success") {
                    alert("인증번호가 발송되었습니다.");
                    
                    // [추가] 로컬 스토리지에 발송 시점 및 번호 저장
                    const now = Date.now();
                    localStorage.setItem("smsSentTime", now);
                    localStorage.setItem("smsPhone", phone);

                    $('#smsVerifyArea').show(); 
                    startTimer(180);           // 3분 타이머
                    startBtnCoolDown(180);     // 3분 버튼 비활성화
                }
            }
        });
    });

    // 4. 인증번호 확인 클릭 이벤트
    $('#btnVerifySms').click(function() {
        const code = $('#smsVerifyCode').val();
        if (code.length < 4) {
            alert("인증번호 4자리를 입력해주세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: contextPath + "/VerifyCodeServlet",
            data: { inputCode: code },
            success: function(response) {
                if (response === "verified") {
                    $('#msgSmsVerify').text("인증에 성공했습니다.").css("color", "blue");
                    $('#phone').attr('readonly', true);
                    $('#smsVerifyCode').attr('readonly', true);
                    $('#btnSendSms').prop('disabled', true).text("인증 완료");
                    $('#btnVerifySms').prop('disabled', true);
                    
                    stopAllTimers();
                    // 인증 성공 시에는 스토리지를 지우지 않고 유지하거나, 용도에 따라 처리
                    isSmsVerified = true; 
                } else {
                    $('#msgSmsVerify').text("인증번호가 일치하지 않거나 시간이 만료되었습니다.").css("color", "red");
                    isSmsVerified = false;
                }
            }
        });
    });

    // [기능 함수] 타이머 및 상태 복구 로직
    function restoreSmsStatus() {
        const sentTime = localStorage.getItem("smsSentTime");
        const savedPhone = localStorage.getItem("smsPhone");

        if (sentTime && savedPhone) {
            const currentTime = Date.now();
            const elapsedSeconds = Math.floor((currentTime - sentTime) / 1000);
            const remainingSeconds = 180 - elapsedSeconds;

            if (remainingSeconds > 0) {
                // 아직 3분이 지나지 않음 -> UI 복구
                $("#phone").val(savedPhone);
                isDuplicateChecked = true;
                $('#smsVerifyArea').show();
                startTimer(remainingSeconds);
                startBtnCoolDown(remainingSeconds);
            } else {
                // 3분이 지났으면 스토리지 정리
                localStorage.removeItem("smsSentTime");
                localStorage.removeItem("smsPhone");
            }
        }
    }

    function stopAllTimers() {
        if (timer) clearInterval(timer);
        if (coolDownTimer) clearInterval(coolDownTimer);
    }

    function startBtnCoolDown(duration) {
        let timeLeft = duration;
        const btn = $('#btnSendSms');
        btn.prop('disabled', true);
        
        if (coolDownTimer) clearInterval(coolDownTimer);
        coolDownTimer = setInterval(function() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;
            btn.text((minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds + " 후 가능");
            
            if (--timeLeft < 0) {
                clearInterval(coolDownTimer);
                btn.prop('disabled', false).text("인증번호 재발송");
                localStorage.removeItem("smsSentTime"); // 버튼 활성화 시점에 스토리지 삭제
            }
        }, 1000);
    }

    function startTimer(duration) {
        let timeLeft = duration;
        if (timer) clearInterval(timer);
        timer = setInterval(function() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;
            $('#smsTimer').text((minutes < 10 ? "0" : "") + minutes + ":" + (seconds < 10 ? "0" : "") + seconds);
            if (--timeLeft < 0) {
                clearInterval(timer);
                $('#smsTimer').text("시간 만료");
            }
        }, 1000);
    }

    // 5. 회원가입 버튼 최종 검증
    $("#btnSubmit").on("click", function (e) {
        if (!(isDuplicateChecked && isSmsVerified)) {
            e.preventDefault(); 
            alert("휴대폰 중복 확인 및 인증번호 확인이 필요합니다.");
            $("#phone").css("border", "2px solid red").focus();
        }
    });
});