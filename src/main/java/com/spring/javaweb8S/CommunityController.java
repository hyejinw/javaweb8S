package com.spring.javaweb8S;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.CommunityService;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.InsSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;

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
			// 아직 안 만들었다.
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
	
	// 기록 상세창
	@RequestMapping(value = "/reflectionDetail", method = RequestMethod.GET)
	public String reflectionDetailGet(int idx, HttpSession session,
			@RequestParam(name = "bookIdx", defaultValue = "0", required = false) int bookIdx,
			Model model) {
		
		ReflectionVO vo = communityService.getReflectionDetail(idx);
		model.addAttribute("vo", vo);
		
		// 댓글
		ArrayList<ReplyVO> replyVOS = communityService.getReply(idx);
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
		
		// 해당 문장 수집을 저장한 기록 모두 삭제
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
	
	
}
