package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefundVO;

public interface MemberDAO {
	
	// 페이징 처리용
	public ArrayList<OrderVO> myPageOrderWithInvoiceTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname);
	public int myPageOrderTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("nickname") String nickname);

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
	
	public BooksletterVO getBooksletterInfo(@Param("nickname") String nickname);


	
	
}
