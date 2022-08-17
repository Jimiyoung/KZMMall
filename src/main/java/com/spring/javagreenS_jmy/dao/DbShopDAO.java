package com.spring.javagreenS_jmy.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_jmy.vo.DbBaesongVO;
import com.spring.javagreenS_jmy.vo.DbCartListVO;
import com.spring.javagreenS_jmy.vo.DbOptionVO;
import com.spring.javagreenS_jmy.vo.DbOrderVO;
import com.spring.javagreenS_jmy.vo.DbProductQnAVO;
import com.spring.javagreenS_jmy.vo.DbProductReviewVO;
import com.spring.javagreenS_jmy.vo.DbProductVO;

public interface DbShopDAO {

	public DbProductVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	public void setCategoryMainInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategoryMain();

	public List<DbProductVO> getCategorySub();

	public List<DbProductVO> getCategorySubOne(@Param("vo") DbProductVO vo);

	public void delCategoryMain(@Param("categoryMainCode") String categoryMainCode);

	public void setCategorySubInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getDbProductOne(@Param("categorySubCode") String categorySubCode);

	public void delCategorySub(@Param("categorySubCode") String categorySubCode);

	public List<DbProductVO> getCategorySubName(@Param("categoryMainCode") String categoryMainCode);

	public DbProductVO getProductMaxIdx();

	public List<DbProductVO> getSubTitle();

	public List<DbProductVO> getDbShopList(@Param("categorySubCode") String categorySubCode, @Param("startIndexNo") int startIndexNo,  @Param("pageSize") int pageSize);

	public DbProductVO getDbShopProduct(@Param("idx") int idx);

	public void setDbProductInput(@Param("vo") DbProductVO vo);

	public String[] getProductName();

	public List<DbProductVO> getProductInfor(@Param("productName") String productName);

	public List<DbOptionVO> getOptionList(@Param("productIdx") int productIdx);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public void setDbOptionInput(@Param("vo") DbOptionVO vo);

	public void setOptionDelete(@Param("idx") int idx);

	public List<DbOptionVO> getDbShopOption(@Param("productIdx") int productIdx);

	public DbProductVO getDbShopContent(@Param("idx") int idx);

	public void setDbShopDelete(@Param("idx") int idx);

	public int totRecCnt(@Param("categorySubCode") String categorySubCode);
	
	public ArrayList<DbProductReviewVO> getProductReview(@Param("idx") int idx);

	public DbCartListVO getDbCartListProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public void dbShopCartUpdate(@Param("vo") DbCartListVO vo);

	public void dbShopCartInput(@Param("vo") DbCartListVO vo);

	public List<DbCartListVO> getDbCartList(@Param("mid") String mid);

	public DbOrderVO getOrderMaxIdx();

	public DbCartListVO getCartIdx(@Param("idx") int idx);

	public void dbCartDelete(@Param("idx") int idx);

	public void setDbOrder(@Param("vo") DbOrderVO vo);

	public void dbCartDeleteAll(@Param("cartIdx") int cartIdx);

	public void setDbBaesong(@Param("baesongVo") DbBaesongVO baesongVo);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid")String mid);

	public List<DbBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public List<DbOrderVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);
	
	public List<DbBaesongVO> getOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);
	
	public int totRecCntCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<DbBaesongVO> getMyOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public List<DbBaesongVO> getAdminOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public int totSearchRecCnt(@Param("part") String part, @Param("searchString") String searchString);

	public List<DbProductVO> getProductSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("searchString") String searchString);

	public int totRecCntStatus(@Param("part") String part, @Param("searchString") String searchString);

	public List<DbBaesongVO> getOrderStatus(@Param("mid") String mid, @Param("orderStatus") String orderStatus, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCntMyOrderStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public int totRecCntAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public List<DbProductVO> getDbShopMainCodeList(@Param("categoryMainCode") String categoryMainCode, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setOrderStatusUpdate(@Param("orderIdx") String orderIdx, @Param("orderStatus") String orderStatus);

	public ArrayList<DbProductQnAVO> getProductQnA(@Param("idx") int idx);

	public void setQnAInput(@Param("dbProductQnAVO") DbProductQnAVO dbProductQnAVO);

	public void setdbShopQnADelete(@Param("idx") int idx);

	public String maxLevelOrder(@Param("productIdx") int productIdx);

	public void levelOrderPlusUpdate(@Param("dbProductQnAVO") DbProductQnAVO dbProductQnAVO);

	public void setQnAInput2(@Param("dbProductQnAVO") DbProductQnAVO dbProductQnAVO);

	public int getCartCount(@Param("mid") String mid);

	public int totMemReviewRecCnt(@Param("searchString") String searchString);

	public ArrayList<DbProductReviewVO> getReviewBoardList(@Param("mid") String mid, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totMemQnARecCnt(@Param("searchString") String searchString);

	public ArrayList<DbProductQnAVO> getQnABoardList(@Param("mid") String mid, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totAdMemQnARecCnt();

	public ArrayList<DbProductQnAVO> getAdQnABoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecOrderCnt(@Param("mid") String mid);

	public int totSubCodeRecCnt(@Param("categorySubCode") String categorySubCode);

	public void setReviewInput(@Param("vo") DbProductReviewVO vo);

	public void setdbShopReviewDelete(@Param("idx") int idx);

	public String getQrCode(@Param("idx") int idx);

	public List<DbOrderVO> getMyOrderConditionList(@Param("mid") String mid, @Param("conditionDate") int conditionDate, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setDbShopOptionDelete(@Param("idx") int idx);

}
