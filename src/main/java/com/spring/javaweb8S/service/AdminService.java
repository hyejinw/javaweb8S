package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.BooksletterVO;
import com.spring.javaweb8S.vo.ChartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.NoticeVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.PointUseVO;
import com.spring.javaweb8S.vo.PointVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.ProverbVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.RefundVO;
import com.spring.javaweb8S.vo.ReplyVO;
import com.spring.javaweb8S.vo.ReportVO;
import com.spring.javaweb8S.vo.StatisticVO안씀;
import com.spring.javaweb8S.vo.SubscribeVO;

public interface AdminService {

	public ArrayList<DefaultPhotoVO> getDefaultPhoto();

	public int memberDefaultPhotoInsert(MultipartFile file, DefaultPhotoVO vo);

	public ArrayList<ProverbVO> getProverb(int startIndexNo, int pageSize);

	public void setProverb(ProverbVO vo);

	public int memberDefaultPhotoDelete(List<String> defaultPhotoList);

	public void setChangeMemberPhotos(List<String> defaultPhotoList);

	public void setProverbDelete(List<String> proverbList);

	public void setUpdateProverb(ProverbVO vo);

	public ArrayList<BookVO> getBooks(int startIndexNo, int pageSize);

	public ArrayList<BookVO> getDBBooks(String searchString, String search, int startIndexNo, int pageSize);

	public void setBookDelete(List<String> bookList);

	public ArrayList<MagazineVO> getMagazineList(int startIndexNo, int pageSize);

	public void setMagazineOpenUpdate(int idx, String maOpen);

	public void setMagazineDelete(List<String> magazineList);

	public ArrayList<MagazineVO> getMagazineTypeList(int startIndexNo, int pageSize, String maType);

	public int setMagazineInsert(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo);

	public MagazineVO getMagazine(int idx);

	public int setMagazineUpdate(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo, MagazineVO originVO);

	public ArrayList<MagazineVO> getMagazineSearchList(String searchString, String search, String startDate,
			String endDate, int startIndexNo, int pageSize);

	public List<MagazineVO> getMagazinePhotoName(List<String> magazineList);

	public int setColCategoryInsert(MultipartFile thumbnailFile, CollectionVO vo);

	public ArrayList<CollectionVO> getColCategoryList(int startIndexNo, int pageSize);

	public void setColCategoryDelete(List<String> colCategoryList);

	public void setColCategoryOpenUpdate(int idx, String colOpen);

	public void setUpdateColCategory(CollectionVO vo);

	public int setColCategorythumbUpdate(MultipartFile thumbnailFile, CollectionVO vo);

	public ArrayList<CollectionVO> getColCategories();

	public int setProdInsert(MultipartFile thumbnailFile, MultipartFile detailFile, ProductVO vo);

	public int setProdOpInsert(ArrayList<OptionVO> optionList, String prodName);

	public String getProdCode(int colIdx, String prodName, int prodPrice);

	public ArrayList<ProductVO> getColProductList(int startIndexNo, int pageSize);

	public void setColProdOpenUpdate(int idx, String prodOpen);

	public ProductVO getProductInfo(int idx);

	public ArrayList<OptionVO> getProdOption(int idx);

	public void setProdOptionDelete(int idx);

	public int setProdUpdate(MultipartFile thumbnailFile, MultipartFile detailFile, ProductVO vo, ProductVO originVO);

	public int setProdOpUpdate(ArrayList<OptionVO> optionList);

	public List<ProductVO> getProductPhotoName(List<String> colProdList);

	public void setColProdDelete(List<String> colProdList);

	public void setProdStatusUpdate(int idx, String prodStatus);

	public ArrayList<ProductVO> getColProdSearchList(String sort, String search, String searchString, String startDate,
			String endDate, int startIndexNo, int pageSize);

	public ArrayList<ProductVO> getColNameProdSearchList(String sort, String search, String searchString,
			String startDate, String endDate, int startIndexNo, int pageSize);

	public ArrayList<OrderVO> getOrderList(int startIndexNo, int pageSize);

	public OrderVO getOrderInfo(int idx);

	public DeliveryVO getDeliveryInfo(int idx);

	public MemberVO getMemberInfo(String memNickname);

	public AddressVO getAddressInfo(int addressIdx);

	public ArrayList<OrderVO> getOrderSearchList(String sort, String search, String searchString, String startDate,
			String endDate, int startIndexNo, int pageSize);

	public ArrayList<DeliveryVO> getSubDeliveryInfo(int idx);

	public SubscribeVO getSubscribeInfo(int idx);

	public ArrayList<OrderVO> getOrderWithInvoiceSearchList(String sort, String search, String searchString,
			String startDate, String endDate, int startIndexNo, int pageSize);

	public RefundVO getRefundInfo(int idx);

	public ArrayList<MemberVO> getMemberList(String sort, String search, String searchString, int startIndexNo, int pageSize);

	public ArrayList<AddressVO> getMemberAddressList(String nickname);

	public ArrayList<PointVO> getMemberPointList(String nickname);

	public ArrayList<PointUseVO> getMemberPointUseList(String nickname);

	public ArrayList<BooksletterVO> getMemberBooksletterList(String nickname);

	public ArrayList<SubscribeVO> getMemberSubscribeList(String nickname);

	public void setMemberForcedDelete(int idx, String memberDelReason);

	public void setAddressForcedDelete(int idx);

	public ArrayList<OrderVO> getSubscribeSearchList(String sort, String search, String searchString, String startDate, String endDate, int startIndexNo, int pageSize);

	public void setSubscribeCancelUpdate(SubscribeVO vo);

	public void setPointInsert(SubscribeVO vo, String pointReason);

	public void setMemPointUpdate(SubscribeVO vo);

	public ArrayList<OrderVO> getRefundSearchList(String sort, String search, String searchString, int startIndexNo,
			int pageSize);

	public void setOrderPointInsert(SubscribeVO vo, String pointReason, int point);

	public ArrayList<AskVO> getAskSearchList(String sort, String search, String searchString, int startIndexNo, int pageSize);

	public ArrayList<AskVO> getNoticeSearchList(String search, String searchString, int startIndexNo, int pageSize);

	public int setNoticeInsert(NoticeVO vo);

	public NoticeVO getNoticeInfo(int idx);

	public int setNoticeUpdate(NoticeVO vo);

	public void setNoticeDelete(int idx);

	public int getMagazineStat(String subStatus);

	public int getBooksletterStat(String booksletterStatus);

	public int getOrderStat(String orderStatus);

	public int getCommunityStat(String flag);

	public int getAskStat(String category);

	public int getReportStat(String reportCategory);

	public ArrayList<BooksletterVO> getBooksletterSearchList(String sort, String search, String searchString);

	public ArrayList<ReportVO> getReportSearchList(String sort, String search, String searchString);

	public ReportVO getReportInfo(int idx);

	public ReflectionVO getReflectionInfo(int originIdx);

	public ReplyVO getReplyInfo(int originIdx);

	public InspiredVO getInspiredInfo(int originIdx);

	public MemberVO getMemberInfoWithIdx(int originIdx);

	public String getOriginNickname(int originIdx);

	public String getOriginRefIdx(int originIdx);

	public void setReportReplyInsert(String idx, String reply);

	public int getChartStat(String type, int term);




}