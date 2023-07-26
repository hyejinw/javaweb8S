package com.spring.javaweb8S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

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

public interface MemberDAO {
	
	// 페이징 처리용
	public ArrayList<OrderVO> myPageOrderWithInvoiceTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname);
	public int myPageOrderTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname);
	public int myPagePointTotRecCnt(@Param("sort") String sort, @Param("nickname") String nickname);
	public int myPagePointUseTotRecCnt(@Param("nickname") String nickname);
	public int myPageAskSearchTotRecCnt(@Param("memNickname") String memNickname, @Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);

	public MemberVO getMidCheck(@Param("mid") String mid);

	public MemberVO getNicknameCheck(@Param("nickname") String nickname);

	public int setMember(@Param("vo") MemberVO vo);

	public void setMemberPoint(@Param("recoMid") String recoMid, @Param("point") int point);

	public void setMemberLoginProcess(@Param("vo") MemberVO vo);

	public String getMidFinder(@Param("name") String name, @Param("email") String email);

	public String getPwdFinder(@Param("mid") String mid, @Param("email") String email);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setRecoMidPointInsert(@Param("recoMid") String recoMid, @Param("point") int point, @Param("pointReason") String pointReason);

	public void setPointInsert(@Param("nickname") String nickname, @Param("point") int point, @Param("pointReason") String pointReason);

	public String getBooksletterCheck(@Param("email") String email);

	public void setBooksletterInsert(@Param("booksletterIdx") String booksletterIdx, @Param("nickname") String nickname);

	public int getProverbTotalNum();

	public ProverbVO getRandomProverb(@Param("randomNum") int randomNum);

	public MemberVO getMemberInfo(@Param("nickname") String nickname);

	public String getTotalPoint(@Param("nickname") String nickname);

	public String getTotalUsedPoint(@Param("nickname") String nickname);

	public OrderVO getTotalOrder(@Param("nickname") String nickname);

	public String getOrderStatusNum(@Param("orderStatus") String orderStatus, @Param("nickname") String nickname);

	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<OrderVO> getOrderSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setOrderComplete(@Param("idx") int idx);
	
	public void setOrderPointInsert(@Param("idx") int idx, @Param("memNickname") String memNickname);
	
	public void setMemberPointUpdate(@Param("idx") int idx, @Param("memNickname") String memNickname);
	
	public int setRefundInsert(@Param("vo") RefundVO vo);
	
	public void setOrderRefundStatus(@Param("orderIdx") int orderIdx);
	
	public void setPartlyOrderPointInsert(@Param("orderIdx") int orderIdx, @Param("point") int point, @Param("memNickname") String memNickname);
	
	public void setPartlyMemberPointUpdate(@Param("point") int point, @Param("memNickname") String memNickname);
	
	public ArrayList<BooksletterVO> getBooksletterInfo(@Param("nickname") String nickname);
	
	public void setBooksletterDelete(@Param("idx") int idx);
	
	public void setMemberUpdate(@Param("vo") MemberVO vo);

	public int setMemberDelete(@Param("vo") MemberVO vo);
	
	public ArrayList<SaveVO> getSaveList(@Param("nickname") String nickname, @Param("sort") String sort);
	
	public void setSaveIdxesDelete(@Param("saveIdxList") List<String> saveIdxList);

	public void setSaveDelete(@Param("idx") int idx);
	
	public ArrayList<AddressVO> getAddressList(@Param("memNickname") String memNickname);

	public AddressVO getAddressInfo(@Param("idx") int idx);
	
	public void setAddressDelete(@Param("idx") int idx);
	
	public ArrayList<PointVO> getPointList(@Param("nickname") String nickname, @Param("sort") String sort, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<PointUseVO> getPointUseList(@Param("nickname") String nickname, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<SubscribeVO> getSubscribeInfo(@Param("nickname") String nickname);
	
	public void setSubscribeCancel(@Param("idx") int idx);
	
	public void setOrderAddressIdxChange(@Param("vo") OrderVO vo);
	
	public ArrayList<AskVO> getMemAskSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("memNickname") String memNickname, @Param("sort") String sort,	@Param("search") String search, @Param("searchString") String searchString);
	
	


	
	
}
