package com.spring.javaweb8S;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb8S.common.AutoUpdate;
import com.spring.javaweb8S.common.BookInsertSearch;
import com.spring.javaweb8S.common.ImageManager;
import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.AdminService;
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

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BookInsertSearch bookInsert;
	
	@Autowired
	AutoUpdate autoUpdate;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	ImageManager imageManager;
	
	// 관리자 메인 창
	@RequestMapping(value = "/adminPage", method = RequestMethod.GET)
	public String adminPageGet(Model model) {

		// 일반 통계
		// 1) 구독관련
		// 1-1) 매거진 정기구독
		int s1 = adminService.getMagazineStat("구독중");
		int s2 = adminService.getMagazineStat("구독종료");
		int s3 = adminService.getMagazineStat("구독취소신청");
		int s4 = adminService.getMagazineStat("구독취소");
		model.addAttribute("s1", s1);
		model.addAttribute("s2", s2);
		model.addAttribute("s3", s3);
		model.addAttribute("s4", s4);
		
		// 1-2) 뉴스레터 구독
		int l1 = adminService.getBooksletterStat("구독중");
		int l2 = adminService.getBooksletterStat("구독취소");
		model.addAttribute("l1", l1);
		model.addAttribute("l2", l2);
	
		// 2) 주문 / 반품
		int o1 = adminService.getOrderStat("결제완료");
		int o2 = adminService.getOrderStat("배송준비중");
		int o3 = adminService.getOrderStat("배송중");
		model.addAttribute("o1", o1);
		model.addAttribute("o2", o2);
		model.addAttribute("o3", o3);
		
		int r1 = adminService.getOrderStat("반품신청");
		int r2 = adminService.getOrderStat("반품중");
		int r3 = adminService.getOrderStat("반품완료");
		model.addAttribute("r1", r1);
		model.addAttribute("r2", r2);
		model.addAttribute("r3", r3);
		
		// 3) 3개의 책(최근 1개월)
		int c1 = adminService.getCommunityStat("기록");
		int c2 = adminService.getCommunityStat("문장수집");
		model.addAttribute("c1", c1);
		model.addAttribute("c2", c2);
		
		// 4) 미확인 문의
		int a1 = adminService.getAskStat("그외");
		int a2 = adminService.getAskStat("커뮤니티");
		model.addAttribute("a1", a1);
		model.addAttribute("a2", a2);
		
		// 5) 미확인 신고
		int p1 = adminService.getReportStat("기록");
		int p2 = adminService.getReportStat("댓글");
		int p3 = adminService.getReportStat("문장수집");
		int p4 = adminService.getReportStat("회원");
		model.addAttribute("p1", p1);
		model.addAttribute("p2", p2);
		model.addAttribute("p3", p3);
		model.addAttribute("p4", p4);
		
		
		return "admin/adminPage";
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
		// 해당 이미지 사용 회원, 프로필 'defaultImage.jpg'로 변경
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
	public String magazineDeletePost(String checkRow,	HttpServletRequest request) {
		
		List<String> magazineList = new ArrayList<String>();
		String[] checkedMagazineIdx = checkRow.split(",");
		
		for(int i=0; i < checkedMagazineIdx.length; i++){
			magazineList.add(checkedMagazineIdx[i].toString());
		}
		
		// 서버 사진 삭제
		List<MagazineVO> magazinePhotoName = adminService.getMagazinePhotoName(magazineList);
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/magazine/");
		
		for(int i=0; i < magazinePhotoName.size(); i++){
			File file1 = new File(realPath + magazinePhotoName.get(i).getMaThumbnail());
			File file2 = new File(realPath + magazinePhotoName.get(i).getMaDetail());
			
			if(file1.exists()) file1.delete();
			if(file2.exists()) file2.delete();
		}
		// DB에서 삭제
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
	
	// 컬렉션 카테고리 등록 창 및 리스트
	@RequestMapping(value = "/collection/colCategoryList", method = RequestMethod.GET)
	public String colCategoryInsertGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminColCategory", "", "");
		ArrayList<CollectionVO> vos = adminService.getColCategoryList(pageVO.getStartIndexNo(), pageSize);

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/collection/colCategoryList";
	}
	
	// 컬렉션 카테고리 등록
	@RequestMapping(value = "/collection/colCategoryList", method = RequestMethod.POST)
	public String colCategoryInsertPost(MultipartFile thumbnailFile, CollectionVO vo) {
		
		int res = adminService.setColCategoryInsert(thumbnailFile, vo);
		if(res == 1) return "redirect:/message/colCategoryInsertOk";
		else return "redirect:/message/colCategoryInsertNo";
	}
	
	// 컬렉션 카테고리 삭제
	@ResponseBody
	@RequestMapping(value = "/collection/colCategoryDelete", method = RequestMethod.POST)
	public String colCategoryDeletePost(String checkRow,	HttpServletRequest request) {
		
		List<String> colCategoryList = new ArrayList<String>();
		String[] checkedcolCategoryThumbnail = checkRow.split(",");
		
		for(int i=0; i < checkedcolCategoryThumbnail.length; i++){
			colCategoryList.add(checkedcolCategoryThumbnail[i].toString());
		}
		
		// 서버 사진 삭제
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/collection/");
		
		for(int i=0; i < colCategoryList.size(); i++){
			File file = new File(realPath + colCategoryList.get(i));
			
			if(file.exists()) file.delete();
		}
		// DB에서 삭제
		adminService.setColCategoryDelete(colCategoryList);
		
		return "1";
	}

	
	// 컬렉션 카테고리 공개 변경 + 관련 상품 전부 똑같이 처리
	@ResponseBody
	@RequestMapping(value = "/collection/colCategoryOpenUpdate", method = RequestMethod.POST)
	public String colCategoryOpenUpdatePost(String colOpen, int idx) {
		
		if(colOpen.equals("공개")) colOpen = "비공개";
		else colOpen = "공개";
		adminService.setColCategoryOpenUpdate(idx, colOpen);
		
		return "1";
	}
	
	// 컬렉션 카테고리 수정
	@ResponseBody
	@RequestMapping(value = "/collection/colCategoryUpdate", method = RequestMethod.POST)
	public String colCategoryUpdatePost(CollectionVO vo) {
		adminService.setUpdateColCategory(vo);
		
		return "1";
	}
	
	// 컬렉션 카테고리 썸네일 수정
	@RequestMapping(value = "/collection/colCategorythumbUpdate", method = RequestMethod.POST)
	public String colCategorythumbUpdatePost(MultipartFile thumbnailFile, CollectionVO vo) {
		
		int res = adminService.setColCategorythumbUpdate(thumbnailFile, vo);
		if(res == 1) return "redirect:/message/colCategorythumbUpdateOk";
		else return "redirect:/message/colCategorythumbUpdateNo";
	}
	
	// 컬렉션 상품 등록 창
	@RequestMapping(value = "/collection/colProdInsert", method = RequestMethod.GET)
	public String colProdInsertGet(Model model,
			 @RequestParam(name="colIdx", defaultValue = "", required = false) String colIdx,
			 @RequestParam(name="prodName", defaultValue = "", required = false) String prodName,
			 @RequestParam(name="prodPrice", defaultValue = "", required = false) String prodPrice) {
		
		ArrayList<CollectionVO> colCategoryVOS = adminService.getColCategories();
		model.addAttribute("colCategoryVOS", colCategoryVOS);
		
		// 책 검색 시, 사용
		model.addAttribute("colIdx", colIdx);
		model.addAttribute("prodName", prodName);
		model.addAttribute("prodPrice", prodPrice);
		
		return "admin/collection/colProdInsert";
	}
	
	// 컬렉션 상품 등록 창에서 도서 검색
	@RequestMapping(value = "/collection/bookSelect", method = RequestMethod.GET)
	public String bookSelectGet(String searchString, Model model,
			 @RequestParam(name="colIdx", defaultValue = "", required = false) String colIdx,
			 @RequestParam(name="prodName", defaultValue = "", required = false) String prodName,
			 @RequestParam(name="prodPrice", defaultValue = "", required = false) String prodPrice) {
		
		ArrayList<BookVO> bookVOS = new ArrayList<BookVO>();
		
		try {
			bookVOS = bookInsert.bookInsert(searchString);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("bookVOS", bookVOS);
		model.addAttribute("searchString", searchString);
		
		ArrayList<CollectionVO> colCategoryVOS = adminService.getColCategories();
		model.addAttribute("colCategoryVOS", colCategoryVOS);
		
		// 책 검색 시, 사용
		model.addAttribute("colIdx", colIdx);
		model.addAttribute("prodName", prodName);
		model.addAttribute("prodPrice", prodPrice);
	
		return "admin/collection/colProdInsert";
	}
	
	// 컬렉션 상품 + 옵션 등록
	@RequestMapping(value = "/collection/colProdInsert", method = RequestMethod.POST)
	public String colProdInsertPost(MultipartFile thumbnailFile, MultipartFile detailFile,
			ProductVO vo, String[] opName, int[] opPrice, int[] opStock) {
		
		int res = 0, res2 = 0;

		// 1. 상품 등록
		// 품절 상태 확인용
		int totStock = 0;
		for(int i=0; i<opStock.length; i++) {
			totStock += opStock[i];
		}
		if(totStock == 0) {
			vo.setProdStatus("품절");
		}
		else {
			vo.setProdStatus("판매");
		}
		
		res = adminService.setProdInsert(thumbnailFile, detailFile, vo);
		
		// 2. 상품 옵션 등록
		ArrayList<OptionVO> optionList = new ArrayList<OptionVO>();
		
		for(int i=0; i<opName.length; i++) {
			OptionVO optionVOi = new OptionVO();
			optionVOi.setOpName(opName[i]);
			optionVOi.setOpPrice(opPrice[i]);
			optionVOi.setOpStock(opStock[i]);
			
			optionList.add(optionVOi);
		}
		
		// 상품 코드 가져오기
		String prodCode = adminService.getProdCode(vo.getColIdx(), vo.getProdName(), vo.getProdPrice());
		if(res == 1) res2 = adminService.setProdOpInsert(optionList, prodCode);
		
		if(res2 != 0) return "redirect:/message/colProdInsertOk";
		else return "redirect:/message/colProdInsertNo";
	}
	
	// 컬렉션 상품 관리 창
	@RequestMapping(value = "/collection/colProdList", method = RequestMethod.GET)
	public String colProdListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminColProduct", "", "");
		ArrayList<ProductVO> vos =	adminService.getColProductList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/collection/colProdList";
	}

	// 컬렉션 상품 공개 변경
	@ResponseBody
	@RequestMapping(value = "/collection/colProdOpenUpdate", method = RequestMethod.POST, produces="application/text; charset=utf-8")
	public String colProdOpenUpdatePost(String prodOpen, int idx) {
		
		if(prodOpen.equals("공개")) prodOpen = "비공개";
		else prodOpen = "공개";
		
		adminService.setColProdOpenUpdate(idx, prodOpen);
		return "1";
	}
	
	// 컬렉션 상품 정보 창
	@RequestMapping(value = "/collection/colProdInfo", method = RequestMethod.GET)
	public String colProdInfoGet(Model model, int idx) {
		
		// 컬렉션 정보
		ArrayList<CollectionVO> colCategoryVOS = adminService.getColCategories();
		model.addAttribute("colCategoryVOS", colCategoryVOS);
		
		// 해당 상품 정보
		ProductVO vo = adminService.getProductInfo(idx);
		model.addAttribute("vo", vo);
		
		// 옵션 정보
		ArrayList<OptionVO> optionVOS = adminService.getProdOption(idx);
		model.addAttribute("optionVOS", optionVOS);
		model.addAttribute("optionTotNum", optionVOS.size());
		
		return "admin/collection/colProdInfo";
	}
	
	// 컬렉션 상품 정보 수정 창에서, 기존 옵션 삭제
	@ResponseBody
	@RequestMapping(value = "/collection/prodOptionDelete", method = RequestMethod.POST)
	public String prodOptionDeletePost(int idx) {
		adminService.setProdOptionDelete(idx);
		return "";
	}
	
	
	// 컬렉션 상품 정보 수정
	@RequestMapping(value = "/collection/colProdUpdate", method = RequestMethod.POST)
	public String colProdUpdatePost(MultipartFile thumbnailFile, MultipartFile detailFile,
			ProductVO vo, int[] opIdx, String[] opName, int[] opPrice, int[] opStock,
			@RequestParam(name="newOpName", defaultValue = "", required = false) String[] newOpName,
			@RequestParam(name="newOpPrice", defaultValue = "", required = false) int[] newOpPrice,
			@RequestParam(name="newOpStock", defaultValue = "", required = false) int[] newOpStock) {
		
		int res = 0, res2 = 0;

		// 1. 상품 수정
		// 기존 정보 가져오기
		ProductVO originVO = adminService.getProductInfo(vo.getIdx());
		
		res = adminService.setProdUpdate(thumbnailFile, detailFile, vo, originVO);
		
		// 2. 기존 상품 옵션 수정
		ArrayList<OptionVO> optionList = new ArrayList<OptionVO>();

		for(int i=0; i<opName.length; i++) {
			OptionVO optionVOi = new OptionVO();
			optionVOi.setIdx(opIdx[i]);
			optionVOi.setOpName(opName[i]);
			optionVOi.setOpPrice(opPrice[i]);
			optionVOi.setOpStock(opStock[i]);
			
			optionList.add(optionVOi);
		}
		
		if(res == 1) res2 = adminService.setProdOpUpdate(optionList);

		// 상품 새 옵션 추가
		if(newOpName.length != 0) {
			ArrayList<OptionVO> newOptionList = new ArrayList<OptionVO>();
			
			for(int i=0; i<newOpName.length; i++) {
				OptionVO optionVOi = new OptionVO();
				optionVOi.setOpName(newOpName[i]);
				optionVOi.setOpPrice(newOpPrice[i]);
				optionVOi.setOpStock(newOpStock[i]);
				
				newOptionList.add(optionVOi);
			}

			if(res == 1) res2 = adminService.setProdOpInsert(newOptionList, vo.getProdCode());
		}
		
		// 3. 품절 상태 확인용
		int totStock = 0;
		for(int i=0; i<opStock.length; i++) {
			totStock += opStock[i];
		}
		if(newOpStock.length != 0) {
			for(int i=0; i<newOpStock.length; i++) {
				totStock += newOpStock[i];
			}
		}
		if(totStock == 0) {
			adminService.setProdStatusUpdate(vo.getIdx(), "품절");
		}
		
		
		if(res2 != 0) return "redirect:/message/colProdUpdateOk?idx=" + vo.getIdx();
		else return "redirect:/message/colProdUpdateNo?idx?idx=" + vo.getIdx();
	}
	
	// 상품 삭제
	@ResponseBody
	@RequestMapping(value = "/collection/colProdDelete", method = RequestMethod.POST)
	public String colProdDeletePost(String checkRow,	HttpServletRequest request) {
		
		List<String> colProdList = new ArrayList<String>();
		String[] checkedProductIdx = checkRow.split(",");
		
		for(int i=0; i < checkedProductIdx.length; i++){
			colProdList.add(checkedProductIdx[i].toString());
		}
		
		// 서버 사진 삭제
		List<ProductVO> productPhotoName = adminService.getProductPhotoName(colProdList);
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/collection/");
		
		for(int i=0; i < productPhotoName.size(); i++){
			File file1 = new File(realPath + productPhotoName.get(i).getProdThumbnail());
			File file2 = new File(realPath + productPhotoName.get(i).getProdDetail());
			
			if(file1.exists()) file1.delete();
			if(file2.exists()) file2.delete();
		}
		// DB에서 삭제
		adminService.setColProdDelete(colProdList);
		
		return "1";
	}
	
	// 상품 검색
	@RequestMapping(value = "/collection/colProdListSearch", method = RequestMethod.GET)
	public String colProdListSearchGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="startDate", defaultValue = "", required = false) String startDate,
			@RequestParam(name="endDate", defaultValue = "", required = false) String endDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = new PageVO();
		ArrayList<ProductVO> vos = new ArrayList<ProductVO>();
		
		if(search.equals("colName")) {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "adminColNameProduct", sort, search, searchString, startDate, endDate);
			vos = adminService.getColNameProdSearchList(sort, search, searchString, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
		}
		
		else {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "adminColProduct", sort, search, searchString, startDate, endDate);
			vos = adminService.getColProdSearchList(sort, search, searchString, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
		}
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/collection/colProdListSearch";
	}
	
	// 주문 관리창
	@RequestMapping(value = "/order/orderList", method = RequestMethod.GET)
	public String orderListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminOrder", "", "");
		ArrayList<OrderVO> vos =	adminService.getOrderList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/order/orderList";
	}
	
	// 주문 관리창, 주문 상세 정보(팝업)
	@RequestMapping(value = "/order/orderInfo", method = RequestMethod.GET)
	public String orderInfoGet(Model model, int idx, String memNickname) {

		OrderVO vo = adminService.getOrderInfo(idx);
		DeliveryVO deliveryVO = adminService.getDeliveryInfo(idx);
		MemberVO memberVO = adminService.getMemberInfo(memNickname);
		AddressVO addressVO = adminService.getAddressInfo(vo.getAddressIdx());
		RefundVO refundVO = adminService.getRefundInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("refundVO", refundVO);
		
		return "admin/order/orderInfo";
	}
	
	// 주문 관리창, 정기구독 주문 상세 정보(팝업)
	@RequestMapping(value = "/order/subOrderInfo", method = RequestMethod.GET)
	public String subOrderInfoGet(Model model, int idx, String memNickname) {
		
		OrderVO vo = adminService.getOrderInfo(idx);
		ArrayList<DeliveryVO> deliveryVOS = adminService.getSubDeliveryInfo(idx);
		MemberVO memberVO = adminService.getMemberInfo(memNickname);
		AddressVO addressVO = adminService.getAddressInfo(vo.getAddressIdx());
		SubscribeVO subscribeVO = adminService.getSubscribeInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("deliveryVOS", deliveryVOS);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("subscribeVO", subscribeVO);
		
		return "admin/order/subOrderInfo";
	}
	
	// 주문 검색
	@RequestMapping(value = "/order/orderListSearch", method = RequestMethod.GET)
	public String orderListSearchGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="startDate", defaultValue = "", required = false) String startDate,
			@RequestParam(name="endDate", defaultValue = "", required = false) String endDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		
		PageVO pageVO = new PageVO();
		ArrayList<OrderVO> vos = new ArrayList<OrderVO>();
		
		if(search.equals("invoice")) {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "adminOrderWithInvoice", sort, search, searchString, startDate, endDate);
			vos = adminService.getOrderWithInvoiceSearchList(sort, search, searchString, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
		}
		else {
			pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "adminOrder", sort, search, searchString, startDate, endDate);
			vos = adminService.getOrderSearchList(sort, search, searchString, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
		}
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/order/orderListSearch";
	}
	
	// 회원리스트 
	@RequestMapping(value = "/member/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "nickname", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		// sort에 들어갈 값: 전체, 탈퇴, 미탈퇴
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", sort+"/"+search, searchString);
		ArrayList<MemberVO> vos = adminService.getMemberList(sort, search, searchString, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/member/memberList";
	}
	
	// 회원 상세정보창(팝업)
	@RequestMapping(value = "/member/memInfo", method = RequestMethod.GET)
	public String memInfoGet(Model model, String nickname) {
		
		// 1) 회원정보
		MemberVO memberVO = adminService.getMemberInfo(nickname);
		model.addAttribute("memberVO", memberVO);
		
		// 2) 배송지 주소록   (+삭제한 것도 전부)
		ArrayList<AddressVO> addressVOS = adminService.getMemberAddressList(nickname);
		model.addAttribute("addressVOS", addressVOS);
		
		// 3-1) 포인트 적립 내역
		ArrayList<PointVO> pointVOS = adminService.getMemberPointList(nickname);
		model.addAttribute("pointVOS", pointVOS);
		
		// 3-2) 포인트 사용 내역
		ArrayList<PointUseVO> pointUseVOS = adminService.getMemberPointUseList(nickname);
		model.addAttribute("pointUseVOS", pointUseVOS);
		
		// 4-1) 뉴스레터 구독  (+삭제한 것도 전부)
		ArrayList<BooksletterVO> booksletterVOS = adminService.getMemberBooksletterList(nickname);
		model.addAttribute("booksletterVOS", booksletterVOS);
		
		// 4-2) 매거진 정기구독 
		ArrayList<SubscribeVO> subscribeVOS = adminService.getMemberSubscribeList(nickname);
		model.addAttribute("subscribeVOS", subscribeVOS);
		
		return "admin/member/memInfo";
	}
	
	// 회원 상세정보창(팝업), 회원 강제탈퇴
	@ResponseBody
	@RequestMapping(value = "/member/memberForcedDelete", method = RequestMethod.POST)
	public String memberForcedDeletePost(int idx, String memberDelReason) {
		
		adminService.setMemberForcedDelete(idx, memberDelReason);
		return "";
	}
	
	// 회원 상세정보창(팝업), 배송지 강제 삭제
	@ResponseBody
	@RequestMapping(value = "/member/addressForcedDelete", method = RequestMethod.POST)
	public String addressForcedDeletePost(int idx) {
		
		adminService.setAddressForcedDelete(idx);
		return "";
	}
	
	// 매거진 정기구독 관리창
	@RequestMapping(value = "/magazine/subscribeList", method = RequestMethod.GET)
	public String subscribeListGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "memNickname", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="startDate", defaultValue = "", required = false) String startDate,
			@RequestParam(name="endDate", defaultValue = "", required = false) String endDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		// sort에 들어올 수 있는 값: 전체, 구독중, 구독취소신청, 구독취소, 구독종료
		PageVO pageVO = pageProcess.totRecCntWithPeriodAndSort(pag, pageSize, "adminSubscribe", sort, search, searchString, startDate, endDate);
		ArrayList<OrderVO> vos = adminService.getSubscribeSearchList(sort, search, searchString, startDate, endDate, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/magazine/subscribeList";
	}
	
	// 매거진 구독취소 승인창(팝업)
	@RequestMapping(value = "/magazine/subscribeCancel", method = RequestMethod.GET)
	public String subscribeCancelGet(int idx, String memNickname, Model model) {
		
		OrderVO vo = adminService.getOrderInfo(idx);
		
		ArrayList<DeliveryVO> deliveryVOS = adminService.getSubDeliveryInfo(idx);
		MemberVO memberVO = adminService.getMemberInfo(memNickname);
		AddressVO addressVO = adminService.getAddressInfo(vo.getAddressIdx());
		SubscribeVO subscribeVO = adminService.getSubscribeInfo(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("deliveryVOS", deliveryVOS);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("subscribeVO", subscribeVO);
		
		return "admin/magazine/subscribeCancel";
	}
	
	// 매거진 구독취소 승인
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/magazine/subscribeCancel", method = RequestMethod.POST)
	public String subscribeCancelPost(SubscribeVO vo, String email, int paidPrice, HttpServletRequest request) throws MessagingException {
		
		// 1) 매거진 구독테이블 수정
		adminService.setSubscribeCancelUpdate(vo);
		
		// 2-0) 구독취소 시, 결제액과 환불금 차액의 5% 포인트 적립.
		if(paidPrice - vo.getSubRefund() > 0) {
			adminService.setOrderPointInsert(vo, "상품구매확정", paidPrice - vo.getSubRefund());
		}
		
		if(vo.getSubRefundPoint() != 0) {
			// 2-1) 포인트 업데이트(정기구독취소 포인트반환)
			adminService.setPointInsert(vo, "정기구독취소 포인트반환");

			// 2-2) 회원 테이블 포인트 수정
			adminService.setMemPointUpdate(vo);
		}
		
		// 3) 이메일 전송
		String title = "[책(의)세계] 매거진 Chaeg 정기구독 취소신청이 승인되었습니다.";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		String content = "";
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송
		content += "<p><img src=\"cid:logo.png\" width='300px'></p>";
		content += "<br><h4>안녕하세요. "+vo.getMemNickname()+"님 책(의)세계입니다.<br>매거진 Chaeg 정기구독 취소신청이 승인되었습니다.</h4><br>";
		content += "<br><h4>환불금액) "+vo.getSubRefund()+"원 , 환불 포인트) "+vo.getSubRefundPoint()+" </h4>";
		content += "<h3>기쁜 마음으로, 책(의)세계 드림</h3><br>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런 후, 다시 보관함에 담기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		File file = new File(realPath + "logo.png");
		messageHelper.addInline("logo.png", file);

		// 메일 전송
		mailSender.send(message);
		
		return "";
	}
	
	// 반품 관리창
	@RequestMapping(value = "/order/refundList", method = RequestMethod.GET)
	public String refundListGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "memNickname", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		// sort에 들어올 수 있는 값: 전체, 반품신청, 반품진행중, 반품완료, 상품하자, 단순변심, 기타
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminRefundList", sort+"/"+search, searchString);
		ArrayList<OrderVO> vos = adminService.getRefundSearchList(sort, search, searchString, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/order/refundList";
	}
	
	// 문의 관리창
	@RequestMapping(value = "/manage/askList", method = RequestMethod.GET)
	public String askListGet(Model model,
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="search", defaultValue = "askTitle", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		// sort에 들어올 수 있는 값: 전체, 커뮤니티, 컬렉션상품, 매거진, 정기구독, 뉴스레터, 포인트, 게임, 기타
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminAskList", sort+"/"+search, searchString);
		ArrayList<AskVO> vos = adminService.getAskSearchList(sort, search, searchString, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("sort", sort);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/manage/askList";
	}
	
	// 공지사항 관리창
	@RequestMapping(value = "/manage/noticeList", method = RequestMethod.GET)
	public String noticeListGet(Model model,
			@RequestParam(name="search", defaultValue = "noticeTitle", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adminNoticeList", search, searchString);
		ArrayList<AskVO> vos = adminService.getNoticeSearchList(search, searchString, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/manage/noticeList";
	}
	
	// 공지사항 등록창
	@RequestMapping(value = "/manage/noticeInsert", method = RequestMethod.GET)
	public String noticeInsertGet(Model model) {
		
		return "admin/manage/noticeInsert";
	}
	
	// 공지사항 등록
	@RequestMapping(value = "/manage/noticeInsert", method = RequestMethod.POST)
	public String noticeInsertPost(NoticeVO vo) {
		
		// 상단 고정
		if(vo.getImportant() == null) vo.setImportant("0");
		else vo.setImportant("1");
		
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/notice/폴더에 저장시켜준다.
		imageManager.imgCheck(vo.getNoticeContent(), "notice");
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 notice폴더 경로로 변경한다.
		vo.setNoticeContent(vo.getNoticeContent().replace("/data/ckeditor/", "/data/notice/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = adminService.setNoticeInsert(vo);
		
		if(res != 0)  return "redirect:/message/adminNoticeInsertOk";
		else return "redirect:/message/adminNoticeInsertOk";
	}
	
	// 공지사항 수정창
	@RequestMapping(value = "/manage/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(int idx, Model model) {
	
		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(ask)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		NoticeVO vo = adminService.getNoticeInfo(idx);
		if(vo.getNoticeContent().indexOf("src=\"/") != -1) imageManager.imgCheckUpdate(vo.getNoticeContent(), "notice", 27);
		model.addAttribute("vo", vo);
		
		return "admin/manage/noticeUpdate";
	}
	
	// 공지사항 수정
	@RequestMapping(value = "/manage/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo) {

		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
		NoticeVO originVO = adminService.getNoticeInfo(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 내용을 수정처리한다.
		if(!originVO.getNoticeContent().equals(vo.getNoticeContent())) {
			
			// 실제로 수정하기 버튼을 클릭하게되면, 기존의 community폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
			if(originVO.getNoticeContent().indexOf("src=\"/") != -1) imageManager.imgDelete(originVO.getNoticeContent(), "notice", 27);
			
			// ask폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getAskContent()에 있는 그림파일경로 'ask'를 'ckeditor'경로로 변경해줘야한다.
			vo.setNoticeContent(vo.getNoticeContent().replace("/data/notice/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/notice/폴더에 저장시켜준다.
			imageManager.imgCheck(vo.getNoticeContent(), "notice");
			
			// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 ask폴더 경로로 변경한다.
			vo.setNoticeContent(vo.getNoticeContent().replace("/data/ckeditor/", "/data/notice/"));
		}
		
		// 상단 고정
		if(vo.getImportant() == null) vo.setImportant("0");
		else vo.setImportant("1");
		
		int res = adminService.setNoticeUpdate(vo);
		
		if(res != 0)  return "redirect:/message/adminNoticeUpdateOk";
		else return "redirect:/message/adminNoticeUpdateNo?idx="+vo.getIdx();
	}
	
	// 공지사항 삭제
	@ResponseBody
	@RequestMapping(value = "/manage/noticeDelete", method = RequestMethod.POST)
	public String noticeDeletePost(int idx) {
	
		adminService.setNoticeDelete(idx);
		return "";
	}
	
	// 임시파일 관리
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/manage/tempFileList", method = RequestMethod.GET)
	public String tempFileListGet(HttpServletRequest request, Model model) {
		
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/manage/tempFileList";
	}
	
	// 선택된 파일 삭제처리하기
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/manage/tempFileDelete", method = RequestMethod.POST)
	public String tempFileDeletePost(HttpServletRequest request, String delItems) {

		String realPath = request.getRealPath("/resources/data/ckeditor/");
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] fileNames = delItems.split("/");
		
		for(String fileName : fileNames) {
			String realPathFile = realPath + fileName;
			new File(realPathFile).delete();
		}
		
		return "1";
	}
	
	
	
}
