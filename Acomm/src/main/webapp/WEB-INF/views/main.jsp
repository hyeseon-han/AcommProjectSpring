<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<jsp:include page="common/header.jsp" flush="true"></jsp:include>
		<script type="text/javascript">
		// 모달창 표시
      	$(() => {
      		var result = '<c:out value="${result}" />';
      		checkModal(result);

      		history.replaceState({}, null, null);
      		
      		function checkModal(result) {
      			if(result === '' || history.state){
      				return;
      			}else{
      				// 모달창에 들어갈 메세지
      				$(".modal-body").html(result);
      				// 모달창 띄워주기
      				$("#myModal").modal("show");
      			}
      		}
      	})
		</script>
	    <div class="site-blocks-cover overlay" style="background-image: url(img/banner.jpg);" data-aos="fade" data-stellar-background-ratio="0.5">
	      <div class="container">
	        <div class="row align-items-center justify-content-center text-center">
	          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
	            <div class="row justify-content-center mb-4">
	              <div class="col-md-8 text-center">
	                <h1>국비지원 수강생을 위한 정보공유 커뮤니티<br><span class="typed-words"></span></h1><br>
	                <p class="lead mb-5">Acomm</p>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
		<!-- 모달창 -->
		<div class="modal fade" id="myModal" role="dialog"
			style="z-index: 100000">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body">
						<p>message</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<script>
	      	var typed = new Typed('.typed-words', {
	        	strings: ["Acommunity"],
	        	typeSpeed: 80,
	        	backSpeed: 80,
	        	backDelay: 4000,
	        	startDelay: 1000,
	        	loop: true,
	        	showCursor: true
	      	});
		</script>

		<section class="site-section" id="blog-section">
		  <div class="container">
		    <div class="row justify-content-center mb-5">
		      <div class="col-md-8 text-center">
		        <h3>IT직무 교육과정</h3>
		      </div>
		    </div>
		
		    <div class="row">
		      <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
		        <div class="h-entry">
		          <a href="#"><img src="img/course6.png" alt="Image" class="img-fluid"></a>
		          <h2 class="font-size-regular"><a href="single.html">OpenSource 기반 빅데이터 분석...</a></h2>
		          <div class="meta mb-4">강사 : 박선화 <span class="mx-2">&bullet;</span> 강의 일수 : 120일<span class="mx-2">&bullet;</span> 비용 : 5700000원</div>
		          <p>머신러닝(Machine Learning)을 활용한 데이터 분석 과정</p>
		          <p><a href="#">more...</a></p>
		        </div> 
		      </div>
		      <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
		        <div class="h-entry">
		          <a href="#"><img src="img/course2.jpg" alt="Image" class="img-fluid"></a>
		          <h2 class="font-size-regular"><a href="single.html">머신러닝을 활용한 데이터 분석 과정</a></h2>
		          <div class="meta mb-4">강사 : 한성은 <span class="mx-2">&bullet;</span> 강의 일수 : 120일<span class="mx-2">&bullet;</span> 비용 : 5000000원</div>
		          <p>머신러닝 알고리즘 기술을 활용하여 정형/비정형 대용량 데이터를 구축, 탐색, 분석하고 시각화를 수행이 가능한 분석 전문가 양성을 목표로 합니다.</p>
		          <p><a href="#">more...</a></p>
		        </div> 
		      </div>
		      <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
		        <div class="h-entry">
		          <a href="#"><img src="img/course3.png" alt="Image" class="img-fluid"></a>
		          <h2 class="font-size-regular"><a href="single.html">React기반의 자바(JAVA)개발자 양성..</a></h2>
		          <div class="meta mb-4">강사 : 이철원 <span class="mx-2">&bullet;</span> 강의 일수 : 90일<span class="mx-2">&bullet;</span> 비용 : 5800000원</div>
		          <p>자바개발자의 중요 스킬인 스프링 프레임워크 교육과 웹프론트엔드 전반적인 내용을 체계적으로 교육함으로써 응용SW엔지니어 양성을 목표로 합니다.</p>
		          <p><a href="#">more...</a></p>
		        </div> 
		      </div>
		      
		    </div>
		  </div>
		</section>
    
		<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	   
	</body>
</html>