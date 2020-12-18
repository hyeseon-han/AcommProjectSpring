<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="css/map.css">	

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>	
<script type="text/javascript">
	function updateBoard(e,f){
		e.preventDefault();
		f.action="loginCheck/update";
		f.submit();
	}
</script>

<div class="container">
	<div class="row justify-content-center mb-5">
    	<div class="col-md-7 text-center">
        	<h3 style="margin-top: 20px">게시글 수정</h3>
        </div>
    </div>

	<form name="myForm">
		<input type="hidden" name="num" value="${freeBoardDetail.num}">
		No. ${freeBoardDetail.num}

		<div class="row form-group">
			<div class="col-md-6 mb-3 mb-md-0">
				<label class="text-black" for="author">작성자</label>
				<input type="text" name="author" id="author" class="form-control" value="${freeBoardDetail.userid}" readonly>
			</div>
			<div class="col-md-6">
				<label class="text-black" for="writeday">작성일</label>
				<input type="text" name="writeday" id="writeday" class="form-control" value="${freeBoardDetail.writeday}" readonly>
			</div>
		</div>

		<div class="row form-group">
			<div class="col-md-12">
				<label class="text-black" for="title">제목</label>
				<input type="text" name="title" id="title" class="form-control" value="${freeBoardDetail.title}" readonly>
			</div>
		</div>

		<div class="map_wrap">
		    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		            	<!-- 저장된 지도 정보가 있을 경우 지도 영역을 표시한다 -->
						<c:if test="${freeBoardDetail.placeName != null}">
		                <div onclick="searchPlaces(); return false;">
		                   	 키워드 : <input type="text" value="${freeBoardDetail.placeName}" id="keyword" size="15"> 
		                    <button type="button" onclick="searchPlaces(); return false;">검색하기</button> 
		                </div>
		                </c:if>
		            	<!-- 저장된 지도 정보가 있을 경우 지도 영역을 표시한다 -->
						<c:if test="${freeBoardDetail.placeName == null}">
		                <div onclick="searchPlaces(); return false;">
		                   	 키워드 : <input type="text" value="에이콘아카데미 강남점" id="keyword" size="15"> 
		                    <button type="button" onclick="searchPlaces(); return false;">검색하기</button> 
		                </div>
		                </c:if>		                
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
		    </div>
		</div>
		
		<br>
		<label class="text-black" for="">선택한 장소</label>	
		<input id="placeName" name="placeName" class="form-control" type="text" value="${freeBoardDetail.placeName}">
		<input id="placeLa" name="placeLa" class="form-control" type="hidden" value="${freeBoardDetail.placeLa}" style="width: 50%; float: left"><input id="placeMa" name="placeMa" class="form-control" type="hidden" value="${freeBoardDetail.placeMa}" style="width: 50%">
		<br>

		<div class="row form-group">
			<div class="col-md-12">
				<label class="text-black" for="content">내용</label>
				<textarea name="content" id="content" cols="30" rows="7" class="form-control" style="padding:20px" readonly>${freeBoardDetail.content}</textarea>
			</div>
		</div>

		<c:if test="${login.userID eq freeBoardDetail.userid}">
			<!-- 수정 가능하도록 활성화  -->
			<script>
				$(document).ready(function() {
					//attr을 이용하여 속성값 변경하기
					$('#title').attr('readonly', false); //readonly을 비활성화 (읽고 쓰기 가능)
					$('#content').attr('readonly', false);
	  			});
			</script>

			<input type="submit" value="수정" class="btn btn-secondary btn-md text-white" onclick="updateBoard(event, myForm)">
			<input type="button" value="목록" class="btn btn-secondary btn-md text-white" onclick="location.href='freeBoardList'">
		</c:if>

	</form>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=64efe24df194e972fb4e28fe4f02b556&libraries=services"></script>
	<script>
	// 키워드 검색창에서 엔터 칠 경우 페이지 이동 방지
		$("#keyword").on("keydown", () => {
		if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	})
	
	// 마커를 담을 배열입니다
	var markers = [];
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	// 키워드로 장소를 검색합니다
	searchPlaces();
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	    var keyword = document.getElementById('keyword').value;
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	    } else if (status === kakao.maps.services.Status.ERROR) {
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	    }
	}
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	            
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	        // 마커에 click 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시하고
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function (marker, title) {
	            kakao.maps.event.addListener(marker, 'click', (function(placePosition) {
	                displayInfowindow(marker, title);
	                return function() {
                		// 좌표정보를 파싱하기 위해 hidden input에 값 지정
                		$("#placeMa").val(placePosition.La);
                		$("#placeLa").val(placePosition.Ma);
                		$("#placeName").val(title);
	                }
	            })(placePosition));
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	            
	        })(marker, places[i].place_name);
	        fragment.appendChild(itemEl);
	        
	    }
	    
	    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '<h5>' + places.place_name + '</h5>';
	    if (places.road_address_name) {
	        itemStr += '<span>' + places.road_address_name + '</span>' +
	                    '<span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '<span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '<span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	    el.innerHTML = itemStr;
	    el.className = 'item';
	    return el;
	}
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	    
	    return marker;
	}
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}					
	</script>
	
</div>