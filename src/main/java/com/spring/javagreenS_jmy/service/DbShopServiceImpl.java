package com.spring.javagreenS_jmy.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_jmy.dao.DbShopDAO;
import com.spring.javagreenS_jmy.vo.DbBaesongVO;
import com.spring.javagreenS_jmy.vo.DbCartListVO;
import com.spring.javagreenS_jmy.vo.DbOptionVO;
import com.spring.javagreenS_jmy.vo.DbOrderVO;
import com.spring.javagreenS_jmy.vo.DbProductQnAVO;
import com.spring.javagreenS_jmy.vo.DbProductReviewVO;
import com.spring.javagreenS_jmy.vo.DbProductVO;
import com.spring.javagreenS_jmy.vo.NoticeVO;

@Service
public class DbShopServiceImpl implements DbShopService {

	@Autowired
	DbShopDAO dbShopDAO;

	@Override
	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName) {
		return dbShopDAO.getCategoryMainOne(categoryMainCode, categoryMainName);
	}

	@Override
	public void setCategoryMainInput(DbProductVO vo) {
		dbShopDAO.setCategoryMainInput(vo);
	}

	@Override
	public List<DbProductVO> getCategoryMain() {
		return dbShopDAO.getCategoryMain();
	}

	@Override
	public List<DbProductVO> getCategorySub() {
		return dbShopDAO.getCategorySub();
	}

	@Override
	public List<DbProductVO> getCategorySubOne(DbProductVO vo) {
		return dbShopDAO.getCategorySubOne(vo);
	}

	@Override
	public void delCategoryMain(String categoryMainCode) {
		dbShopDAO.delCategoryMain(categoryMainCode);
	}

	@Override
	public void setCategorySubInput(DbProductVO vo) {
		dbShopDAO.setCategorySubInput(vo);
	}

	@Override
	public List<DbProductVO> getDbProductOne(String categorySubCode) {
		return dbShopDAO.getDbProductOne(categorySubCode);
	}

	@Override
	public void delCategorySub(String categorySubCode) {
		dbShopDAO.delCategorySub(categorySubCode);
	}

	@Override
	public List<DbProductVO> getCategorySubName(String categoryMainCode) {
		return dbShopDAO.getCategorySubName(categoryMainCode);
	}

	
	@Override
	public List<DbProductVO> getSubTitle() {
		return dbShopDAO.getSubTitle();
	}

	@Override
	public List<DbProductVO> getDbShopList(String categorySubCode,int startIndexNo, int pageSize) {
		return dbShopDAO.getDbShopList(categorySubCode,startIndexNo,pageSize);
	}

	@Override
	public DbProductVO getDbShopProduct(int idx) {
		return dbShopDAO.getDbShopProduct(idx);
	}

	
  @Override 
  public List<DbOptionVO> getDbShopOption(int productIdx) { 
  	return dbShopDAO.getDbShopOption(productIdx); 
  }
	 

	@Override
	public void imgCheckProductInput(MultipartFile file, DbProductVO vo) {
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != null && originalFilename != "") {
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			  String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName);	  
				vo.setFName(originalFilename);		
				vo.setFSName(saveFileName);				
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/dbShop/");
		
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	
			
			copyFilePath = uploadPath + "product/" + imgFile;	
			
			fileCopyCheck(oriFilePath, copyFilePath);	
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		vo.setContent(vo.getContent().replace("/data/dbShop/", "/data/dbShop/product/"));
		int maxIdx = 0;
		DbProductVO maxVo = dbShopDAO.getProductMaxIdx();
		if(maxVo != null) {
			maxIdx = maxVo.getIdx() + 1;
			vo.setIdx(maxIdx);
		}
		vo.setProductCode(vo.getCategoryMainCode()+vo.getCategorySubCode()+maxIdx);
		dbShopDAO.setDbProductInput(vo);
	}

	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
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

	private void writeFile(MultipartFile fName, String saveFileName) throws IOException{
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
		
	}

	@Override
	public String[] getProductName() {
		return dbShopDAO.getProductName();
	}

	@Override
	public List<DbProductVO> getProductInfor(String productName) {
		return dbShopDAO.getProductInfor(productName);
	}

	@Override
	public List<DbOptionVO> getOptionList(int productIdx) {
		return dbShopDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return dbShopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public void setDbOptionInput(DbOptionVO vo) {
		dbShopDAO.setDbOptionInput(vo);
	}

	@Override
	public void setOptionDelete(int idx) {
		dbShopDAO.setOptionDelete(idx);
	}

	@Override
	public DbProductVO getDbShopContent(int idx) {
		return dbShopDAO.getDbShopContent(idx);
	}

	@Override
	public void imgDelete(String content) {
		
		if(content.indexOf("src=\"/") ==-1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
		
		int position=41;
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
	public void setDbShopDelete(int idx) {
		dbShopDAO.setDbShopDelete(idx);
	}

	@Override
	public void imgCheckUpdate(String content) {
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
		
		int position=41;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw= true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;
			String coptFilePath = request.getRealPath("/resources/data/dbShop/"+imgFile);
			
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
	public ArrayList<DbProductReviewVO> getProductReview(int idx) {
		return dbShopDAO.getProductReview(idx);
	}

	@Override
	public DbCartListVO getDbCartListProductOptionSearch(String productName, String optionName, String mid) {
		return dbShopDAO.getDbCartListProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public void dbShopCartUpdate(DbCartListVO vo) {
		dbShopDAO.dbShopCartUpdate(vo);
	}

	@Override
	public void dbShopCartInput(DbCartListVO vo) {
		dbShopDAO.dbShopCartInput(vo);
	}

	@Override
	public List<DbCartListVO> getDbCartList(String mid) {
		return dbShopDAO.getDbCartList(mid);
	}

	@Override
	public DbOrderVO getOrderMaxIdx() {
		return dbShopDAO.getOrderMaxIdx();
	}

	@Override
	public DbCartListVO getCartIdx(int idx) {
		return dbShopDAO.getCartIdx(idx);
	}

	@Override
	public void dbCartDelete(int idx) {
		dbShopDAO.dbCartDelete(idx);
	}

	@Override
	public void setDbOrder(DbOrderVO vo) {
		dbShopDAO.setDbOrder(vo);
	}

	@Override
	public void dbCartDeleteAll(int cartIdx) {
		dbShopDAO.dbCartDeleteAll(cartIdx);
	}

	@Override
	public void setDbBaesong(DbBaesongVO baesongVo) {
		dbShopDAO.setDbBaesong(baesongVo);
	}

	@Override
	public void setMemberPointPlus(int point, String mid) {
		dbShopDAO.setMemberPointPlus(point, mid);
	}

	@Override
	public List<DbBaesongVO> getOrderBaesong(String orderIdx) {
		return dbShopDAO.getOrderBaesong(orderIdx);
	}

	@Override
	public List<DbOrderVO> getMyOrderList(int startIndexNo, int pageSize, String mid) {
		return dbShopDAO.getMyOrderList(startIndexNo, pageSize, mid);
	}

	@Override
	public List<DbBaesongVO> getOrderCondition(String mid, int conditionDate, int startIndexNo, int pageSize) {
		return dbShopDAO.getOrderCondition(mid, conditionDate, startIndexNo, pageSize);
	}

	@Override
	public List<DbBaesongVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus) {
		return dbShopDAO.getMyOrderStatus(startIndexNo, pageSize, mid, startJumun, endJumun,	conditionOrderStatus);
	}

	@Override
	public List<DbBaesongVO> getAdminOrderStatus(int startIndexNo, int pageSize, String startJumun, String endJumun, String orderStatus) {
		return dbShopDAO.getAdminOrderStatus(startIndexNo, pageSize, startJumun, endJumun, orderStatus);
	}

	@Override
	public List<DbProductVO> getProductSearch(int startIndexNo, int pageSize, String searchString) {
		return dbShopDAO.getProductSearch(startIndexNo, pageSize, searchString);
	}

	@Override
	public List<DbBaesongVO> getOrderStatus(String mid, String orderStatus, int startIndexNo, int pageSize) {
		return dbShopDAO.getOrderStatus(mid, orderStatus, startIndexNo, pageSize);
	}

	@Override
	public List<DbProductVO> getDbShopMainCodeList(String categoryMainCode, int startIndexNo, int pageSize) {
		return dbShopDAO.getDbShopMainCodeList(categoryMainCode, startIndexNo, pageSize);
	}

	@Override
	public void setOrderStatusUpdate(String orderIdx, String orderStatus) {
		dbShopDAO.setOrderStatusUpdate(orderIdx, orderStatus);
	}

	@Override
	public ArrayList<DbProductQnAVO> getProductQnA(int idx) {
		return dbShopDAO.getProductQnA(idx);
	}

	@Override
	public void setQnAInput(DbProductQnAVO dbProductQnAVO) {
		dbShopDAO.setQnAInput(dbProductQnAVO);
	}

	@Override
	public void setdbShopQnADelete(int idx) {
		dbShopDAO.setdbShopQnADelete(idx);
	}

	@Override
	public String maxLevelOrder(int productIdx) {
		return dbShopDAO.maxLevelOrder(productIdx);
	}

	@Override
	public void levelOrderPlusUpdate(DbProductQnAVO dbProductQnAVO) {
		dbShopDAO.levelOrderPlusUpdate(dbProductQnAVO);
	}

	@Override
	public void setQnAInput2(DbProductQnAVO dbProductQnAVO) {
		dbShopDAO.setQnAInput2(dbProductQnAVO);
	}

	@Override
	public int getCartCount(String mid) {
		return dbShopDAO.getCartCount(mid);
	}

	@Override
	public ArrayList<DbProductReviewVO> getReviewBoardList(String mid, int startIndexNo, int pageSize) {
		return dbShopDAO. getReviewBoardList(mid, startIndexNo, pageSize);
	}

	@Override
	public ArrayList<DbProductQnAVO> getQnABoardList(String mid, int startIndexNo, int pageSize) {
		return dbShopDAO.getQnABoardList(mid, startIndexNo, pageSize);
	}

	@Override
	public ArrayList<DbProductQnAVO> getAdQnABoardList(int startIndexNo, int pageSize) {
		return dbShopDAO.getAdQnABoardList(startIndexNo, pageSize);
	}

	@Override
	public void setReviewInput(DbProductReviewVO vo) {
		dbShopDAO.setReviewInput(vo);
	}

	@Override
	public void setdbShopReviewDelete(int idx) {
		dbShopDAO.setdbShopReviewDelete(idx);
	}

	@Override
	public String getQrCode(int idx) {
		return dbShopDAO.getQrCode(idx);
	}

	@Override
	public List<DbOrderVO> getMyOrderConditionList(String mid, int conditionDate, int startIndexNo, int pageSize) {
		return dbShopDAO.getMyOrderConditionList(mid, conditionDate, startIndexNo, pageSize);
	}

	@Override
	public void setDbShopOptionDelete(int idx) {
		dbShopDAO.setDbShopOptionDelete(idx);
	}

}
