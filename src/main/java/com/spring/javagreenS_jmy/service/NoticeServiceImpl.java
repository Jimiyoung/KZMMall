package com.spring.javagreenS_jmy.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS_jmy.dao.NoticeDAO;
import com.spring.javagreenS_jmy.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO noticeDAO;

	@Override
	public void imgCheck(String content) {
		if(content.indexOf("src=\"/")==-1) return;  
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");

		int position= 35;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw= true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "notice/" + imgFile;
			
			fileCopyCheck(oriFilePath,copyFilePath); 
		
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
	}
	
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer,0,count);
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

	@Override
	public void setNoticeInput(NoticeVO vo) {
		noticeDAO.setNoticeInput(vo);
	}

	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return noticeDAO.getNoticeList(startIndexNo, pageSize);
	}

	@Override
	public void setReadNum(int idx) {
		noticeDAO.setReadNum(idx);
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return noticeDAO.getNoticeContent(idx);
	}

	@Override
	public ArrayList<NoticeVO> getPreNext(int idx) {
		return noticeDAO.getPreNext(idx);
	}

	@Override
	public int getMinIdx() {
		return noticeDAO.getMinIdx();
	}

	@Override
	public void imgDelete(String content) {
		
		if(content.indexOf("src=\"/") ==-1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/notice/");
		
		int position=52;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			
			fileDelete(oriFilePath);  
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
	}
	
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setNoticeDelete(int idx) {
		noticeDAO.setNoticeDelete(idx); 
	}

	@Override
	public void imgCheckUpdate(String content) {

		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/notice/");
		
		int position=52;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw= true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			String coptFilePath = request.getRealPath("/resources/data/ckeditor/"+imgFile);
			
			fileCopyCheck(oriFilePath, coptFilePath); 
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw=false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
	}
 
	@Override
	public void setNoticeUpdate(NoticeVO vo) {
		noticeDAO.setNoticeUpdate(vo);
	}

	@Override
	public List<NoticeVO> getNoticeSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return noticeDAO.getNoticeSearch(startIndexNo, pageSize, search, searchString);
	}
}
