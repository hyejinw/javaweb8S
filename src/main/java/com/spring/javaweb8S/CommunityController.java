package com.spring.javaweb8S;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.CommunityService;
import com.spring.javaweb8S.vo.BlockVO;
import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.InsSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
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
	
	
	// 커뮤니티 가이드 창
	@RequestMapping(value = "/guide", method = RequestMethod.GET)
	public String guideGet() {
		return "community/guide";
	}
	
	// 커뮤니티 메인 창
	@RequestMapping(value = "/communityMain", method = RequestMethod.GET)
	public String communityMainGet(Model model, HttpSession session) {
		String nickname = (String) session.getAttribute("sNickname");
		
		// 커뮤니티 메뉴에 띄울 회원 사진, 세션에 저장
		if(nickname != null) {
			MemberVO memberVO = communityService.getMemberInfo(nickname);
			model.addAttribute("memberVO", memberVO);
			session.setAttribute("sMemPhoto", memberVO.getMemPhoto());
		}
		
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
		communityService.imgCheck(vo.getContent());
		
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
	public String replyDeletePost(int idx) {
		
		communityService.setReplyDelete(idx);
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
		if(vo.getContent().indexOf("src=\"/") != -1) communityService.imgCheckUpdate(vo.getContent());
		
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
			if(originVO.getContent().indexOf("src=\"/") != -1) communityService.imgDelete(originVO.getContent());
			
			// board폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getContent()에 있는 그림파일경로 'community'를 'ckeditor'경로로 변경해줘야한다.
			vo.setContent(vo.getContent().replace("/data/community/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
			communityService.imgCheck(vo.getContent());
			
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
		if(vo.getContent().indexOf("src=\"/") != -1) communityService.imgDelete(vo.getContent());
		
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
	@RequestMapping(value = "/communityMyPage", method = RequestMethod.GET)
	public String communityMyPageGet(String memNickname, Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,  // 책 검색용
			@RequestParam(name="inspiredSearchString", defaultValue = "", required = false) String inspiredSearchString,  // 문장수집 첵 검색용
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		// 차단 정보
		if(!nickname.equals(memNickname)) {
			String blockedNickname = memNickname;
			BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
			model.addAttribute("blockVO", blockVO);
		}
		
		// (서재) 카테고리별 책 저장
		ArrayList<BookSaveVO> bookSave1VOS = communityService.getBookSave("인생책", memNickname);
		ArrayList<BookSaveVO> bookSave2VOS = communityService.getBookSave("추천책", memNickname);
		ArrayList<BookSaveVO> bookSave3VOS = communityService.getBookSave("읽은책", memNickname);
		ArrayList<BookSaveVO> bookSave4VOS = communityService.getBookSave("관심책", memNickname);
		
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
		
		return "community/communityMyPage";
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
	public String bookSaveDeletePost(int idx) {
		
		communityService.setBookSaveDelete(idx);
		return "";
	}
	
	
	// 커뮤니티 마이페이지 기록창(검색 가능)
	@RequestMapping(value = "/communityMyPage/reflection", method = RequestMethod.GET)
	public String communityMyPageReflectionGet(String memNickname, Model model, HttpSession session,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		// 차단 정보
		if(!nickname.equals(memNickname)) {
			String blockedNickname = memNickname;
			BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
			model.addAttribute("blockVO", blockVO);
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
		
		return "community/communityMyPage/reflection";
	}
	
	// 커뮤니티 마이페이지 댓글창
	@RequestMapping(value = "/communityMyPage/reply", method = RequestMethod.GET)
	public String communityMyPageReflectionGet(String memNickname, 
			Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		String nickname = (String) session.getAttribute("sNickname");
		// 차단 정보
		if(!nickname.equals(memNickname)) {
			String blockedNickname = memNickname;
			BlockVO blockVO = communityService.getBlockInfo(nickname, blockedNickname);
			model.addAttribute("blockVO", blockVO);
		}
		
		
		// 새 소식
		
		
		// 댓글 
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "communityMyPageReplyList", memNickname, "");
		ArrayList<ReplyVO> vos =	communityService.getMemReplyList(pageVO.getStartIndexNo(), pageSize, memNickname);

		model.addAttribute("pageVO", pageVO);
		model.addAttribute("vos", vos);
		
		// 작성 문의
		
		
		return "community/communityMyPage/reply";
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
	@RequestMapping(value = "/communityMyPage/memInfo", method = RequestMethod.GET)
	public String memInfoGet(String memNickname, Model model, HttpSession session) {
		
		// 회원정보
		MemberVO memberVO = communityService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 차단 리스트
		ArrayList<BlockVO> blockVOS = communityService.getBlockList(memNickname);
		model.addAttribute("blockVOS", blockVOS);
		
		return "community/communityMyPage/memInfo";
	}
	
	// 커뮤니티 마이페이지 회원정보 창에서 프로필 사진 변경
	@RequestMapping(value = "/communityMyPage/memPhotoUpdate", method = RequestMethod.POST)
	public String memPhotoUpdatePost(MultipartFile file, MemberVO vo, 
			String defaultPhoto, HttpSession session) throws UnsupportedEncodingException {
		
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
		if(res != 0) return "redirect:/message/memPhotoUpdateOk?nickname=" + nickname;
		else return "redirect:/message/memPhotoUpdateNo?idx?nickname=" + nickname;
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
	
	
	
	// 회원 창
	@RequestMapping(value = "/memPage", method = RequestMethod.GET)
	public String memPageGet(String memNickname) {
		
		// 서재(책 저장 카테고리별 책 가져오기: 최신)
		
		
		
		// 
		
		return "community/memPage";
	}

	
	
}
