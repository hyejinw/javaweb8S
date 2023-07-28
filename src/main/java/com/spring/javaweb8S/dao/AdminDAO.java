package com.spring.javaweb8S.dao;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

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
import com.spring.javaweb8S.vo.SubscribeVO;

public interface AdminDAO {

	// 책 등록 및 검색
	public BookVO getBookIsbn(@Param("isbn") String isbn);
	public void setBook(@Param("vo") BookVO vo);

	// 페이징 처리용
	public int proverbTotRecCnt();
	public int bookTotRecCnt();
	public int bookTotRecCntSearch(@Param("search") String search, @Param("searchString") String searchString2);
	public int magazineTotRecCnt();
	public int magazineTotRecCntWithPeriod(@Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int magazineTypeTotRecCnt(@Param("maType") String maType);
	public int colCategoryTotRecCnt();
	public int colProductTotRecCnt();
	public int colProdTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int colProdColNameTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int orderTotRecCnt();
	public int orderTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public ArrayList<OrderVO> orderWithInvoiceTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int memberListTotRecCnt(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);
	public int subscribeTotRecCntWithPeriod(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate, @Param("endDate") String endDate);
	public int refundListTotRecCnt(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);
	public int askListTotRecCnt(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString);
	public int noticeListTotRecCnt(@Param("search") String search, @Param("searchString") String searchString);	

	public ArrayList<DefaultPhotoVO> getDefaultPhoto();

	public int memberDefaultPhotoInsert(@Param("vo") DefaultPhotoVO vo);

	public ArrayList<ProverbVO> getProverb(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setProverb(@Param("vo") ProverbVO vo);

	public int memberDefaultPhotoDelete(@Param("defaultPhotoList") List<String> defaultPhotoList);

	public void setChangeMemberPhotos(@Param("defaultPhotoList") List<String> defaultPhotoList);

	public void setProverbDelete(@Param("proverbList") List<String> proverbList);

	public void setUpdateProverb(@Param("vo") ProverbVO vo);

	public ArrayList<BookVO> getBooks(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<BookVO> getDBBooks(@Param("searchString") String searchString, @Param("search") String search, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setBookDelete(@Param("bookList") List<String> bookList);

	public ArrayList<MagazineVO> getMagazineList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setMagazineOpenUpdate(@Param("idx") int idx, @Param("maOpen") String maOpen);
	
	public void setMagazineDelete(@Param("magazineList") List<String> magazineList);
	
	public ArrayList<MagazineVO> getMagazineTypeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("maType") String maType);
	
	public int setMagazineInsert(@Param("vo") MagazineVO vo);
	
	public MagazineVO getMagazine(@Param("idx") int idx);

	public void setMagazineUpdate(@Param("vo") MagazineVO vo);
	
	public ArrayList<MagazineVO> getMagazineSearchList(@Param("searchString") String searchString, @Param("search") String search, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public List<MagazineVO> getMagazinePhotoName(@Param("magazineList") List<String> magazineList);

	public int setColCategoryInsert(@Param("vo") CollectionVO vo);
	
	public ArrayList<CollectionVO> getColCategoryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setColCategoryDelete(@Param("colCategoryList") List<String> colCategoryList);
	
	public void setColCategoryOpenUpdate(@Param("idx") int idx, @Param("colOpen") String colOpen);
	
	public void setUpdateColCategory(@Param("vo") CollectionVO vo);
	
	public void setColCategorythumbUpdate(@Param("vo") CollectionVO vo);
	
	public ArrayList<CollectionVO> getColCategories();
	
	public int setProdInsert(@Param("vo") ProductVO vo);
	
	public int setProdOpInsert(@Param("optionList") ArrayList<OptionVO> optionList, @Param("prodCode") String prodCode);
	
	public String getProdCode(@Param("colIdx") int colIdx, @Param("prodName") String prodName, @Param("prodPrice") int prodPrice);
	
	public ArrayList<ProductVO> getColProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setColProdOpenUpdate(@Param("idx") int idx, @Param("prodOpen") String prodOpen);
	
	public ProductVO getProductInfo(@Param("idx") int idx);
	
	public ArrayList<OptionVO> getProdOption(@Param("idx") int idx);
	
	public void setProdOptionDelete(@Param("idx") int idx);
	
	public void setProdUpdate(@Param("vo") ProductVO vo);
	
	public int setProdOpUpdate(@Param("optionList") ArrayList<OptionVO> optionList);
	
	public List<ProductVO> getProductPhotoName(@Param("colProdList") List<String> colProdList);
	
	public void setColProdDelete(@Param("colProdList") List<String> colProdList);
	
	public void setProdStatusUpdate(@Param("idx") int idx, @Param("prodStatus") String prodStatus);
	
	public ArrayList<ProductVO> getColProdSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<ProductVO> getColNameProdSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<OrderVO> getOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public OrderVO getOrderInfo(@Param("idx") int idx);
	
	public DeliveryVO getDeliveryInfo(@Param("idx") int idx);
	
	public MemberVO getMemberInfo(@Param("memNickname") String memNickname);
	
	public AddressVO getAddressInfo(@Param("addressIdx") int addressIdx);
	
	public ArrayList<OrderVO> getOrderSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<DeliveryVO> getSubDeliveryInfo(@Param("idx") int idx);
	
	public SubscribeVO getSubscribeInfo(@Param("idx") int idx);
	
	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public RefundVO getRefundInfo(@Param("idx") int idx);
	
	public ArrayList<MemberVO> getMemberList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<AddressVO> getMemberAddressList(@Param("nickname") String nickname);
	
	public ArrayList<PointVO> getMemberPointList(@Param("nickname") String nickname);
	
	public ArrayList<PointUseVO> getMemberPointUseList(@Param("nickname") String nickname);
	
	public ArrayList<BooksletterVO> getMemberBooksletterList(@Param("nickname") String nickname);
	
	public ArrayList<SubscribeVO> getMemberSubscribeList(@Param("nickname") String nickname);
	
	public void setMemberForcedDelete(@Param("idx") int idx, @Param("memberDelReason") String memberDelReason);
	
	public void setAddressForcedDelete(@Param("idx") int idx);
	
	public ArrayList<OrderVO> getSubscribeSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startDate") String startDate,
			@Param("endDate") String endDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setSubscribeCancelUpdate(@Param("vo") SubscribeVO vo);
	
	public void setPointInsert(@Param("vo") SubscribeVO vo, @Param("pointReason") String pointReason);
	
	public void setMemPointUpdate(@Param("vo") SubscribeVO vo);
	
	public ArrayList<OrderVO> getRefundSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public void setOrderPointInsert(@Param("vo") SubscribeVO vo, @Param("pointReason") String pointReason, @Param("point") int point);
	
	public ArrayList<AskVO> getAskSearchList(@Param("sort") String sort, @Param("search") String search, @Param("searchString") String searchString, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public ArrayList<AskVO> getNoticeSearchList(@Param("search") String search, @Param("searchString") String searchString, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public int setNoticeInsert(@Param("vo") NoticeVO vo);
	
	public NoticeVO getNoticeInfo(@Param("idx") int idx);
	
	public int setNoticeUpdate(@Param("vo") NoticeVO vo);
	
	public void setNoticeDelete(@Param("idx") int idx);
	
	public int getMagazineStat(@Param("subStatus") String subStatus);
	
	public int getBooksletterStat(@Param("booksletterStatus") String booksletterStatus);
	
	public int getOrderStat(@Param("orderStatus") String orderStatus);
	
	public int getCommunityStat(@Param("flag") String flag);
	
	public int getAskStat(@Param("category") String category);
	
	public int getReportStat(@Param("reportCategory") String reportCategory);


	
	




}
