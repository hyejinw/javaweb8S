package com.spring.javaweb8S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb8S.vo.AddressVO;
import com.spring.javaweb8S.vo.CartVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.OrderVO;
import com.spring.javaweb8S.vo.SaveVO;

public interface OrderDAO {

	public MemberVO getMemberInfo(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getProductCartList(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getMagazineCartList(@Param("memNickname") String memNickname);

	public ArrayList<CartVO> getSubscribeCartList(@Param("memNickname") String memNickname);

	public void setCartProdNumUpdate(@Param("vo") CartVO vo);

	public void setCartIdxesDelete(@Param("cartIdxList") List<String> cartIdxList);

	public void setCartIdxDelete(@Param("idx") int idx);

	public void setSaveDelete(@Param("memNickname") String memNickname, @Param("idx") int idx);

	public void setSaveInsertPost(@Param("vo") SaveVO vo);

	public ArrayList<CartVO> getCartList(@Param("memNickname") String memNickname, @Param("cartIdxList")List<String> cartIdxList);

	public AddressVO getDefaultAddress(@Param("memNickname") String memNickname);

	public ArrayList<AddressVO> getAddressList(@Param("memNickname") String memNickname);

	public void setDefaultAddressReset(@Param("memNickname") String memNickname);

	public void setAddressInsert(@Param("vo") AddressVO vo);

	public void setAddressIdxesDelete(@Param("addressIdxList") List<String> addressIdxList);

	public AddressVO getAddressInfo(@Param("idx") int idx);

	public void setAddressUpdate(@Param("vo") AddressVO vo);

	public void setOrderInsert(@Param("orderVOS") ArrayList<OrderVO> orderVOS);

	public void setDeliveryInsert(@Param("orderVOS") ArrayList<OrderVO> orderVOS);

	public String getCartIdx(@Param("cartVO") CartVO cartVO);

	public void setSubscribeInsert(@Param("subVOS") ArrayList<OrderVO> subVOS);

	public void setPointUseInsert(@Param("pointUseVOS") ArrayList<OrderVO> pointUseVOS);

	public void setMemberPointUpdate(@Param("totalUsedPoint") int totalUsedPoint, @Param("memNickname") String memNickname);

	public void setProdOpStockUpdate(@Param("prodOrderVOS") ArrayList<OrderVO> prodOrderVOS);

	public ArrayList<String> getProdStockUpdateIdx();

	public void setProdStockUpdate(@Param("prodStockUpdateIdx") ArrayList<String> prodStockUpdateIdx);

	public void setMaStockUpdate(@Param("maOrderVOS") ArrayList<OrderVO> maOrderVOS);

	public void setProdSaleQuantityUpdate(@Param("prodOrderVOS") ArrayList<OrderVO> prodOrderVOS);


}
