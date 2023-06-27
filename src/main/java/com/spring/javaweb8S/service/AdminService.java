package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.vo.DefaultPhotoVO;

public interface AdminService {

	public ArrayList<DefaultPhotoVO> getDefaultPhoto();

//	public int memberDefaultPhotoInsert(MultipartFile fName, DefaultPhotoVO vo);
	public int memberDefaultPhotoInsert(DefaultPhotoVO vo);

}
