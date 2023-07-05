package com.spring.javaweb8S.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.ProverbVO;

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

}