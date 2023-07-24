package com.spring.javaweb8S.pagination;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.dao.CollectionDAO;
import com.spring.javaweb8S.dao.CommunityDAO;
import com.spring.javaweb8S.dao.MagazineDAO;
import com.spring.javaweb8S.dao.MemberDAO;
import com.spring.javaweb8S.dao.OrderDAO;
import com.spring.javaweb8S.vo.OrderVO;

@Service
public class PageProcess {

	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	MagazineDAO magazineDAO;
	
	@Autowired
	CollectionDAO collectionDAO;
	
	@Autowired
	OrderDAO orderDAO;
	
	@Autowired
	CommunityDAO communityDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String search, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("adminProverb"))	totRecCnt = adminDAO.proverbTotRecCnt();
		else if(section.equals("adminBook")) {
			if(searchString.equals("")) totRecCnt = adminDAO.bookTotRecCnt();
			else {
				totRecCnt = adminDAO.bookTotRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("adminMagazine")) totRecCnt = adminDAO.magazineTotRecCnt();
		else if(section.equals("adminMagazineType")) totRecCnt = adminDAO.magazineTypeTotRecCnt(search);
		else if(section.equals("adminColCategory")) totRecCnt = adminDAO.colCategoryTotRecCnt();
		else if(section.equals("adminColProduct")) totRecCnt = adminDAO.colProductTotRecCnt();
		else if(section.equals("adminOrder")) totRecCnt = adminDAO.orderTotRecCnt();

		else if(section.equals("magazineList")) totRecCnt = magazineDAO.magazineListTotRecCnt(search, searchString);
		else if(section.equals("collectionList")) totRecCnt = collectionDAO.collectionTotRecCnt(search);
		else if(section.equals("colProductList")) totRecCnt = collectionDAO.productTotRecCnt(search, searchString);
		else if(section.equals("communityReflectionList")) totRecCnt = communityDAO.reflectionTotRecCnt();
		else if(section.equals("communityReflectionSearch")) totRecCnt = communityDAO.reflectionSearchTotRecCnt(search, searchString);
		else if(section.equals("communityMyPageInspired")) totRecCnt = communityDAO.myPageInspiredTotRecCnt(search);
		else if(section.equals("communityMyPageReflectionList")) totRecCnt = communityDAO.myPageReflectionTotRecCnt(search);
		else if(section.equals("communityMyPageReflectionSearch")) {
			String memNickname = search.split("/")[0];
			search = search.split("/")[1];
			
			totRecCnt = communityDAO.myPageReflectionSearchTotRecCnt(memNickname, search, searchString);
		}
		else if(section.equals("communityMyPageReplyList")) totRecCnt = communityDAO.myPageReplyTotRecCnt(search);
		else if(section.equals("communityMyPageAskSearch")) {
			String memNickname = search.split("/")[0];
			String sort = search.split("/")[1];
			search = search.split("/")[2];

			totRecCnt = communityDAO.myPageAskSearchTotRecCnt(memNickname, sort, search, searchString);
		}
		else if(section.equals("communityAskSearch")) {
			String sort = search.split("/")[0];
			search = search.split("/")[1];
			
			totRecCnt = communityDAO.AskSearchTotRecCnt(sort, search, searchString);
		}
		
		
//		else if(section.equals("board")) {
//			if(part.equals("")) totRecCnt = boardDAO.totRecCnt();
//			else {
//				search = part;
//				totRecCnt = boardDAO.totRecCntSearch(search, searchString);
//			}
//		}
//		else if(section.equals("pds"))	totRecCnt = pdsDAO.totRecCnt(part);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}
	
	// 기간으로 검색
	public PageVO totRecCntWithPeriod(int pag, int pageSize, String section, String search, String searchString, String startDate, String endDate) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		
		if(section.equals("adminMagazine"))	totRecCnt = adminDAO.magazineTotRecCntWithPeriod(search, searchString, startDate, endDate);
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}

	// 기간과 상품 상태까지 함께 검색
	public PageVO totRecCntWithPeriodAndSort(int pag, int pageSize, String section, String sort, String search,
			String searchString, String startDate, String endDate) {

		PageVO pageVO = new PageVO();
		int totRecCnt = 0;
		
		if(section.equals("adminColProduct")) totRecCnt = adminDAO.colProdTotRecCntWithPeriod(sort, search, searchString, startDate, endDate);
		if(section.equals("adminColNameProduct")) totRecCnt = adminDAO.colProdColNameTotRecCntWithPeriod(sort, search, searchString, startDate, endDate);
		if(section.equals("adminOrder")) totRecCnt = adminDAO.orderTotRecCntWithPeriod(sort, search, searchString, startDate, endDate);
		if(section.equals("adminOrderWithInvoice")) {
			ArrayList<OrderVO> temp = adminDAO.orderWithInvoiceTotRecCntWithPeriod(sort, search, searchString, startDate, endDate);
			totRecCnt = temp.size();
		}
		if(section.equals("myPageOrderWithInvoice")) {
			String nickname = search.split("/")[0];
			search = search.split("/")[1];
			ArrayList<OrderVO> temp = memberDAO.myPageOrderWithInvoiceTotRecCntWithPeriod(sort, search, searchString, startDate, endDate, nickname);
			totRecCnt = temp.size();
		}
		if(section.equals("myPageOrder")) {
			String nickname = search.split("/")[0];
			search = search.split("/")[1];
			totRecCnt = memberDAO.myPageOrderTotRecCntWithPeriod(sort, search, searchString, startDate, endDate, nickname);
		}
			
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}

}
