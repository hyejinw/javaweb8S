package com.spring.javaweb8S.service;

import java.util.ArrayList;

import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;

public interface CommunityService {

	public MemberVO getMemberInfo(String nickname);

	public ArrayList<ReflectionVO> getReflectionList(int startIndexNo, int pageSize);

	public void imgCheck(String content);

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

	public void imgCheckUpdate(String content);

	public void imgDelete(String content);



}
