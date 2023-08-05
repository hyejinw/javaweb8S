package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.RefundVO;
import com.spring.javaweb8S.vo.SubscribeVO;

public interface AutoUpdateDAO {

	public ArrayList<OrderVO> getAutoOrderList();

	// 주문 자동 업데이트
	public void setOrderAutoUpdate(@Param("level") ArrayList<Integer> level, @Param("status") String status);
	// 배송 자동 업데이트
	public void setDeliveryAutoUpdate(@Param("level") ArrayList<Integer> level, @Param("status") String status);

	// 배송 자동 업데이트(송장 번호, 배송 날짜)
	public void setDeliveryAutoUpdateWithInvoices(@Param("insertVOS") ArrayList<DeliveryVO> insertVOS, @Param("status") String status);

	// 정기 구독, 구독중 리스트만 가져오기 (구독취소/구독종료 제외)
	public ArrayList<SubscribeVO> getAutoSubList();
	
	// 정기 구독, 배송준비중으로 배송 처리
	public void setDeliAutoInsert(@Param("insertVOS") ArrayList<DeliveryVO> insertVOS);

	// 잔여 횟수 1인 회원, 구독 종료로 변경
	public void setSubStatusUpdate();

	// 구독중인 회원 발송 잔여 횟수 -1
	public void setSubSendNum();

	// 매거진 정기 구독 발송 기록 처리
	public void setSubDeliAutoInsert(@Param("vos") ArrayList<SubscribeVO> vos);

	// 잔여 횟수 0인 회원, 구독 유지 유도하는 메일 전송 (회원 별명, 이메일 주소, 구독 시작일, 구독 종료일)
	public ArrayList<SubscribeVO> getMemberInfo();

	// 매거진 정기 구독 발송완료 처리
	public void setSubDeliAutoUpdate();

	// 뉴스레터 구독 정보 리스트 
	public ArrayList<BooksletterVO> getBooksletterList();

	// 반품 리스트
	public ArrayList<RefundVO> getAutoRefundList();

	// 반품 테이블 상태 업데이트
	public void setRefundAutoUpdate(@Param("level") ArrayList<RefundVO> level, @Param("status") String status);

	// 주문 테이블 상태 업데이트(반품관련)
	public void setRefundOrderAutoUpdate(@Param("level") ArrayList<RefundVO> level, @Param("status") String status);

	// 포인트 테이블 포인트 반환 
	public void setPointReturn(@Param("tempVOS") ArrayList<RefundVO> tempVOS);

	// 회원 테이블 포인트 반환
	public void setMemPointReturn(@Param("tempVOS") ArrayList<RefundVO> tempVOS);

	// 상품 재고 변경 + 판매수량 변경
	public void setStockUpdate(@Param("level") ArrayList<RefundVO> level);

	// 구매확정 후, 포인트 지급
	public void setOrderPointInsert(@Param("level") ArrayList<OrderVO> level);

	// 구매확정 후, 회원 테이블 포인트 수정
	public void setMemberPointUpdate(@Param("level") ArrayList<OrderVO> level);

	// 뉴스레터 발송횟수 증가
	public void setBooksletterSendNumUpdate(@Param("vos") ArrayList<BooksletterVO> vos);

	// 매거진 정기구독 구독종료 시, 포인트 지급: 1) 포인트 테이블 추가
	public void setSubPointInsert(@Param("subPointVOS") ArrayList<SubscribeVO> subPointVOS);

	// 매거진 정기구독 구독종료 시, 포인트 지급: 2) 회원 테이블 포인트 수정
	public void setSubMemPointUpdate(@Param("subPointVOS") ArrayList<SubscribeVO> subPointVOS);

	// 탈퇴 1개월 경과 회원 영구탈퇴
	public void setMemberPermanentDelete();


}
