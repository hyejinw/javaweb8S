<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>책(의)세계</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		body,h1,h2,h3,h4,h5,h6 {font-family: 'Noto Sans KR', sans-serif;}
		
		body, html {
		  height: 100%;
		  line-height: 1.8;
		}
		
		.mySlides {display:none;}
		.w3-left, .w3-right, .w3-badge {cursor:pointer}
		.w3-badge {height:13px;width:13px;padding:0}

		/* Full height image header */
		.bgimg-1 {
		  background-position: center;
		  background-size: cover;
		  background-image: url("/w3images/mac.jpg");
		  min-height: 100%;
		}
		
		.w3-bar .w3-button {
		  padding: 16px;
		}
		
		
		#back-to-top {
		  display: inline-block;
		  background-color: #282828;
		  width: 50px;
		  height: 50px;
		  text-align: center;
		  border-radius: 4px;
		  position: fixed;
		  bottom: 30px;
		  right: 30px;
		  transition: background-color .3s, opacity .5s, visibility .5s;
		  opacity: 0;
		  visibility: hidden;
		  z-index: 1000;
		}
		#back-to-top::after {
		  content: "\f077";
		  font-family: FontAwesome;
		  font-weight: normal;
		  font-style: normal;
		  font-size: 2em;
		  line-height: 50px;
		  color: #fff;
		}
		#back-to-top:hover {
		  cursor: pointer;
		  text-decoration: none;
		  background-color: #333;
		}
		#back-to-top:active {
		  background-color: #555;
		}
		#back-to-top.show {
		  opacity: 1;
		  visibility: visible;
		}
	</style>
	
</head>
<%-- <body  style="background-image:url('${ctp}/resources/images/background.jpeg')"> --%>
<body>
<a id="back-to-top"></a>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

	
<%-- 	<div class="w3-content w3-display-container" style="max-width:1500px;">
<!-- 	<div class="w3-content w3-display-container" style="max-width:1500px; margin-top:60px"> -->
	  <img class="mySlides" src="${ctp}/resources/images/chaeg_banner1.jpg" style="width:100%">
	  <img class="mySlides" src="${ctp}/resources/images/chaeg_banner2.jpg" style="width:100%">
	  <img class="mySlides" src="${ctp}/resources/images/chaeg_banner3.jpg" style="width:100%">
	  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
	    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)"><font color="#282828" size="6px">&#10094;</font></div>
	    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)"><font color="#282828" size="6px">&#10095;</font></div>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
	  </div>
	</div>
	 --%>
	<div class="w3-content w3-display-container" style="max-width:5000px;">
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner1.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 30px 100px 0px;"><b>
		    	첵(의)세계에서 발행하는 책Chaeg은<br/>
		    	책을 좋아하는 사람들이 만든 책과 문화에 관한 월간지입니다.<br/><br/></b>
		    	책을 많이 읽는 사람만을 위한 잡지는 아닙니다.<br/>
		    	굳이 많이 읽지 않아도 책을 좋아하거나, 즐겨 사거나,<br/>
		    	힐끗 책의 세계에 다가가보기 원하는 사람 모두를 위한 잡지입니다.<br/>
		    </p>
		  </div>
		</div>
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner2.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 30px 100px 0px;"><b>
		    	'3개의 책'은 책(의)세계에서 운영하는 도서 커뮤니티 입니다.<br/><br/></b>
				  세상은 나와 너, 우리로 만들어진 '3개의 책' 이란 테마 안에서,<br/> 
		    	매일 새로운 이야기와 물음으로 책의 안팎과 주변의 세계를 살피고 있습니다.<br/>
					다양한 목적의 의미있는 일에 기여하기를, 마침내 책에 대한 호기심으로<br/>
					이어지기를 소원합니다.<br/>
		    </p>
		  </div>
		</div>
	 	<div class="w3-display-container mySlides">
		  <img src="${ctp}/resources/images/main_banner3.jpg" style="width:100%">
		  <div class="w3-display-bottomright w3-container">
		    <p style="margin:0px 30px 100px 0px;"><b>
		    	책의 세계는 가볍고 즐거워야 합니다.<br/><br/></b>
		    	책(의)세계는 ‘책을 읽자’ ‘더 똑똑해지자’식의 계몽을 위한 공간이 아닙니다.<br/>
		    	다만 맛있는 음식이 넘쳐나는 잔치에 더 많은 사람들을<br/>
		    	초대하고 싶은 마음으로 가꾼 열린 공간입니다.<br/>
		    </p>
		  </div>
		</div>
	 <button class="w3-button w3-display-left" onclick="plusDivs(-1)"><font color="#282828" size="6px">&#10094;</font></button>
	 <button class="w3-button w3-display-right" onclick="plusDivs(1)"><font color="#282828" size="6px">&#10095;</font></button>

	  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
	    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
	  </div>
	</div>
	
	
	
	<!-- Header with full-height image -->
	<header class="bgimg-1 w3-display-container w3-grayscale-min" id="home">
	  <div class="w3-display-left w3-text-white" style="padding:48px">
	    <span class="w3-jumbo w3-hide-small">Start something that matters</span><br>
	    <span class="w3-xxlarge w3-hide-large w3-hide-medium">Start something that matters</span><br>
	    <span class="w3-large">Stop wasting valuable time with projects that just isn't you.</span>
	    <p><a href="#about" class="w3-button w3-white w3-padding-large w3-large w3-margin-top w3-opacity w3-hover-opacity-off">Learn more and start today</a></p>
	  </div> 
	  <div class="w3-display-bottomleft w3-text-grey w3-large" style="padding:24px 48px">
	    <i class="fa fa-facebook-official w3-hover-opacity"></i>
	    <i class="fa fa-instagram w3-hover-opacity"></i>
	    <i class="fa fa-snapchat w3-hover-opacity"></i>
	    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
	    <i class="fa fa-twitter w3-hover-opacity"></i>
	    <i class="fa fa-linkedin w3-hover-opacity"></i>
	  </div>
	</header>
	
	<!-- About Section -->
	<div class="w3-container" style="padding:128px 16px" id="about">
	  <h3 class="w3-center">ABOUT THE COMPANY</h3>
	  <p class="w3-center w3-large">Key features of our company</p>
	  <div class="w3-row-padding w3-center" style="margin-top:64px">
	    <div class="w3-quarter">
	      <i class="fa fa-desktop w3-margin-bottom w3-jumbo w3-center"></i>
	      <p class="w3-large">Responsive</p>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
	    </div>
	    <div class="w3-quarter">
	      <i class="fa fa-heart w3-margin-bottom w3-jumbo"></i>
	      <p class="w3-large">Passion</p>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
	    </div>
	    <div class="w3-quarter">
	      <i class="fa fa-diamond w3-margin-bottom w3-jumbo"></i>
	      <p class="w3-large">Design</p>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
	    </div>
	    <div class="w3-quarter">
	      <i class="fa fa-cog w3-margin-bottom w3-jumbo"></i>
	      <p class="w3-large">Support</p>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore.</p>
	    </div>
	  </div>
	</div>
	
	<!-- Promo Section - "We know design" -->
	<div class="w3-container w3-light-grey" style="padding:128px 16px">
	  <div class="w3-row-padding">
	    <div class="w3-col m6">
	      <h3>We know design.</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod<br>tempor incididunt ut labore et dolore.</p>
	      <p><a href="#work" class="w3-button w3-black"><i class="fa fa-th"> </i> View Our Works</a></p>
	    </div>
	    <div class="w3-col m6">
	      <img class="w3-image w3-round-large" src="/w3images/phone_buildings.jpg" alt="Buildings" width="700" height="394">
	    </div>
	  </div>
	</div>
	
	<!-- Team Section -->
	<div class="w3-container" style="padding:128px 16px" id="team">
	  <h3 class="w3-center">THE TEAM</h3>
	  <p class="w3-center w3-large">The ones who runs this company</p>
	  <div class="w3-row-padding w3-grayscale" style="margin-top:64px">
	    <div class="w3-col l3 m6 w3-margin-bottom">
	      <div class="w3-card">
	        <img src="/w3images/team2.jpg" alt="John" style="width:100%">
	        <div class="w3-container">
	          <h3>John Doe</h3>
	          <p class="w3-opacity">CEO & Founder</p>
	          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
	          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
	        </div>
	      </div>
	    </div>
	    <div class="w3-col l3 m6 w3-margin-bottom">
	      <div class="w3-card">
	        <img src="/w3images/team1.jpg" alt="Jane" style="width:100%">
	        <div class="w3-container">
	          <h3>Anja Doe</h3>
	          <p class="w3-opacity">Art Director</p>
	          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
	          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
	        </div>
	      </div>
	    </div>
	    <div class="w3-col l3 m6 w3-margin-bottom">
	      <div class="w3-card">
	        <img src="/w3images/team3.jpg" alt="Mike" style="width:100%">
	        <div class="w3-container">
	          <h3>Mike Ross</h3>
	          <p class="w3-opacity">Web Designer</p>
	          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
	          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
	        </div>
	      </div>
	    </div>
	    <div class="w3-col l3 m6 w3-margin-bottom">
	      <div class="w3-card">
	        <img src="/w3images/team4.jpg" alt="Dan" style="width:100%">
	        <div class="w3-container">
	          <h3>Dan Star</h3>
	          <p class="w3-opacity">Designer</p>
	          <p>Phasellus eget enim eu lectus faucibus vestibulum. Suspendisse sodales pellentesque elementum.</p>
	          <p><button class="w3-button w3-light-grey w3-block"><i class="fa fa-envelope"></i> Contact</button></p>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Promo Section "Statistics" -->
	<div class="w3-container w3-row w3-center w3-dark-grey w3-padding-64">
	  <div class="w3-quarter">
	    <span class="w3-xxlarge">14+</span>
	    <br>Partners
	  </div>
	  <div class="w3-quarter">
	    <span class="w3-xxlarge">55+</span>
	    <br>Projects Done
	  </div>
	  <div class="w3-quarter">
	    <span class="w3-xxlarge">89+</span>
	    <br>Happy Clients
	  </div>
	  <div class="w3-quarter">
	    <span class="w3-xxlarge">150+</span>
	    <br>Meetings
	  </div>
	</div>
	
	<!-- Work Section -->
	<div class="w3-container" style="padding:128px 16px" id="work">
	  <h3 class="w3-center">OUR WORK</h3>
	  <p class="w3-center w3-large">What we've done for people</p>
	
	  <div class="w3-row-padding" style="margin-top:64px">
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_mic.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A microphone">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_phone.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A phone">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_drone.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A drone">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_sound.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="Soundbox">
	    </div>
	  </div>
	
	  <div class="w3-row-padding w3-section">
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_tablet.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A tablet">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_camera.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A camera">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_typewriter.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A typewriter">
	    </div>
	    <div class="w3-col l3 m6">
	      <img src="/w3images/tech_tableturner.jpg" style="width:100%" onclick="onClick(this)" class="w3-hover-opacity" alt="A tableturner">
	    </div>
	  </div>
	</div>
	
	<!-- Modal for full size images on click-->
	<div id="modal01" class="w3-modal w3-black" onclick="this.style.display='none'">
	  <span class="w3-button w3-xxlarge w3-black w3-padding-large w3-display-topright" title="Close Modal Image">×</span>
	  <div class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
	    <img id="img01" class="w3-image">
	    <p id="caption" class="w3-opacity w3-large"></p>
	  </div>
	</div>
	
	<!-- Skills Section -->
	<div class="w3-container w3-light-grey w3-padding-64">
	  <div class="w3-row-padding">
	    <div class="w3-col m6">
	      <h3>Our Skills.</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod<br>
	      tempor incididunt ut labore et dolore.</p>
	      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod<br>
	      tempor incididunt ut labore et dolore.</p>
	    </div>
	    <div class="w3-col m6">
	      <p class="w3-wide"><i class="fa fa-camera w3-margin-right"></i>Photography</p>
	      <div class="w3-grey">
	        <div class="w3-container w3-dark-grey w3-center" style="width:90%">90%</div>
	      </div>
	      <p class="w3-wide"><i class="fa fa-desktop w3-margin-right"></i>Web Design</p>
	      <div class="w3-grey">
	        <div class="w3-container w3-dark-grey w3-center" style="width:85%">85%</div>
	      </div>
	      <p class="w3-wide"><i class="fa fa-photo w3-margin-right"></i>Photoshop</p>
	      <div class="w3-grey">
	        <div class="w3-container w3-dark-grey w3-center" style="width:75%">75%</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Pricing Section -->
	<div class="w3-container w3-center w3-dark-grey" style="padding:128px 16px" id="pricing">
	  <h3>PRICING</h3>
	  <p class="w3-large">Choose a pricing plan that fits your needs.</p>
	  <div class="w3-row-padding" style="margin-top:64px">
	    <div class="w3-third w3-section">
	      <ul class="w3-ul w3-white w3-hover-shadow">
	        <li class="w3-black w3-xlarge w3-padding-32">Basic</li>
	        <li class="w3-padding-16"><b>10GB</b> Storage</li>
	        <li class="w3-padding-16"><b>10</b> Emails</li>
	        <li class="w3-padding-16"><b>10</b> Domains</li>
	        <li class="w3-padding-16"><b>Endless</b> Support</li>
	        <li class="w3-padding-16">
	          <h2 class="w3-wide">$ 10</h2>
	          <span class="w3-opacity">per month</span>
	        </li>
	        <li class="w3-light-grey w3-padding-24">
	          <button class="w3-button w3-black w3-padding-large">Sign Up</button>
	        </li>
	      </ul>
	    </div>
	    <div class="w3-third">
	      <ul class="w3-ul w3-white w3-hover-shadow">
	        <li class="w3-red w3-xlarge w3-padding-48">Pro</li>
	        <li class="w3-padding-16"><b>25GB</b> Storage</li>
	        <li class="w3-padding-16"><b>25</b> Emails</li>
	        <li class="w3-padding-16"><b>25</b> Domains</li>
	        <li class="w3-padding-16"><b>Endless</b> Support</li>
	        <li class="w3-padding-16">
	          <h2 class="w3-wide">$ 25</h2>
	          <span class="w3-opacity">per month</span>
	        </li>
	        <li class="w3-light-grey w3-padding-24">
	          <button class="w3-button w3-black w3-padding-large">Sign Up</button>
	        </li>
	      </ul>
	    </div>
	    <div class="w3-third w3-section">
	      <ul class="w3-ul w3-white w3-hover-shadow">
	        <li class="w3-black w3-xlarge w3-padding-32">Premium</li>
	        <li class="w3-padding-16"><b>50GB</b> Storage</li>
	        <li class="w3-padding-16"><b>50</b> Emails</li>
	        <li class="w3-padding-16"><b>50</b> Domains</li>
	        <li class="w3-padding-16"><b>Endless</b> Support</li>
	        <li class="w3-padding-16">
	          <h2 class="w3-wide">$ 50</h2>
	          <span class="w3-opacity">per month</span>
	        </li>
	        <li class="w3-light-grey w3-padding-24">
	          <button class="w3-button w3-black w3-padding-large">Sign Up</button>
	        </li>
	      </ul>
	    </div>
	  </div>
	</div>
	
	<!-- Contact Section -->
	<div class="w3-container w3-light-grey" style="padding:128px 16px" id="contact">
	  <h3 class="w3-center">CONTACT</h3>
	  <p class="w3-center w3-large">Lets get in touch. Send us a message:</p>
	  <div style="margin-top:48px">
	    <p><i class="fa fa-map-marker fa-fw w3-xxlarge w3-margin-right"></i> Chicago, US</p>
	    <p><i class="fa fa-phone fa-fw w3-xxlarge w3-margin-right"></i> Phone: +00 151515</p>
	    <p><i class="fa fa-envelope fa-fw w3-xxlarge w3-margin-right"> </i> Email: mail@mail.com</p>
	    <br>
	    <form action="/action_page.php" target="_blank">
	      <p><input class="w3-input w3-border" type="text" placeholder="Name" required name="Name"></p>
	      <p><input class="w3-input w3-border" type="text" placeholder="Email" required name="Email"></p>
	      <p><input class="w3-input w3-border" type="text" placeholder="Subject" required name="Subject"></p>
	      <p><input class="w3-input w3-border" type="text" placeholder="Message" required name="Message"></p>
	      <p>
	        <button class="w3-button w3-black" type="submit">
	          <i class="fa fa-paper-plane"></i> SEND MESSAGE
	        </button>
	      </p>
	    </form>
	    <!-- Image of location/map -->
	    <img src="/w3images/map.jpg" class="w3-image w3-greyscale" style="width:100%;margin-top:48px">
	  </div>
	</div>
	
	<!-- Footer -->
	<footer class="w3-center w3-black w3-padding-64">
	  <a href="#home" class="w3-button w3-light-grey"><i class="fa fa-arrow-up w3-margin-right"></i>To the top</a>
	  <div class="w3-xlarge w3-section">
	    <i class="fa fa-facebook-official w3-hover-opacity"></i>
	    <i class="fa fa-instagram w3-hover-opacity"></i>
	    <i class="fa fa-snapchat w3-hover-opacity"></i>
	    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
	    <i class="fa fa-twitter w3-hover-opacity"></i>
	    <i class="fa fa-linkedin w3-hover-opacity"></i>
	  </div>
	  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" title="W3.CSS" target="_blank" class="w3-hover-text-green">w3.css</a></p>
	</footer>
	 
	<script>
		var slideIndex = 1;
		showDivs(slideIndex);
	
		function plusDivs(n) {
		  showDivs(slideIndex += n);
		}
	
		function currentDiv(n) {
		  showDivs(slideIndex = n);
		}
	
		function showDivs(n) {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  var dots = document.getElementsByClassName("demo");
		  if (n > x.length) {slideIndex = 1}
		  if (n < 1) {slideIndex = x.length}
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";  
		  }
		  for (i = 0; i < dots.length; i++) {
		    dots[i].className = dots[i].className.replace(" w3-white", "");
		  }
		  x[slideIndex-1].style.display = "block";  
		  dots[slideIndex-1].className += " w3-white";
		}
		
		
		var myIndex = 0;
		carousel();
		
		function carousel() {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  for (i = 0; i < x.length; i++) {
		    x[i].style.display = "none";  
		  }
		  myIndex++;
		  if (myIndex > x.length) {myIndex = 1}    
		  x[myIndex-1].style.display = "block";  
		  setTimeout(carousel, 15000); // Change image every 15 seconds
		}
	
		// Modal Image Gallery
		function onClick(element) {
		  document.getElementById("img01").src = element.src;
		  document.getElementById("modal01").style.display = "block";
		  var captionText = document.getElementById("caption");
		  captionText.innerHTML = element.alt;
		}
		
		// 맨 위로 스크롤
		$(function(){
			  $('#back-to-top').on('click',function(e){
			      e.preventDefault();
			      $('html,body').animate({scrollTop:0},600);
			  });
			  
			  $(window).scroll(function() {
			    if ($(document).scrollTop() > 100) {
			      $('#back-to-top').addClass('show');
			    } else {
			      $('#back-to-top').removeClass('show');
			    }
			  });
			});

	</script>

</body>
</html>
