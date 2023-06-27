package com.spring.javaweb8S.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<DefaultPhotoVO> getDefaultPhoto() {
		return adminDAO.getDefaultPhoto();
	}

	/*
	 * @Override public int memberDefaultPhotoInsert(MultipartFile fName,
	 * DefaultPhotoVO vo) {
	 * 
	 * try { String saveFileName = fName.getOriginalFilename(); writeFile(fName,
	 * saveFileName);
	 * 
	 * } catch (IOException e) { e.printStackTrace(); } return
	 * adminDAO.memberDefaultPhotoInsert(vo); }
	 */
	@Override
	public int memberDefaultPhotoInsert(DefaultPhotoVO vo) {
		
		return adminDAO.memberDefaultPhotoInsert(vo);
	}

	/*
	 * // 파일 업로드 private void writeFile(MultipartFile fName, String saveFileName)
	 * throws IOException { byte[] data = fName.getBytes();
	 * 
	 * HttpServletRequest request =
	 * ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).
	 * getRequest(); String realPath =
	 * request.getSession().getServletContext().getRealPath(
	 * "/resources/data/admin/member/");
	 * 
	 * FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
	 * fos.write(data); fos.close(); }
	 */
	
}
