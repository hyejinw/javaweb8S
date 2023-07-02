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
	
	// 매거진 관리 검색
	@RequestMapping(value = "/magazine/magazineListSearch", method = RequestMethod.GET)
	public String magazineListSearchGet(Model model,
			@RequestParam(name="maType", defaultValue = "", required = false) String maType,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="startDate", defaultValue = "", required = false) String startDate,
			@RequestParam(name="endDate", defaultValue = "", required = false) String endDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = new PageVO();
		ArrayList<MagazineVO> vos = new ArrayList<MagazineVO>();
		
		// 정기구독 상품만
		if(!maType.equals("")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMagazineType", maType, "");
			vos =	adminService.getMagazineTypeList(pageVO.getStartIndexNo(), pageSize, maType);
	
			model.addAttribute("maType", maType);
		}
		// 매거진 검색
		else {                                    
			pageVO = pageProcess.totRecCntWithPeriod(pag, pageSize, "adminMagazine", search, searchString, startDate, endDate);
			vos =	adminService.getMagazineSearchList(searchString, search, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
			
			model.addAttribute("search", search);
			model.addAttribute("searchString", searchString);
			model.addAttribute("startDate", startDate);
			model.addAttribute("endDate", endDate);
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/magazine/magazineListSearch";
	}
	
	// 매거진 공개 변경
	@ResponseBody
	@RequestMapping(value = "/magazine/magazineOpenUpdate", method = RequestMethod.POST)
	public String magazineOpenUpdatePost(String maOpen, int idx) {
		
		if(maOpen.equals("공개")) maOpen = "비공개";
		else maOpen = "공개";
		
		adminService.setMagazineOpenUpdate(idx, maOpen);
		
		return "1";
	}
	
	// 매거진 삭제
	@ResponseBody
	@RequestMapping(value = "/magazine/magazineDelete", method = RequestMethod.POST)
	public String magazineDeletePost(String checkRow) {
		
		List<String> magazineList = new ArrayList<String>();
		String[] checkedMagazineIdx = checkRow.split(",");
		
		for(int i=0; i < checkedMagazineIdx.length; i++){
			magazineList.add(checkedMagazineIdx[i].toString());
		}
		adminService.setMagazineDelete(magazineList);
		
		return "1";
	}
	
	// 매거진 등록 창
	@RequestMapping(value = "/magazine/magazineInsert", method = RequestMethod.GET)
	public String magazineInsertGet() {
		return "admin/magazine/magazineInsert";
	}
	
	// 매거진 등록
	@RequestMapping(value = "/magazine/magazineInsert", method = RequestMethod.POST)
	public String magazineInsertPost(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo) {
		
		int res = adminService.setMagazineInsert(thumbnailFile, detailFile, vo);
		if(res == 1) return "redirect:/message/magazineInsertOk";
		else return "redirect:/message/magazineInsertNo";
	}
	
	// 매거진 수정 창
	@RequestMapping(value = "/magazine/magazineUpdate", method = RequestMethod.GET)
	public String magazineUpdateGet(int idx, Model model) {
		
		MagazineVO vo = adminService.getMagazine(idx);
		model.addAttribute("vo", vo);

		return "admin/magazine/magazineUpdate";
	}
	
	// 매거진 수정
	@RequestMapping(value = "/magazine/magazineUpdate", method = RequestMethod.POST)
	public String magazineUpdatePost(MultipartFile thumbnailFile, MultipartFile detailFile, MagazineVO vo) {
		MagazineVO originVO = adminService.getMagazine(vo.getIdx());
		
		int res = adminService.setMagazineUpdate(thumbnailFile, detailFile, vo, originVO);
		if(res == 1) return "redirect:/message/magazineUpdateOk";
		else return "redirect:/message/magazineUpdateNo?idx="+vo.getIdx();
	}
	
	
}
