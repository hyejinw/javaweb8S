package com.spring.javaweb8S.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String memType = session.getAttribute("sMemType") == null ? "none" : (String) session.getAttribute("sMemType");
		
		// 회원, 관리자가 아니면 초기화면창으로 보내준다.
		if(memType.equals("none")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/restrictedPageForMember");
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
}
