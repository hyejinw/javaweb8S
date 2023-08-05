package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.PointUseVO;
import com.spring.javaweb8S.vo.PointVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefundVO;
import com.spring.javaweb8S.vo.SaveVO;
import com.spring.javaweb8S.vo.SubscribeVO;

public interface MemberService {

	public MemberVO getMidCheck(String mid);

	public MemberVO getNicknameCheck(String nickname);

	public int setMember(MemberVO vo);

	public void setMemberPoint(String recoMid, int point);

	public void setMemberLoginProcess(MemberVO vo);

	public String getMidFinder(String name, String email);

	public String getPwdFinder(String mid, String email);

	public void setMemberPwdUpdate(String mid, String encode);

	public void setRecoMidPointInsert(String recoMid, int point, String pointReason);

	public void setPointInsert(String nickname, int point, String pointReason);

	public String getBooksletterCheck(String email);

	public void setBooksletterInsert(String booksletterIdx, String nickname);

	public int getProverbTotalNum();

	public ProverbVO getRandomProverb(int randomNum);

	public MemberVO getMemberInfo(String nickname);

	public String getTotalPoint(String nickname);

	public String getTotalUsedPoint(String nickname);

	public OrderVO getTotalOrder(String nickname);

	public String getOrderStatusNum(String orderStatus, String nickname);

	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(String sort, String search, String searchString, String startDate, String endDate, String nickname, int startIndexNo, int pageSize);

	public ArrayList<OrderVO> getOrderSearchList(String sort, String search, String searchString, String startDate, String endDate, String nickname, int startIndexNo, int pageSize);

	public void setOrderComplete(int idx);

	public void setOrderPointInsert(int idx, String memNickname);

	public void setMemberPointUpdate(int idx, String memNickname);

	public int setRefundInsert(MultipartFile file, RefundVO vo);

	public void setOrderRefundStatus(int orderIdx);

	public void setPartlyOrderPointInsert(int orderIdx, int point, String memNickname);

	public void setPartlyMemberPointUpdate(int point, String memNickname);

	public ArrayList<BooksletterVO> getBooksletterInfo(String nickname);

	public void setBooksletterDelete(int idx);

	public void setMemberUpdate(MemberVO vo);

	public int setMemberDelete(MemberVO vo);

	public ArrayList<SaveVO> getSaveList(String nickname, String sort);

	public void setSaveIdxesDelete(List<String> saveIdxList);

	public void setSaveDelete(int idx);

	public ArrayList<AddressVO> getAddressList(String memNickname);

	public AddressVO getAddressInfo(int idx);

	public void setAddressDelete(int idx);

	public ArrayList<PointVO> getPointList(String nickname, String sort, int startIndexNo, int pageSize);

	public ArrayList<PointUseVO> getPointUseList(String nickname, int startIndexNo, int pageSize);

	public ArrayList<SubscribeVO> getSubscribeInfo(String nickname);

	public void setSubscribeCancel(int idx);

	public void setOrderAddressIdxChange(OrderVO vo);

	public ArrayList<AskVO> getMemAskSearch(int startIndexNo, int pageSize, String memNickname, String sort, String search, String searchString);


}
