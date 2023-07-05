package com.spring.javaweb8S;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String listGet(@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="idx", defaultValue = "1", required=false) int idx,
			Model model) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "가입되셨습니다. 책(의)세계에 오신 걸 환영합니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "가입 과정에서 오류가 발생했습니다.\\n재시도 부탁드립니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberMidNo")) {
			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberPwdNo")) {
			model.addAttribute("msg", "비밀번호가 다릅니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 다시 만나 반갑습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberDefaultPhotoInsertOk")) {
			model.addAttribute("msg", "성공적으로 업로드 되었습니다.");
			model.addAttribute("url", "/admin/member/memberPhoto");
		}
		else if(msgFlag.equals("memberDefaultPhotoInsertNo")) {
			model.addAttribute("msg", "업로드 실패하였습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/member/memberPhoto");
		}
		else if(msgFlag.equals("magazineInsertOk")) {
			model.addAttribute("msg", "매거진이 성공적으로 등록되었습니다.");
			model.addAttribute("url", "/admin/magazine/magazineInsert");
		}
		else if(msgFlag.equals("magazineInsertNo")) {
			model.addAttribute("msg", "매거진 등록에 실패하였습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/magazine/magazineInsert");
		}
		else if(msgFlag.equals("magazineUpdateOk")) {
			model.addAttribute("msg", "매거진이 성공적으로 수정되었습니다.");
			model.addAttribute("url", "/admin/magazine/magazineList");
		}
		else if(msgFlag.equals("magazineUpdateNo")) {
			model.addAttribute("msg", "매거진 수정에 실패하였습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/magazine/magazineUpdate?idx="+idx);
		}
		else if(msgFlag.equals("colCategoryInsertOk")) {
			model.addAttribute("msg", "컬렉션 카테고리에 성공적으로 등록되었습니다.");
			model.addAttribute("url", "/admin/collection/colCategoryList");
		}
		else if(msgFlag.equals("colCategoryInsertNo")) {
			model.addAttribute("msg", "컬렉션 카테고리 등록에 실패하였습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/collection/colCategoryList");
		}
		else if(msgFlag.equals("colCategorythumbUpdateOk")) {
			model.addAttribute("msg", "컬렉션 카테고리 썸네일이 변경되었습니다.");
			model.addAttribute("url", "/admin/collection/colCategoryList");
		}
		else if(msgFlag.equals("colCategorythumbUpdateNo")) {
			model.addAttribute("msg", "컬렉션 카테고리 썸네일 변경에 실패했습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/collection/colCategoryList");
		}
		
		
		return "include/message";
	}
	
	
}