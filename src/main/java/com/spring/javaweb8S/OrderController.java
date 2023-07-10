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
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.CollectionVO;
import com.spring.javaweb8S.vo.MemberVO;

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
		ArrayList<CartVO> productVOS = orderService.getProductCartList(memNickname);
		ArrayList<CartVO> magazineVOS = orderService.getMagazineCartList(memNickname);
		ArrayList<CartVO> subscribeVOS = orderService.getSubscribeCartList(memNickname);

		model.addAttribute("productVOS", productVOS);
		model.addAttribute("magazineVOS", magazineVOS);
		model.addAttribute("subscribeVOS", subscribeVOS);
		
		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		return "order/cart";
	}
	
	// 매거진 바로 주문결제 창
	@RequestMapping(value = "/magazineOrderNow", method = RequestMethod.POST)
	public String orderGet(CartVO magazineCartVO, Model model) {
		
		MemberVO memberVO = orderService.getMemberInfo(magazineCartVO.getMemNickname());
		model.addAttribute("magazineCartVO", magazineCartVO);
		model.addAttribute("memberVO", memberVO);
		
		System.out.println("magazineCartVO.getMemNickname() : " + magazineCartVO.getMemNickname());
		System.out.println("magazineCartVO : " + magazineCartVO);
		System.out.println("memberVO : " + memberVO);
		return "order/order";
	}
	
	
}
