package com.spring.javaweb8S.common;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaweb8S.dao.AutoUpdateDAO;
import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.SubscribeVO;

@Service
public class AutoUpdate {
	
	@Autowired
	AutoUpdateDAO autoUpdateDAO;

	@Autowired
	JavaMailSender mailSender;
	

	// 주문(배송) 관련 자동 처리
	// 매 시간마다 실시(정각)
	@Transactional
	@Scheduled(cron = "0 0 0/1 * * *")  
	public void orderAutoUpdate() throws ParseException {
		
		// 정기구독 제외, 구매확정 제외한 모든 주문의 idx, orderStatus, manageDate
		ArrayList<OrderVO> vos = autoUpdateDAO.getAutoOrderList();
		System.out.println("orderAutoUpdate의 vos : " + vos);
		// level (결제완료) 후, 1(배송준비중:24시간 후), 2(배송중:12시간 후), 3(배송완료:120시간 후(5일 후)), 
		// (반품신청) 후, 4(반품처리중:24시간 후), 5(반품완료:120시간 후(5일 후))
		// (구매확정)은 구매자가 한다.
		
		// 현재 시간
		Date tempNow = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(tempNow);
		 
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println("now  : " + now);
		Date format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(now);
		Date format2 = new Date();
		
		System.out.println("format1  : " + format1);
		ArrayList<Integer> level1 = new ArrayList<Integer>();
		ArrayList<Integer> level2 = new ArrayList<Integer>();
		ArrayList<Integer> level3 = new ArrayList<Integer>();
		ArrayList<Integer> level4 = new ArrayList<Integer>();
		ArrayList<Integer> level5 = new ArrayList<Integer>();
		
		for(int i=0; i<vos.size(); i++) {
			format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(vos.get(i).getManageDate());
			long diffHor = (format1.getTime() - format2.getTime()) / 3600000; //시 차이
			System.out.println("format2  : " + format2);
			System.out.println("diffHor  : " + diffHor);
			
			// 1단계) 배송준비중
			if(vos.get(i).getOrderStatus().equals("결제완료")) {
				if(diffHor >= 24) level1.add(vos.get(i).getIdx());
			}
			// 2단계) 배송중
			if(vos.get(i).getOrderStatus().equals("배송준비중")) {
				if(diffHor >= 12) level2.add(vos.get(i).getIdx());
			}
			// 3단계) 배송완료
			if(vos.get(i).getOrderStatus().equals("배송중")) {
				if(diffHor >= 120) level3.add(vos.get(i).getIdx());
			}
			// 4단계) 반품처리중
			if(vos.get(i).getOrderStatus().equals("반품신청")) {
				if(diffHor >= 24) level4.add(vos.get(i).getIdx());
			}
			// 4단계) 반품완료
			if(vos.get(i).getOrderStatus().equals("반품처리중")) {
				if(diffHor >= 120) level5.add(vos.get(i).getIdx());
			}
		}
		
		if(level1.size() != 0) {
			autoUpdateDAO.setOrderAutoUpdate(level1, "배송준비중");
			autoUpdateDAO.setDeliveryAutoUpdate(level1, "배송준비중");
		}
		if(level2.size() != 0) {
			autoUpdateDAO.setOrderAutoUpdate(level2, "배송중");
			
			// 배송 테이블에 송장 번호, 배송 날짜 추가
			ArrayList<DeliveryVO> insertVOS = new ArrayList<DeliveryVO>();
			
			for(int i=0; i<level2.size(); i++) {
				DeliveryVO vo = new DeliveryVO();
				// 송장 번호 생성
				SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
				Date today = new Date();
				String res = format.format(today) + (int)(Math.random() * 899999);  // 6자리 난수
				vo.setInvoice(res);
				
				vo.setIdx(level2.get(i));
				insertVOS.add(vo);
			}
			
			autoUpdateDAO.setDeliveryAutoUpdateWithInvoices(insertVOS, "배송중");
		}
		if(level3.size() != 0) {
			autoUpdateDAO.setOrderAutoUpdate(level3, "배송완료");
			autoUpdateDAO.setDeliveryAutoUpdate(level3, "배송완료");
		}
		
		if(level4.size() != 0) autoUpdateDAO.setRefundAutoUpdate(level4, "반품처리중");
		if(level5.size() != 0) autoUpdateDAO.setRefundAutoUpdate(level5, "반품완료");
			
	}
	
	
	// 정기구독 발송
	// 매월 15일 자정 마다!
	@Transactional
	@Scheduled(cron = "0 0 0 15 * *")  
	public void subAutoUpdate() throws ParseException, MessagingException {

		// 1) 매거진 발송 처리
		// 1-1) 구독중 리스트만 가져오기 (구독취소/구독종료 제외)
		ArrayList<SubscribeVO> vos = autoUpdateDAO.getAutoSubList();

		// 1-2) 배송중으로 배송 처리
		// 회원 별명, 주문 고유번호, 배송지 고유번호, 송장번호, 배송 상태(배송중), 배송 날짜(default), 배송 사유(정기 구독)
		ArrayList<DeliveryVO> insertVOS = new ArrayList<DeliveryVO>();
		for(int i=0; i<vos.size(); i++) {
			
			DeliveryVO vo = new DeliveryVO();
			// 송장 번호 생성
			SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
			Date today = new Date();
			String res = format.format(today) + (int)(Math.random() * 899999);  // 6자리 난수
			vo.setInvoice(res);
			
			vo.setMemNickname(vos.get(i).getMemNickname());
			vo.setOrderIdx(vos.get(i).getOrderIdx());
			
			insertVOS.add(vo);
		}
		
		autoUpdateDAO.setDeliAutoInsert(insertVOS);
		
		// 1-3) 구독중인 회원 발송 잔여 횟수 -1
		autoUpdateDAO.setSubSendNum();

		
		// 2) 잔여 횟수 0인 회원, 구독 종료로 변경
		autoUpdateDAO.setSubStatusUpdate();

		// 2-1) 잔여 횟수 0인 회원, 구독 유지 유도하는 메일 전송
		// 회원 별명, 이메일 주소, 구독 시작일, 구독 종료일
		ArrayList<SubscribeVO> tempVOS = autoUpdateDAO.getMemberInfo();
		
		for(int i=0; i<tempVOS.size(); i++) {
			
			String title = "책(의)세계에서 발송한 이메일입니다";
			String expireDate= vos.get(i).getSubExpireDate().substring(0,10);
			String startDate= vos.get(i).getSubStartDate().substring(0,10);
			
			// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
			messageHelper.setTo(tempVOS.get(i).getEmail());
			messageHelper.setSubject(title);
			String content = "";
			
			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
			content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
			content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>매거진 책 Chaeg 의 정기 구독이   "+expireDate+"  일자로 종료될 예정입니다.</h4><br>";
			content += "<br><h3>정기 구독 기간 : <font color='blue'>"+startDate+" ~ "+expireDate+"</font></h3><br>";
			content += "<br><h4>정기 구독을 이어가시려면 책(의)세계에서 구독권 재구매 또는 문의를 남겨주세요:)</h4>";
			content += "<br><h4>매 달 새로운 소식으로 함께할 수 있어 영광이었습니다.</h4>";
			content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
			messageHelper.setText(content, true);
			
			// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
			File file = new File(realPath + "logo.png");		
			messageHelper.addInline("logo.png", file);
			
			// 메일 전송
			mailSender.send(message);
		}
		
	}

	// 정기구독 발송완료
	// 매월 20일 오전 11시마다! (+ 발송 후, 5일 뒤) 
	@Transactional
	@Scheduled(cron = "0 0 11 20 * *")  
	public void subDeliAutoUpdate() throws ParseException {
		
		// 매거진 정기 구독 발송완료 처리
		autoUpdateDAO.setSubDeliAutoUpdate();
	}
	
	// 뉴스레터 발송
	// 매주 월요일 오후 3시
	@Transactional
	@Scheduled(cron = "0 0 15 * * 1")  
	public void booksletterAutoSend() throws MessagingException {
		
		ArrayList<BooksletterVO> vos = autoUpdateDAO.getBooksletterList();
		
		for(int i=0; i<vos.size(); i++) {
			
			String title = "책(의)편지 뉴스레터";
			
			// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
			messageHelper.setTo(vos.get(i).getEmail());
			messageHelper.setSubject(title);
			String content = "";
			
			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
			content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
			content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>책(의)편지 뉴스레터를 보내드립니다.</h4><br>";
			content += "<br><p><img src=\"cid:booksletter1.jpg\" width='500px'></p><br>";
			content += "<br><p><img src=\"cid:booksletter2.jpg\" width='500px'></p><br>";
			content += "<br><p><img src=\"cid:booksletter3.jpg\" width='500px'></p><br>";
			content += "<br><h4>책(의)편지 관련 문의는 책(의)세계 <U>이메일</U> 혹은 (회원일 경우) <U>마이페이지 > 문의</U>에 남겨주세요:)</h4>";
			content += "<br><h4>매주 새로운 소식으로 함께할 수 있어 영광입니다.</h4>";
			content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
			messageHelper.setText(content, true);
			
			// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
			File file1 = new File(realPath + "logo.png");		
			File file2 = new File(realPath + "booksletter1.jpg");		
			File file3 = new File(realPath + "booksletter2.jpg");		
			File file4 = new File(realPath + "booksletter3.jpg");		
			messageHelper.addInline("logo.png", file1);
			messageHelper.addInline("booksletter1.jpg", file2);
			messageHelper.addInline("booksletter2.jpg", file3);
			messageHelper.addInline("booksletter3.jpg", file4);
			
			// 메일 전송
			mailSender.send(message);
		}
	}
	
	
	
	// @Scheduled(cron="*/1 * * * * *")
  public void test2() {
      System.out.println("123@Scheduled annotation : 1초에 1번씩 console 찍기");
  }
  
  //@Scheduled(cron = "0 0 0/1 * * *")
  public void test3() {
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  	System.out.println("정각이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }
	
	
}