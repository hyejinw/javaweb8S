package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BlockVO;
import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;
import com.spring.javaweb8S.vo.ReportVO;

public interface CommunityService {

	public MemberVO getMemberInfo(String nickname);

	public ArrayList<ReflectionVO> getReflectionList(int startIndexNo, int pageSize);

	public int setReflectionInsert(ReflectionVO vo);

	public ReflectionVO getReflectionDetail(int idx);

	public ArrayList<ReplyVO> getReply(int idx);

	public ArrayList<InspiredVO> getInspired(int bookIdx, String nickname);

	public RefSaveVO getRefSave(int idx, String nickname);

	public String getMaxGroupId(int refIdx);

	public void setReplyInsert(ReplyVO vo);

	public ArrayList<ReflectionVO> getReflectionSearch(int startIndexNo, int pageSize, String search,	String searchString);

	public void setRefSave(int refIdx, String memNickname);

	public void setRefSaveDelete(int refIdx, String memNickname);

	public void setInspiredInsert(InspiredVO vo);

	public void setRefSaveUpdate(int refIdx, int refSaveNum);

	public void setInsSave(int insIdx, String memNickname);

	public void setInsSaveUpdate(int insIdx, int insSaveNum);

	public void setInsSaveDelete(int idx);

	public void setInspiredDelete(int idx);

	public void setInsSaveForcedDelete(int idx);

	public void setInspiredUpdate(InspiredVO vo);

	public int setRefBookUpdate(String publisher, String bookTitle, int idx);

	public int setReflectionUpdate(ReflectionVO vo);

	public ArrayList<ReplyVO> getReReplyOriginContent(ArrayList<ReplyVO> tempReplyVOS);

	public void setReplyUpdate(ReplyVO vo);

	public void setReplyDelete(ReplyVO vo);

	public void setRefViewUpdate(int idx);

	public int setReflectionDelete(int idx);

	public void setRefSaveForcedDelete(int idx);

	public void setReplyForcedDelete(int idx);

	public ArrayList<BookSaveVO> getBookSave(String categoryName, String memNickname);

	public ArrayList<InspiredVO> getMemInspired(int startIndexNo, int pageSize, String memNickname, String nickname);

	public void setBookSaveInsert(BookSaveVO vo);

	public void setBookSaveDelete(int idx);

	public void setBookSaveCategoryChange(BookSaveVO vo);

	public void setInspiredInsertMyPage(InspiredVO vo);

	public void setReportInsert(ReportVO vo);

	public ArrayList<ReflectionVO> getMemReflectionList(int startIndexNo, int pageSize, String memNickname);

	public ArrayList<ReflectionVO> getMemReflectionSearch(int startIndexNo, int pageSize, String memNickname, String search, String searchString);

	public ArrayList<ReplyVO> getMemReplyList(int startIndexNo, int pageSize, String memNickname);

	public BlockVO getBlockInfo(String nickname, String blockedNickname);

	public void setBlockInsert(BlockVO vo);

	public void setBlockDelete(BlockVO vo);

	public ArrayList<BlockVO> getBlockList(String memNickname);

	public int setMemPhotoUpdate(MultipartFile file, MemberVO vo);

	public int setMemDefaultPhotoUpdate(MemberVO vo);

	public void setIntroductionUpdate(String introduction, String nickname);

	public ArrayList<MemberVO> getMemberSearchList(String searchString, String memNickname);

	public ArrayList<AskVO> getMemAskSearch(int startIndexNo, int pageSize, String memNickname, String sort, String search, String searchString);

	public ArrayList<AskVO> getAskSearch(int startIndexNo, int pageSize, String sort, String search, String searchString);

	public int setAskInsert(AskVO vo);

	public AskVO getAskDetail(int idx);

	public int setAskUpdate(AskVO vo);

	public int setAskDelete(int idx);

	public ArrayList<AskVO> getAskList(List<String> askList);

	public void setAskIdxesDelete(List<String> askList);

	public void setAnswerInsert(int idx, String answer);

	public ArrayList<ReportVO> getMemReportList(String memNickname, String sort);



}
