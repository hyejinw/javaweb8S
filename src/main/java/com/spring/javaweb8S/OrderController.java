package com.spring.javaweb8S;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb8S.pagination.PageProcess;
import com.spring.javaweb8S.service.CollectionService;
import com.spring.javaweb8S.service.MagazineService;
import com.spring.javaweb8S.service.OrderService;
import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.SaveVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	MagazineService magazineService;
	
	@Autowired
	CollectionService collectionService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 장바구니 창
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String cartGet(Model model, HttpSession session) {
		
		// 바로 주문하기로 장바구니에 저장된 상품이 있다면 session에 저장된 값 지워주기
		if((String)session.getAttribute("sTempCartIdx") != null) {
			orderService.setCartIdxDelete(Integer.parseInt((String)session.getAttribute("sTempCartIdx")));
			session.removeAttribute("sTempCartIdx");
		}
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		// 컬렉션 상품, 매거진 상품, 매거진 정기구독 상품 나눠서 가져오기
		ArrayList<CartVO> cartProdVOS = orderService.getProductCartList(memNickname);
		ArrayList<CartVO> cartMagazineVOS = orderService.getMagazineCartList(memNickname);
		ArrayList<CartVO> cartSubscribeVOS = orderService.getSubscribeCartList(memNickname);

		model.addAttribute("cartProdVOS", cartProdVOS);
		model.addAttribute("cartMagazineVOS", cartMagazineVOS);
		model.addAttribute("cartSubscribeVOS", cartSubscribeVOS);
		
		// 장바구니에 담긴 전체 상품 개수
		model.addAttribute("cartProdVOSNum", cartProdVOS.size());
		model.addAttribute("cartMagazineVOSNum", cartMagazineVOS.size());
		model.addAttribute("cartSubscribeVOSNum", cartSubscribeVOS.size());
		
		int soldoutProdNum = 0;
		int soldoutMagazineNum = 0;
		
		// 품절 상품 개수
		for(int i=0; i<cartProdVOS.size(); i++) {
			if(cartProdVOS.get(i).getStock() == 0) soldoutProdNum++;
		}
		// 품절 매거진 개수
		for(int i=0; i<cartMagazineVOS.size(); i++) {
			if(cartMagazineVOS.get(i).getStock() == 0) soldoutMagazineNum++;
		}
		model.addAttribute("soldoutProdNum", soldoutProdNum);
		model.addAttribute("soldoutMagazineNum", soldoutMagazineNum);

		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(memNickname);
		model.addAttribute("memberVO", memberVO);
		
		return "order/cart";
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
	public String cartIdxesDeletePost(String checkRow, HttpSession session) {
		
		List<String> cartIdxList = new ArrayList<String>();
		String[] checkedCartIdx = checkRow.split(",");
		
		for(int i=0; i < checkedCartIdx.length; i++){
			cartIdxList.add(checkedCartIdx[i].toString());
		}

		orderService.setCartIdxesDelete(cartIdxList);
		
		// 장바구니 개수 session 변경
		if(session.getAttribute("sCartNum") != null) {
			int cartNum = (int) session.getAttribute("sCartNum");
			session.setAttribute("sCartNum", cartNum - cartIdxList.size());
		}
		return "";
	}
	
	// 장바구니 상품 삭제(단일)
	@ResponseBody
	@RequestMapping(value = "/cartIdxDelete", method = RequestMethod.POST)
	public String cartIdxDeletePost(int idx, HttpSession session) {
		
		orderService.setCartIdxDelete(idx);
		
		// 장바구니 개수 session 변경
		if(session.getAttribute("sCartNum") != null) {
			int cartNum = (int) session.getAttribute("sCartNum");
			session.setAttribute("sCartNum", cartNum - 1);
		}
		return "";
	}
	
	// 관심 상품 등록
	@ResponseBody
	@RequestMapping(value = "/saveInsert", method = RequestMethod.POST)
	public String saveInsertPost(SaveVO vo) {
		
		orderService.setSaveInsertPost(vo);
		
		// 상품 or 매거진 테이블 저장 등록 수 변경
		orderService.setSaveNumUpdate(vo, 1);
		
		return "";
	}
	
	// 관심 상품 취소
	@ResponseBody
	@RequestMapping(value = "/saveDelete", method = RequestMethod.POST)
	public String saveDeletePost(SaveVO vo) {
		
		orderService.setSaveDelete(vo.getMemNickname(), vo.getIdx());
		
		// 상품 or 매거진 테이블 저장 등록 수 변경
		orderService.setSaveNumUpdate(vo, -1);
		
		return "";
	}

	// 매거진 바로 주문 창
	@RequestMapping(value = "/magazineOrderNow", method = RequestMethod.POST)
	public String magazineOrderNowPost(CartVO cartVO, Model model, HttpSession session) {
		
		// 임시로 장바구니에 넣어둔다.
		magazineService.setMagazineCartInsert(cartVO);
		String checkRow = orderService.getCartIdx(cartVO);
		
		// 임시로 넣어둔 장바구니 고유번호 세션 저장
		session.setAttribute("sTempCartIdx", checkRow);
		
		// 주문할 상품 정보(from cart)
		List<String> cartIdxList = new ArrayList<String>();
		cartIdxList.add(checkRow);
		
		
		ArrayList<CartVO> vos = orderService.getCartList(cartVO.getMemNickname(), cartIdxList);
		model.addAttribute("vos", vos);
		
		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(cartVO.getMemNickname());
		model.addAttribute("memberVO", memberVO);
		
		// 회원의 기본 주소 정보
		AddressVO addressVO = orderService.getDefaultAddress(cartVO.getMemNickname());
		model.addAttribute("addressVO", addressVO);
		
		// 선택한 상품의 장바구니 고유번호
		model.addAttribute("checkRow", checkRow);
		
		return "order/order";
	}
	
	// 상품 바로 주문 창
	@RequestMapping(value = "/productOrderNow", method = RequestMethod.POST)
	public String productOrderNowPost(CartVO vo, 
			int[] opIdx, String[] opName, int[] opPrice, int[] num,
			Model model, HttpSession session) {
		
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
		// 임시로 장바구니에 넣어둔다.
		collectionService.setProductOpCartInsert(vo, optionList);
		
		String checkRow = orderService.getCartIdx(vo);
		
		// 임시로 넣어둔 장바구니 고유번호 세션 저장
		session.setAttribute("sTempCartIdx", checkRow);
		
		// 주문할 상품 정보(from cart)
		List<String> cartIdxList = new ArrayList<String>();
		cartIdxList.add(checkRow);
		
		
		ArrayList<CartVO> vos = orderService.getCartList(vo.getMemNickname(), cartIdxList);
		model.addAttribute("vos", vos);
		
		// 회원 정보
		MemberVO memberVO = orderService.getMemberInfo(vo.getMemNickname());
		model.addAttribute("memberVO", memberVO);
		
		// 회원의 기본 주소 정보
		AddressVO addressVO = orderService.getDefaultAddress(vo.getMemNickname());
		model.addAttribute("addressVO", addressVO);
		
		// 선택한 상품의 장바구니 고유번호
		model.addAttribute("checkRow", checkRow);
		
		return "order/order";
	}
	
	// 주문창, 선택된 상품 보여주기(여러 개)
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public String orderGet(String checkRow, Model model, HttpSession session) {
		
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
		
		// 선택한 상품의 장바구니 고유번호
		model.addAttribute("checkRow", checkRow);
		
		return "order/order";
	}
	
	// 주문창, 주소록 리스트 창(팝업)
	@RequestMapping(value = "/addressList", method = RequestMethod.GET)
	public String addressListGet(Model model, HttpSession session) {
		
		String memNickname = (String) session.getAttribute("sNickname");
		
		ArrayList<AddressVO> vos = orderService.getAddressList(memNickname);
		model.addAttribute("vos", vos);
		
		model.addAttribute("addressNum", vos.size());
		
		return "order/addressList";
	}
	
	// 주문창, 주소록 등록 창(팝업)
	@RequestMapping(value = "/addressInsert", method = RequestMethod.GET)
	public String addressListGet() {
		return "order/addressInsert";
	}
	
	// 주문창, 주소록 등록
	@ResponseBody
	@RequestMapping(value = "/addressInsert", method = RequestMethod.POST)
	public String addressListPost(AddressVO vo) {
		
		// 기본주소로 설정 시, 기존 기본주소가 있다면 해당 주소를 일반으로 변경
		if(vo.getDefaultAddress() == 0) orderService.setDefaultAddressReset(vo.getMemNickname());

		orderService.setAddressInsert(vo);
		return "";
	}
	
	// 주문창, 주소록 삭제
	@ResponseBody
	@RequestMapping(value = "/addressIdxesDelete", method = RequestMethod.POST)
	public String addressIdxesDeletePost(String checkRow) {
		
		List<String> addressIdxList = new ArrayList<String>();
		String[] checkedAddressIdx = checkRow.split(",");
		
		for(int i=0; i < checkedAddressIdx.length; i++){
			addressIdxList.add(checkedAddressIdx[i].toString());
		}

		orderService.setAddressIdxesDelete(addressIdxList);
		return "";
	}
	
	// 주문창, 주소록 수정 창(팝업)
	@RequestMapping(value = "/addressUpdate", method = RequestMethod.GET)
	public String addressUpdateGet(int idx, Model model) {
		
		AddressVO vo = orderService.getAddressInfo(idx);
		model.addAttribute("vo", vo);
		
		return "order/addressUpdate";
	}
	
	// 주문창, 주소록 수정
	@ResponseBody
	@RequestMapping(value = "/addressUpdate", method = RequestMethod.POST)
	public String addressUpdatePost(AddressVO vo) {
		
		// 기본주소로 설정 시, 기존 기본주소가 있다면 해당 주소를 일반으로 변경
		if(vo.getDefaultAddress() == 0) orderService.setDefaultAddressReset(vo.getMemNickname());
		
		orderService.setAddressUpdate(vo);
		return "";
	}
	
	// 주문창, 포인트 사용 창 (팝업)
	@RequestMapping(value = "/pointUsage", method = RequestMethod.GET)
	public String pointUsageGet(String checkRow, HttpSession session, Model model) {
		
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
		
		// 선택한 상품의 장바구니 고유번호
		model.addAttribute("checkRow", checkRow);
		
		return "order/pointUsage";
	}

	// 상품 주문
	//@Transactional
	@RequestMapping(value = "/orderInsert", method = RequestMethod.POST)
	public String orderPost(OrderVO orderVO, HttpSession session,
			@RequestParam(name="checkRow", defaultValue = "", required = false) String checkRow, 
			@RequestParam(name="paidPrice", defaultValue = "", required = false) int[] paidPrice,
			@RequestParam(name="usedPoint", defaultValue = "", required = false) int[] usedPoint) {

		List<String> cartIdxList = new ArrayList<String>();
		String[] checkedCartIdx = checkRow.split(",");
		
		for(int i=0; i < checkedCartIdx.length; i++){
			cartIdxList.add(checkedCartIdx[i].toString());
		}
		// 장바구니 정보 가져와서
		ArrayList<CartVO> cartVOS = orderService.getCartList(orderVO.getMemNickname(), cartIdxList);
		
		// 주문 코드 생성
		SimpleDateFormat format = new SimpleDateFormat("yyMMdd");
		Date today = new Date();
		String res = format.format(today);
		
		UUID uid = UUID.randomUUID();

		// 주문에 담기(일반 주문, 상품)
		ArrayList<OrderVO> prodOrderVOS = new ArrayList<OrderVO>();
		// 주문에 담기(일반 주문, 매거진)
		ArrayList<OrderVO> maOrderVOS = new ArrayList<OrderVO>();
		// 주문에 담기(정기 구독)
		ArrayList<OrderVO> subVOS = new ArrayList<OrderVO>();
		// 포인트 사용 처리
		ArrayList<OrderVO> pointUseVOS = new ArrayList<OrderVO>();
		
		for(int i=0; i<cartVOS.size(); i++) {
			
			OrderVO tempVO = new OrderVO();
			tempVO.setMemNickname(orderVO.getMemNickname());
			tempVO.setType(cartVOS.get(i).getType());
			tempVO.setOrderCode(res + uid.toString().substring(0,5));
			
			tempVO.setAddressIdx(orderVO.getAddressIdx());
			tempVO.setMaIdx(cartVOS.get(i).getMaIdx());
			tempVO.setProdIdx(cartVOS.get(i).getProdIdx());
			tempVO.setOpIdx(cartVOS.get(i).getOpIdx());
			
			tempVO.setProdName(cartVOS.get(i).getProdName());
			tempVO.setProdPrice(cartVOS.get(i).getProdPrice());
			tempVO.setProdThumbnail(cartVOS.get(i).getProdThumbnail());
			
			tempVO.setOpName(cartVOS.get(i).getOpName());
			tempVO.setOpPrice(cartVOS.get(i).getOpPrice());
			
			tempVO.setNum(cartVOS.get(i).getNum());
			tempVO.setTotalPrice(cartVOS.get(i).getTotalPrice());
			tempVO.setPaidPrice(cartVOS.get(i).getTotalPrice() - usedPoint[i]);
			tempVO.setUsedPoint(usedPoint[i]);
			
			if(cartVOS.get(i).getType().equals("컬렉션 상품")) {
				prodOrderVOS.add(tempVO);
			}
			if(cartVOS.get(i).getType().equals("매거진")) {
				maOrderVOS.add(tempVO);
			}
			if(cartVOS.get(i).getType().equals("정기 구독")) {
				subVOS.add(tempVO);
			}
			if(usedPoint[i] != 0) {
				pointUseVOS.add(tempVO);
			}
		}
		
		// 1. 주문 테이블 처리
		if(prodOrderVOS.size() != 0) orderService.setOrderInsert(prodOrderVOS);
		if(maOrderVOS.size() != 0) orderService.setOrderInsert(maOrderVOS);
		if(subVOS.size() != 0) orderService.setOrderInsert(subVOS);
		
		// 1-1. 장바구니 테이블 데이터 삭제
		orderService.setCartIdxesDelete(cartIdxList);
		
		// 1-2. 바로 주문하기로 온 상품이라면 session에 저장된 값 지워주기
		session.removeAttribute("sTempCartIdx");
		
		// 2. 배송 테이블 처리(정기 구독 제외)
		if(prodOrderVOS.size() != 0) orderService.setDeliveryInsert(prodOrderVOS);
		if(maOrderVOS.size() != 0) orderService.setDeliveryInsert(maOrderVOS);
		
		// 3. 정기 구독 테이블 처리
		if(subVOS.size() != 0) orderService.setSubscribeInsert(subVOS);
		
		// 4. 사용 포인트 정리
		if(pointUseVOS.size() != 0) {
			// 적립금 사용 테이블
			orderService.setPointUseInsert(pointUseVOS);
			
			// 회원 테이블
			int totalUsedPoint = 0;
			for(int i=0; i<pointUseVOS.size(); i++) {
				totalUsedPoint += pointUseVOS.get(i).getUsedPoint();
			}
			orderService.setMemberPointUpdate(totalUsedPoint, pointUseVOS.get(0).getMemNickname());
		}
		
		System.out.println("prodOrderVOS : " +prodOrderVOS);
		System.out.println("maOrderVOS : " +maOrderVOS);
		
		
		// 5. 재고 변경
		if(prodOrderVOS.size() != 0) {
			// 상품 옵션 재고 변경
			orderService.setProdOpStockUpdate(prodOrderVOS);
			
			// 상품 판매 수량 변경
			orderService.setProdSaleQuantityUpdate(prodOrderVOS);
			
			// 현 재고 0인 상품 고유번호
			ArrayList<String> ProdStockUpdateIdx = orderService.getProdStockUpdateIdx();
			System.out.println("ProdStockUpdateIdx : " +ProdStockUpdateIdx);
			
			if(ProdStockUpdateIdx.size() != 0) orderService.setProdStockUpdate(ProdStockUpdateIdx);  // 상품 품절로 상태 변경
		}
		
		if(maOrderVOS.size() != 0) {
			// 매거진 재고 변경 + 판매 수량 변경
			orderService.setMaStockUpdate(maOrderVOS);
		}
		
		
		// 장바구니 개수 session 변경
		if(session.getAttribute("sCartNum") != null) {
			int cartNum = (int) session.getAttribute("sCartNum");
			session.setAttribute("sCartNum", cartNum - cartVOS.size());
		}
		
		// 원래 return 할 곳은 해당 회원의 (마이페이지 안) 주문 내역
		return "order/cart";
		
		// 아니면 order/orderInfo를 만들어서 결제를 한 번 더 보여주는 것도 좋다
	}
	
	
	
	
}
