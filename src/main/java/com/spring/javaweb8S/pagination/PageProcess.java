package com.spring.javaweb8S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AdminDAO;

@Service
public class PageProcess {

	@Autowired
	AdminDAO adminDAO;
	
	
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

}
