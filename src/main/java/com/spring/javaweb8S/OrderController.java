package com.spring.javaweb8S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.CartVO;
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
	public String cartGet() {
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
