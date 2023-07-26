package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.JavawebProvide;
import com.spring.javaweb8S.dao.MemberDAO;
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

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	// 아이디 중복 검사, 추천인 검색
	@Override
	public MemberVO getMidCheck(String mid) {
		return memberDAO.getMidCheck(mid);
	}

	// 별명 중복 검사
	@Override
	public MemberVO getNicknameCheck(String nickname) {
		return memberDAO.getNicknameCheck(nickname);
	}

	// 회원가입
	@Override
	public int setMember(MemberVO vo) {
		return memberDAO.setMember(vo);
	}

	// 추천인 아이디 적립금(5000)
	@Override
	public void setMemberPoint(String recoMid, int point) {
		memberDAO.setMemberPoint(recoMid, point);
	}
	
	// 추천인 아이디 적립(5000): 적립금 테이블
	@Override
	public void setRecoMidPointInsert(String recoMid, int point, String pointReason) {
		memberDAO.setRecoMidPointInsert(recoMid, point, pointReason);
	}
	
	// 회원 가입 적립
	@Override
	public void setPointInsert(String nickname, int point, String pointReason) {
		memberDAO.setPointInsert(nickname, point, pointReason);
	}
	
	// 로그인 성공
	@Override
	public void setMemberLoginProcess(MemberVO vo) {
		memberDAO.setMemberLoginProcess(vo);
	}

	// 아이디 찾기
	@Override
	public String getMidFinder(String name, String email) {
		return memberDAO.getMidFinder(name, email);
	}

	// 비밀번호 찾기
	@Override
	public String getPwdFinder(String mid, String email) {
		return memberDAO.getPwdFinder(mid, email);
	}

	// 비밀번호 변경
	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}
	
	// 회원가입 시, 뉴스레터 비회원 구독 중인지 확인
	@Override
	public String getBooksletterCheck(String email) {
		return memberDAO.getBooksletterCheck(email);
	}
	
	// 회원가입 시, 뉴스레터 비회원 구독 중이라면 별명 넣어주기
	@Override
	public void setBooksletterInsert(String booksletterIdx, String nickname) {
		memberDAO.setBooksletterInsert(booksletterIdx, nickname);
	}

	// 회원가입 창, 명언 총 개수
	@Override
	public int getProverbTotalNum() {
		return memberDAO.getProverbTotalNum();
	}

	// 랜덤 명언 가져오기
	@Override
	public ProverbVO getRandomProverb(int randomNum) {
		return memberDAO.getRandomProverb(randomNum);
	}

	// 마이페이지, 회원 기본 정보
	@Override
	public MemberVO getMemberInfo(String nickname) {
		return memberDAO.getMemberInfo(nickname);
	}

	// 마이페이지, 총 포인트
	@Override
	public String getTotalPoint(String nickname) {
		return memberDAO.getTotalPoint(nickname);
	}

	// 마이페이지, 총 사용 포인트
	@Override
	public String getTotalUsedPoint(String nickname) {
		return memberDAO.getTotalUsedPoint(nickname);
	}

  // 총 주문 횟수, 총 주문 금액
	@Override
	public OrderVO getTotalOrder(String nickname) {
		return memberDAO.getTotalOrder(nickname);
	}

	// 마이페이지, 주문 상태에 따른 개수
	@Override
	public String getOrderStatusNum(String orderStatus, String nickname) {
		return memberDAO.getOrderStatusNum(orderStatus, nickname);
	}

	// 마이페이지, 주문 내역 리스트(송장으로 검색)
	@Override
	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(String sort, String search, String searchString, String startDate, String endDate, String nickname, int startIndexNo, int pageSize) {
		return memberDAO.getOrderWithInvoiceSearchList(sort, search, searchString, startDate, endDate, nickname, startIndexNo, pageSize);
	}

	// 마이페이지, 주문 내역 리스트(일반 검색)
	@Override
	public ArrayList<OrderVO> getOrderSearchList(String sort, String search, String searchString, String startDate, String endDate, String nickname, int startIndexNo, int pageSize) {
		return memberDAO.getOrderSearchList(sort, search, searchString, startDate, endDate, nickname, startIndexNo, pageSize);
	}

	// 마이페이지, 주문 조회창 구매확정
	@Override
	public void setOrderComplete(int idx) {
		memberDAO.setOrderComplete(idx);
	}

	// 구매확정 시, 포인트 지급
	@Override
	public void setOrderPointInsert(int idx, String memNickname) {
		memberDAO.setOrderPointInsert(idx, memNickname);
	}

	// 구매확정 시, 회원테이블 포인트 증가
	@Override
	public void setMemberPointUpdate(int idx, String memNickname) {
		memberDAO.setMemberPointUpdate(idx, memNickname);
	}

	// 반품 신청
	@Override
	public int setRefundInsert(MultipartFile file, RefundVO vo) {
		if(file != null) {
			// 새로운 파일 서버 업로드
			JavawebProvide jp = new JavawebProvide();
			String refundPhoto = jp.fileUpload(file, "refund");
			
			// 새로운 파일명 set
			vo.setRefundPhoto(refundPhoto);
		}
		return memberDAO.setRefundInsert(vo);
	}

	// 주문 테이블 상품 상태 변경
	@Override
	public void setOrderRefundStatus(int orderIdx) {
		memberDAO.setOrderRefundStatus(orderIdx);
	}

	// 일부 반품 시, 나머지 상품은 구매확정 포인트 지급
	@Override
	public void setPartlyOrderPointInsert(int orderIdx, int point, String memNickname) {
		memberDAO.setPartlyOrderPointInsert(orderIdx, point, memNickname);
	}

	// 일부 반품 시, 회원 테이블 포인트 증가
	@Override
	public void setPartlyMemberPointUpdate(int point, String memNickname) {
		memberDAO.setPartlyMemberPointUpdate(point, memNickname);
	}

	// 마이페이지 회원정보 수정, 뉴스레터 내용
	@Override
	public ArrayList<BooksletterVO> getBooksletterInfo(String nickname) {
		return memberDAO.getBooksletterInfo(nickname);
	}

	// 마이페이지 회원정보 수정창, 뉴스레터 구독 취소
	@Override
	public void setBooksletterDelete(int idx) {
		memberDAO.setBooksletterDelete(idx);
	}

	// 마이페이지 회원정보 수정창, 회원정보 수정
	@Override
	public void setMemberUpdate(MemberVO vo) {
		memberDAO.setMemberUpdate(vo);
	}
	
	// 마이페이지 회원정보 수정창, 회원탈퇴
	@Override
	public int setMemberDelete(MemberVO vo) {
		return memberDAO.setMemberDelete(vo);
	}

	// 마이페이지 관심상품 창, 관심상품 리스트
	@Override
	public ArrayList<SaveVO> getSaveList(String nickname, String sort) {
		return memberDAO.getSaveList(nickname, sort);
	}

	// 마이페이지 관심상품 창, 관심상품 삭제(복수 개)
	@Override
	public void setSaveIdxesDelete(List<String> saveIdxList) {
		memberDAO.setSaveIdxesDelete(saveIdxList);
	}

	// 마이페이지 관심상품 창, 관심상품 삭제(단일)
	@Override
	public void setSaveDelete(int idx) {
		memberDAO.setSaveDelete(idx);
	}

	// 마이페이지 배송 주소록 창, 주소록 리스트
	@Override
	public ArrayList<AddressVO> getAddressList(String memNickname) {
		return memberDAO.getAddressList(memNickname);
	}

	// 마이페이지 배송 주소록 창, 해당 주소 정보 가져오기
	@Override
	public AddressVO getAddressInfo(int idx) {
		return memberDAO.getAddressInfo(idx);
	}

	// 마이페이지 배송 주소록 창, 주소록 삭제
	@Override
	public void setAddressDelete(int idx) {
		memberDAO.setAddressDelete(idx);
	}

	// 마이페이지 포인트 적립 내역
	@Override
	public ArrayList<PointVO> getPointList(String nickname, String sort, int startIndexNo, int pageSize) {
		return memberDAO.getPointList(nickname, sort, startIndexNo, pageSize);
	}

	// 마이페이지 포인트 사용 내역
	@Override
	public ArrayList<PointUseVO> getPointUseList(String nickname, int startIndexNo, int pageSize) {
		return memberDAO.getPointUseList(nickname, startIndexNo, pageSize);
	}

	// 마이페이지 회원 정보창, 매거진 정기 구독 정보
	@Override
	public ArrayList<SubscribeVO> getSubscribeInfo(String nickname) {
		return memberDAO.getSubscribeInfo(nickname);
	}

	// 마이페이지, 구독관리 창에서 매거진 정기구독 취소신청
	@Override
	public void setSubscribeCancel(int idx) {
		memberDAO.setSubscribeCancel(idx);
	}

	// 마이페이지, 구독관리 창에서 매거진 정기구독 정기배송지 변경
	@Override
	public void setOrderAddressIdxChange(OrderVO vo) {
		memberDAO.setOrderAddressIdxChange(vo);
	}

	// 마이페이지, 문의관리창
	@Override
	public ArrayList<AskVO> getMemAskSearch(int startIndexNo, int pageSize, String memNickname, String sort, String search, String searchString) {
		return memberDAO.getMemAskSearch(startIndexNo, pageSize, memNickname, sort, search, searchString);
	}


	

}
