package com.spring.javaweb8S;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET, produces="application/text; charset=utf-8")
	public String listGet(@PathVariable String msgFlag, HttpSession session,
			@RequestParam(name="nickname", defaultValue = "", required=false) String nickname,
			@RequestParam(name="idx", defaultValue = "1", required=false) int idx,
			@RequestParam(name="returnPath", defaultValue = "", required=false) String returnPath,
			@RequestParam(name="returnOriginIdx", defaultValue = "", required=false) String returnOriginIdx,
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
			model.addAttribute("msg", nickname+"님 다시 만나 반갑습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", nickname+"님 로그아웃 되었습니다.");
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
		else if(msgFlag.equals("colProdInsertOk")) {
			model.addAttribute("msg", "컬렉션 상품이 등록되었습니다.");
			model.addAttribute("url", "/admin/collection/colProdList");
		}
		else if(msgFlag.equals("colProdInsertNo")) {
			model.addAttribute("msg", "컬렉션 상품 등록에 실패했습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/collection/colProdInsert");
		}
		else if(msgFlag.equals("colProdUpdateOk")) {
			model.addAttribute("msg", "컬렉션 상품 정보가 수정되었습니다.");
			model.addAttribute("url", "/admin/collection/colProdInfo?idx="+idx);
		}
		else if(msgFlag.equals("colProdUpdateNo")) {
			model.addAttribute("msg", "컬렉션 상품 정보가 수정에 실패했습니다. 재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/collection/colProdInfo?idx="+idx);
		}
		else if(msgFlag.equals("reflectionInsertOk")) {
			model.addAttribute("msg", "기록이 등록되었습니다.");
			model.addAttribute("url", "/community/reflection");
		}
		else if(msgFlag.equals("reflectionInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/reflectionInsert");
		}
		else if(msgFlag.equals("refBookUpdateOk")) {
			model.addAttribute("msg", "책이 변경되었습니다.");
			model.addAttribute("url", "/community/reflectionUpdate?idx="+idx);
		}
		else if(msgFlag.equals("refBookUpdateNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/reflectionUpdate?idx="+idx);
		}
		else if(msgFlag.equals("reflectionUpdateOk")) {
			model.addAttribute("msg", "기록이 수정되었습니다.");
			model.addAttribute("url", "/community/reflectionDetail?idx="+idx);
		}
		else if(msgFlag.equals("reflectionUpdateNo")) {            
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/reflectionUpdate?idx="+idx);
		}
		else if(msgFlag.equals("reflectionDeleteOk")) {
			model.addAttribute("msg", "기록이 삭제되었습니다.");
			model.addAttribute("url", "/community/reflection");
		}
		else if(msgFlag.equals("reflectionDeleteNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/reflectionDetail?idx="+idx);
		}
		else if(msgFlag.equals("memPhotoUpdateOk")) {
			model.addAttribute("msg", "프로필 사진이 변경되었습니다.");
			model.addAttribute("url", "/community/myPage/memInfo?memNickname="+nickname);
		}
		else if(msgFlag.equals("memPhotoUpdateNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/myPage/memInfo?memNickname="+nickname);
		}
		else if(msgFlag.equals("adminMemPhotoUpdateOk")) {
			model.addAttribute("msg", "프로필 사진이 변경되었습니다.");
			model.addAttribute("url", "/admin/member/memInfo?nickname="+nickname);
		}
		else if(msgFlag.equals("adminMemPhotoUpdateOk")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/member/memInfo?nickname="+nickname);
		}
		else if(msgFlag.equals("askInsertOk")) {
			model.addAttribute("msg", "문의가 등록되었습니다.");
			model.addAttribute("url", "/community/ask");
		}
		else if(msgFlag.equals("askInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/askInsert");
		}
		else if(msgFlag.equals("communityMypageAskInsertOk")) {
			model.addAttribute("msg", "문의가 등록되었습니다.");
			model.addAttribute("url", "/community/myPage/ask?memNickname="+nickname);
		}
		else if(msgFlag.equals("communityMypageAskInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/askInsert");
		}
		else if(msgFlag.equals("askUpdateOk")) {
			model.addAttribute("msg", "문의가 수정되었습니다.");
			model.addAttribute("url", "/community/askDetail?idx="+idx);
		}
		else if(msgFlag.equals("askUpdateNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/askUpdate?idx="+idx);
		}
		else if(msgFlag.equals("askDeleteOk")) {
			model.addAttribute("msg", "문의가 삭제되었습니다.");
			model.addAttribute("url", "/community/ask");
		}
		else if(msgFlag.equals("askDeleteNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/community/askDetail?idx="+idx);
		}
		else if(msgFlag.equals("aboutAskDeleteOk")) {
			model.addAttribute("msg", "문의가 삭제되었습니다.");
			model.addAttribute("url", "/about/ask");
		}
		else if(msgFlag.equals("aboutAskDeleteNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/about/askDetail?idx="+idx);
		}
		else if(msgFlag.equals("refundInsertOk")) {
			model.addAttribute("msg", "반품 신청되었습니다.");
			model.addAttribute("url", "/member/myPage/order");
		}
		else if(msgFlag.equals("refundInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/member/myPage/order");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", nickname+"님 지금까지 함께 해주셔서 감사합니다.\\n다시 뵙게 될 날을 기대합니다:)");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/member/myPage/profile");
		}
		else if(msgFlag.equals("aboutAskInsertOk")) {
			model.addAttribute("msg", "문의가 등록되었습니다.");
			model.addAttribute("url", "/about/ask");
		}
		else if(msgFlag.equals("aboutAskInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/about/askInsert");
		}
		else if(msgFlag.equals("aboutOriginAskInsertOk")) {
			model.addAttribute("msg", "문의가 등록되었습니다.");
			if(returnPath.equals("컬렉션상품")) model.addAttribute("url", "/collection/colProduct?idx="+returnOriginIdx+"#q&a");
			else model.addAttribute("url", "/magazine/maProduct?idx="+returnOriginIdx+"#q&a");
		}
		else if(msgFlag.equals("aboutOriginAskInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/about/askInsert?category="+returnPath+"&originIdx="+returnOriginIdx);
//			if(returnPath.equals("컬렉션상품")) model.addAttribute("url", "/collection/colProduct?idx="+returnOriginIdx);
//			else model.addAttribute("url", "/magazine/maProduct?idx="+returnOriginIdx);
		}
		else if(msgFlag.equals("aboutAskUpdateOk")) {
			model.addAttribute("msg", "문의가 수정되었습니다.");
			model.addAttribute("url", "/about/askDetail?idx="+idx);
		}
		else if(msgFlag.equals("aboutAskUpdateNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/about/askUpdate?idx="+idx);
		}
		else if(msgFlag.equals("adminNoticeInsertOk")) {
			model.addAttribute("msg", "공지사항이 등록되었습니다.");
			model.addAttribute("url", "/admin/manage/noticeList");
		}
		else if(msgFlag.equals("adminNoticeInsertNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/manage/noticeInsert");
		}
		else if(msgFlag.equals("adminNoticeUpdateOk")) {
			model.addAttribute("msg", "공지사항이 수정되었습니다.");
			model.addAttribute("url", "/admin/manage/noticeList");
		}
		else if(msgFlag.equals("adminNoticeUpdateNo")) {
			model.addAttribute("msg", "재시도 부탁드립니다.");
			model.addAttribute("url", "/admin/manage/noticeUpdate?idx="+idx);
		}
		// 인터셉터 처리
		else if(msgFlag.equals("restrictedPageForAdmin")) {
			model.addAttribute("msg", "관리자 전용 페이지입니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("restrictedPageForMember")) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/");
		}
		
		
		
		return "include/message";
	}
	
	
}