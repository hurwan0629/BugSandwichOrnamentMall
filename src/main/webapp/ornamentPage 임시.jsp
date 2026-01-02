<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

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

<!-- Custom Style (버그샌드위치) -->
<link href="customResource/ratingStar.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/customResource/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/customResource/dropdown.css">


<style>

</style>
</head>

<body>



	<tag:header />

	<!-- Single Page Header start -->
	<div class="container-fluid page-header py-5">
		<h1 class="text-center text-white display-6 wow fadeInUp"
			data-wow-delay="0.1s">오너먼트 상품</h1>
	</div>
	<!-- Single Page Header End -->



	<!-- Shop Page Start -->
	<div class="container-fluid shop py-5">
		<div class="container py-5 d-flex justify-content-center">
			<div class="col-lg-9 wow fadeInUp content" data-wow-delay="0.1s">
				
				<!-- 상품 정렬 옵션 영역 -->
				<div class="row g-4">
					<!-- 검색창 영역 -->
					<div class="col-xl-7">
						<div class="input-group w-100 mx-auto d-flex" style="cursor: pointer;">
							<input id="search-bar" type="search" class="form-control p-3"
								placeholder="검색어를 입력해주세요" 
								aria-describedby="search-icon-1">
							<span id="search-icon-1" class="input-group-text p-3"><i
								class="fa fa-search"></i></span>
								<!-- 최근 검색어 드롭다운 바 -->
						<div id="recent-search-dropdown" class="recent-search-dropdown d-none">
							<!-- 최대 5개 드롭다운 생성 -->
						</div>
						</div>
						
					</div>
					<!-- 검색창 영역 종료 -->
					
					<!-- 검색어 옆 추가 정렬 버튼 -->
					<div class="col-lg-5 wow" data-wow-delay="0.1s">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item mb-4">
                                <a id="star-desc"
                                class="d-flex mx-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill"
                                    href="#">
                                    <span class="text-dark" style="width: 130px;">별점 높은순</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <!-- 검색어 옆 추가 정렬 버튼 종료 -->
				</div>
				<!-- 상품 정렬 옵션 영역 종료 -->
				
				<!-- 상품 목록 및 페이지네이션 -->
				<div class="tab-content">
					<div id="tab-5" class="tab-pane fade show p-0 active">
						<div id="item-list-container" class="row g-4 product">
							
							<!-- 상품 목록 비동기 로딩 -->

						</div>
						<!-- 페이지네이션 부분 -->
						<div class="col-12 wow fadeInUp" data-wow-delay="0.1s">
							<div id="item-page-list"
								class="pagination d-flex justify-content-center mt-5">
								
								<!-- 페이지네이션 비동기 로딩 -->
								
							</div>
						</div>
					</div>
				</div>
				<!-- 상품 목록 및 페이지네이션 종료 -->
			</div>
		</div>
	</div>
	<!-- Shop Page End -->


	<tag:footer />



	<!-- JavaScript Libraries -->
	<!-- <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script> -->
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>


	<!-- Template Javascript -->
	<script src="js/main.js"></script>

	<!-- Custom JavaScript -->
	<script src="customResource/ratingStar.js"></script>
	<script>
	/*
	itemDatas: ArrayList<ItemDTO> [ itemPk, itemStock, itemImageUrl, itemName, itemStar]
	currentPage : 사용자가 누른 페이지
	startPage : 출력할 첫 페이지 번호
	endPage : 출력할 마지막 페이지 번호
	totalPage : 총 블럭 개수
	*/
	// ===== 최근 검색어(로컬스토리지) + 드롭다운 =====
	const STORAGE_KEY = "recentSearches"; // 로컬 스토리지 키
	const MAX_COUNT = 5;		// 최대 드롭다운 개수

	const searchInput = $("#search-bar");	// input 검색어 창
	const searchBtn = $("#search-icon-1");  // 검색하기 버튼
	const dropdown = $("#recent-search-dropdown"); // 검색어 드롭다운 공간

	// 드롭다운이 검색창 아래에 붙도록 부모를 relative로
	// (input-group의 상위 col-xl-7 안에서 absolute 기준을 잡아도 되는데, 여기선 가장 안전하게 input-group에 설정)
	searchInput.closest(".col-xl-7").css("position", "relative");

	dropdown.css({
	  position: "absolute",
	  left: 0,
	  right: 0,
	  top: "100%"
	});
	
	// 로컬 스토리지에서 json형태로 키와 리스트 주기 (없으면 빈 리스트 반환)
	function getRecentSearches() {
	  try {
	    return JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
	  } catch (e) {
	    return [];
	  }
	}
	
	// 최근 검색 값 로컬 스토리지에 넣어주기
	function setRecentSearches(list) {
	  localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
	}
	
	// 최근 검색어 업데이트 하기
	function saveRecentSearch(keyword) {
		// 키워드가 비어있으면 취소
	  if (!keyword) return;
		
		// 키워드가 비어있으면 취소
	  const value = String(keyword).trim();
	  if (value.length === 0) return;

	  // 기존의 데이터 받아와서 최신순으로 업데이트 해주고 그대로 로컬 스토리지에 넣어주기
	  let list = getRecentSearches();
	  list = list.filter(item => item !== value); // 중복 제거
	  list.unshift(value);                        // 최신을 맨 앞
	  list = list.slice(0, MAX_COUNT);            // 5개 유지
	  setRecentSearches(list);
	}
	
	// 인자와 다른 검색어들만 살려두기
	function removeRecentSearch(keyword) {
	  const value = String(keyword).trim();
	  let list = getRecentSearches();
	  list = list.filter(item => item !== value);
	  setRecentSearches(list);
	}
	
	// 드롭다운 보여주기
	function showDropdown() {
	  const list = getRecentSearches();
		
	  // 길이가 0이면 d-none 속성 추가해서 안보이게 해주기
	  if (!list.length) {
	    dropdown.addClass("d-none").empty();
	    return;
	  }

	  // getRecentSearches를 통한 로컬 스토리지에 데이터가 존재하면 그만큼 드롭다운으로 만들어주기
	  let html = "";
	  list.forEach((kw) => {
	    html += `
	      <div class="recent-search-item" data-keyword="\${kw.replace(/"/g, "&quot;")}">
	        <div class="recent-search-text">\${kw}</div>
	        <button type="button" class="recent-search-remove" data-remove="\${kw.replace(/"/g, "&quot;")}">&times;</button>
	      </div>
	    `;
	  });
		// 드롭다운 보이게 해주기
	  dropdown.html(html).removeClass("d-none");
	}

	function hideDropdown() {
		// 드롭다운 숨기기
	  dropdown.addClass("d-none");
	}

	// 검색 실행을 "기존 검색 버튼 로직"으로 태우기 (중복 방지)
	function runSearchWithKeyword(kw) {
	  searchInput.val(kw);
	  hideDropdown();
	  searchBtn.trigger("click"); // 기존 ajax 검색 로직 그대로 사용
	}

	// 1) 검색창 포커스/클릭 시 드롭다운 표시
	searchInput.on("focus click", function() {
	  showDropdown();
	});

	// 2) 검색창 입력이 바뀌면(UX적으로) 드롭다운 갱신
	searchInput.on("input", function() {
	  // 여기서는 "최근 검색어"만 보여주는 목적이므로 그대로 갱신만.
	  showDropdown();
	});

	// 3) 드롭다운 항목 클릭 -> 검색
//	    (X버튼 클릭은 별도 처리하므로, item 클릭만)
	$(document).on("click", ".recent-search-item", function(e) {
	  // X 버튼 누른 경우는 아래 handler가 처리하니 여기서 막아줌
	  if ($(e.target).hasClass("recent-search-remove")) return;
	  const kw = $(this).data("keyword");
	  if (kw) runSearchWithKeyword(kw);
	});

	// 4) X 버튼 클릭 -> 즉시 삭제 + 다시 렌더
	$(document).on("click", ".recent-search-remove", function(e) {
	  e.stopPropagation(); // item 클릭 이벤트로 안 퍼지게
	  const kw = $(this).data("remove");
	  removeRecentSearch(kw);
	  showDropdown();
	});

	// 5) 바깥 클릭하면 닫기 (단, 드롭다운 내부 클릭은 닫히면 안 됨)
	$(document).on("mousedown", function(e) {
	  const isInside = $(e.target).closest("#recent-search-dropdown, #search-bar, #search-icon-1").length > 0;
	  if (!isInside) hideDropdown();
	});

	// 6) 엔터로 검색해도 저장되게 
	searchInput.on("keydown", function(e) {
	  if (e.key === "Enter") {
	    e.preventDefault();
	    searchBtn.trigger("click");
	  }
	});

	// ===== 최근 검색어(로컬스토리지) + 드롭다운 끝 =====
	
	
	const itemListContainer = $("#item-list-container");
	
	function renderItems(itemDatas) {
		console.log('renderItems');
	  	console.log("a" + itemDatas);
	  
	  let html = "";
	  $.each(itemDatas, function (index, itemData) {
		  console.log("index:["+index+"]")
		  console.log("itemData:["+itemData+"]")
	    html += `
	      <div class="col-lg-4">
	        <div class="rounded ">
	          <div class="product-item-inner border rounded  item-card">

	            <div class="product-item-inner-item ">
	              <img src="${pageContext.request.contextPath}\${itemData.itemImageUrl}"
	                   class="img-fluid w-100 rounded-top product-img"
	                   alt="상품 이미지">
	              <div class="product-details"></div>
	            </div>

	            <div class="text-center rounded-bottom p-4">
	              <a href="ornamentDetailPage.do?itemPk=\${itemData.itemPk}" class="d-block h4 product-title">
	                \${itemData.itemName}

	              </a>
	              <span class="text-primary fs-5">
	              \${Number(itemData.itemPrice).toLocaleString('ko-KR') + '원'}
	              </span>
	            </div>

	            <div class="text-center rounded-bottom p-4">
	              <div class="rating_box">
	                <div class="rating">
	                  ★★★★★
	                  <span class="rating_star"
	                        style="width: \${itemData.itemStar * 10}%;">
	                    ★★★★★
	                  </span>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    `;
	  });
	  itemListContainer.html(html);
	}
	
	function renderPagination(data) {
		console.log('renderPagination');
		  let html = "";

		  const currentPage = data.currentPage;
		  const startPage   = data.startPage;
		  const endPage     = data.endPage;
		  const totalPage   = data.totalPage;
			console.log(
					"currentPage:["+currentPage+"]"+
					"startPage:["+startPage+"]"+
					"endPage:["+endPage+"]"+
					"totalPage:["+totalPage+"]");
		  // 현재페이지가 보이는 페이지네이션 맨 왼쪽이 아니라면 '<<' 표시 해주기
		  if (currentPage > 1) {
		    html += `
		      <a href="#" class="rounded pagenation-button item-card" data-page="\${currentPage - 1}">
		        &laquo;
		      </a>
		    `;
		  }

		  // 페이지 번호들 출력, 현재 페이지면 active 클래스 붙여주기
		  for (let page = startPage; page <= endPage; page++) {
		    html += `
		      <a href="#"
		         class="rounded pagenation-button \${page === currentPage ? 'active' : 'item-card'}"
		         data-page="\${page}">
		        \${page}
		      </a>
		    `;
		  }
		  
		  // 마지막 페이지에 갔을때면 '>>' 표시 없애주기
		  if (currentPage < totalPage) {
		    html += `
		      <a href="#" class="rounded pagenation-button item-card" data-page="\${currentPage + 1}">
		        &raquo;
		      </a>
		    `;
		  }
			console.log(html);
		  const paginationContainer = $("#item-page-list"); 
		  paginationContainer.html(html);
		}
	
	
	let keyword = $("#search-bar").val();
	let condition = "keyword";
	let page = "1";
	
	// 1. 키워드 검색 눌렀을 때
	const searchButton = $('#search-icon-1');
	searchButton.on('keydown click', function(){
		console.log("검색어 검색 버튼 눌림");
		
		keyword = $("#search-bar").val();
		saveRecentSearch(keyword); // ✅ 추가
		condition = "keyword";
		page = "1";
		
		$.ajax({
		  url: "${pageContext.request.contextPath}/ItemListPagenationServlet",
		  type: "GET", 
		  dataType: "json", // 서버가 JSON을 응답하면
		  contentType: "application/json; charset=UTF-8", 
		  data: { keyword: $("#search-bar").val(), condition: "keyword", page: "1"},
		  success: function (result) { 
			console.log("검색어 관련 데이터 받음");
			// itemDatas, currentPage, startPage, endPage, totalPage
		    renderItems(result.itemDatas);
		 	// currentPage, startPage, endPage, totalPage 주고 페이지네이션 밑부분 만들기
		  	renderPagination(result); 
		  },
		  error: function (xhr, status, err) {
		    console.log("error:", status, err);
		    console.log("responseText:", xhr.responseText);
		  },
		  complete: function () {
		    console.log("complete");
		  }
		});
	});
	
	
	// 2. 별점 내림차순 버튼 눌렀을 때 
	$('#star-desc').on('click', function(){
		console.log("별점 내림차순 버튼 눌림");
		
		keyword = $("#search-bar").val();
		condition = "starDesc";
		page = "1";
		
		$.ajax({
			  url: "${pageContext.request.contextPath}/ItemListPagenationServlet",
			  type: "GET", 
			  dataType: "json", // 서버가 JSON을 응답하면
			  contentType: "application/json; charset=UTF-8", 
			  data: { keyword: $("#search-bar").val(), condition: "starDesc", page: "1"},
			  success: function (result) { // itemDatas, currentPage, startPage, endPage, totalPage
			    renderItems(result.itemDatas);
			    renderPagination(result); // currentPage, startPage, endPage, totalPage 주고 페이지 네이션 밑부분 만들기
			  },
			  error: function (xhr, status, err) {
			    console.log("error:", status, err);
			    console.log("responseText:", xhr.responseText);
			  },
			  complete: function () {
			    console.log("complete");
			  }
			});
	});
	// 3. 최초 로딩 페이지
	$(document).ready(function(){
		console.log("최초 페이지 로딩");
		
		keyword = $("#search-bar").val();
		condition = "default";
		page = "1";
		
		$.ajax({
			  url: "${pageContext.request.contextPath}/ItemListPagenationServlet",
			  type: "GET", 
			  dataType: "json", // 서버가 JSON을 응답하면
			  data: { keyword: $("#search-bar").val(), condition: "default", page: "1"},
			  success: function (result) { // itemDatas, currentPage, startPage, endPage, totalPage
				console.log(result);
			    renderItems(result.itemDatas);
			    renderPagination(result); // currentPage, startPage, endPage, totalPage 주고 페이지 네이션 밑부분 만들기
			  },
			  error: function (xhr, status, err) {
			    console.log("error:", status, err);
			    console.log("responseText:", xhr.responseText);
			  },
			  complete: function () {
			    console.log("complete");
			  }
			});
	});
	
	// 4. 페이지네이션 번호 눌렀을 때
	$(document).on('click', '.pagenation-button', function(e) {
		page = $(this).data('page');
		console.log("페이지네이션 버튼 눌림:["+page+"]");
		
		$.ajax({
		  url: "${pageContext.request.contextPath}/ItemListPagenationServlet",
		  type: "GET", 
		  dataType: "json", // 서버가 JSON을 응답하면
		  contentType: "application/json; charset=UTF-8", 
		  data: { keyword: keyword, condition: condition, page: page},
		  success: function (result) { // itemDatas, currentPage, startPage, endPage, totalPage
		    renderItems(result.itemDatas);
		    renderPagination(result); // currentPage, startPage, endPage, totalPage 주고 페이지 네이션 밑부분 만들기
		  },
		  error: function (xhr, status, err) {
		    console.log("error:", status, err);
		    console.log("responseText:", xhr.responseText);
		  },
		  complete: function () {
		    console.log("complete");
		  }
		});
	});
	</script>
</body>

</html>