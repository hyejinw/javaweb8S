package com.spring.javaweb8S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.dao.AutoUpdateDAO;
import com.spring.javaweb8S.service.CommunityService;
import com.spring.javaweb8S.service.HomeService;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;

@Controller
public class HomeController {

	@Autowired
	HomeService homeService;
	
	@Autowired
	CommunityService communityService;

	@Autowired
	BookInsertSearch bookInsert;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AutoUpdateDAO autoUpdateDAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session) {
		
		// 신규 매거진 20개 
		ArrayList<MagazineVO> magazineVOS = homeService.getNewMagazines();
		model.addAttribute("magazineVOS", magazineVOS);
		
		// 장바구니 제품 수 
		String nickname = (String) session.getAttribute("sNickname");
		if(nickname != "") {
			int cartNum = homeService.getCartNum(nickname);
			session.setAttribute("sCartNum", cartNum);
		}
		
		// 공지사항(3개) 고정된 공지가 3개미만이면, 일반공지에서 가져오기!
		ArrayList<NoticeVO> noticeVOS = homeService.getImportantNotice();
		model.addAttribute("noticeVOS", noticeVOS);
		
		if(noticeVOS.size() < 3) {
			ArrayList<NoticeVO> extraNoticeVOS = homeService.getExtraNotice(3 - noticeVOS.size());
			model.addAttribute("extraNoticeVOS", extraNoticeVOS);
		}

		// 방문 수 10회 이하 반갑습니다 메시지
		if(nickname != null) {
			String totCnt = homeService.getTotCnt(nickname);
			if(Integer.parseInt(totCnt) <= 10) model.addAttribute("totCnt", totCnt);
		} 
		
		// 최근 문장수집(10개)
		ArrayList<InspiredVO> inspiredVOS = communityService.getNewInspired(nickname);
		model.addAttribute("inspiredVOS", inspiredVOS);
			
		return "home";
	}
	
	// 책 랜덤 추출기
	@ResponseBody
	@RequestMapping(value = "/home/randomBook", method = RequestMethod.POST)
	public BookVO randomBookPost() throws UnsupportedEncodingException {

		ArrayList<String> randomAlphabet = new ArrayList<String>();
		
		// 대문자 A-Z 알파벳 생성
		for(int i = 0; i < 26; i++) {
			char ch = (char)(i + 65);
			randomAlphabet.add(String.valueOf(ch));
		}
		
		// 소문자 a-z 알파벳 생성
		for(int i = 0; i < 26; i++) {
			char ch = (char)(i + 97);
			randomAlphabet.add(String.valueOf(ch));
		}
		
		// 숫자도 넣어주면 좋겠다.
		
		// 받침없는 한글
		String[] temp = new String[] {"가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하",
				"갸", "냐", "댜", "랴", "먀", "뱌", "샤", "야", "쟈", "챠", "캬", "탸", "퍄", "햐",
				"거", "너", "더", "러", "머", "버", "서", "어", "저", "처", "커", "터", "퍼", "허",
				"겨", "네", "데", "레", "메", "베", "세", "에", "제", "체", "케", "테", "페", "헤",
				"고", "노", "도", "로", "모", "보", "소", "오", "조", "초", "코", "토", "포", "호",
				"교", "뇨", "된", "료", "묘", "뵤", "쇼", "요", "좌", "좌", "쵸", "좌", "퇴", "효",
				"구", "누", "두", "루", "무", "부", "수", "우", "주", "추", "쿠", "투", "푸", "후",
				"규", "뉴", "듀", "류", "뮤", "비", "시", "이", "지", "치", "키", "티", "피", "히",
				"기", "니", "디", "리", "미", "비", "시", "이", "지", "치", "키", "티", "피", "히",
				"그", "느", "드", "르", "므", "브", "스", "으", "즈", "츠", "크", "트", "프", "흐",
				"귀", "니"};
		
		for(int i =0; i < temp.length; i++) { 
			randomAlphabet.add(temp[i]); 
		}
		
		// 랜덤 글자 위치 하나 추출
		int randomNum = (int) (Math.random() * (randomAlphabet.size()));
		
		// 랜덤 글자로 bookInsert에서 검색
		ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
		bookVOS = bookInsert.bookInsert(randomAlphabet.get(randomNum));
		
		// 검색 결과가 없으면 재 검색
		while(bookVOS.size() == 0) {
			randomNum = (int) (Math.random() * (randomAlphabet.size()));
			bookVOS = bookInsert.bookInsert(randomAlphabet.get(randomNum));
		}
		
		// 검색 결과에서 하나의 결과만 랜덤 추출
		int bookRandomNum = (int) (Math.random() * (bookVOS.size()));
		BookVO bookVO = bookVOS.get(bookRandomNum);

		return bookVO;
	}

	
	// CKEditor 임시 저장용 
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		// 파일명 중복 방지!
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;    
		
		// ckeditor에서 올린(전송)한 파일을 서버 파일시스템에 실제로 저장처리시켜준다.
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		// 서버 파일시스템에 저장되어 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();		
		fos.close();
	}
	
//	
//	// 뉴스레터 전송
//	@Scheduled(cron = "0 19 11 * * 2")  
//	//@RequestMapping(value = "/booksletterMailAutoSend")
//	public void booksletterMailAutoSend(HttpServletRequest request) {
//		System.out.println("하이");
//		ArrayList<BooksletterVO> vos = autoUpdateDAO.getBooksletterList();
//		
//		for(int i=0; i<vos.size(); i++) {
//			
//			String title = "책(의)편지 뉴스레터";
//			
//			// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
//			MimeMessage message = mailSender.createMimeMessage();
//			
//			// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
//			try {
//				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
//				messageHelper.setTo(vos.get(i).getEmail());
//				
//				messageHelper.setSubject(title);
//				String content = "";
//				
//				// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
//				content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
//				content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>책(의)편지 뉴스레터를 보내드립니다.</h4><br>";
//				content += "<br><p><img src=\"cid:booksletter1.jpg\" width='500px'></p><br>";
//				content += "<br><p><img src=\"cid:booksletter2.jpg\" width='500px'></p><br>";
//				content += "<br><p><img src=\"cid:booksletter3.jpg\" width='500px'></p><br>";
//				content += "<br><h4>책(의)편지 관련 문의는 책(의)세계 <U>이메일</U> 혹은 (회원일 경우) <U>마이페이지 > 문의</U>에 남겨주세요:)</h4>";
//				content += "<br><h4>매주 새로운 소식으로 함께할 수 있어 영광입니다.</h4>";
//				content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
//				messageHelper.setText(content, true);
//				
//				// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
//				//HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
//				String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
//				File file1 = new File(realPath + "logo.png");		
//				File file2 = new File(realPath + "booksletter1.jpg");		
//				File file3 = new File(realPath + "booksletter2.jpg");		
//				File file4 = new File(realPath + "booksletter3.jpg");		
//				messageHelper.addInline("logo.png", file1);
//				messageHelper.addInline("booksletter1.jpg", file2);
//				messageHelper.addInline("booksletter2.jpg", file3);
//				messageHelper.addInline("booksletter3.jpg", file4);
//				
//				// 메일 전송
//				mailSender.send(message);
//			
//			} catch (MessagingException e) {
//				e.printStackTrace();
//			}
//		}
//			
//		
//	}
	
}
