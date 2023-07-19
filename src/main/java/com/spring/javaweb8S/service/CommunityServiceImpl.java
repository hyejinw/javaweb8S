package com.spring.javaweb8S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaweb8S.dao.CommunityDAO;
import com.spring.javaweb8S.vo.BookSaveVO;
import com.spring.javaweb8S.vo.InspiredVO;
import com.spring.javaweb8S.vo.MemberVO;
import com.spring.javaweb8S.vo.RefSaveVO;
import com.spring.javaweb8S.vo.ReflectionVO;
import com.spring.javaweb8S.vo.ReplyVO;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	// 커뮤니티 메뉴에서 쓸 회원 정보 가져오기
	@Override
	public MemberVO getMemberInfo(String nickname) {
		return communityDAO.getMemberInfo(nickname);
	}

	// 커뮤니티 기록 창 리스트
	@Override
	public ArrayList<ReflectionVO> getReflectionList(int startIndexNo, int pageSize) {
		return communityDAO.getReflectionList(startIndexNo, pageSize);
	}

	// 기록 등록 창에서 사진 업로드(CKEditor -> 저장)
	public void imgCheck(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "community/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 community폴더 위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 파일 복사
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream  fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();		
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
	  }
	}

	// 기록 등록
	@Override
	public int setReflectionInsert(ReflectionVO vo) {
		return communityDAO.setReflectionInsert(vo);
	}

	// 기록 상세창
	@Override
	public ReflectionVO getReflectionDetail(int idx) {
		return communityDAO.getReflectionDetail(idx);
	}

	// 댓글
	@Override
	public ArrayList<ReplyVO> getReply(int idx) {
		return communityDAO.getReply(idx);
	}

	// 문장수집
	@Override
	public ArrayList<InspiredVO> getInspired(int bookIdx, String nickname) {
		return communityDAO.getInspired(bookIdx, nickname);
	}

	// 기록 저장 유무
	@Override
	public RefSaveVO getRefSave(int idx, String nickname) {
		return communityDAO.getRefSave(idx, nickname);
	}

	// 해당 기록 댓글의 최대 그룹 ID 가져오기
	@Override
	public String getMaxGroupId(int refIdx) {
		return communityDAO.getMaxGroupId(refIdx);
	}

	// 기록 댓글 추가
	@Override
	public void setReplyInsert(ReplyVO vo) {
		communityDAO.setReplyInsert(vo);
	}

	// 기록 검색
	@Override
	public ArrayList<ReflectionVO> getReflectionSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return communityDAO.getReflectionSearch(startIndexNo, pageSize, search, searchString);
	}

	// 커뮤니티 기록 상세창에서, 기록 저장
	@Override
	public void setRefSave(int refIdx, String memNickname) {
		communityDAO.setRefSave(refIdx, memNickname);
	}

	// 커뮤니티 기록 상세창에서, 기록 저장 취소
	@Override
	public void setRefSaveDelete(int refIdx, String memNickname) {
		communityDAO.setRefSaveDelete(refIdx, memNickname);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 추가
	@Override
	public void setInspiredInsert(InspiredVO vo) {
		communityDAO.setInspiredInsert(vo);
	}

	// 커뮤니티 기록 저장 등록 수 변경
	@Override
	public void setRefSaveUpdate(int refIdx, int refSaveNum) {
		communityDAO.setRefSaveUpdate(refIdx, refSaveNum);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 저장
	@Override
	public void setInsSave(int insIdx, String memNickname) {
		communityDAO.setInsSave(insIdx, memNickname);
	}

	// 커뮤니티 문장수집 저장 등록 수 변경
	@Override
	public void setInsSaveUpdate(int insIdx, int insSaveNum) {
		communityDAO.setInsSaveUpdate(insIdx, insSaveNum);
	}
  
	// 커뮤니티 기록 상세창에서, 문장 수집 저장 취소
	@Override
	public void setInsSaveDelete(int idx) {
		communityDAO.setInsSaveDelete(idx);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 삭제
	@Override
	public void setInspiredDelete(int idx) {
		communityDAO.setInspiredDelete(idx);
	}

	// 해당 문장 수집을 저장한 기록 모두 삭제
	@Override
	public void setInsSaveForcedDelete(int idx) {
		communityDAO.setInsSaveForcedDelete(idx);
	}

	// 커뮤니티 기록 상세창에서, 문장 수집 수정
	@Override
	public void setInspiredUpdate(InspiredVO vo) {
		communityDAO.setInspiredUpdate(vo);
	}

	// 커뮤니티 기록 수정창에서 책 변경 
	@Override
	public int setRefBookUpdate(String publisher, String bookTitle, int idx) {
		return communityDAO.setRefBookUpdate(publisher, bookTitle, idx);
	}

	// 커뮤니티 기록 수정
	@Override
	public int setReflectionUpdate(ReflectionVO vo) {
		return communityDAO.setReflectionUpdate(vo);
	}

	// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(community)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
	@Override
	public void imgCheckUpdate(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/board/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "community/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
				}
			else {
					nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	// 실제로 수정하기 버튼을 클릭하게되면, 기존의 community폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
	@Override
	public void imgDelete(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/community/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/community/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// 그림파일명만 꺼내오기
			
			String origFilePath = realPath + "community/" + imgFile;
			
			fileDelete(origFilePath);	// 'community'폴더의 그림을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 실제로 서버의 파일을 삭제처리한다.
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	// 대댓글의 원본 댓글 내용 가져오기
	@Override
	public ArrayList<ReplyVO> getReReplyOriginContent(ArrayList<ReplyVO> tempReplyVOS) {
		return communityDAO.getReReplyOriginContent(tempReplyVOS);
	}

	// 커뮤니티 기록 상세창에서 댓글 수정
	@Override
	public void setReplyUpdate(ReplyVO vo) {
		communityDAO.setReplyUpdate(vo);
	}

	// 커뮤니티 기록 상세창에서 댓글 삭제
	@Override
	public void setReplyDelete(int idx) {
		communityDAO.setReplyDelete(idx);
	}

	// 조회수 증가하기
	@Override
	public void setRefViewUpdate(int idx) {
		communityDAO.setRefViewUpdate(idx);
	}

	// 기록 삭제
	@Override
	public int setReflectionDelete(int idx) {
		return communityDAO.setReflectionDelete(idx);
	}

	// 해당 기록을 저장한 경우 모두 삭제
	@Override
	public void setRefSaveForcedDelete(int idx) {
		communityDAO.setRefSaveForcedDelete(idx);
	}

	// 해당 기록에 달린 댓글 삭제
	@Override
	public void setReplyForcedDelete(int idx) {
		communityDAO.setReplyForcedDelete(idx);
	}

	// 커뮤니티 마이페이지, (서재) 카테고리별 책 저장
	@Override
	public ArrayList<BookSaveVO> getBookSave(String categoryName, String memNickname) {
		return communityDAO.getBookSave(categoryName, memNickname);
	}

	// 커뮤니티 마이페이지, 기록
	@Override
	public ArrayList<ReflectionVO> getMemReflection(String memNickname) {
		return communityDAO.getMemReflection(memNickname);
	}

	// 커뮤니티 마이페이지, 문장수집
	@Override
	public ArrayList<InspiredVO> getMemInspired(int startIndexNo, int pageSize, String memNickname) {
		return communityDAO.getMemInspired(startIndexNo, pageSize, memNickname);
	}

	// 커뮤니티 마이페이지 메인창에서, 책 저장 추가
	@Override
	public void setBookSaveInsert(BookSaveVO vo) {
		communityDAO.setBookSaveInsert(vo);
	}

	// 책 저장 삭제
	@Override
	public void setBookSaveDelete(int idx) {
		communityDAO.setBookSaveDelete(idx);
	}

	// 책 저장 카테고리 변경
	@Override
	public void setBookSaveCategoryChange(BookSaveVO vo) {
		communityDAO.setBookSaveCategoryChange(vo);
	}
	
	
	
}
