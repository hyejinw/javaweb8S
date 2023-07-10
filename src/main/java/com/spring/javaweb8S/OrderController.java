package com.spring.javaweb8S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.SaveVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 장바구니 창
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String cartGet(Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		// 컬렉션 상품, 매거진 상품, 매거진 정기구독 상품 나눠서 가져오기
		ArrayList<CartVO> cartProdVOS = orderService.getProductCartList(memNickname);
		ArrayList<CartVO> cartMagazineVOS = orderService.getMagazineCartList(memNickname);
		ArrayList<CartVO> cartSubscribeVOS = orderService.getSubscribeCartList(memNickname);

		model.addAttribute("cartProdVOS", cartProdVOS);
		model.addAttribute("cartMagazineVOS", cartMagazineVOS);
		model.addAttribute("cartSubscribeVOS", cartSubscribeVOS);
		
		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		return "order/cart";
	}
	
	// 매거진 바로 주문결제 창
	@RequestMapping(value = "/magazineOrderNow", method = RequestMethod.POST)
	public String orderPost(CartVO magazineCartVO, Model model) {
		
		MemberVO memberVO = orderService.getMemberInfo(magazineCartVO.getMemNickname());
		model.addAttribute("magazineCartVO", magazineCartVO);
		model.addAttribute("memberVO", memberVO);
		
		System.out.println("magazineCartVO.getMemNickname() : " + magazineCartVO.getMemNickname());
		System.out.println("magazineCartVO : " + magazineCartVO);
		System.out.println("memberVO : " + memberVO);
		return "order/order";
	}
	
	// 장바구니 상품 수량 변경
	@ResponseBody
	@RequestMapping(value = "/cartProdNumUpdate", method = RequestMethod.POST)
	public String cartProdNumUpdatePost(CartVO vo) {
		
		orderService.setCartProdNumUpdate(vo);
		return "";
	}
	
	// 장바구니 상품 삭제(여러 개)
	@ResponseBody
	@RequestMapping(value = "/cartIdxesDelete", method = RequestMethod.POST)
	public String cartIdxesDeletePost(String checkRow) {
		
		List<String> cartIdxList = new ArrayList<String>();
		String[] checkedCartIdx = checkRow.split(",");
		
		for(int i=0; i < checkedCartIdx.length; i++){
			cartIdxList.add(checkedCartIdx[i].toString());
		}

		orderService.setCartIdxesDelete(cartIdxList);
		return "";
	}
	
	// 장바구니 상품 삭제(단일)
	@ResponseBody
	@RequestMapping(value = "/cartIdxDelete", method = RequestMethod.POST)
	public String cartIdxDeletePost(int idx) {
		
		orderService.setCartIdxDelete(idx);
		return "";
	}
	
	// 관심 상품 등록
	@ResponseBody
	@RequestMapping(value = "/saveInsert", method = RequestMethod.POST)
	public String saveInsertPost(SaveVO vo) {
		
		orderService.setSaveInsertPost(vo);
		return "";
	}
	
	// 관심 상품 취소
	@ResponseBody
	@RequestMapping(value = "/saveDelete", method = RequestMethod.POST)
	public String saveDeletePost(String memNickname, int idx) {
		
		orderService.setSaveDelete(memNickname, idx);
		return "";
	}
	
	// 주문창, 선택된 상품 보여주기(여러 개)
	@RequestMapping(value = "/orderMutiItems", method = RequestMethod.GET)
	public String orderMutiItemsGet(String checkRow, Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		// 주문할 상품 정보(from cart)
		List<String> cartIdxList = new ArrayList<String>();
		String[] checkedCartIdx = checkRow.split(",");
		
		for(int i=0; i < checkedCartIdx.length; i++){
			cartIdxList.add(checkedCartIdx[i].toString());
		}
		ArrayList<CartVO> vos = orderService.getCartList(memNickname, cartIdxList);
		model.addAttribute("vos", vos);
		
		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		// 회원의 기본 주소 정보
		AddressVO addressVO = orderService.getDefaultAddress(memNickname);
		model.addAttribute("addressVO", addressVO);
		
		return "/order/order";
	}
	
	// 주문창, 주소록 리스트(팝업)
	@RequestMapping(value = "/addressList", method = RequestMethod.GET)
	public String addressListGet(Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		ArrayList<AddressVO> vos = orderService.getAddressList(memNickname);
		model.addAttribute("vos", vos);
		
		model.addAttribute("addressNum", vos.size());
		
		return "/order/addressList";
	}
	
	// 주문창, 주소록 등록(팝업)
	@RequestMapping(value = "/addressInsert", method = RequestMethod.GET)
	public String addressListGet() {
		return "/order/addressInsert";
	}
	
	
	
}
