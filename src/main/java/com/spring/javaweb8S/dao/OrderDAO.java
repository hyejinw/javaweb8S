package com.spring.javaweb8S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.MemberVO;

public interface OrderDAO {

	public MemberVO getMemberInfo(@Param("memNickname") String memNickname);

}
