package com.spring.javaweb8S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.JavawebProvide;
import com.spring.javaweb8S.dao.CommunityDAO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BlockVO;
import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;
import com.spring.javaweb8S.vo.ReportVO;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	// 커뮤니티 메뉴에서 쓸 회원 정보 가져오기
	@Override
	public MemberVO getMemberInfo(String nickname) {
		return communityDAO.getMemberInfo(nickname);
	}

	// 커뮤니티 기록 창 리스트
	@Override
	public ArrayList<ReflectionVO> getReflectionList(int startIndexNo, int pageSize) {
		return communityDAO.getReflectionList(startIndexNo, pageSize);
	}

	// 기록 등록
	@Override
	public int setReflectionInsert(ReflectionVO vo) {
		return communityDAO.setReflectionInsert(vo);
	}

	// 기록 상세창
	@Override
	public ReflectionVO getReflectionDetail(int idx) {
		return communityDAO.getReflectionDetail(idx);
	}

	// 댓글
	@Override
	public ArrayList<ReplyVO> getReply(int idx) {
		return communityDAO.getReply(idx);
	}

	// 문장수집
	@Override
	public ArrayList<InspiredVO> getInspired(int bookIdx, String nickname) {
		return communityDAO.getInspired(bookIdx, nickname);
	}

	// 기록 저장 유무
	@Override
	public RefSaveVO getRefSave(int idx, String nickname) {
		return communityDAO.getRefSave(idx, nickname);
	}

	// 해당 기록 댓글의 최대 그룹 ID 가져오기
	@Override
	public String getMaxGroupId(int refIdx) {
		return communityDAO.getMaxGroupId(refIdx);
	}

	// 기록 댓글 추가
	@Override
	public void setReplyInsert(ReplyVO vo) {
		communityDAO.setReplyInsert(vo);
	}

	// 기록 검색
	@Override
	public ArrayList<ReflectionVO> getReflectionSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return communityDAO.getReflectionSearch(startIndexNo, pageSize, search, searchString);
	}

	// 커뮤니티 기록 상세창에서, 기록 저장
	@Override
	public void setRefSave(int refIdx, String memNickname) {
		communityDAO.setRefSave(refIdx, memNickname);
	}

	// 커뮤니티 기록 상세창에서, 기록 저장 취소
	@Override
	public void setRefSaveDelete(int refIdx, String memNickname) {
		communityDAO.setRefSaveDelete(refIdx, memNickname);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 추가
	@Override
	public void setInspiredInsert(InspiredVO vo) {
		communityDAO.setInspiredInsert(vo);
	}

	// 커뮤니티 기록 저장 등록 수 변경
	@Override
	public void setRefSaveUpdate(int refIdx, int refSaveNum) {
		communityDAO.setRefSaveUpdate(refIdx, refSaveNum);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 저장
	@Override
	public void setInsSave(int insIdx, String memNickname) {
		communityDAO.setInsSave(insIdx, memNickname);
	}

	// 커뮤니티 문장수집 저장 등록 수 변경
	@Override
	public void setInsSaveUpdate(int insIdx, int insSaveNum) {
		communityDAO.setInsSaveUpdate(insIdx, insSaveNum);
	}
  
	// 커뮤니티 기록 상세창에서, 문장 수집 저장 취소
	@Override
	public void setInsSaveDelete(int idx) {
		communityDAO.setInsSaveDelete(idx);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 삭제
	@Override
	public void setInspiredDelete(int idx) {
		communityDAO.setInspiredDelete(idx);
	}

	// 해당 문장 수집을 저장한 기록 모두 삭제
	@Override
	public void setInsSaveForcedDelete(int idx) {
		communityDAO.setInsSaveForcedDelete(idx);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 수정
	@Override
	public void setInspiredUpdate(InspiredVO vo) {
		communityDAO.setInspiredUpdate(vo);
	}

	// 커뮤니티 기록 수정창에서 책 변경 
	@Override
	public int setRefBookUpdate(String publisher, String bookTitle, int idx) {
		return communityDAO.setRefBookUpdate(publisher, bookTitle, idx);
	}

	// 커뮤니티 기록 수정
	@Override
	public int setReflectionUpdate(ReflectionVO vo) {
		return communityDAO.setReflectionUpdate(vo);
	}

	// 대댓글의 원본 댓글 내용 가져오기
	@Override
	public ArrayList<ReplyVO> getReReplyOriginContent(ArrayList<ReplyVO> tempReplyVOS) {
		return communityDAO.getReReplyOriginContent(tempReplyVOS);
	}

	// 커뮤니티 기록 상세창에서 댓글 수정
	@Override
	public void setReplyUpdate(ReplyVO vo) {
		communityDAO.setReplyUpdate(vo);
	}

	// 커뮤니티 기록 상세창에서 댓글 삭제
	@Override
	public void setReplyDelete(ReplyVO vo) {
		communityDAO.setReplyDelete(vo);
	}

	// 조회수 증가하기
	@Override
	public void setRefViewUpdate(int idx) {
		communityDAO.setRefViewUpdate(idx);
	}

	// 기록 삭제
	@Override
	public int setReflectionDelete(int idx) {
		return communityDAO.setReflectionDelete(idx);
	}

	// 해당 기록을 저장한 경우 모두 삭제
	@Override
	public void setRefSaveForcedDelete(int idx) {
		communityDAO.setRefSaveForcedDelete(idx);
	}

	// 해당 기록에 달린 댓글 삭제
	@Override
	public void setReplyForcedDelete(int idx) {
		communityDAO.setReplyForcedDelete(idx);
	}

	// 커뮤니티 마이페이지, (서재) 카테고리별 책 저장
	@Override
	public ArrayList<BookSaveVO> getBookSave(String categoryName, String memNickname, String flag) {
		return communityDAO.getBookSave(categoryName, memNickname, flag);
	}

	// 커뮤니티 마이페이지, 문장수집
	@Override
	public ArrayList<InspiredVO> getMemInspired(int startIndexNo, int pageSize, String memNickname, String nickname) {
		return communityDAO.getMemInspired(startIndexNo, pageSize, memNickname, nickname);
	}

	// 커뮤니티 마이페이지 메인창에서, 책 저장 추가
	@Override
	public void setBookSaveInsert(BookSaveVO vo) {
		communityDAO.setBookSaveInsert(vo);
	}

	// 책 저장 삭제
	@Override
	public void setBookSaveDelete(int idx) {
		communityDAO.setBookSaveDelete(idx);
	}

	// 책 저장 카테고리 변경
	@Override
	public void setBookSaveCategoryChange(BookSaveVO vo) {
		communityDAO.setBookSaveCategoryChange(vo);
	}

	// 커뮤니티 마이페이지 메인창에서, 문장수집 추가
	@Override
	public void setInspiredInsertMyPage(InspiredVO vo) {
		communityDAO.setInspiredInsertMyPage(vo);
	}

	// 커뮤니티 기록 상세창, 신고
	@Override
	public void setReportInsert(ReportVO vo) {
		communityDAO.setReportInsert(vo);
	}

	// 커뮤니티 마이페이지 기록창에서 전체 리스트
	@Override
	public ArrayList<ReflectionVO> getMemReflectionList(int startIndexNo, int pageSize, String memNickname) {
		return communityDAO.getMemReflectionList(startIndexNo, pageSize, memNickname);
	}

	// 커뮤니티 마이페이지 기록창에서 전체 리스트 검색
	@Override
	public ArrayList<ReflectionVO> getMemReflectionSearch(int startIndexNo, int pageSize, String memNickname, String search, String searchString) {
		return communityDAO.getMemReflectionSearch(startIndexNo, pageSize, memNickname, search, searchString);
	}

	// 커뮤니티 마이페이지 댓글창
	@Override
	public ArrayList<ReplyVO> getMemReplyList(int startIndexNo, int pageSize, String memNickname) {
		return communityDAO.getMemReplyList(startIndexNo, pageSize, memNickname);
	}

	// 커뮤니티 마이페이지 차단 친구
	@Override
	public BlockVO getBlockInfo(String nickname, String blockedNickname) {
		return communityDAO.getBlockInfo(nickname, blockedNickname);
	}

	// 회원 차단
	@Override
	public void setBlockInsert(BlockVO vo) {
		communityDAO.setBlockInsert(vo);
	}

	// 회원 차단 해제
	@Override
	public void setBlockDelete(BlockVO vo) {
		communityDAO.setBlockDelete(vo);
	}

	// 커뮤니티 마이페이지 회원정보 창에서 차단 리스트
	@Override
	public ArrayList<BlockVO> getBlockList(String memNickname) {
		return communityDAO.getBlockList(memNickname);
	}

	// 커뮤니티 마이페이지 회원정보 창에서 프로필 사진 변경
	@Override
	public int setMemPhotoUpdate(MultipartFile file, MemberVO vo) {
		
		// 기존에 존재하는 파일은 삭제처리 (기본 프로필 제외!)
		if((!vo.getMemPhoto().equals("adminPhoto.png")) && (!vo.getMemPhoto().equals("defaultImage.jpg")) && (!vo.getMemPhoto().equals("defaultPhoto1.png")) && (!vo.getMemPhoto().equals("defaultPhoto2.png")) 
				&& (!vo.getMemPhoto().equals("defaultPhoto3.png")) 	&& (!vo.getMemPhoto().equals("defaultPhoto4.png")) && (!vo.getMemPhoto().equals("defaultPhoto5.png") && (!vo.getMemPhoto().equals("defaultPhoto6.png")))) {
			
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/member/");
			File originFileDelete = new File(realPath + vo.getMemPhoto());
			originFileDelete.delete();
		}
			
		try {
			String memPhotoFileName = file.getOriginalFilename();
			
			// 새로운 파일 서버 업로드
			JavawebProvide jp = new JavawebProvide();
			jp.writeFile(file,memPhotoFileName,"admin/member");
			
			// 새로운 파일명 set
			vo.setMemPhoto(memPhotoFileName);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return communityDAO.setMemPhotoUpdate(vo);
	}

	
	// 커뮤니티 마이페이지 회원정보 창에서 프로필 사진 변경 (기본 사진)
	@Override
	public int setMemDefaultPhotoUpdate(MemberVO vo) {
		return communityDAO.setMemPhotoUpdate(vo);
	}

	// 커뮤니티 마이페이지 회원정보 창에서 소개글 수정
	@Override
	public void setIntroductionUpdate(String introduction, String nickname) {
		communityDAO.setIntroductionUpdate(introduction, nickname);
	}

	// 커뮤니티 마이페이지 회원정보 창에서, 차단할 회원 검색
	@Override
	public ArrayList<MemberVO> getMemberSearchList(String searchString, String memNickname) {
		return communityDAO.getMemberSearchList(searchString, memNickname);
	}

	// 커뮤니티 마이페이지 문의/신고 창에서, 문의 내역 리스트
	@Override
	public ArrayList<AskVO> getMemAskSearch(int startIndexNo, int pageSize, String memNickname, String sort, String search, String searchString) {
		return communityDAO.getMemAskSearch(startIndexNo, pageSize, memNickname, sort, search, searchString);
	}

	// 문의 리스트
	@Override
	public ArrayList<AskVO> getAskSearch(int startIndexNo, int pageSize, String sort, String search, String searchString) {
		return communityDAO.getAskSearch(startIndexNo, pageSize, sort, search, searchString);
	}

	// 문의 등록
	@Override
	public int setAskInsert(AskVO vo) {
		return communityDAO.setAskInsert(vo);
	}

	// 문의 상세 내용
	@Override
	public AskVO getAskDetail(int idx) {
		return communityDAO.getAskDetail(idx);
	}

	// 문의 수정
	@Override
	public int setAskUpdate(AskVO vo) {
		return communityDAO.setAskUpdate(vo);
	}

	// 문의 삭제
	@Override
	public int setAskDelete(int idx) {
		return communityDAO.setAskDelete(idx);
	}

	// 삭제할 문의 내용 가져오기
	@Override
	public ArrayList<AskVO> getAskList(List<String> askList) {
		return communityDAO.getAskList(askList);
	}

	// 마이페이지 문의 복수 개 삭제
	@Override
	public void setAskIdxesDelete(List<String> askList) {
		communityDAO.setAskIdxesDelete(askList);
	}

	// 문의 답변달기
	@Override
	public void setAnswerInsert(int idx, String answer) {
		communityDAO.setAnswerInsert(idx, answer);
	}

	// 커뮤니티 마이페이지 신고 리스트
	@Override
	public ArrayList<ReportVO> getMemReportList(String memNickname, String sort) {
		return communityDAO.getMemReportList(memNickname, sort);
	}

	// 마이페이지 신고 복수 개 삭제
	@Override
	public void setReportIdxesDelete(List<String> reportList) {
		communityDAO.setReportIdxesDelete(reportList);
	}

	// 커뮤니티 메인창 최근 문장수집(10개)
	@Override
	public ArrayList<InspiredVO> getNewInspired(String nickname) {
		return communityDAO.getNewInspired(nickname);
	}

	// 책 고유번호 가져오기
	@Override
	public int getBookIdx(String title, String publisher) {
		return communityDAO.getBookIdx(title, publisher);
	}

	// 책 테이블 저장 등록 수 변경
	@Override
	public void setBookSaveNumUpdate(int idx, int bookSaveNum) {
		communityDAO.setBookSaveNumUpdate(idx, bookSaveNum);
	}

	// 가장 많이 저장된 책(10개)
	@Override
	public ArrayList<BookVO> getPopularBook() {
		return communityDAO.getPopularBook();
	}

	// 최신 기록(10개)
	@Override
	public ArrayList<ReflectionVO> getNewReflection() {
		return communityDAO.getNewReflection();
	}

	// 회원 페이지 문장수집 리스트(팝업)
	@Override
	public ArrayList<InspiredVO> getMemPageInspired(String memNickname, String nickname) {
		return communityDAO.getMemPageInspired(memNickname, nickname);
	}

	// 회원 페이지 기록 리스트(팝업)
	@Override
	public ArrayList<ReflectionVO> getMemPageReflection(String memNickname) {
		return communityDAO.getMemPageReflection(memNickname);
	}

	// 책 상세 정보 (팝업) 책 정보
	@Override
	public BookVO getBookInfo(int idx) {
		return communityDAO.getBookInfo(idx);
	}

	// 책 상세 정보 (팝업) 해당 책 저장한 카테고리별 회원 
	@Override
	public ArrayList<BookSaveVO> getMemBookSave(String categoryName, int idx) {
		return communityDAO.getMemBookSave(categoryName, idx);
	}

	// 책 상세 정보 (팝업) 해당 책으로 작성된 기록
	@Override
	public ArrayList<ReflectionVO> getBookReflection(int idx) {
		return communityDAO.getBookReflection(idx);
	}

	// 랜덤 명언용, 총 명언 개수 구하기
	@Override
	public int getProverbTotalNum() {
		return communityDAO.getProverbTotalNum();
	}

	// 랜덤 명언 가져오기
	@Override
	public ProverbVO getRandomProverb(int randomNum) {
		return communityDAO.getRandomProverb(randomNum);
	}

	// 책 상세 정보(팝업) 해당 책으로 작성된 문장수집
	@Override
	public ArrayList<InspiredVO> getBookPageInspired(String nickname, int idx) {
		return communityDAO.getBookPageInspired(nickname, idx);
	}
	
	
	
}
