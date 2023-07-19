package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;

public interface CommunityDAO {
	
	// 페이징 처리용
	public int reflectionTotRecCnt();
	public int reflectionSearchTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);
	public int myPageInspiredTotRecCnt(String search);

	public MemberVO getMemberInfo(@Param("nickname") String nickname);

	public ArrayList<ReflectionVO> getReflectionList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setReflectionInsert(@Param("vo") ReflectionVO vo);

	public ReflectionVO getReflectionDetail(@Param("idx") int idx);

	public ArrayList<ReplyVO> getReply(@Param("idx") int idx);

	public ArrayList<InspiredVO> getInspired(@Param("bookIdx") int bookIdx, @Param("nickname") String nickname);

	public RefSaveVO getRefSave(@Param("idx") int idx, @Param("nickname") String nickname);

	public String getMaxGroupId(@Param("refIdx") int refIdx);

	public void setReplyInsert(@Param("vo") ReplyVO vo);
	
	public ArrayList<ReflectionVO> getReflectionSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, 
			@Param("search") String search, @Param("searchString") String searchString);
	
	public void setRefSave(@Param("refIdx") int refIdx, @Param("memNickname") String memNickname);
	
	public void setRefSaveDelete(@Param("refIdx") int refIdx, @Param("memNickname") String memNickname);
	
	public void setInspiredInsert(@Param("vo") InspiredVO vo);
	
	public void setRefSaveUpdate(@Param("refIdx") int refIdx, @Param("refSaveNum") int refSaveNum);
	
	public void setInsSave(@Param("insIdx") int insIdx, @Param("memNickname") String memNickname);
	
	public void setInsSaveUpdate(@Param("insIdx") int insIdx, @Param("insSaveNum") int insSaveNum);
	
	public void setInsSaveDelete(@Param("idx") int idx);
	
	public void setInspiredDelete(@Param("idx") int idx);
	
	public void setInsSaveForcedDelete(@Param("idx") int idx);
	
	public void setInspiredUpdate(@Param("vo") InspiredVO vo);
	
	public int setRefBookUpdate(@Param("publisher") String publisher, @Param("bookTitle") String bookTitle, @Param("idx") int idx);
	
	public int setReflectionUpdate(@Param("vo") ReflectionVO vo);
	
	public ArrayList<ReplyVO> getReReplyOriginContent(@Param("tempReplyVOS") ArrayList<ReplyVO> tempReplyVOS);
	
	public void setReplyUpdate(@Param("vo") ReplyVO vo);
	
	public void setReplyDelete(@Param("idx") int idx);
	
	public void setRefViewUpdate(@Param("idx") int idx);
	
	public int setReflectionDelete(@Param("idx") int idx);
	
	public void setRefSaveForcedDelete(@Param("idx") int idx);
	
	public void setReplyForcedDelete(@Param("idx") int idx);
	
	public ArrayList<BookSaveVO> getBookSave(@Param("categoryName") String categoryName, @Param("memNickname") String memNickname);
	
	public ArrayList<ReflectionVO> getMemReflection(@Param("memNickname") String memNickname);
	
	public ArrayList<InspiredVO> getMemInspired(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("memNickname") String memNickname);
	
	public void setBookSaveInsert(@Param("vo") BookSaveVO vo);
	
	public void setBookSaveDelete(@Param("idx") int idx);
	
	public void setBookSaveCategoryChange(@Param("vo") BookSaveVO vo);


}
