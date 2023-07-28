package com.spring.javaweb8S;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.common.ImageManager;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.CommunityService;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BlockVO;
import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.InsSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;
import com.spring.javaweb8S.vo.ReportVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService communityService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BookInsertSearch bookInsert;
	
	@Autowired
	ImageManager imageManager;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;
	
	// 커뮤니티 가이드 창
	@RequestMapping(value = "/guide", method = RequestMethod.GET)
	public String guideGet() {
		return "community/guide";
	}
	
	// 커뮤니티 메인 창
	@RequestMapping(value = "/communityMain", method = RequestMethod.GET)
	public String communityMainGet(Model model, HttpSession session) {
		String nickname = (String) session.getAttribute("sNickname");
		
		// 랜덤 명언 띄우기
		int proverbNum = communityService.getProverbTotalNum();
		
		// 1 ~ 명언 총 개수 사이의 랜덤한 정수를 얻는다.
		int randomNum = (int) ((Math.random() * proverbNum) + 1);
		ProverbVO proverbVO = communityService.getRandomProverb(randomNum - 1);
		
		model.addAttribute("proverbVO", proverbVO);
		
		// 커뮤니티 메뉴에 띄울 회원 사진, 세션에 저장
		if(nickname != null) {
			MemberVO memberVO = communityService.getMemberInfo(nickname);
			model.addAttribute("memberVO", memberVO);
			session.setAttribute("sMemPhoto", memberVO.getMemPhoto());
		}
		
		// 최근 문장수집(10개)
		ArrayList<InspiredVO> inspiredVOS = communityService.getNewInspired(nickname);
		model.addAttribute("inspiredVOS", inspiredVOS);
		
		// 가장 많이 저장된 책(20개)
		ArrayList<BookVO> bookVOS = communityService.getPopularBook();
		model.addAttribute("bookVOS", bookVOS);

		// 최신 기록(10개)
		ArrayList<ReflectionVO> reflectionVOS = communityService.getNewReflection();
		model.addAttribute("reflectionVOS", reflectionVOS);
		
		return "community/communityMain";
	}
	
	// 커뮤니티 기록 창 (작성한 글 리스트 전부 가져가야 함)
	@RequestMapping(value = "/reflection", method = RequestMethod.GET)
	public String reflectionGet(Model model,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {

		PageVO pageVO = new PageVO();
		ArrayList<ReflectionVO> vos = new ArrayList<ReflectionVO>();
		
		// 검색어가 없다면, 전체를 보여준다.
		if(searchString.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "communityReflectionList", "", "");
			vos =	communityService.getReflectionList(pageVO.getStartIndexNo(), pageSize);
		}
		else {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "communityReflectionSearch", search, searchString);
			vos = communityService.getReflectionSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
			model.addAttribute("search", search);
			model.addAttribute("searchString", searchString);
		}
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		
		return "community/reflection";
	}
	
	
	// 커뮤니티 기록 남기기 창
	@RequestMapping(value = "/reflectionInsert", method = RequestMethod.GET)
	public String reflectionInsertGet() {
		return "community/reflectionInsert";
	}
	
	// 커뮤니티 기록 남기기 창에서, 도서 검색
	@RequestMapping(value = "/bookSelect", method = RequestMethod.GET)
	public String bookSelectGet(String searchString, Model model,
			 @RequestParam(name="title", defaultValue = "", required = false) String title,
			 @RequestParam(name="idx", defaultValue = "0", required = false) int idx) {
		
		ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
		
		try {
			bookVOS = bookInsert.bookInsert(searchString);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("bookVOS", bookVOS);
		model.addAttribute("searchString", searchString);

		// 책 검색 시, 사용
		model.addAttribute("title", title);
	
		
		// 기록 수정창
		if(idx != 0) {
			ReflectionVO vo = communityService.getReflectionDetail(idx);
			model.addAttribute("vo", vo);
			return "community/reflectionUpdate";
		}
		else {
			return "community/reflectionInsert";
		}
	}
	
	// 기록 등록
	@RequestMapping(value = "/reflectionInsert", method = RequestMethod.POST)
	public String reflectionInsertPost(ReflectionVO vo) {
		
		if(vo.getReplyOpen() == null) vo.setReplyOpen("0");
		else vo.setReplyOpen("1");
		
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
		imageManager.imgCheck(vo.getContent(), "community");
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 community폴더 경로로 변경한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/community/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = communityService.setReflectionInsert(vo);
		if(res != 0)  return "redirect:/message/reflectionInsertOk";
		else return "redirect:/message/reflectionInsertNo";
	}
	
	// (발표할 때 넣기!!!!!!!! 사랑훼 혜진앙)
	// 기록 상세창
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/reflectionDetail", method = RequestMethod.GET)
	public String reflectionDetailGet(int idx, HttpSession session,
			@RequestParam(name = "bookIdx", defaultValue = "0", required = false) int bookIdx,
			Model model) {
		
		// 글 조회수 1씩 증가시키기(조회수 중복방지 - 세션처리('reflection+고유번호'를 객체배열에 추가시켜준다.)
		ArrayList<String> reflectionIdx = (ArrayList) session.getAttribute("sReflectionIdx");
		if(reflectionIdx == null) {
			reflectionIdx = new ArrayList<String>();
		}
		
		String tempRefIdx = "reflection" + idx;
		if(!reflectionIdx.contains(tempRefIdx)) {
			// 조회수 증가하기	
			communityService.setRefViewUpdate(idx);
			reflectionIdx.add(tempRefIdx);
		}
		session.setAttribute("sReflectionIdx", reflectionIdx);
		
		
		ReflectionVO vo = communityService.getReflectionDetail(idx);
		model.addAttribute("vo", vo);
		
		// 댓글
		ArrayList<ReplyVO> replyVOS = communityService.getReply(idx);
		
		// 대댓글일 경우, 처리
		ArrayList<ReplyVO> tempReplyVOS = new ArrayList<ReplyVO>();
		
		for(int i=0; i<replyVOS.size(); i++) {
			if(replyVOS.get(i).getMentionedNickname() != null) {
				tempReplyVOS.add(replyVOS.get(i));	
			}
		}
		
		// 원본 댓글 내용 가져온다
		ArrayList<ReplyVO> tempOriginVOS = new ArrayList<ReplyVO>();
		
		if(tempReplyVOS.size() != 0) {
			tempOriginVOS = communityService.getReReplyOriginContent(tempReplyVOS);
		}
		
		// 가져온 원본 댓글의 내용을 담는다
		for(int i=0; i<tempOriginVOS.size(); i++) {

			for(int j=0; j<replyVOS.size(); j++) {
				if(replyVOS.get(j).getOriginIdx() == tempOriginVOS.get(i).getIdx()) {
					
					ReplyVO tempVO = new ReplyVO();
					tempVO = replyVOS.get(j);
					tempVO.setOriginContent(tempOriginVOS.get(i).getContent());
					tempVO.setOriginEdit(tempOriginVOS.get(i).getEdit());
				}
			}
		}
		
		model.addAttribute("replyVOS", replyVOS);
		model.addAttribute("replyNum", replyVOS.size());
		
		String nickname = (String) session.getAttribute("sNickname");
		
		if(bookIdx != 0) {
			// 문장수집
			ArrayList<InspiredVO> inspiredVOS = communityService.getInspired(bookIdx, nickname);
			model.addAttribute("inspiredVOS", inspiredVOS);
			model.addAttribute("inspiredNum", inspiredVOS.size());
		}
		
		// 저장유무 
		if(nickname != null) {
			RefSaveVO saveVO = communityService.getRefSave(idx, nickname);
			model.addAttribute("saveVO", saveVO);
		}
		
		return "community/reflectionDetail";
	}
	
	// 커뮤니티 기록 상세창에서 댓글 작성
	@ResponseBody
	@RequestMapping(value = "/replyInsert", method = RequestMethod.POST)
	public String replyInsertGet(ReplyVO vo) {
		
		// 해당 기록 댓글의 최대 그룹 ID 가져오기
		String groupId = communityService.getMaxGroupId(vo.getRefIdx());
		if(groupId != null) vo.setGroupId(Integer.parseInt(groupId)+1);
		else vo.setGroupId(0);
		vo.setLevel(0);
		
		communityService.setReplyInsert(vo);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서 대댓글 작성
	@ResponseBody
	@RequestMapping(value = "/reReplyInsert", method = RequestMethod.POST)
	public String reReplyInsertPost(ReplyVO vo) {
		
		vo.setLevel(vo.getLevel()+1);
		communityService.setReplyInsert(vo);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서 댓글 수정
	@ResponseBody
	@RequestMapping(value = "/replyUpdate", method = RequestMethod.POST)
	public String replyUpdatePost(ReplyVO vo) {
		
		communityService.setReplyUpdate(vo);
		return "";
	}

	// 커뮤니티 기록 상세창에서 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
	public String replyDeletePost(ReplyVO vo) {
		
		communityService.setReplyDelete(vo);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 기록 저장
	@ResponseBody
	@RequestMapping(value = "/refSave", method = RequestMethod.POST)
	public String refSavePost(RefSaveVO vo) {
		
		communityService.setRefSave(vo.getRefIdx(), vo.getMemNickname());
		communityService.setRefSaveUpdate(vo.getRefIdx(), 1);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 기록 저장 취소
	@ResponseBody
	@RequestMapping(value = "/refSaveDelete", method = RequestMethod.POST)
	public String refSaveDeletePost(RefSaveVO vo) {
		
		communityService.setRefSaveDelete(vo.getRefIdx(), vo.getMemNickname());
		communityService.setRefSaveUpdate(vo.getRefIdx(), -1);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 문장 수집 추가
	@ResponseBody
	@RequestMapping(value = "/inspiredInsert", method = RequestMethod.POST)
	public String inspiredInsertPost(InspiredVO vo) {
		
		communityService.setInspiredInsert(vo);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 문장 수집 저장 
	@ResponseBody
	@RequestMapping(value = "/insSave", method = RequestMethod.POST)
	public String inspiredInsertPost(InsSaveVO vo) {
		
		communityService.setInsSave(vo.getInsIdx(), vo.getMemNickname());
		communityService.setInsSaveUpdate(vo.getInsIdx(), 1);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 문장 수집 저장 취소
	@ResponseBody
	@RequestMapping(value = "/insSaveDelete", method = RequestMethod.POST)
	public String insSaveDeletePost(InsSaveVO vo) {
		
		communityService.setInsSaveDelete(vo.getIdx());
		communityService.setInsSaveUpdate(vo.getInsIdx(), -1);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 문장 수집 삭제
	@ResponseBody
	@RequestMapping(value = "/inspiredDelete", method = RequestMethod.POST)
	public String inspiredDeletePost(int idx) {
		
		communityService.setInspiredDelete(idx);
		
		// 해당 문장 수집을 저장한 경우 모두 삭제
		communityService.setInsSaveForcedDelete(idx);
		return "";
	}
	
	// 커뮤니티 기록 상세창에서, 문장 수집 수정
	@ResponseBody
	@RequestMapping(value = "/inspiredUpdate", method = RequestMethod.POST)
	public String inspiredUpdatePost(InspiredVO vo) {
		
		communityService.setInspiredUpdate(vo);
		
		return "";
	}
	
	// 커뮤니티 기록 수정창
	@RequestMapping(value = "/reflectionUpdate", method = RequestMethod.GET)
	public String inspiredUpdateGet(int idx, Model model) {
		
		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(board)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		ReflectionVO vo = communityService.getReflectionDetail(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) imageManager.imgCheckUpdate(vo.getContent(), "community", 30);
		
		model.addAttribute("vo", vo);
		return "community/reflectionUpdate";
	}
	
	// 커뮤니티 기록 수정창에서 책 변경 
	@RequestMapping(value = "/refBookUpdate", method = RequestMethod.GET)
	public String refBookUpdateGet(String publisher, String bookTitle, int idx) {
		
		int res = communityService.setRefBookUpdate(publisher, bookTitle, idx);
		
		if(res != 0)  return "redirect:/message/refBookUpdateOk?idx="+idx;
		else return "redirect:/message/refBookUpdateNo?idx="+idx;
	}
	
	// 커뮤니티 기록 수정
	@RequestMapping(value = "/reflectionUpdate", method = RequestMethod.POST)
	public String reflectionUpdatePost(ReflectionVO vo) {
		
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
		ReflectionVO originVO = communityService.getReflectionDetail(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 내용을 수정처리한다.
		if(!originVO.getContent().equals(vo.getContent())) {
			
			// 실제로 수정하기 버튼을 클릭하게되면, 기존의 community폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
			if(originVO.getContent().indexOf("src=\"/") != -1) imageManager.imgDelete(originVO.getContent(), "community", 30);
			
			// board폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getContent()에 있는 그림파일경로 'community'를 'ckeditor'경로로 변경해줘야한다.
			vo.setContent(vo.getContent().replace("/data/community/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
			imageManager.imgCheck(vo.getContent(), "community");
			
			// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 community폴더 경로로 변경한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/community/"));
		}
		
		
		if(vo.getReplyOpen() == null) vo.setReplyOpen("0");
		else vo.setReplyOpen("1");
		
		int res = communityService.setReflectionUpdate(vo);
		
		if(res != 0)  return "redirect:/message/reflectionUpdateOk?idx="+vo.getIdx();
		else return "redirect:/message/reflectionUpdateNo?idx="+vo.getIdx();
	}
	
	// 커뮤니티 기록 상세창에서 기록 삭제
	@Transactional
	@RequestMapping(value = "/reflectionDelete", method = RequestMethod.GET)
	public String reflectionDeleteGet(int idx) {
		
		// 기록에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		ReflectionVO vo = communityService.getReflectionDetail(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) imageManager.imgDelete(vo.getContent(), "community", 30);
		
		// 기록 삭제
		int res = communityService.setReflectionDelete(idx);
		
		// 해당 기록을 저장한 경우 모두 삭제
		communityService.setRefSaveForcedDelete(idx);
		
		// 해당 기록에 달린 댓글 삭제
		communityService.setReplyForcedDelete(idx);
		
		if(res != 0)  return "redirect:/message/reflectionDeleteOk";
		else return "redirect:/message/reflectionDeleteNo?idx="+idx;
	}
	
	
	// 커뮤니티 기록 상세창, 신고
	@ResponseBody
	@RequestMapping(value = "/reportInsert", method = RequestMethod.POST)
	public String reportInsertPosrt(ReportVO vo) {
		
		communityService.setReportInsert(vo);
		return "";
	}
	
	// 커뮤니티 마이페이지 메인창(서재, 문장수집)
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPageGet(String memNickname, Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,  // 책 검색용
			@RequestParam(name="inspiredSearchString", defaultValue = "", required = false) String inspiredSearchString,  // 문장수집 첵 검색용
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		// 차단 정보
		if(nickname != null) {
			if(!nickname.equals(memNickname)) {
				String blockedNickname = memNickname;
				BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
				model.addAttribute("blockVO", blockVO);
			}
		}
		
		// (서재) 카테고리별 책 저장
		ArrayList<BookSaveVO> bookSave1VOS = communityService.getBookSave("인생책", memNickname, "myPage");
		ArrayList<BookSaveVO> bookSave2VOS = communityService.getBookSave("추천책", memNickname, "myPage");
		ArrayList<BookSaveVO> bookSave3VOS = communityService.getBookSave("읽은책", memNickname, "myPage");
		ArrayList<BookSaveVO> bookSave4VOS = communityService.getBookSave("관심책", memNickname, "myPage");
		
		model.addAttribute("bookSave1VOS", bookSave1VOS);
		model.addAttribute("bookSave2VOS", bookSave2VOS);
		model.addAttribute("bookSave3VOS", bookSave3VOS);
		model.addAttribute("bookSave4VOS", bookSave4VOS);
		
		model.addAttribute("bookSave1VOSNum", bookSave1VOS.size());
		model.addAttribute("bookSave2VOSNum", bookSave2VOS.size());
		model.addAttribute("bookSave3VOSNum", bookSave3VOS.size());
		model.addAttribute("bookSave4VOSNum", bookSave4VOS.size());
		// 새 소식
	
		// 문장 수집 + 저장 유무도 가져오기
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageInspired", memNickname, "");
		ArrayList<InspiredVO> inspiredVOS = communityService.getMemInspired(pageVO.getStartIndexNo(), pageSize, memNickname, nickname);
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("inspiredVOS", inspiredVOS);
		
		// 책 검색
		if(!searchString.equals("")) {
			ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
			
			try {
				bookVOS = bookInsert.bookInsert(searchString);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			model.addAttribute("bookVOS", bookVOS);
			model.addAttribute("searchString", searchString);
		}
		
		// 문장수집용 책 검색
		if(!inspiredSearchString.equals("")) {
			ArrayList<BookVO> insBookVOS = new ArrayList<BookVO>();
			
			try {
				insBookVOS = bookInsert.bookInsert(inspiredSearchString);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			model.addAttribute("insBookVOS", insBookVOS);
			model.addAttribute("inspiredSearchString", inspiredSearchString);
		}
		
		return "community/myPage";
	}
	
	
	// 커뮤니티 마이페이지 메인창에서, 문장수집 추가
	@ResponseBody
	@RequestMapping(value = "/inspiredInsertMyPage", method = RequestMethod.POST)
	public String inspiredInsertMyPagePost(InspiredVO vo) {
		
		communityService.setInspiredInsertMyPage(vo);
		return "";
	}
	
	
	// 커뮤니티 마이페이지 메인창에서, 책 저장 추가
	@ResponseBody
	@RequestMapping(value = "/bookSaveInsert", method = RequestMethod.POST)
	public String bookSaveInsertPost(BookSaveVO vo) {
		
		communityService.setBookSaveInsert(vo);
		
		int idx = communityService.getBookIdx(vo.getTitle(), vo.getPublisher());
		
		// 책 테이블 저장 등록 수 변경
		communityService.setBookSaveNumUpdate(idx, 1);
		
		return "";
	}
	
	// 커뮤니티 마이페이지 메인창에서, 책 저장 카테고리 변경
	@ResponseBody
	@RequestMapping(value = "/bookSaveCategoryChange", method = RequestMethod.POST)
	public String bookSaveCategoryChangePost(BookSaveVO vo) {
		// 책 저장 삭제
		communityService.setBookSaveDelete(vo.getIdx());
		// 책 저장 카테고리 변경
		communityService.setBookSaveCategoryChange(vo);
		return "";
	}
	
	// 커뮤니티 마이페이지 메인창에서, 책 저장 삭제
	@ResponseBody
	@RequestMapping(value = "/bookSaveDelete", method = RequestMethod.POST)
	public String bookSaveDeletePost(int idx, int bookIdx) {
		
		communityService.setBookSaveDelete(idx);
		
		// 책 테이블 저장 등록 수 변경
		communityService.setBookSaveNumUpdate(bookIdx, -1);
		return "";
	}
	
	
	// 커뮤니티 마이페이지 기록창(검색 가능)
	@RequestMapping(value = "/myPage/reflection", method = RequestMethod.GET)
	public String myPageReflectionGet(String memNickname, Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		
		// 차단 정보
		if(nickname != null) {
			if(!nickname.equals(memNickname)) {
				String blockedNickname = memNickname;
				BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
				model.addAttribute("blockVO", blockVO);
			}
		}
		
		
		// 새 소식
	
		
		// 기록 
		PageVO pageVO = new PageVO();
		ArrayList<ReflectionVO> vos = new ArrayList<ReflectionVO>();
		
		// 검색어가 없다면, 전체를 보여준다.
		if(searchString.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageReflectionList", memNickname, "");
			vos =	communityService.getMemReflectionList(pageVO.getStartIndexNo(), pageSize, memNickname);
		}
		else {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageReflectionSearch", memNickname+"/"+search, searchString);
			vos = communityService.getMemReflectionSearch(pageVO.getStartIndexNo(), pageSize, memNickname, search, searchString);
			model.addAttribute("search", search);
			model.addAttribute("searchString", searchString);
		}
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		
		return "community/myPage/reflection";
	}
	
	// 커뮤니티 마이페이지 댓글창
	@RequestMapping(value = "/myPage/reply", method = RequestMethod.GET)
	public String myPageReflectionGet(String memNickname, 
			Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		// 차단 정보
		if(nickname != null) {
			if(!nickname.equals(memNickname)) {
				String blockedNickname = memNickname;
				BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
				model.addAttribute("blockVO", blockVO);
			}
		}
		
		
		// 새 소식
		
		
		// 댓글 
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageReplyList", memNickname, "");
		ArrayList<ReplyVO> vos =	communityService.getMemReplyList(pageVO.getStartIndexNo(), pageSize, memNickname);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		
		// 작성 문의
		
		
		return "community/myPage/reply";
	}
	
	// 회원 차단
	@ResponseBody
	@RequestMapping(value = "/blockInsert", method = RequestMethod.POST)
	public String blockInsertPost(BlockVO vo) {
		
		communityService.setBlockInsert(vo);
		return "";
	}
	
	// 회원 차단 해제
	@ResponseBody
	@RequestMapping(value = "/blockDelete", method = RequestMethod.POST)
	public String blockDeletePost(BlockVO vo) {
		
		communityService.setBlockDelete(vo);
		return "";
	}
	
	// 커뮤니티 마이페이지 회원정보 창 (해당 페이지 주인만 들어갈 수 있음!)
	@RequestMapping(value = "/myPage/memInfo", method = RequestMethod.GET)
	public String myPageInfoGet(String memNickname, Model model, HttpSession session) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 차단 리스트
		ArrayList<BlockVO> blockVOS = communityService.getBlockList(memNickname);
		model.addAttribute("blockVOS", blockVOS);
		
		return "community/myPage/memInfo";
	}
	
	// 커뮤니티 마이페이지 회원정보 창에서 프로필 사진 변경
	@RequestMapping(value = "/myPage/memPhotoUpdate", method = RequestMethod.POST)
	public String myPagePhotoUpdatePost(MultipartFile file, MemberVO vo, 
			String defaultPhoto, HttpSession session,
			@RequestParam(name = "flag", defaultValue = "", required = false) String flag) throws UnsupportedEncodingException {
		
		int res = 0;
		
		if(defaultPhoto.equals("defaultPhotoNone")) {
			res = communityService.setMemPhotoUpdate(file, vo);
			
			String memPhotoFileName = file.getOriginalFilename();
			session.setAttribute("sMemPhoto", memPhotoFileName);
		}
		else {
			vo.setMemPhoto(defaultPhoto);
			res = communityService.setMemDefaultPhotoUpdate(vo);
			session.setAttribute("sMemPhoto", defaultPhoto);
		}
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		if(flag.equals("")) {
			if(res != 0) return "redirect:/message/memPhotoUpdateOk?nickname=" + nickname;
			else return "redirect:/message/memPhotoUpdateNo?nickname=" + nickname;
		}
		else {
			if(res != 0) return "redirect:/message/adminMemPhotoUpdateOk?nickname=" + nickname;
			else return "redirect:/message/adminMemPhotoUpdateNo?nickname=" + nickname;
		}
		
	}
	
	// 커뮤니티 마이페이지 회원정보 창에서 소개글 수정
	@ResponseBody
	@RequestMapping(value = "/introductionUpdate", method = RequestMethod.POST)
	public String introductionUpdatePost(String introduction, String nickname) {
		
		communityService.setIntroductionUpdate(introduction, nickname);
		return "";
	}
	
	// 커뮤니티 마이페이지 회원정보 창에서, 차단할 회원 검색
	@ResponseBody
	@RequestMapping(value = "/blockMemSearch", method = RequestMethod.POST)
	public ArrayList<MemberVO> blockMemSearchPost(String searchString, String memNickname) {
		
		ArrayList<MemberVO> searchVOS = communityService.getMemberSearchList(searchString, memNickname);
		
		return searchVOS;
	}
	
	// 커뮤니티 마이페이지 문의/신고 창 중에 문의 (검색 가능)
	@RequestMapping(value = "/myPage/ask", method = RequestMethod.GET)
	public String myPageAskGet(String memNickname, Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "제목", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 문의 내역
		// sort 에 들어올 수 있는 값: 전체, 답변완료, 답변전, 비공개, 공개
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageAskSearch", memNickname+"/"+sort+"/"+search, searchString);
		ArrayList<AskVO> vos = communityService.getMemAskSearch(pageVO.getStartIndexNo(), pageSize, memNickname, sort, search, searchString);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("askNum", vos.size());
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("sort", sort);
		
		
		return "community/myPage/ask";
	}
	
	// 커뮤니티 마이페이지 문의/신고 창 중에, 문의 복수 삭제
	@ResponseBody
	@RequestMapping(value = "/askIdxesDelete", method = RequestMethod.POST)
	public String askIdxesDeletePost(String checkRow) {
		
		List<String> askList = new ArrayList<String>();
		String[] checkedAskIdxes = checkRow.split(",");
		
		for(int i=0; i < checkedAskIdxes.length; i++){
			askList.add(checkedAskIdxes[i].toString());
		}
		
		// 삭제할 문의 내용 가져오기
		ArrayList<AskVO> askDeleteList = communityService.getAskList(askList);
		
		// 문의에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		for(int i=0; i<askDeleteList.size(); i++) {
			AskVO vo = askDeleteList.get(i);
			if(vo.getAskContent().indexOf("src=\"/") != -1) imageManager.imgDelete(vo.getAskContent(), "ask", 24);
		}

		// DB에서 삭제
		communityService.setAskIdxesDelete(askList);
		
		return "";
	}	
	
	// 커뮤니티 마이페이지 문의/신고 창 중에, 신고 창
	@RequestMapping(value = "/myPage/report", method = RequestMethod.GET)
	public String myPageReportGet(String memNickname, Model model,
			@RequestParam(name = "sort", defaultValue = "전체", required = false) String sort) {

		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 신고 내역
		ArrayList<ReportVO> vos = communityService.getMemReportList(memNickname, sort);
		model.addAttribute("vos", vos);
		model.addAttribute("reportNum", vos.size());
		model.addAttribute("sort", sort);
		
		// 처리 전 상태인 신고 개수
		int reportYetDoneNum = 0;
		
		// 품절 상품 개수
		for(int i=0; i<vos.size(); i++) {
			if(vos.get(i).getReportDone().equals("처리 전")) reportYetDoneNum++;
		}
		model.addAttribute("reportYetDoneNum", reportYetDoneNum);
		
		return "community/myPage/report";
	}	
	

	// 커뮤니티 마이페이지 문의/신고 창 중에, 신고 복수 삭제
	@ResponseBody
	@RequestMapping(value = "/reportIdxesDelete", method = RequestMethod.POST)
	public String reportIdxesDeletePost(String checkRow) {
		
		List<String> reportList = new ArrayList<String>();
		String[] checkedReportIdxes = checkRow.split(",");
		
		for(int i=0; i < checkedReportIdxes.length; i++){
			reportList.add(checkedReportIdxes[i].toString());
		}

		// DB에서 삭제
		communityService.setReportIdxesDelete(reportList);
		
		return "";
	}	
	
	// 문의 창
	@RequestMapping(value = "/ask", method = RequestMethod.GET)
	public String ask(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "제목", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
		
		// 전체 문의 내역
		// sort 에 들어올 수 있는 값: 전체, 답변완료, 답변전, 비공개, 공개
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "communityAskSearch", sort+"/"+search, searchString);
		ArrayList<AskVO> vos = communityService.getAskSearch(pageVO.getStartIndexNo(), pageSize, sort, search, searchString);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("sort", sort);
		
		return "community/ask";
	}
	
	
	// 커뮤니티 문의 남기기 창
	@RequestMapping(value = "/askInsert", method = RequestMethod.GET)
	public String askInsertGet() {
		return "community/askInsert";
	}
	
	// 문의 등록
	@RequestMapping(value = "/askInsert", method = RequestMethod.POST)
	public String askInsertPost(AskVO vo,
			@RequestParam(name = "returnPath", defaultValue = "", required = false) String returnPath) throws UnsupportedEncodingException {
		
		// 비회원 비밀번호 암호화
		if(vo.getPwd() != null) vo.setPwd(passwordEncoder.encode(vo.getPwd()));

		// 공개, 비공개 처리
		if(vo.getSecret() == null) vo.setSecret("비공개");
		else vo.setSecret("공개");
		vo.setCategory("커뮤니티");
		
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/ask/폴더에 저장시켜준다.
		imageManager.imgCheck(vo.getAskContent(), "ask");
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 ask폴더 경로로 변경한다.
		vo.setAskContent(vo.getAskContent().replace("/data/ckeditor/", "/data/ask/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = communityService.setAskInsert(vo);
		
		if(returnPath.equals("")) {
			if(res != 0)  return "redirect:/message/askInsertOk";
			else return "redirect:/message/askInsertNo";
		}
		// 마이페이지에서 왔다면, 다시 보내준다
		else {
			String nickname = URLEncoder.encode(vo.getMemNickname(), "UTF-8");
			if(res != 0)  return "redirect:/message/communityMypageAskInsertOk?nickname="+nickname;
			else return "redirect:/message/communityMypageAskInsertNo";
		}
	}
	
	// 문의 상세창
	@RequestMapping(value = "/askDetail", method = RequestMethod.GET)
	public String askDetailGet(int idx, Model model) {
		
		AskVO vo = communityService.getAskDetail(idx);
		model.addAttribute("vo", vo);
		
		return "community/askDetail";
	}
	
	// 문의 상세창 들어가기 전, 비회원 비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "/askPwdCheck", method = RequestMethod.POST)
	public String askPwdCheckPost(String pwd, String ans) {
		
		if(!passwordEncoder.matches(ans, pwd)) {
			return "0";
		}
		else {
			return "1";
		}
	}
	
	// 문의 수정창
	@RequestMapping(value = "/askUpdate", method = RequestMethod.GET)
	public String askUpdateGet(int idx, Model model) {
		
		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(ask)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		AskVO vo = communityService.getAskDetail(idx);
		if(vo.getAskContent().indexOf("src=\"/") != -1) imageManager.imgCheckUpdate(vo.getAskContent(), "ask", 24);
		
		model.addAttribute("vo", vo);
		
		return "community/askUpdate";
	}
	
	// 문의 수정
	@RequestMapping(value = "/askUpdate", method = RequestMethod.POST)
	public String askUpdatePost(AskVO vo) {
		
			// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
			AskVO originVO = communityService.getAskDetail(vo.getIdx());
			
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
			
			int res = communityService.setAskUpdate(vo);
			
			if(res != 0)  return "redirect:/message/askUpdateOk?idx="+vo.getIdx();
			else return "redirect:/message/askUpdateNo?idx="+vo.getIdx();
	}
	
	// 문의 삭제
	@RequestMapping(value = "/askDelete", method = RequestMethod.GET)
	public String askDeleteGet(int idx,
			@RequestParam(name = "flag", defaultValue = "", required = false) String flag) {

		// 문의에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		AskVO vo = communityService.getAskDetail(idx);
		if(vo.getAskContent().indexOf("src=\"/") != -1) imageManager.imgDelete(vo.getAskContent(), "ask", 24);
		
		// 문의 삭제
		int res = communityService.setAskDelete(idx);
		if(flag.equals("")) {
			if(res != 0)  return "redirect:/message/askDeleteOk";
			else return "redirect:/message/askDeleteNo?idx="+idx;
		}
		else {
			// 책(의)세계 문의 삭제의 경우!
			if(res != 0)  return "redirect:/message/aboutAskDeleteOk";
			else return "redirect:/message/aboutAskDeleteNo?idx="+idx;
		}
	}

	// 문의 답변 달기
	@ResponseBody
	@RequestMapping(value = "/answerInsert", method = RequestMethod.POST)
	public String answerInsertPost(int idx, String answer, HttpServletRequest request) throws MessagingException {
		
		// 답변 등록
		communityService.setAnswerInsert(idx, answer);

		// 이메일
		AskVO vo = communityService.getAskDetail(idx);
		String email = "";
		if(vo.getMemNickname() != null) {
			MemberVO memberVO = communityService.getMemberInfo(vo.getMemNickname());
			email = memberVO.getEmail();
		}
		else email = vo.getEmail();
		
		System.out.println("email : " + email);
		
		// 이메일 전송! + 이거 나중에 링크 바꿔서 달아주기! 49.142.157.251 그거로
		String title = "[3개의 책] 문의 답변이 등록되었습니다.";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		String content = "";
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
		content += "<br><h4>안녕하세요. 책(의)세계입니다.<br>작성하신 [3개의 책] 커뮤니티 문의에 답변이 등록되었습니다.</h4>";
		content += "<br><h5>문의 제목) "+vo.getAskTitle()+"</h5>";
		content += "<br><hr><a href=\"http://localhost:9090/javaweb8S/community/askDetail?idx="+vo.getIdx()+"\"><h2><font color='blue'>바로 확인하기</font></h2></a><br>";
		content += "<br><h4>추가 문의는 3개의 책 문의창에 남겨주세요.</h4>";
		content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		File file = new File(realPath + "logo.png");		
		messageHelper.addInline("logo.png", file);

		// 메일 전송
		mailSender.send(message);
		
		return "";
	}
	
	// 문의 답변 수정
	@ResponseBody
	@RequestMapping(value = "/answerUpdate", method = RequestMethod.POST)
	public String answerUpdatePost(int idx, String answer) {
		
		// 답변 등록
		communityService.setAnswerInsert(idx, answer);
		
		return "";
	}
	
	// 회원 창 메인(팝업)
	@RequestMapping(value = "/memPage", method = RequestMethod.GET)
	public String memPageGet(String memNickname, Model model, HttpSession session) {
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// (서재) 카테고리별 책 저장 (5개씩 가져오기)
		ArrayList<BookSaveVO> bookSave1VOS = communityService.getBookSave("인생책", memNickname, "memPage");
		ArrayList<BookSaveVO> bookSave2VOS = communityService.getBookSave("추천책", memNickname, "memPage");
		ArrayList<BookSaveVO> bookSave3VOS = communityService.getBookSave("읽은책", memNickname, "memPage");
		ArrayList<BookSaveVO> bookSave4VOS = communityService.getBookSave("관심책", memNickname, "memPage");
		
		model.addAttribute("bookSave1VOS", bookSave1VOS);
		model.addAttribute("bookSave2VOS", bookSave2VOS);
		model.addAttribute("bookSave3VOS", bookSave3VOS);
		model.addAttribute("bookSave4VOS", bookSave4VOS);
		
		// 문장 수집 (5개씩 가져오기)
		String nickname = (String) session.getAttribute("sNickname");
		ArrayList<InspiredVO> inspiredVOS = communityService.getMemPageInspired(memNickname, nickname);
		model.addAttribute("inspiredVOS", inspiredVOS);

		return "community/memPage";
	}
	
	// 회원 창 기록(팝업)
	@RequestMapping(value = "/memPage/reflection", method = RequestMethod.GET)
	public String memPagereflectionGet(String memNickname, Model model, HttpSession session) {
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 기록  (10개씩 가져오기)
		ArrayList<ReflectionVO> vos = communityService.getMemPageReflection(memNickname);
		model.addAttribute("vos", vos);
		
		return "community/memPage/reflection";
	}

	// 책 상세창(팝업)
	@RequestMapping(value = "/bookPage", method = RequestMethod.GET)
	public String bookPageGet(int idx, Model model) {
	
		// 책 정보
		BookVO bookVO = communityService.getBookInfo(idx);
		model.addAttribute("bookVO", bookVO);
		
		// (서재) 카테고리별 책 저장한 회원
		ArrayList<BookSaveVO> bookSave1VOS = communityService.getMemBookSave("인생책", idx);
		ArrayList<BookSaveVO> bookSave2VOS = communityService.getMemBookSave("추천책", idx);
		ArrayList<BookSaveVO> bookSave3VOS = communityService.getMemBookSave("읽은책", idx);
		ArrayList<BookSaveVO> bookSave4VOS = communityService.getMemBookSave("관심책", idx);
		
		model.addAttribute("bookSave1VOS", bookSave1VOS);
		model.addAttribute("bookSave2VOS", bookSave2VOS);
		model.addAttribute("bookSave3VOS", bookSave3VOS);
		model.addAttribute("bookSave4VOS", bookSave4VOS);

		model.addAttribute("bookSave1VOSNum", bookSave1VOS.size());
		model.addAttribute("bookSave2VOSNum", bookSave2VOS.size());
		model.addAttribute("bookSave3VOSNum", bookSave3VOS.size());
		model.addAttribute("bookSave4VOSNum", bookSave4VOS.size());
		
		// 작성된 기록
		ArrayList<ReflectionVO> vos = communityService.getBookReflection(idx);
		model.addAttribute("vos", vos);
		
		// 수집된 문장
		
		
		return "community/bookPage";
	}
	
	// 책 상세창(팝업) + 문장수집
	@RequestMapping(value = "/bookPage/inspired", method = RequestMethod.GET)
	public String bookPageInspiredGet(int idx, Model model, HttpSession session) {
		
		// 책 정보
		BookVO bookVO = communityService.getBookInfo(idx);
		model.addAttribute("bookVO", bookVO);
		
		// 수집된 문장
		String nickname = (String) session.getAttribute("sNickname");
		ArrayList<InspiredVO> inspiredVOS = communityService.getBookPageInspired(nickname, idx);
		model.addAttribute("inspiredVOS", inspiredVOS);
		
		return "community/bookPage/inspired";
	}
	
}
