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
import com.spring.javaweb8S.service.CollectionService;
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.AskVO;
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
	OrderService orderService;
	
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
	public String colProductListGet(Model model, HttpSession session,
			@RequestParam(name="flag", defaultValue = "", required = false) String flag,
			@RequestParam(name="colIdx", defaultValue = "", required = false) String colIdx,
			@RequestParam(name="search", defaultValue = "최신순", required = false) String search,
			@RequestParam(name="sort", defaultValue = "상품", required = false) String sort,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "colProductList", search, colIdx);
		ArrayList<CollectionVO>	vos = collectionService.getProductList(search, colIdx, pageVO.getStartIndexNo(), pageSize);
		
		// 바로 주문하기로 장바구니에 저장된 상품이 있다면 session에 저장된 값 지워주기
		if((String)session.getAttribute("sTempCartIdx") != null) {
			orderService.setCartIdxDelete(Integer.parseInt((String)session.getAttribute("sTempCartIdx")));
			session.removeAttribute("sTempCartIdx");
		}
		
		model.addAttribute("colIdx", colIdx);
		model.addAttribute("search", search);
		model.addAttribute("sort", sort);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		// 상품 전체
		if(!flag.equals("")) model.addAttribute("flag", "All");
		
		return "collection/colProductList";
	}
	
	// 컬렉션 상품 상세 창
	@RequestMapping(value = "/colProduct", method = RequestMethod.GET)
	public String productGet(Model model, HttpSession session, 
			@RequestParam(name="idx", defaultValue = "1", required = false) int idx) {
		
		// 바로 주문하기로 장바구니에 저장된 상품이 있다면 session에 저장된 값 지워주기
		if((String)session.getAttribute("sTempCartIdx") != null) {
			orderService.setCartIdxDelete(Integer.parseInt((String)session.getAttribute("sTempCartIdx")));
			session.removeAttribute("sTempCartIdx");
		}
		
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
		
		// 상품 문의
		ArrayList<AskVO> askVOS = collectionService.getProductAsk(idx, "컬렉션상품");
		model.addAttribute("askVOS", askVOS);
		
		return "collection/colProduct";
	}
	
	// 상품 저장
	@ResponseBody
	@RequestMapping(value = "/productSave", method = RequestMethod.POST)
	public String productSavePost(SaveVO vo) {
		
		// 상품 저장 테이블
		collectionService.setProductSave(vo);

		// 상품 테이블 저장 등록 수 변경
		collectionService.setProdSaveNumUpdate(vo.getProdIdx(), 1);

		return "";
	}
	
	// 상품 저장 취소
	@ResponseBody
	@RequestMapping(value = "/productSaveDelete", method = RequestMethod.POST)
	public String productSaveDeletePost(SaveVO vo) {

		// 상품 저장 테이블
		collectionService.setProductSaveDelete(vo.getMemNickname(), vo.getProdIdx());
		
		// 상품 테이블 저장 등록 수 변경
		collectionService.setProdSaveNumUpdate(vo.getProdIdx(), -1);
		
		return "";
	}
	// (ppt에 꼭 넣장!)
	// 상품 장바구니 저장
	@ResponseBody
	@RequestMapping(value = "/productCartInsert", method = RequestMethod.POST)
	public String productCartInsertPost(CartVO vo, HttpSession session,
			int[] opIdx, String[] opName, int[] opPrice, int[] num) {
		
		// 옵션 정보 담기
		ArrayList<CartVO> optionList = new ArrayList<CartVO>();
		
		for(int i=0; i<opName.length; i++) {
			CartVO optionVOi = new CartVO();
			optionVOi.setOpIdx(opIdx[i]);
			optionVOi.setOpName(opName[i]);
			optionVOi.setOpPrice(opPrice[i]);
			optionVOi.setNum(num[i]);
			optionVOi.setTotalPrice(opPrice[i] * num[i]);
			
			optionList.add(optionVOi);
		}
		
		// 기존 장바구니 내역 중, 같은 상품 존재 확인(닉네임, 상품 고유번호, 옵션 고유번호로 검색)
		ArrayList<Integer> reservedProdOpIdxes = 
				collectionService.getProductOpCartSearch(vo.getMemNickname(), vo.getProdIdx(), optionList);
		
		// 수량만 업데이트할 옵션
		ArrayList<CartVO> updateOption = new ArrayList<CartVO>();
		
		// 새로 장바구니에 담을 옵션
		ArrayList<CartVO> insertOption = new ArrayList<CartVO>();
		
		
		for(int i=0; i<optionList.size(); i++) {
			// 수량만 업데이트
			if(reservedProdOpIdxes.contains(optionList.get(i).getOpIdx())) {
				updateOption.add(optionList.get(i));
			}
			// 새로 추가
			else {
				insertOption.add(optionList.get(i));
			}
		}
		
		// 실제 처리
		if(updateOption.size() != 0) collectionService.setProductOpCartUpdate(vo, updateOption);
		if(insertOption.size() != 0) collectionService.setProductOpCartInsert(vo, insertOption);
		
		// 장바구니 개수 session 변경
		if(session.getAttribute("sCartNum") != null) {
			int cartNum = (int) session.getAttribute("sCartNum");
			session.setAttribute("sCartNum", cartNum + insertOption.size());
		}
		return "";
	}
	
	
	
}
