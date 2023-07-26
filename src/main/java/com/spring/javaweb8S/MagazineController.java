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
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.AskVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MagazineVO;
import com.spring.javaweb8S.vo.SaveVO;

@Controller
@RequestMapping("/magazine")
public class MagazineController {
	
	@Autowired
	MagazineService magazineService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	PageProcess pageProcess;

	// 매거진 창
	@RequestMapping(value = "/magazineList", method = RequestMethod.GET)
	public String magazineListGet(Model model, HttpSession session,
			@RequestParam(name="search", defaultValue = "최신순", required = false) String search,
			@RequestParam(name="maDate", defaultValue = "전체", required = false) String maDate,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "24", required = false) int pageSize) {
		
		// 바로 주문하기로 장바구니에 저장된 상품이 있다면 session에 저장된 값 지워주기
		if((String)session.getAttribute("sTempCartIdx") != null) {
			orderService.setCartIdxDelete(Integer.parseInt((String)session.getAttribute("sTempCartIdx")));
			session.removeAttribute("sTempCartIdx");
		}
	
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
		
		// 바로 주문하기로 장바구니에 저장된 상품이 있다면 session에 저장된 값 지워주기
		if((String)session.getAttribute("sTempCartIdx") != null) {
			orderService.setCartIdxDelete(Integer.parseInt((String)session.getAttribute("sTempCartIdx")));
			session.removeAttribute("sTempCartIdx");
		}
		
		// 관심 저장 유무 확인
		String nickname = (String) session.getAttribute("sNickname");
		SaveVO saveVO = magazineService.getMagazineSave(nickname, idx);
		model.addAttribute("saveVO", saveVO);

		// 장바구니 저장 유무 확인
		CartVO cartVO = magazineService.getMagazineCartSearch(nickname, idx);
		model.addAttribute("cartVO", cartVO);
		
		// 매거진 상세 내용
		MagazineVO vo = magazineService.getMagazineProduct(idx);
		model.addAttribute("vo", vo);

		// 상품 문의
		ArrayList<AskVO> askVOS = new ArrayList<AskVO>();
		
		if(vo.getMaType().equals("매거진")) askVOS = magazineService.getMagazineAsk(idx, "매거진");
		else askVOS = magazineService.getMagazineAsk(idx, "정기구독");
		model.addAttribute("askVOS", askVOS);
			
		
		return "magazine/maProduct";
	}
	
	// 매거진 저장
	@ResponseBody
	@RequestMapping(value = "/magazineSave", method = RequestMethod.POST)
	public String magazineSavePost(SaveVO vo) {
		
		// 상품 저장 테이블
		magazineService.setMagazineSave(vo);
		
		// 매거진 테이블 저장 등록 수 변경
		magazineService.setMaSaveNumUpdate(vo.getMaIdx(), 1);
		
		return "";
	}
	
	// 매거진 저장 취소
	@ResponseBody
	@RequestMapping(value = "/magazineSaveDelete", method = RequestMethod.POST)
	public String magazineSaveDeletePost(SaveVO vo) {
		// 상품 저장 테이블
		magazineService.setMagazineSaveDelete(vo.getMemNickname(), vo.getMaIdx());
		
		// 매거진 테이블 저장 등록 수 변경
		magazineService.setMaSaveNumUpdate(vo.getMaIdx(), -1);
		return "";
	}
	
	// 매거진 장바구니 저장
	@ResponseBody
	@RequestMapping(value = "/magazineCartInsert", method = RequestMethod.POST)
	public String magazineCartInsertPost(CartVO vo, HttpSession session) {
		
		// 기존 장바구니 내역 중, 같은 상품 존재 확인
		CartVO previousVO = magazineService.getMagazineCartSearch(vo.getMemNickname(), vo.getMaIdx());
		
		// 같은 매거진 존재
		if(previousVO != null) {
			magazineService.setMagazineCartUpdate(vo);
		}
		else {
			magazineService.setMagazineCartInsert(vo);
			
			if(session.getAttribute("sCartNum") != null) {
				int cartNum = (int) session.getAttribute("sCartNum");
				session.setAttribute("sCartNum", cartNum + 1);
			}
		}
		return "";
	}
	
	
	
}
