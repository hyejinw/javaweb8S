package com.spring.javaweb8S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;

public interface OrderDAO {

	public MemberVO getMemberInfo(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getProductCartList(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getMagazineCartList(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getSubscribeCartList(@Param("memNickname") String memNickname);


}
