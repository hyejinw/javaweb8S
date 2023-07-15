package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.DeliveryVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.ProverbVO;
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




}