<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>밥먹자</title>
   <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
   <link rel="stylesheet" href="${ctp}/resources/font/font.css">
   <link rel="stylesheet" href="${ctp}/resources/css/owl.carousel.min.css">
   <link rel="stylesheet" href="${ctp}/resources/css/owl.theme.default.min.css">
   <script src="${ctp}/resources/js/owl.carousel.js"></script> 
   <script src="${ctp}/resources/js/owl.carousel.min.js"></script>
   <style>
      @font-face {
       font-family: 'RIDIBatang';
       src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
       font-weight: normal;
       font-style: normal;
      }
      
      #item {
         width: 200px;
         heigth: 200px;
      }
      
      #work2, #work1 {
         float: right;   
         margin-right: 50px;      
         margin-top: 5px;   
         margin-bottom: 0px;   
         color: #676a59;   
         font-size: 1em;
      }
      
      #work2 a:hover, #work1 a:hover {
         text-decoration: none;
         color: #cfdd8e;
      }
      
      a:hover {text-decoration:none;}
      
      .border {
         border-style:solid;
         border-width:10px;
         border-color:#de34n6;
      }
      
      .card-text {
         font-size:22px;
         font-family:'SUITE-Regular';
      }
      
      #ps {font-family:'RIDIBatang'; font-size:30px;}
   </style>
</head>
<body>
<!-- logo -->
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- silde show -->
<div class="container">
   <div class="text-center mt-5 mb-0" id="ps" style="padding-top:20px;">&nbsp;|&nbsp;다양한 상품을 둘러보세요&nbsp;|&nbsp;</div>
   <br /><span id="work1"><a href="${ctp}/recipe/recipeList"><b>상품 전체보기 ></b></a></span><br /><br />
   <div class="owl-carousel owl-theme">
      <c:forEach var="vo" items="${productVOS}">
      <div class="card shadow-none" style="width:79%; height:280px; border: 3px solid #f5f5f5;">
       <div id="item"><a href="${ctp}/shop/itemContent?idx=${vo.idx}"><img src="${ctp}/product/${vo.thumbnail}" style="width:206px;height:193px;" /></a></div>
          <div class="w3-container w3-center">
            <div><b>${vo.productName}</b></div>
            <c:if test="${vo.discountRate != 0}">
                <div><font size="2em"><del><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</del></font></div>
                <div>
                   <font size="3em" color="#f66f58">${vo.discountRate}%</font>&nbsp;
                   <font size="3em" color="black"><fmt:formatNumber value="${vo.discount}" pattern="#,###"/>원</font>
                </div>
             </c:if>
             <c:if test="${vo.discountRate == 0}">
                <div><font size="3em"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</font></div>
             </c:if>
          </div>
     </div>
     </c:forEach>
   </div>
   <div class="text-center mb-0" id="ps" style="padding-top:50px;">&nbsp;|&nbsp;맛있는 하루를 위한 레시피를 둘러보세요&nbsp;|&nbsp;</div>
   <br /><span id="work2" class="mb-0"><a href="${ctp}/recipe/recipeList"><b>레시피 전체보기 ></b></a></span><br /><br />
  <c:set var="cnt" value="0" />
  <c:forEach var="i"  begin="1" end="3">
     <div class="row">
       <c:forEach begin="1" end="3">
         <div class="col mt-3 mb-5">
                <a href="${ctp}/recipe/recipeContent?idx=${recipeVOS[cnt].idx}">
                   <div class="border" style="width:281px; height: 310px; background-color:#dedede">
                     <c:set var="file" value="${fn:split(recipeVOS[cnt].file,'/')}"/>
                        <img src ="${ctp}/recipe/${file[0]}" width="280px" height="220px">
                        <div class="card-body text-center">
                       <span id="en" class="card-text"><font color="black"><b>${recipeVOS[cnt].foodName}</b></font></span>
                       <br /><span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-signal-3 xi-x"></i>${recipeVOS[cnt].star}</font></span>&nbsp;&nbsp;
                       <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-time-o xi-x"></i>${recipeVOS[cnt].cookTime}</font></span>
                     </div>
                   </div>
                </a>
              </div>
              <c:set var="cnt" value="${cnt + 1}"/>
        </c:forEach>
     </div>
  </c:forEach>
</div>
<p><br /><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
   var owl = $('.owl-carousel');
   owl.owlCarousel({
       loop:true,
       nav:true,
       margin:10,
       responsive:{
           0:{
               items:1
           },
           600:{
               items:3
           },            
           960:{
               items:5
           },
           1200:{
               items:4
           }
       }
   });
   owl.on('mousewheel', '.owl-stage', function (e) {
       if (e.deltaY>0) {
           owl.trigger('next.owl');
       } else {
           owl.trigger('prev.owl');
       }
       e.preventDefault();
   });

   // 천단위마다 콤마를 표시해 주는 함수
  function numberWithCommas(x) {
     return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
  }
</script>
</body>
</html>