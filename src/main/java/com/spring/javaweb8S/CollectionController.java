package com.spring.javaweb8S;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.CollectionService;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.OptionVO;
import com.spring.javaweb8S.vo.ProductVO;
import com.spring.javaweb8S.vo.SaveVO;

@Controller
@RequestMapping("/collection")
public class CollectionController {
	
	@Autowired
	CollectionService collectionService;
	
	@Autowired
	PageProcess pageProcess;

	// 컬렉션 창
	@RequestMapping(value = "/collectionList", method = RequestMethod.GET)
	public String magazineListGet(Model model,
			@RequestParam(name="search", defaultValue = "최신순", required = false) String search,
			@RequestParam(name="sort", defaultValue = "컬렉션", required = false) String sort,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "collectionList", search, "");
		ArrayList<CollectionVO> vos = collectionService.getCollectionList(search, pageVO.getStartIndexNo(), pageSize);

		model.addAttribute("search", search);
		model.addAttribute("sort", sort);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "collection/collectionList";
	}
	
	// 상품 창
	@RequestMapping(value = "/colProductList", method = RequestMethod.GET)
	public String colProductListGet(Model model,
			@RequestParam(name="colIdx", defaultValue = "0", required = false) String colIdx,
			@RequestParam(name="search", defaultValue = "최신순", required = false) String search,
			@RequestParam(name="sort", defaultValue = "상품", required = false) String sort,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "colProductList", search, colIdx);
		ArrayList<CollectionVO>	vos = collectionService.getProductList(search, colIdx, pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("colIdx", colIdx);
		model.addAttribute("search", search);
		model.addAttribute("sort", sort);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "collection/colProductList";
	}
	
	// 컬렉션 상품 상세 창
	@RequestMapping(value = "/colProduct", method = RequestMethod.GET)
	public String productGet(Model model, HttpSession session, 
			@RequestParam(name="idx", defaultValue = "1", required = false) int idx) {
		System.out.println("colProduct의 idx : " +  idx);
		
		// 관심 저장 유무 확인
		String nickname = (String) session.getAttribute("sNickname");
		SaveVO saveVO = collectionService.getProductSave(nickname, idx);
		model.addAttribute("saveVO", saveVO);

		// 장바구니 저장 유무 확인
		CartVO cartVO = collectionService.getProductCartSearch(nickname, idx);
		model.addAttribute("cartVO", cartVO);
		
		// 해당 컬렉션 정보
		CollectionVO collectionVO = collectionService.getProdCollection(idx);
		model.addAttribute("collectionVO", collectionVO);
		
		// 상품 상세 내용
		ProductVO vo = collectionService.getProductInfo(idx);
		model.addAttribute("vo", vo);
		
		// 상품 옵션
		ArrayList<OptionVO> optionVOS = collectionService.getProdOption(idx);
		model.addAttribute("optionVOS", optionVOS);
		
		return "collection/colProduct";
	}
	
//	// 매거진 저장
//	@ResponseBody
//	@RequestMapping(value = "/magazineSave", method = RequestMethod.POST)
//	public String magazineSavePost(SaveVO vo) {
//		magazineService.setMagazineSave(vo);
//		return "";
//	}
//	
//	// 매거진 저장 취소
//	@ResponseBody
//	@RequestMapping(value = "/magazineSaveDelete", method = RequestMethod.POST)
//	public String magazineSaveDeletePost(SaveVO vo) {
//		magazineService.setMagazineSaveDelete(vo.getMemNickname(), vo.getMaIdx());
//		return "";
//	}
//	
//	// 매거진 장바구니 저장
//	@ResponseBody
//	@RequestMapping(value = "/magazineCartInsert", method = RequestMethod.POST)
//	public String magazineCartInsertPost(CartVO vo) {
//		
//		// 기존 장바구니 내역 중, 같은 상품 존재 확인
//		CartVO previousVO = magazineService.getMagazineCartSearch(vo.getMemNickname(), vo.getMaIdx());
//		
//		// 같은 매거진 존재
//		if(previousVO != null) {
//			magazineService.setMagazineCartUpdate(vo);
//		}
//		else {
//			magazineService.setMagazineCartInsert(vo);
//		}
//		return "";
//	}
	
	
	
}
