package com.spring.javagreenS_jmy;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_jmy.pagination.PageProcess;
import com.spring.javagreenS_jmy.pagination.PageVO;
import com.spring.javagreenS_jmy.service.DbShopService;
import com.spring.javagreenS_jmy.service.MemberService;
import com.spring.javagreenS_jmy.vo.DbBaesongVO;
import com.spring.javagreenS_jmy.vo.DbCartListVO;
import com.spring.javagreenS_jmy.vo.DbOptionVO;
import com.spring.javagreenS_jmy.vo.DbOrderVO;
import com.spring.javagreenS_jmy.vo.DbProductQnAVO;
import com.spring.javagreenS_jmy.vo.DbProductReviewVO;
import com.spring.javagreenS_jmy.vo.DbProductVO;
import com.spring.javagreenS_jmy.vo.MemberVO;
import com.spring.javagreenS_jmy.vo.PayMentVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {
	String msgFlag = "";

	@Autowired
	DbShopService dbShopService;

	@Autowired
	MemberService memberService;

	@Autowired
	PageProcess pageProcess;

	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String dbCategoryGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		List<DbProductVO> subVos = dbShopService.getCategorySub();

		model.addAttribute("mainVos", mainVos);
		model.addAttribute("subVos", subVos);

		return "admin/dbShop/dbCategory";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST)
	public String categoryMainInputPost(DbProductVO vo) {
		DbProductVO imsiVo = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());

		if (imsiVo != null)
			return "0";
		dbShopService.setCategoryMainInput(vo); 
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/delCategoryMain", method = RequestMethod.POST)
	public String delCategoryMainPost(DbProductVO vo) {
		List<DbProductVO> vos = dbShopService.getCategorySubOne(vo);
		if (vos.size() != 0)
			return "0";
		dbShopService.delCategoryMain(vo.getCategoryMainCode());
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/categorySubInput", method = RequestMethod.POST)
	public String categorySubInputPost(DbProductVO vo) {
		List<DbProductVO> vos = dbShopService.getCategorySubOne(vo);
		if (vos.size() != 0)
			return "0";
		dbShopService.setCategorySubInput(vo);
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/delCategorySub", method = RequestMethod.POST)
	public String delCategorySubPost(DbProductVO vo) {
		List<DbProductVO> vos = dbShopService.getDbProductOne(vo.getCategorySubCode());
		if (vos.size() != 0)
			return "0";
		dbShopService.delCategorySub(vo.getCategorySubCode());
		return "1";
	}

	@RequestMapping(value = "/dbProduct", method = RequestMethod.GET)
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}

	@ResponseBody
	@RequestMapping(value = "/categorySubName", method = RequestMethod.POST)
	public List<DbProductVO> categorySubNamePost(String categoryMainCode) {
		return dbShopService.getCategorySubName(categoryMainCode);
	}

	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String originalFilename = upload.getOriginalFilename();

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;

		byte[] bytes = upload.getBytes();

		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes); 

		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/dbShop/" + originalFilename;
		out.println("{\"originalFilename\":\"" + originalFilename + "\",\"uploaded\":1,\"url\":\"" + fileUrl
				+ "\"}"); 

		out.flush();
		outStr.close();
	}

	@RequestMapping(value = "/dbProduct", method = RequestMethod.POST)
	public String dbProductPost(MultipartFile file, DbProductVO vo) {
		dbShopService.imgCheckProductInput(file, vo);
		msgFlag = "dbProductInputOk";
		return "redirect:/msg/" + msgFlag;
	}

	@RequestMapping(value = "/dbShopList", method = RequestMethod.GET)
	public String dbShopListGet(@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String categorySubCode, Model model) {
		PageVO pageVO = null; 
		List<DbProductVO> productVos = null;
		List<DbProductVO> subTitleVos = dbShopService.getSubTitle();
		if(categorySubCode.equals("전체")) {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "dbShop", "", "");
			productVos = dbShopService.getDbShopList(categorySubCode, pageVO.getStartIndexNo(), pageSize);
		}
		else {
			pageVO = pageProcess.totRecCnt(pag, pageSize, "dbShop","categorySubCode", categorySubCode);
			productVos = dbShopService.getDbShopList(categorySubCode, pageVO.getStartIndexNo(), pageSize);
		}
		
		model.addAttribute("subTitleVos", subTitleVos);
		model.addAttribute("part", categorySubCode);
		model.addAttribute("productVos", productVos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("categorySubCode", categorySubCode);
		
		return "admin/dbShop/dbShopList";
	}

	@RequestMapping(value = "/dbOption", method = RequestMethod.GET)
	public String dbOptionGet(Model model) {
		String[] productNames = dbShopService.getProductName();
		model.addAttribute("productNames", productNames);

		return "admin/dbShop/dbOption";
	}

	@ResponseBody
	@RequestMapping(value = "/getProductInfor", method = RequestMethod.POST)
	public List<DbProductVO> getProductInforPost(String productName) {
		return dbShopService.getProductInfor(productName);
	}

	@ResponseBody
	@RequestMapping(value = "/getOptionList", method = RequestMethod.POST)
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}

	@RequestMapping(value = "/dbOption", method = RequestMethod.POST)
	public String dbOptionPost(DbOptionVO vo, String[] optionName, int[] optionPrice) {
		for (int i = 0; i < optionName.length; i++) {
			int optionCnt = dbShopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if (optionCnt != 0)
				continue;

			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);

			vo.setOptionPrice(optionPrice[i]);
			dbShopService.setDbOptionInput(vo);
		}

		msgFlag = "dbOptionInputOk";
		return "redirect:/msg/" + msgFlag;
	}

	@ResponseBody
	@RequestMapping(value = "/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		dbShopService.setOptionDelete(idx);
		return "";
	}

	@RequestMapping(value = "/dbShopContent", method = RequestMethod.GET)
	public String dbShopContentGet(int idx, int pag, int pageSize, Model model) {
		DbProductVO productVo = dbShopService.getDbShopProduct(idx);
		List<DbOptionVO> optionVos = dbShopService.getDbShopOption(idx); 
		model.addAttribute("productVo", productVo);
		model.addAttribute("optionVos", optionVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/dbShop/dbShopContent";
	}

	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/dbShopDeleteOk", method = RequestMethod.POST)
	public String dbShopDeleteOkPost(HttpServletRequest request, int idx) {
		
		DbProductVO vo = dbShopService.getDbShopContent(idx);
		if (vo.getContent().indexOf("src=\"/") != -1) dbShopService.imgDelete(vo.getContent());	
    
		String uploadPath = request.getRealPath("/resources/data/dbShop/product/");
		String realPathFile = uploadPath + vo.getFSName();
		new File(realPathFile).delete();
		

		dbShopService.setDbShopOptionDelete(vo.getIdx());
		dbShopService.setDbShopDelete(idx);

		return "";
	}

	@RequestMapping(value = "/dbProductUpdate", method = RequestMethod.GET)
	public String dbProductUpdateGet(int idx, int pag, int pageSize, Model model) {
		DbProductVO vo = dbShopService.getDbShopContent(idx);
		if (vo.getContent().indexOf("src=\"/") != -1)
			dbShopService.imgCheckUpdate(vo.getContent());

		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);

		return "admin/dbShop/dbProductUpdate";
	}

	@RequestMapping(value = "/dbProductList", method = RequestMethod.GET)
	public String dbProductListGet(
			@RequestParam(name = "categoryMainCode", defaultValue = "", required = false) String categoryMainCode,
			@RequestParam(name = "categorySubCode", defaultValue = "", required = false) String categorySubCode,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "16", required = false) int pageSize, 
			Model model) {
		
		  PageVO pageVO = null; 
		  List<DbProductVO> productVos = null;
		  if(!categoryMainCode.equals("")) {	
		  	pageVO = pageProcess.totRecCnt(pag, pageSize, "dbShop", "categoryMainCode", categoryMainCode);
		  	productVos = dbShopService.getDbShopMainCodeList(categoryMainCode, pageVO.getStartIndexNo(), pageSize);
		  }
		  else {	
				pageVO = pageProcess.totRecCnt(pag, pageSize, "dbShop", "categorySubCode", categorySubCode);
				productVos = dbShopService.getDbShopList(categorySubCode, pageVO.getStartIndexNo(), pageSize);
		  }
		  model.addAttribute("categorySubCode", categorySubCode);
		  model.addAttribute("categoryMainCode", categoryMainCode);
		  model.addAttribute("pageVO", pageVO);
		  model.addAttribute("productVos", productVos);
		return "dbShop/dbProductList";
	}

	@RequestMapping(value = "/dbProductContent", method = RequestMethod.GET)
	public String dbProductContentGet(int idx, Model model) {
		DbProductVO productVo = dbShopService.getDbShopProduct(idx); 
		List<DbOptionVO> optionVos = dbShopService.getDbShopOption(idx); 
		model.addAttribute("productVo", productVo);
		model.addAttribute("optionVos", optionVos);

		ArrayList<DbProductReviewVO> reviewVos = dbShopService.getProductReview(idx);
		model.addAttribute("reviewVos", reviewVos);
		
		ArrayList<DbProductQnAVO> qnaVos = dbShopService.getProductQnA(idx);
		model.addAttribute("qnaVos",qnaVos);
		
		String qrCode = dbShopService.getQrCode(idx);
		model.addAttribute("qrCode", qrCode);
		
		return "dbShop/dbProductContent";
	}

	@RequestMapping(value = "/dbProductContent", method = RequestMethod.POST)
	public String dbProductContentPost(DbCartListVO vo, HttpSession session, String flag, Model model,
			@RequestParam(name = "categoryMainCode", defaultValue = "", required = false) String categoryMainCode,
			@RequestParam(name = "categorySubCode", defaultValue = "", required = false) String categorySubCode,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "16", required = false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		DbCartListVO resVo = dbShopService.getDbCartListProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
		if (resVo != null) { 
			String[] voOptionNums = vo.getOptionNum().split(","); 
			String[] resOptionNums = resVo.getOptionNum().split(","); 
			int[] nums = new int[99]; 
			String strNums = ""; 
			for (int i = 0; i < voOptionNums.length; i++) {
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
				strNums += nums[i]; 
				if (i < nums.length - 1)
					strNums += ","; 
			}
			vo.setOptionNum(strNums);
			dbShopService.dbShopCartUpdate(vo);
		} else { 
			dbShopService.dbShopCartInput(vo);
		}
		
		  int count = (int) session.getAttribute("sCount") + 1;
		  session.setAttribute("sCount", count);
		 
		  model.addAttribute("flag", "?categorySubCode="+categorySubCode+"&categoryMainCode="+categoryMainCode+"&pag="+pag+"&pageSize="+pageSize);
		  
		if (flag.equals("order")) {
			return "redirect:/msg/cartOrderOk";
		} else {
			return "redirect:/msg/cartInputOk";
		}

	}

	@RequestMapping(value = "/dbCartList", method = RequestMethod.GET)
	public String dbCartListGet(HttpSession session, DbCartListVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<DbCartListVO> vos = dbShopService.getDbCartList(mid);


		model.addAttribute("cartListVos", vos);
		return "dbShop/dbCartList";
	}

	@RequestMapping(value = "/dbCartList", method = RequestMethod.POST)
	public String dbCartListPost(HttpServletRequest request, Model model, HttpSession session) {
		String mid = session.getAttribute("sMid").toString();
		int baesong = Integer.parseInt(request.getParameter("baesong"));

		DbOrderVO maxIdx = dbShopService.getOrderMaxIdx();
		int idx = 1;
		if (maxIdx != null) idx = maxIdx.getMaxIdx() + 1;

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;

		String[] idxChecked = request.getParameterValues("idxChecked");

		DbCartListVO cartVo = new DbCartListVO();
		List<DbOrderVO> orderVos = new ArrayList<DbOrderVO>();

		for (String strIdx : idxChecked) { 
			cartVo = dbShopService.getCartIdx(Integer.parseInt(strIdx)); 
			DbOrderVO orderVo = new DbOrderVO();
			orderVo.setProductIdx(cartVo.getProductIdx());
			orderVo.setProductName(cartVo.getProductName());
			orderVo.setMainPrice(cartVo.getMainPrice());
			orderVo.setThumbImg(cartVo.getThumbImg());
			orderVo.setOptionName(cartVo.getOptionName());
			orderVo.setOptionPrice(cartVo.getOptionPrice());
			orderVo.setOptionNum(cartVo.getOptionNum());
			orderVo.setTotalPrice(cartVo.getTotalPrice());
			orderVo.setCartIdx(cartVo.getIdx());
			orderVo.setBaesong(baesong);

			orderVo.setOrderIdx(orderIdx); 
			orderVo.setMid(mid);

			orderVos.add(orderVo);
		}
		session.setAttribute("sOrderVos", orderVos); 
		model.addAttribute("cartVo", cartVo);
		
		MemberVO memberVo = memberService.getMemIdCheck(mid);
		model.addAttribute("memberVo", memberVo);

		return "dbShop/dbOrder"; 
	}

	@ResponseBody
	@RequestMapping(value = "/dbCartDelete", method = RequestMethod.POST)
	public String dbCartDeleteGet(int idx) {
		dbShopService.dbCartDelete(idx);
		return "";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String paymentPost(DbOrderVO orderVo, PayMentVO payMentVo, DbBaesongVO baesongVo, HttpSession session,	Model model) {
		
		model.addAttribute("payMentVo", payMentVo);

		session.setAttribute("sPayMentVo", payMentVo);
		session.setAttribute("sBaesongVo", baesongVo);

		return "dbShop/paymentOk";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, PayMentVO receivePayMentVo, Model model) {
		List<DbOrderVO> orderVos = (List<DbOrderVO>) session.getAttribute("sOrderVos");
		PayMentVO payMentVo = (PayMentVO) session.getAttribute("sPayMentVo");
		DbBaesongVO baesongVo = (DbBaesongVO) session.getAttribute("sBaesongVo");
		
		for(DbOrderVO vo : orderVos) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); 
			vo.setOrderIdx(vo.getOrderIdx());        				
			vo.setMid(vo.getMid());							
			
			dbShopService.setDbOrder(vo);                 	
			dbShopService.dbCartDeleteAll(vo.getCartIdx()); 
		}
		baesongVo.setOIdx(orderVos.get(0).getIdx());
		baesongVo.setOrderIdx(orderVos.get(0).getOrderIdx());
		baesongVo.setAddress(payMentVo.getBuyer_addr());
		baesongVo.setTel(payMentVo.getBuyer_tel());
		
		dbShopService.setDbBaesong(baesongVo);  
		dbShopService.setMemberPointPlus((int)(baesongVo.getOrderTotalPrice() * 0.01), orderVos.get(0).getMid());	
		
		payMentVo.setImp_uid(receivePayMentVo.getImp_uid());
		payMentVo.setMerchant_uid(receivePayMentVo.getMerchant_uid());
		payMentVo.setPaid_amount(receivePayMentVo.getPaid_amount());
		payMentVo.setApply_num(receivePayMentVo.getApply_num());
		session.setAttribute("sPayMentVo", payMentVo);
		session.setAttribute("orderTotalPrice", baesongVo.getOrderTotalPrice());
		
		session.setAttribute("sCount", 0);
		return "redirect:/msg/paymentResultOk";
	}
	
	@RequestMapping(value = "/paymentResultOk",method = RequestMethod.GET)
	public String paymentResultOkGet() {
		return "dbShop/paymentResult";
	}
	
	@RequestMapping(value = "/dbOrderBaesong", method = RequestMethod.GET)
	public String dbOrderBaesongGet(String orderIdx, Model model) {
		List<DbBaesongVO> vos = dbShopService.getOrderBaesong(orderIdx); 
		model.addAttribute("vo", vos.get(0)); 

		return "dbShop/dbOrderBaesong";
	}

	@RequestMapping(value = "/dbMyOrder", method = RequestMethod.GET)
	public String dbMyOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) { 
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");

		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "dbMyOrder", "", mid);
		List<DbOrderVO> vos = dbShopService.getMyOrderList(pageVo.getStartIndexNo(), pageSize, mid);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);

		return "dbShop/dbMyOrder";
	}

 @RequestMapping(value="/orderStatus", method=RequestMethod.GET)
 public String orderStatusGet(HttpSession session,
     @RequestParam(name="pag", defaultValue="1", required=false) int pag,
     @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
     @RequestParam(name="orderStatus", defaultValue="전체", required=false) String orderStatus,
     Model model) {
   String mid = (String) session.getAttribute("sMid");

   PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "dbShopMyOrderStatus", mid, orderStatus);
   
   List<DbBaesongVO> vos = dbShopService.getOrderStatus(mid, orderStatus, pageVo.getStartIndexNo(), pageSize);
   
   model.addAttribute("orderStatus", orderStatus);
   model.addAttribute("vos", vos);
   model.addAttribute("pageVo", pageVo);

   return "dbShop/dbMyOrder";
 }
 
	@RequestMapping(value = "/orderCondition", method = RequestMethod.GET)
	public String orderConditionGet(HttpSession session, int conditionDate, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) {
		String mid = (String) session.getAttribute("sMid");
		String strConditionDate = conditionDate + "";
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "dbShopMyOrderCondition", mid, strConditionDate);

		List<DbOrderVO> vos = dbShopService.getMyOrderConditionList(mid, conditionDate, pageVo.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("conditionDate", conditionDate);
		
		Calendar startDateJumun = Calendar.getInstance();
		Calendar endDateJumun = Calendar.getInstance();
		
		startDateJumun.setTime(new Date());
		endDateJumun.setTime(new Date()); 
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String startJumun = "";
		String endJumun = "";
		switch (conditionDate) {
			case 1:
				startJumun = sdf.format(startDateJumun.getTime());
				endJumun = sdf.format(endDateJumun.getTime());
				break;
			case 7:
				startDateJumun.add(Calendar.DATE, -7);
				break;
			case 30:
				startDateJumun.add(Calendar.MONTH, -1);
				break;
			case 90:
				startDateJumun.add(Calendar.MONTH, -3);
				break;
			case 99999:
				startDateJumun.set(2022, 00, 01);
				break;
			default:
				startJumun = null;
				endJumun = null;
		}
		if (conditionDate != 1 && endJumun != null) {
			startJumun = sdf.format(startDateJumun.getTime());
			endJumun = sdf.format(endDateJumun.getTime());
		}

		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);

		return "dbShop/dbMyOrder";
	}

	@RequestMapping(value = "/myOrderStatus", method = RequestMethod.GET)
	public String myOrderStatusGet(HttpServletRequest request, HttpSession session, String startJumun, String endJumun,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name = "conditionOrderStatus", defaultValue = "전체", required = false) String conditionOrderStatus,
			Model model) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");

		if (level == 0) mid = "전체";
		String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString); 
		
		List<DbBaesongVO> vos = dbShopService.getMyOrderStatus(pageVo.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVo", pageVo);

		return "dbShop/dbMyOrder";
	}

	@RequestMapping(value = "/adminOrderStatus")
	public String dbOrderProcessGet(Model model,
			@RequestParam(name = "startJumun", defaultValue = "", required = false) String startJumun,
			@RequestParam(name = "endJumun", defaultValue = "", required = false) String endJumun,
			@RequestParam(name = "orderStatus", defaultValue = "전체", required = false) String orderStatus,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		List<DbBaesongVO> vos = null;
		PageVO pageVo = null;
		String strNow = "";
		if (startJumun.equals("")) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			strNow = sdf.format(now);

			startJumun = strNow;
			endJumun = strNow;
		}

		String strOrderStatus = startJumun + "@" + endJumun + "@" + orderStatus;
		pageVo = pageProcess.totRecCnt(pag, pageSize, "adminDbOrderProcess", "", strOrderStatus);

		vos = dbShopService.getAdminOrderStatus(pageVo.getStartIndexNo(), pageSize, startJumun, endJumun, orderStatus);

		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("orderStatus", orderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVo", pageVo);

		return "admin/dbShop/dbOrderProcess";
	}

	@RequestMapping(value="/productSearch",method=RequestMethod.GET) 
	public String productSearch(
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="16", required = false) int pageSize,
			String searchString, Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dbShop", "",searchString);
		List<DbProductVO> vos = dbShopService.getProductSearch(pageVO.getStartIndexNo(), pageSize,searchString);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos", vos);
		model.addAttribute("searchString",searchString);
		
	return"dbShop/productSearch"; 
	}
	
	@ResponseBody
	@RequestMapping(value="/goodsStatus", method=RequestMethod.POST)
	public String goodsStatusGet(String orderIdx, String orderStatus) {
		dbShopService.setOrderStatusUpdate(orderIdx, orderStatus);
		return "";
	}  
	
	@ResponseBody
	@RequestMapping(value="/dbShopQnAInput", method=RequestMethod.POST)
	public String dbShopQnAPost(DbProductQnAVO dbProductQnAVO) {
		int levelOrder = 0;
		
		String strLevelOrder = dbShopService.maxLevelOrder(dbProductQnAVO.getProductIdx());
		if(strLevelOrder != null) levelOrder = Integer.parseInt(strLevelOrder)+1;
		
		dbProductQnAVO.setLevelOrder(levelOrder);
		
		dbShopService.setQnAInput(dbProductQnAVO);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/dbShopQnADelete", method=RequestMethod.POST)
	public String dbShopQnADeletePost(int idx) {
		dbShopService.setdbShopQnADelete(idx);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaInput2", method=RequestMethod.POST)
	public String qnaInput2Post(DbProductQnAVO dbProductQnAVO) {
		dbShopService.levelOrderPlusUpdate(dbProductQnAVO);     
		
		dbProductQnAVO.setLevel(dbProductQnAVO.getLevel()+1); 
		dbProductQnAVO.setLevelOrder(dbProductQnAVO.getLevelOrder()+1);
		
		dbShopService.setQnAInput2(dbProductQnAVO);
		return "";
	}
	
	@RequestMapping(value="/dbReview", method=RequestMethod.GET)
	public String dbReviewGet(DbProductVO vo, int idx, Model model,
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="10", required = false) int pageSize) {
		vo = dbShopService.getDbShopContent(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		return "dbShop/dbReview";
	}
	
	@ResponseBody
	@RequestMapping(value="/dbShopReviewInput",method=RequestMethod.POST)
	public String dbShopReviewInputPost(DbProductReviewVO vo) {
		dbShopService.setReviewInput(vo);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/dbShopReviewDelete", method=RequestMethod.POST)
	public String dbShopReviewDeletePost(int idx) {
		dbShopService.setdbShopReviewDelete(idx);
		return "";
	}
}
