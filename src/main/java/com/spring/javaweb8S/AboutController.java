package com.spring.javaweb8S;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.common.ImageManager;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.AboutService;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.NoticeVO;
import com.spring.javaweb8S.vo.ProductVO;

@Controller
@RequestMapping("/about")
public class AboutController {

	@Autowired
	AboutService aboutService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	ImageManager imageManager;
	
	@Autowired
	PageProcess pageProcess;

	
	// 책(의)세계란, 소개 창
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String aboutGet() {
		return "about/about";
	}
	
	// 소개 창, 뉴스레터를 위한 기존 등록 이메일 유무 확인 + 해당 별명들 가져오기
	@ResponseBody
	@RequestMapping(value = "/booksletterEmailCheck", method = RequestMethod.POST)
	public String[] booksletterEmailCheckPost(String email) {
		
		String[] memNicknameArray = aboutService.getNicknameListWithEmail(email);
		
		return memNicknameArray;
	}
	
	// 이미 뉴스레터 구독 중인지 확인
	@ResponseBody
	@RequestMapping(value = "/booksletterCheck", method = RequestMethod.POST)
	public String booksletterCheckPost(String email, 
			@RequestParam(name = "memNickname", defaultValue = "", required = false) String memNickname) {
		
		String booksletterDate = aboutService.getBooksletterCheck(email, memNickname);
		
		if(booksletterDate != null) return booksletterDate.substring(0,10);
		else return booksletterDate;
		
	}
	
	// 소개 창, 뉴스레터 등록
	@ResponseBody
	@RequestMapping(value = "/booksletterInsert", method = RequestMethod.POST)
	public String booksletterInsertPost(String email, String memNickname) {

		aboutService.getBooksletterInsert(email, memNickname);
		return "";
	}
	
	// 문의 등록창
	@RequestMapping(value = "/askInsert", method = RequestMethod.GET)
	public String booksletterInsertPost(Model model,
			@RequestParam(name = "category", defaultValue = "", required = false) String category,
			@RequestParam(name = "originIdx", defaultValue = "", required = false) String originIdx) {
		
		// 컬렉션상품 or 매거진 / 정기 구독의 경우 따로 originIdx 존재한다!
		if(!category.equals("") ) {

			if(category.equals("컬렉션상품")) {
				ProductVO productVO = aboutService.getProductInfo(originIdx);
				model.addAttribute("productVO", productVO);
			}
			else {
				MagazineVO magazineVO = aboutService.getMagazineInfo(originIdx);
				model.addAttribute("magazineVO", magazineVO);
			}
			
			model.addAttribute("category", category);
			model.addAttribute("originIdx", originIdx);
		}
		
		return "about/askInsert";
	}
	
	// 문의 등록창, 매거진 리스트(상세 카테고리용)
	@ResponseBody
	@RequestMapping(value = "/magazineSelectList", method = RequestMethod.POST)
	public String[] magazineSelectListPost(String maType) {
		
		String[] magazineTitleArray = aboutService.getMagazineTitle(maType);
		return magazineTitleArray;
	}
	
	// 문의 등록창, 컬렉션상품 리스트(상세 카테고리용)
	@ResponseBody
	@RequestMapping(value = "/productSelectList", method = RequestMethod.POST)
	public String[] productSelectListPost() {
		
		String[] productNameArray = aboutService.getProductName();
		return productNameArray;
	}
	
	// 문의 등록
	@RequestMapping(value = "/askInsert", method = RequestMethod.POST)
	public String askInsertPost(AskVO vo,
			@RequestParam(name = "returnPath", defaultValue = "", required = false) String returnPath,
			@RequestParam(name = "returnOriginIdx", defaultValue = "", required = false) String returnOriginIdx) throws UnsupportedEncodingException {
		
		// 비회원 비밀번호 암호화
		if(vo.getPwd() != null) vo.setPwd(passwordEncoder.encode(vo.getPwd()));

		// 공개, 비공개 처리
		if(vo.getSecret() == null) vo.setSecret("비공개");
		else vo.setSecret("공개");
		
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/ask/폴더에 저장시켜준다.
		imageManager.imgCheck(vo.getAskContent(), "ask");
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 ask폴더 경로로 변경한다.
		vo.setAskContent(vo.getAskContent().replace("/data/ckeditor/", "/data/ask/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = aboutService.setAskInsert(vo);
		
		if(returnPath.equals("")) {
			if(res != 0)  return "redirect:/message/aboutAskInsertOk";
			else return "redirect:/message/aboutAskInsertNo";
		}
		// 매거진 or 상품 상세창에서 왔다면, 다시 보내준다
		else {
			returnPath = URLEncoder.encode(returnPath, "UTF-8");
			returnOriginIdx = URLEncoder.encode(returnOriginIdx, "UTF-8");
			if(res != 0)  return "redirect:/message/aboutOriginAskInsertOk?returnPath="+returnPath+"&returnOriginIdx="+returnOriginIdx;
			else return "redirect:/message/aboutOriginAskInsertNo?returnPath="+returnPath+"&returnOriginIdx="+returnOriginIdx;
		}
	}
	
	// 문의 창, 문의 리스트
	@RequestMapping(value = "/ask", method = RequestMethod.GET)
	public String ask(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "askTitle", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
		
		// 전체 문의 내역
		// sort 에 들어올 수 있는 값: 전체, 답변완료, 답변전, 비공개, 공개
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "aboutAskSearch", sort+"/"+search, searchString);
		ArrayList<AskVO> vos = aboutService.getAskSearch(pageVO.getStartIndexNo(), pageSize, sort, search, searchString);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("sort", sort);
		
		return "about/ask";
	}
	
	// 문의 상세창
	@RequestMapping(value = "/askDetail", method = RequestMethod.GET)
	public String askDetailGet(int idx, Model model) {
		
		AskVO vo = aboutService.getAskDetail(idx);
		model.addAttribute("vo", vo);
		
		// 상품명 가져오기
		if(vo.getCategory().equals("컬렉션상품")) {
			vo.setOriginName(aboutService.getAskProdName(vo.getOriginIdx(), "컬렉션상품"));
		}
		else if((vo.getCategory().equals("매거진")) || (vo.getCategory().equals("정기구독"))) {
			vo.setOriginName(aboutService.getAskProdName(vo.getOriginIdx(), ""));
		}
		return "about/askDetail";
	}
	
	// 문의 수정창
	@RequestMapping(value = "/askUpdate", method = RequestMethod.GET)
	public String askUpdateGet(int idx, Model model) {
		
		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(ask)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		AskVO vo = aboutService.getAskDetail(idx);
		if(vo.getAskContent().indexOf("src=\"/") != -1) imageManager.imgCheckUpdate(vo.getAskContent(), "ask", 24);
		model.addAttribute("vo", vo);
		
		// 상품명 가져오기
		if(vo.getCategory().equals("컬렉션상품")) {
			vo.setOriginName(aboutService.getAskProdName(vo.getOriginIdx(), "컬렉션상품"));
		}
		else if((vo.getCategory().equals("매거진")) || (vo.getCategory().equals("정기구독"))) {
			vo.setOriginName(aboutService.getAskProdName(vo.getOriginIdx(), ""));
		}
		
		return "about/askUpdate";
	}
	
	// 문의 수정
	@RequestMapping(value = "/askUpdate", method = RequestMethod.POST)
	public String askUpdatePost(AskVO vo) {

		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
		AskVO originVO = aboutService.getAskDetail(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 내용을 수정처리한다.
		if(!originVO.getAskContent().equals(vo.getAskContent())) {
			
			// 실제로 수정하기 버튼을 클릭하게되면, 기존의 community폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
			if(originVO.getAskContent().indexOf("src=\"/") != -1) imageManager.imgDelete(originVO.getAskContent(), "ask", 24);
			
			// ask폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getAskContent()에 있는 그림파일경로 'ask'를 'ckeditor'경로로 변경해줘야한다.
			vo.setAskContent(vo.getAskContent().replace("/data/ask/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/ask/폴더에 저장시켜준다.
			imageManager.imgCheck(vo.getAskContent(), "ask");
			
			// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 ask폴더 경로로 변경한다.
			vo.setAskContent(vo.getAskContent().replace("/data/ckeditor/", "/data/ask/"));
		}
		
		// 비회원 비밀번호 암호화
		if(vo.getPwd() != null) vo.setPwd(passwordEncoder.encode(vo.getPwd()));

		// 공개, 비공개 처리
		if(vo.getSecret() == null) vo.setSecret("비공개");
		else vo.setSecret("공개");
		vo.setCategory("커뮤니티");
		
		int res = aboutService.setAskUpdate(vo);
		
		if(res != 0)  return "redirect:/message/aboutAskUpdateOk?idx="+vo.getIdx();
		else return "redirect:/message/aboutAskUpdateNo?idx="+vo.getIdx();
	}
	
	// 공지사항 리스트
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice(Model model,
			@RequestParam(name="search", defaultValue = "noticeTitle", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		// 전체 공지사항 내역
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "aboutNoticeSearch", search, searchString);
		ArrayList<NoticeVO> vos = aboutService.getNoticeSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		
		return "about/notice";
	}
	
	// 공지사항 상세창
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/noticeDetail", method = RequestMethod.GET)
	public String noticeDetailGet(HttpSession session, Model model, int idx) {
		
		// 공지사항 조회수 1씩 증가시키기(조회수 중복방지 - 세션처리('sNoticeIdx+고유번호'를 객체배열에 추가시켜준다.)
		ArrayList<String> noticeIdx = (ArrayList) session.getAttribute("sNoticeIdx");
		if(noticeIdx == null) {
			noticeIdx = new ArrayList<String>();
		}
		
		String tempNoticeIdx = "notice" + idx;
		if(!noticeIdx.contains(tempNoticeIdx)) {
			// 조회수 증가하기	
			aboutService.setNoticeViewUpdate(idx);
			noticeIdx.add(tempNoticeIdx);
		}
		session.setAttribute("sNoticeIdx", noticeIdx);
			
		NoticeVO vo = aboutService.getNoticeInfo(idx);
		model.addAttribute("vo", vo);
		
		return "about/noticeDetail";
	}
}
