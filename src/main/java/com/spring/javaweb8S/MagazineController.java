package com.spring.javaweb8S;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.pagination.PageVO;
import com.spring.javaweb8S.service.MagazineService;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.SaveVO;

@Controller
@RequestMapping("/magazine")
public class MagazineController {
	
	@Autowired
	MagazineService magazineService;
	
	@Autowired
	PageProcess pageProcess;

	// 매거진 창
	@RequestMapping(value = "/magazineList", method = RequestMethod.GET)
	public String magazineListGet(Model model,
			@RequestParam(name="search", defaultValue = "최신순", required = false) String search,
			@RequestParam(name="maDate", defaultValue = "전체", required = false) String maDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "24", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "magazineList", search, maDate);
		ArrayList<MagazineVO> vos = magazineService.getMagazineList(search, maDate, pageVO.getStartIndexNo(), pageSize);
		ArrayList<String> maDateVO = magazineService.getMaDate();
		
		model.addAttribute("search", search);
		model.addAttribute("maDate", maDate);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("maDateVO", maDateVO);
		
		return "magazine/magazineList";
	}
	
	// 매거진 상세 창
	@RequestMapping(value = "/maProduct", method = RequestMethod.GET)
	public String productGet(Model model, HttpSession session, 
			@RequestParam(name="idx", defaultValue = "1", required = false) int idx) {
		
		// 관심 저장 유무 확인
		String nickname = (String) session.getAttribute("sNickname");
		SaveVO saveVO = magazineService.getMagazineSave(nickname, idx);

		// 장바구니 저장 유무 확인
		CartVO cartVO = magazineService.getMagazineCartSearch(nickname, idx);
		
		// 매거진 상세 내용
		MagazineVO vo = magazineService.getMagazineProduct(idx);

		model.addAttribute("vo", vo);
		model.addAttribute("saveVO", saveVO);
		model.addAttribute("cartVO", cartVO);
		
		return "magazine/maProduct";
	}
	
	// 매거진 저장
	@ResponseBody
	@RequestMapping(value = "/magazineSave", method = RequestMethod.POST)
	public String magazineSavePost(SaveVO vo) {
		magazineService.setMagazineSave(vo);
		return "";
	}
	
	// 매거진 저장 취소
	@ResponseBody
	@RequestMapping(value = "/magazineSaveDelete", method = RequestMethod.POST)
	public String magazineSaveDeletePost(SaveVO vo) {
		magazineService.setMagazineSaveDelete(vo.getMemNickname(), vo.getMaIdx());
		return "";
	}
	
	// 매거진 장바구니 저장
	@ResponseBody
	@RequestMapping(value = "/magazineCartInsert", method = RequestMethod.POST)
	public String magazineCartInsertPost(CartVO vo) {
		
		// 기존 장바구니 내역 중, 같은 상품 존재 확인
		CartVO previousVO = magazineService.getMagazineCartSearch(vo.getMemNickname(), vo.getMaIdx());
		
		// 같은 매거진 존재
		if(previousVO != null) {
			magazineService.setMagazineCartUpdate(vo);
		}
		else {
			magazineService.setMagazineCartInsert(vo);
		}
		return "";
	}
	
	
	
}
