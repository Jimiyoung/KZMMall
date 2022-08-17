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

import com.spring.javagreenS_jmy.dao.AsDAO;
import com.spring.javagreenS_jmy.vo.AsReplyVO;
import com.spring.javagreenS_jmy.vo.AsVO;

@Service
public class AsServiceImpl implements AsService{
	
	@Autowired
	AsDAO asDAO;

	@Override
	public void setAsInputOk(AsVO vo) {
		asDAO.setAsInputOk(vo);
	}

	@Override
	public List<AsVO> getAsList(int startIndexNo, int pageSize) {
		return asDAO.getAsList(startIndexNo, pageSize);
	}

	@Override
	public AsVO getAsContent(int idx) {
		return asDAO.getAsContent(idx);
	}

	@Override
	public void imgDelete(String content) {
		if(content.indexOf("src=\"/") ==-1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/as/");
		
		int position=48;
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
	public void imgCheck(String content) {
		if(content.indexOf("src=\"/") ==-1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position=35;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath +"as/"+ imgFile;
			
			fileCopyCheck(oriFilePath,copyFilePath);  
			
			if(nextImg.indexOf("src=\"/")==-1) {
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
	public void setAsUpdate(AsVO vo) {
		asDAO.setAsUpdate(vo);
	}

	@Override
	public void imgCheckUpdate(String content) {
		if(content.indexOf("src=\"/") ==-1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/as/");
		
		int position=38;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFile);
		
			fileCopyCheck(oriFilePath,copyFilePath); 
			
			if(nextImg.indexOf("src=\"/")==-1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			}
		}
	}

	@Override
	public void setAsDelete(int idx) {
		asDAO.setAsDelete(idx);
		
	}

	@Override
	public String maxLevelOrder(int asIdx) {
		return asDAO.maxLevelOrder(asIdx);
	}

	@Override
	public void setAsReplyInput(AsReplyVO replyVo) {
		asDAO.setAsReplyInput(replyVo);
		
	}

	@Override
	public ArrayList<AsReplyVO> getAsReply(int idx) {
		return asDAO.getAsReply(idx);
	}

	@Override
	public void setAsReplyDelete(int idx) {
		asDAO.setAsReplyDelete(idx);
	}

	@Override
	public void setAsReplyUpdate(AsReplyVO replyVo) {
		asDAO.setAsReplyUpdate(replyVo);
		
	}

	@Override
	public void levelOrderPlusUpdate(AsReplyVO replyVo) {
		asDAO.levelOrderPlusUpdate(replyVo);
	}

	@Override
	public void setAsReplyInput2(AsReplyVO replyVo) {
		asDAO.setAsReplyInput2(replyVo);
	}

	@Override
	public void swCheck(int idx) {
		asDAO.swCheck(idx);
	}

	@Override
	public ArrayList<AsVO> getAsBoardList(String mid, int startIndexNo, int pageSize) {
		return asDAO.getAsBoardList(mid,startIndexNo,pageSize);
	}

	@Override
	public void setAsDeleteReply(int idx) {
		asDAO.setAsDeleteReply(idx);
	}






}
