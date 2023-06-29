package com.spring.javaweb8S;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.AdminService;
import com.spring.javaweb8S.vo.BookVO;
import com.spring.javaweb8S.vo.DefaultPhotoVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.ProverbVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BookInsertSearch bookInsert;

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
	
	// 회원 기본 프로필 사진 관리 창
	@RequestMapping(value = "/member/memberPhoto", method = RequestMethod.GET)
	public String memberPhotoGet(Model model) {
		ArrayList<DefaultPhotoVO> vos = adminService.getDefaultPhoto();
		
		model.addAttribute("vos", vos);
		return "admin/member/memberPhoto";
	}
	
	
  // 회원 기본 프로필 사진 업로드
  @RequestMapping(value = "/member/memberDefaultPhotoInsert", method = RequestMethod.POST) 
  public String memberDefaultPhotoInsertPost(MultipartFile file, DefaultPhotoVO vo) { 
  
  	int res = adminService.memberDefaultPhotoInsert(file, vo); 
  	if(res == 1) {
  		return "redirect:/message/memberDefaultPhotoInsertOk"; 
		} 
  	else { 
  		return "redirect:/message/memberDefaultPhotoInsertNo"; 
  	} 
	}
	 
	// 회원 기본 프로필 사진 삭제
  @ResponseBody
	@RequestMapping(value = "/member/memberDefaultPhotoDelete", method = RequestMethod.POST)
	public String memberDefaultPhotoDeletePost(String checkRow,	HttpServletRequest request) {
		
		
		List<String> defaultPhotoList = new ArrayList<String>();
		String[] checkedPhotoName = checkRow.split(",");

		for(int i=0; i < checkedPhotoName.length; i++){
			defaultPhotoList.add(checkedPhotoName[i].toString());
		}
		int res = adminService.memberDefaultPhotoDelete(defaultPhotoList);
		
		
		// 서버 사진 삭제
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/member/");
		
		for(int i=0; i < checkedPhotoName.length; i++){
			File file = new File(realPath + checkedPhotoName[i]);
			
			if(file.exists()) {
				file.delete();
			}
		}
		// 해당 이미지 사용 회원, 프로필 'defaultImage.png'로 변경
		adminService.setChangeMemberPhotos(defaultPhotoList);
		
		return Integer.toString(res);
	}
	
  
	// 책 명언 관리 창 + 페이징 처리
	@RequestMapping(value = "/community/proverb", method = RequestMethod.GET)
	public String proverbGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminProverb", "", "");
		ArrayList<ProverbVO> vos = adminService.getProverb(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/community/proverb";
	}
	
	// 책 명언 추가
	@ResponseBody
	@RequestMapping(value = "/community/proverb", method = RequestMethod.POST)
	public String proverbPost(ProverbVO vo) {
		
		adminService.setProverb(vo);
		return "1";
	}
	
	// 책 명언 삭제
	@ResponseBody
	@RequestMapping(value = "/community/proverbDelete", method = RequestMethod.POST)
	public String proverbDeletePost(String checkRow) {
		
		List<String> proverbList = new ArrayList<String>();
		String[] checkedPhotoName = checkRow.split(",");

		for(int i=0; i < checkedPhotoName.length; i++){
			proverbList.add(checkedPhotoName[i].toString());
		}
		adminService.setProverbDelete(proverbList);
		
		return "1";
	}
	
	// 책 명언 수정
	@ResponseBody
	@RequestMapping(value = "/community/proverbUpdate", method = RequestMethod.POST)
	public String proverbUpdatePost(ProverbVO vo) {
		
		adminService.setUpdateProverb(vo);
		return "1";
	}
	
	// 책 등록 관리창 + 페이징 처리
	@RequestMapping(value = "/community/book", method = RequestMethod.GET)
	public String bookGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminBook", "", "");
		ArrayList<BookVO> vos = adminService.getBooks(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/community/book";
	}
	
	// 책 검색
	@RequestMapping(value = "/community/bookInsert", method = RequestMethod.GET)
	public String bookInsertGet(String searchString, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize,
			@RequestParam(name="searchString2", defaultValue = "", required = false) String searchString2,
			@RequestParam(name="search2", defaultValue = "", required = false) String search2,
			@RequestParam(name = "flag", defaultValue = "book", required = false) String flag) {
		
		ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
		
		try {
			bookVOS = bookInsert.bookInsert(searchString);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("bookVOS", bookVOS);
		model.addAttribute("searchString", searchString);
		
		if(flag.equals("bookDB")) {
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminBook", search2, searchString2);
			ArrayList<BookVO> vos = adminService.getDBBooks(searchString, search2, pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("search2", search2);
			model.addAttribute("searchString2", searchString2);
			
			return "admin/community/bookDB";
		}
		return "admin/community/book";
	}
	
	// 책 검색(DB)    
	@RequestMapping(value = "/community/bookDB", method = RequestMethod.GET, produces="application/text; charset=utf-8")
	public String bookDBSearchGet(String searchString, String search, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminBook", search, searchString);
		ArrayList<BookVO> vos = adminService.getDBBooks(searchString, search, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("search2", search);
		model.addAttribute("searchString2", searchString);
		
		return "admin/community/bookDB";
	}
	
	// 책 명언 삭제
	@ResponseBody
	@RequestMapping(value = "/community/bookDelete", method = RequestMethod.POST)
	public String bookDeletePost(String checkRow) {
		
		List<String> bookList = new ArrayList<String>();
		String[] checkedBookIdx = checkRow.split(",");
		
		for(int i=0; i < checkedBookIdx.length; i++){
			bookList.add(checkedBookIdx[i].toString());
		}
		adminService.setBookDelete(bookList);
		
		return "1";
	}
	
	// 매거진 관리 창
	@RequestMapping(value = "/magazine/magazineList", method = RequestMethod.GET)
	public String magazineListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMagazine", "", "");
		ArrayList<MagazineVO> vos =	adminService.getMagazineList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/magazine/magazineList";
	}
	
	
	

}
