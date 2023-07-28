package com.spring.javaweb8S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.JavawebProvide;
import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.NoticeVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.PointUseVO;
import com.spring.javaweb8S.vo.PointVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.RefundVO;
import com.spring.javaweb8S.vo.StatisticVO안씀;
import com.spring.javaweb8S.vo.SubscribeVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;
	
	// 프로필 기본 사진 가져오기
	@Override
	public ArrayList<DefaultPhotoVO> getDefaultPhoto() {
		return adminDAO.getDefaultPhoto();
	}
	
	// 프로필 기본 사진 추가
  @Override 
  public int memberDefaultPhotoInsert(MultipartFile file, DefaultPhotoVO vo) {
  
  	try { 
  		String saveFileName = file.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(file,saveFileName,"admin/member");
  		
  		vo.setPhotoName(saveFileName);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
  	return adminDAO.memberDefaultPhotoInsert(vo); 
  }
 
  // 책 명언 리스트
	@Override
	public ArrayList<ProverbVO> getProverb(int startIndexNo, int pageSize) {
		return adminDAO.getProverb(startIndexNo, pageSize);
	}

	// 책 명언 추가
	@Override
	public void setProverb(ProverbVO vo) {
		adminDAO.setProverb(vo);
	}

	// 기본 이미지 삭제
	@Override
	public int memberDefaultPhotoDelete(List<String> defaultPhotoList) {
		return adminDAO.memberDefaultPhotoDelete(defaultPhotoList);
	}

  // 삭제된 기본 이미지 사용 회원, 프로필 'defaultImage.jpg'로 변경
	@Override
	public void setChangeMemberPhotos(List<String> defaultPhotoList) {
		adminDAO.setChangeMemberPhotos(defaultPhotoList);
	}

	// 책 명언 삭제
	@Override
	public void setProverbDelete(List<String> proverbList) {
		adminDAO.setProverbDelete(proverbList);
	}

	// 책 명언 수정
	@Override
	public void setUpdateProverb(ProverbVO vo) {
		adminDAO.setUpdateProverb(vo);
	}

	// DB 저장된 책 리스트 가져오기
	@Override
	public ArrayList<BookVO> getBooks(int startIndexNo, int pageSize) {
		return adminDAO.getBooks(startIndexNo, pageSize);
	}

	// DB 저장된 책에서 검색
	@Override
	public ArrayList<BookVO> getDBBooks(String searchString, String search, int startIndexNo, int pageSize) {
		return adminDAO.getDBBooks(searchString, search, startIndexNo, pageSize);
	}

	// DB 저장된 책 삭제
	@Override
	public void setBookDelete(List<String> bookList) {
		adminDAO.setBookDelete(bookList);
	}

	// 매거진 리스트 가져오기
	@Override
	public ArrayList<MagazineVO> getMagazineList(int startIndexNo, int pageSize) {
		return adminDAO.getMagazineList(startIndexNo, pageSize);
	}

	// 매거진 공개/비공개 변경 
	@Override
	public void setMagazineOpenUpdate(int idx, String maOpen) {
		adminDAO.setMagazineOpenUpdate(idx, maOpen);
	}

	// 매거진 삭제
	@Override
	public void setMagazineDelete(List<String> magazineList) {
		adminDAO.setMagazineDelete(magazineList);
	}

	// 매거진 삭제 전, 서버 삭제용 매거진 이름 가져오기
	@Override
	public List<MagazineVO> getMagazinePhotoName(List<String> magazineList) {
		return adminDAO.getMagazinePhotoName(magazineList);
	}

	// 정기구독만 보기
	@Override
	public ArrayList<MagazineVO> getMagazineTypeList(int startIndexNo, int pageSize, String maType) {
		return adminDAO.getMagazineTypeList(startIndexNo, pageSize, maType);
	}

	// 매거진 등록
	@Override
	public int setMagazineInsert(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo) {
		
  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		String detailFileName = detailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"magazine");
  		jp.writeFile(detailFile,detailFileName,"magazine");
  		
  		vo.setMaThumbnail(thumbnailFileName);
  		vo.setMaDetail(detailFileName);
  		
  		// 상품 코드 제작
  		UUID uid = UUID.randomUUID();
  		String code = "BWM" + uid.toString().substring(0,5);
  		vo.setMaCode(code);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setMagazineInsert(vo);
	}

	// 매거진 정보 가져오기
	@Override
	public MagazineVO getMagazine(int idx) {
		return adminDAO.getMagazine(idx);
	}

	// 매거진 정보 수정
	@Override
	public int setMagazineUpdate(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo,  MagazineVO originVO) {
		int res = 0;
		
		try { 
			String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
			String detailFileName = detailFile.getOriginalFilename(); 
			
			// 공백이 아닐 경우 변경 처리
			if(!thumbnailFileName.equals("") && !detailFileName.equals("")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/magazine/");
				
				// 기존에 존재하는 파일은 삭제처리
				File thumbnailFileDelete = new File(realPath + originVO.getMaThumbnail());
				File detailFileDelete = new File(realPath + originVO.getMaDetail());
				thumbnailFileDelete.delete();
				detailFileDelete.delete();
				
				// 새로운 파일 업로드
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(thumbnailFile,thumbnailFileName,"magazine");
				jp.writeFile(detailFile,detailFileName,"magazine");

				// 새로운 파일명 set
				vo.setMaThumbnail(thumbnailFileName);
				vo.setMaDetail(detailFileName);
			}
			
  		adminDAO.setMagazineUpdate(vo);
			res = 1;
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return res;
	}

	// 매거진 검색
	@Override
	public ArrayList<MagazineVO> getMagazineSearchList(String searchString, String search, String startDate, String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getMagazineSearchList(searchString, search, startDate, endDate, startIndexNo, pageSize);
	}

	// 컬렉션 카테고리 등록
	@Override
	public int setColCategoryInsert(MultipartFile thumbnailFile, CollectionVO vo) {

  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"collection");
  		
  		vo.setColThumbnail(thumbnailFileName);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setColCategoryInsert(vo);
	}

	// 컬렉션 카테고리 리스트 가져오기
	@Override
	public ArrayList<CollectionVO> getColCategoryList(int startIndexNo, int pageSize) {
		return adminDAO.getColCategoryList(startIndexNo, pageSize);
	}

	// 컬렉션 삭제
	@Override
	public void setColCategoryDelete(List<String> colCategoryList) {
		adminDAO.setColCategoryDelete(colCategoryList);
	}

	// 컬렉션 카테고리 공개/비공개 처리
	@Override
	public void setColCategoryOpenUpdate(int idx, String colOpen) {
		adminDAO.setColCategoryOpenUpdate(idx, colOpen);
	}

	// 컬렉션 카테고리 수정
	@Override
	public void setUpdateColCategory(CollectionVO vo) {
		adminDAO.setUpdateColCategory(vo);
	}

	// 컬렉션 카테고리 썸네일 수정
	@Override
	public int setColCategorythumbUpdate(MultipartFile thumbnailFile, CollectionVO vo) {
		int res = 0;
		
		try { 
			String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
			
			// 공백이 아닐 경우 변경 처리
			if(!thumbnailFileName.equals("")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/collection/");
				
				// 기존에 존재하는 파일은 삭제처리
				File thumbnailFileDelete = new File(realPath + vo.getColThumbnail());
				thumbnailFileDelete.delete();
				
				// 새로운 파일 업로드
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(thumbnailFile,thumbnailFileName,"collection");

				// 새로운 파일명 set
				vo.setColThumbnail(thumbnailFileName);
			}
			
  		adminDAO.setColCategorythumbUpdate(vo);
			res = 1;
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return res;
	}

	// 상품 등록 창, 컬렉션 리스트 가져오기
	@Override
	public ArrayList<CollectionVO> getColCategories() {
		return adminDAO.getColCategories();
	}

	// 상품 등록
	@Override
	public int setProdInsert(MultipartFile thumbnailFile, MultipartFile detailFile, ProductVO vo) {
		
  	try { 
  		String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
  		String detailFileName = detailFile.getOriginalFilename(); 
  		
  		JavawebProvide jp = new JavawebProvide();
  		jp.writeFile(thumbnailFile,thumbnailFileName,"collection");
  		jp.writeFile(detailFile,detailFileName,"collection");
  		
  		vo.setProdThumbnail(thumbnailFileName);
  		vo.setProdDetail(detailFileName);
  		
  		// 상품 코드 제작
  		UUID uid = UUID.randomUUID();
  		String code = "BWP" + uid.toString().substring(0,5);
  		vo.setProdCode(code);
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return adminDAO.setProdInsert(vo);
	}

	// 상품 옵션 등록
	@Override
	public int setProdOpInsert(ArrayList<OptionVO> optionList, String prodCode) {
		return adminDAO.setProdOpInsert(optionList, prodCode);
	}

	// 상품 코드 가져오기
	@Override
	public String getProdCode(int colIdx, String prodName, int prodPrice) {
		return adminDAO.getProdCode(colIdx, prodName, prodPrice);
	}

	// 상품 리스트 가져오기
	@Override
	public ArrayList<ProductVO> getColProductList(int startIndexNo, int pageSize) {
		return adminDAO.getColProductList(startIndexNo, pageSize);
	}

	// 상품 공개/비공개 처리
	@Override
	public void setColProdOpenUpdate(int idx, String prodOpen) {
		adminDAO.setColProdOpenUpdate(idx, prodOpen);
	}

	// 상품 정보 창
	@Override
	public ProductVO getProductInfo(int idx) {
		return adminDAO.getProductInfo(idx);
	}

	// 해당 상품의 옵션들 정보
	@Override
	public ArrayList<OptionVO> getProdOption(int idx) {
		return adminDAO.getProdOption(idx);
	}

	// 컬렉션 상품 정보 수정 창에서, 기존 옵션 삭제
	@Override
	public void setProdOptionDelete(int idx) {
		adminDAO.setProdOptionDelete(idx);
	}

	// 컬렉션 상품 정보 수정
	@Override
	public int setProdUpdate(MultipartFile thumbnailFile, MultipartFile detailFile, ProductVO vo, ProductVO originVO) {
		int res = 0;
		
		try { 
			String thumbnailFileName = thumbnailFile.getOriginalFilename(); 
			String detailFileName = detailFile.getOriginalFilename(); 
			
			// 공백이 아닐 경우 변경 처리
			if(!thumbnailFileName.equals("") && !detailFileName.equals("")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/collection/");
				
				// 기존에 존재하는 파일은 삭제처리
				File thumbnailFileDelete = new File(realPath + originVO.getProdThumbnail());
				File detailFileDelete = new File(realPath + originVO.getProdDetail());
				thumbnailFileDelete.delete();
				detailFileDelete.delete();
				
				// 새로운 파일 업로드
				JavawebProvide jp = new JavawebProvide();
				jp.writeFile(thumbnailFile,thumbnailFileName,"collection");
				jp.writeFile(detailFile,detailFileName,"collection");

				// 새로운 파일명 set
				vo.setProdThumbnail(thumbnailFileName);
				vo.setProdDetail(detailFileName);
			}
			
  		adminDAO.setProdUpdate(vo);
			res = 1;
  
  	} catch (IOException e) { 
  		e.printStackTrace(); 
  	} 
		return res;
	}

	// 기존 상품 옵션 수정
	@Override
	public int setProdOpUpdate(ArrayList<OptionVO> optionList) {
		return adminDAO.setProdOpUpdate(optionList);
	}

	// 상품 이미지 삭제를 위해 파일명 가져오기
	@Override
	public List<ProductVO> getProductPhotoName(List<String> colProdList) {
		return adminDAO.getProductPhotoName(colProdList);
	}

	// 상품 삭제
	@Override
	public void setColProdDelete(List<String> colProdList) {
		adminDAO.setColProdDelete(colProdList);
	}

	// 상품 상태 '품절'로 변경
	@Override
	public void setProdStatusUpdate(int idx, String prodStatus) {
		adminDAO.setProdStatusUpdate(idx, prodStatus);
	}

	// 상품 검색
	@Override
	public ArrayList<ProductVO> getColProdSearchList(String sort, String search, String searchString, String startDate,
			String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getColProdSearchList(sort, search, searchString, startDate,
				endDate, startIndexNo, pageSize);
	}

	// 상품 검색(컬렉션 명으로)
	@Override
	public ArrayList<ProductVO> getColNameProdSearchList(String sort, String search, String searchString,
			String startDate, String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getColNameProdSearchList(sort, search, searchString, startDate,
				endDate, startIndexNo, pageSize);
	}

	// 주문 리스트
	@Override
	public ArrayList<OrderVO> getOrderList(int startIndexNo, int pageSize) {
		return adminDAO.getOrderList(startIndexNo, pageSize);
	}

	// 주문 관리창, 주문 상세 정보
	@Override
	public OrderVO getOrderInfo(int idx) {
		return adminDAO.getOrderInfo(idx);
	}

	// 주문 관리창, 배송 상세 정보
	@Override
	public DeliveryVO getDeliveryInfo(int idx) {
		return adminDAO.getDeliveryInfo(idx);
	}

	// 주문 관리창, 회원 상세 정보
	@Override
	public MemberVO getMemberInfo(String memNickname) {
		return adminDAO.getMemberInfo(memNickname);
	}
	
  // 주문 관리창, 배송지 상세 정보
	@Override
	public AddressVO getAddressInfo(int addressIdx) {
		return adminDAO.getAddressInfo(addressIdx);
	}

	// 주문 관리창, 주문 검색
	@Override
	public ArrayList<OrderVO> getOrderSearchList(String sort, String search, String searchString, String startDate,
			String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getOrderSearchList(sort, search, searchString, startDate, endDate, startIndexNo, pageSize);
	}

  // 주문 관리창, 배송 상세 정보 (정기 구독)
	@Override
	public ArrayList<DeliveryVO> getSubDeliveryInfo(int idx) {
		return adminDAO.getSubDeliveryInfo(idx);
	}

	// 주문 관리창, 정기 구독 상세 정보
	@Override
	public SubscribeVO getSubscribeInfo(int idx) {
		return adminDAO.getSubscribeInfo(idx);
	}

	// 주문 관리창, 송장으로 검색
	@Override
	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(String sort, String search, String searchString,
			String startDate, String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getOrderWithInvoiceSearchList(sort, search, searchString, startDate, endDate, startIndexNo, pageSize);
	}

	// 주문 상세 팝업창, 반품 정보
	@Override
	public RefundVO getRefundInfo(int idx) {
		return adminDAO.getRefundInfo(idx);
	}

	// 회원 리스트
	@Override
	public ArrayList<MemberVO> getMemberList(String sort, String search, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getMemberList(sort, search, searchString, startIndexNo, pageSize);
	}

	// 회원 상세창, 배송지 주소록 (+삭제한 것도 전부)
	@Override
	public ArrayList<AddressVO> getMemberAddressList(String nickname) {
		return adminDAO.getMemberAddressList(nickname);
	}

	// 회원 상세창, 포인트 적립내역
	@Override
	public ArrayList<PointVO> getMemberPointList(String nickname) {
		return adminDAO.getMemberPointList(nickname);
	}

	// 회원 상세창, 포인트 사용내역
	@Override
	public ArrayList<PointUseVO> getMemberPointUseList(String nickname) {
		return adminDAO.getMemberPointUseList(nickname);
	}

	// 회원 상세창, 뉴스레터 구독 내역
	@Override
	public ArrayList<BooksletterVO> getMemberBooksletterList(String nickname) {
		return adminDAO.getMemberBooksletterList(nickname);
	}

	// 회원 상세창, 매거진 정기구독 내역
	@Override
	public ArrayList<SubscribeVO> getMemberSubscribeList(String nickname) {
		return adminDAO.getMemberSubscribeList(nickname);
	}

	// 회원 상세창, 회원 강제탈퇴
	@Override
	public void setMemberForcedDelete(int idx, String memberDelReason) {
		adminDAO.setMemberForcedDelete(idx, memberDelReason);
	}

	// 회원 상세창, 배송지 강제삭제
	@Override
	public void setAddressForcedDelete(int idx) {
		adminDAO.setAddressForcedDelete(idx);
	}

	// 매거진 정기구독 리스트
	@Override
	public ArrayList<OrderVO> getSubscribeSearchList(String sort, String search, String searchString, String startDate, String endDate, int startIndexNo, int pageSize) {
		return adminDAO.getSubscribeSearchList(sort, search, searchString, startDate, endDate, startIndexNo, pageSize);
	}

	// 구독취소 시, 결제액과 환불금 차액의 5% 포인트 적립
	@Override
	public void setOrderPointInsert(SubscribeVO vo, String pointReason, int point) {
		adminDAO.setOrderPointInsert(vo, pointReason, point);
	}

	// 매거진 정기구독 취소신청 승인, 구독테이블 수정
	@Override
	public void setSubscribeCancelUpdate(SubscribeVO vo) {
		adminDAO.setSubscribeCancelUpdate(vo);
	}

	// 매거진 정기구독 취소신청 승인, 환불포인트 지급
	@Override
	public void setPointInsert(SubscribeVO vo, String pointReason) {
		adminDAO.setPointInsert(vo, pointReason);
	}

	// 매거진 정기구독 취소신청 승인, 회원테이블 포인트 변경
	@Override
	public void setMemPointUpdate(SubscribeVO vo) {
		adminDAO.setMemPointUpdate(vo);
	}

	// 상품 반품 리스트
	@Override
	public ArrayList<OrderVO> getRefundSearchList(String sort, String search, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getRefundSearchList(sort, search, searchString, startIndexNo, pageSize);
	}

	// 문의 리스트
	@Override
	public ArrayList<AskVO> getAskSearchList(String sort, String search, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getAskSearchList(sort, search, searchString, startIndexNo, pageSize);
	}

	// 공지사항 리스트
	@Override
	public ArrayList<AskVO> getNoticeSearchList(String search, String searchString, int startIndexNo, int pageSize) {
		return adminDAO.getNoticeSearchList(search, searchString, startIndexNo, pageSize);
	}

	// 공지사항 등록
	@Override
	public int setNoticeInsert(NoticeVO vo) {
		return adminDAO.setNoticeInsert(vo);
	}

	// 공지사항 수정용, 상세정보
	@Override
	public NoticeVO getNoticeInfo(int idx) {
		return adminDAO.getNoticeInfo(idx);
	}

	// 공지사항 수정
	@Override
	public int setNoticeUpdate(NoticeVO vo) {
		return adminDAO.setNoticeUpdate(vo);
	}

	// 공지사항 삭제
	@Override
	public void setNoticeDelete(int idx) {
		adminDAO.setNoticeDelete(idx);
	}

	// 관리자창 메인, 매거진 정기구독 일반통계
	@Override
	public int getMagazineStat(String subStatus) {
		return adminDAO.getMagazineStat(subStatus);
	}

	// 관리자창 메인, 뉴스레터 구독 일반통계
	@Override
	public int getBooksletterStat(String booksletterStatus) {
		return adminDAO.getBooksletterStat(booksletterStatus);
	}

	// 관리자창 메인, 주문/반품 일반통계
	@Override
	public int getOrderStat(String orderStatus) {
		return adminDAO.getOrderStat(orderStatus);
	}

	// 관리자창 메인, 3개의 책(최근 1개월) 일반통계
	@Override
	public int getCommunityStat(String flag) {
		return adminDAO.getCommunityStat(flag);
	}

	// 관리자창 메인, 미확인 문의 일반통계
	@Override
	public int getAskStat(String category) {
		return adminDAO.getAskStat(category);
	}

	// 관리자창 메인, 미확인 신고 일반통계
	@Override
	public int getReportStat(String reportCategory) {
		return adminDAO.getReportStat(reportCategory);
	}


			

	 
	
}
