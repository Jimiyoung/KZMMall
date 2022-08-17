package com.spring.javagreenS_jmy.pagination;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.cj.conf.url.XDevApiDnsSrvConnectionUrl;
import com.spring.javagreenS_jmy.dao.AsDAO;
import com.spring.javagreenS_jmy.dao.DbShopDAO;
import com.spring.javagreenS_jmy.dao.MemberDAO;
import com.spring.javagreenS_jmy.dao.NoticeDAO;
import com.spring.javagreenS_jmy.vo.DbProductVO;

@Service
public class PageProcess {
	
	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	AsDAO asDAO;
	
	@Autowired 
	DbShopDAO dbShopDAO;
	
	@Autowired
	MemberDAO memberDAO;
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		int blockSize = 10;
		
		if(section.equals("notice")) {
			if(searchString.equals("")) {
				totRecCnt = noticeDAO.totRecCnt();
			}
			else {
				String search = part;
				totRecCnt = noticeDAO.totSearchRecCnt(search,searchString);
			}
		}	
		else if (section.equals("as")){
			if(searchString.equals("")) {
				totRecCnt = asDAO.totRecCnt();
			}
			else {
				String search = part;
				totRecCnt = asDAO.totSearchRecCnt(search,searchString);
			}
		}
		else if (section.equals("dbShop")){
			if(searchString.equals("")) {
				totRecCnt = dbShopDAO.totRecCnt(searchString); 
			}
			else if(!part.equals("categorySubCode")) {
				totRecCnt = dbShopDAO.totSearchRecCnt(part,searchString); 
			}
			else {
				totRecCnt = dbShopDAO.totSubCodeRecCnt(searchString);
			}
		}
		else if(section.equals("dbMyOrder")) {
			String mid = searchString;
			totRecCnt = dbShopDAO.totRecOrderCnt(mid);
		}
		else if(section.equals("myOrderStatus")) {
			String[] searchStringArr = searchString.split("@");
			totRecCnt = dbShopDAO.totRecCntMyOrderStatus(part,searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("dbShopMyOrderStatus")) {
			totRecCnt = dbShopDAO.totRecCntStatus(part,searchString);
		}
		else if(section.equals("dbShopMyOrderCondition")) {
			totRecCnt = dbShopDAO.totRecCntCondition(part, Integer.parseInt(searchString));
		}
		else if(section.equals("adminDbOrderProcess")) {
			String[] searchStringArr = searchString.split("@");
			totRecCnt = dbShopDAO.totRecCntAdminStatus(searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("adminMemberList")) {
			if(part.equals("")) {
				totRecCnt = memberDAO.totRecCntAdminMemberList(Integer.parseInt(searchString));
			}
			else {
				totRecCnt = memberDAO.totRecCntAdminMemberMidList(part);
			}
		}
		else if(section.equals("memAS")) {
			totRecCnt = asDAO.totMemASRecCnt(searchString);
		}
		else if(section.equals("memReview")) {
			totRecCnt = dbShopDAO.totMemReviewRecCnt(searchString);
		}
		else if(section.equals("memQna")) {
			totRecCnt = dbShopDAO.totMemQnARecCnt(searchString);
		}
		else if(section.equals("adMemQna")) {
			totRecCnt = dbShopDAO.totAdMemQnARecCnt();
		}
		
		int totPage = (totRecCnt%pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize)+1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage % blockSize)==0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
	
}
