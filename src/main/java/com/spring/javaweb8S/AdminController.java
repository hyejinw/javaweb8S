package com.spring.javaweb8S;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.service.AdminService;
import com.spring.javaweb8S.vo.DefaultPhotoVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;

	@RequestMapping(value = "/practice", method = RequestMethod.GET)
	public String practice() {
		return "admin/practice";
	}
	
	// 관리자 메인 창
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String adminPageGet() {
		return "admin/adminPage";
	}
	
	// 회원관리 창
	@RequestMapping(value = "/member/memberList", method = RequestMethod.GET)
	public String memberListGet() {
		return "admin/member/memberList";
	}
	
	// 회원 기본 프로필 관리 창
	@RequestMapping(value = "/member/memberPhoto", method = RequestMethod.GET)
	public String memberPhotoGet(Model model) {
		ArrayList<DefaultPhotoVO> vos = adminService.getDefaultPhoto();
		
		model.addAttribute("vos", vos);
		return "admin/member/memberPhoto";
	}
	
	/*
	 * // 회원 기본 프로필 업로드
	 * 
	 * @RequestMapping(value = "/member/memberDefaultPhotoInsert", method =
	 * RequestMethod.POST) public String memberDefaultPhotoInsertPost(MultipartFile
	 * fName, DefaultPhotoVO vo) { System.out.println("들어옴");
	 * 
	 * System.out.println("fName : " + fName); System.out.println("vo :" + vo);
	 * 
	 * int res = adminService.memberDefaultPhotoInsert(fName, vo); if(res == 1) {
	 * return "redirect:/message/admin/memberDefaultPhotoInsertOk"; } else { return
	 * "redirect:/message/admin/memberDefaultPhotoInsertNo"; } }
	 */
	
	// 회원 기본 프로필 업로드
	@RequestMapping(value = "/member/memberDefaultPhotoInsert", method = RequestMethod.POST)
	public String memberDefaultPhotoInsertPost(DefaultPhotoVO vo) {
		System.out.println("들어옴");
		
		System.out.println("vo :" + vo);
		
		int res = adminService.memberDefaultPhotoInsert(vo);
		if(res == 1) {
			return "redirect:/message/admin/memberDefaultPhotoInsertOk";
		}
		else {
			return "redirect:/message/admin/memberDefaultPhotoInsertNo";
		}
	}
	
	// 회원 기본 프로필 삭제
	@ResponseBody
	@RequestMapping(value = "/member/memberdefaultPhotoDelete", method = RequestMethod.POST)
	public String memberdefaultPhotoDeletePost() {
		
		
		return "1";
	}

}
