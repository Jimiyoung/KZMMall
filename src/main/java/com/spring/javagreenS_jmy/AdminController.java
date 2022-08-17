package com.spring.javagreenS_jmy;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmy.pagination.PageProcess;
import com.spring.javagreenS_jmy.pagination.PageVO;
import com.spring.javagreenS_jmy.service.AdminService;
import com.spring.javagreenS_jmy.service.DbShopService;
import com.spring.javagreenS_jmy.service.MemberService;
import com.spring.javagreenS_jmy.vo.ChartVO;
import com.spring.javagreenS_jmy.vo.DbProductQnAVO;
import com.spring.javagreenS_jmy.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag="";
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	DbShopService dbShopService;
	
	@RequestMapping(value="/adMemberList", method = RequestMethod.GET)
	public String adMemberListGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="20", required=false) int pageSize,
			@RequestParam(name="level", defaultValue="99", required=false) int level,
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			Model model) {
	  PageVO pageVo = null;
	  if(mid.equals("")) {
	  	pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", "", level+"");
	  }
	  else {
	  	pageVo = pageProcess.totRecCnt(pag, pageSize, "adminMemberList", mid, "");	
	  }
	  
	  ArrayList<MemberVO> vos = new ArrayList<MemberVO>();
	  if(mid.equals("")) {	
	  	vos = memberService.getAdminMemberLevelList(pageVo.getStartIndexNo(), pageSize, level);
	  }
	  else {								
	  	vos = memberService.getAdminMemberMidList(pageVo.getStartIndexNo(), pageSize, mid);
	  }
		model.addAttribute("vos", vos);
		model.addAttribute("level", level);
		model.addAttribute("mid", mid);
		model.addAttribute("pageVo", pageVo);
		model.addAttribute("totRecCnt", pageVo.getTotRecCnt());
		
		return "admin/member/adMemberList";
	}
	
	@RequestMapping(value="/adMemberInfor",method=RequestMethod.GET)
	public String adMemberInforGet(int idx, Model model) {
		MemberVO vo = memberService.getMemInfor(idx);
		model.addAttribute("vo", vo);
		return "admin/member/adMemberInfor";
	}
	
	@ResponseBody
	@RequestMapping(value="/adMemberLevel", method = RequestMethod.POST)
	public String adMemberLevelPost(int idx, int level) {
		memberService.setAdminLevelUpdate(idx, level);
		return "";
	}
	
	@RequestMapping(value="/adMemQnA", method=RequestMethod.GET)
	public String adMemQnAGet(Model model,
		@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
		@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) { 

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "adMemQna", "", "");
		ArrayList<DbProductQnAVO> vos = dbShopService.getAdQnABoardList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("vos",vos);
		System.out.println("vos: " + vos);
		return "admin/member/adMemQnA";
	}
	
	@RequestMapping(value="/adChart", method = RequestMethod.GET)
	public String adChartGet() {
		return "admin/adChart";
	}
	
	@RequestMapping(value="/googleChartRecently", method=RequestMethod.GET)
	public String googleChartRecentlyGet(Model model) {
		List<ChartVO> vos = null;
		vos = adminService.getRecentlyVisitCount();
		String[] visitDates = new String[7];
		int[] visitDays = new int[7];	
		int[] visitCounts = new int[7];
		for(int i=0; i<7; i++) {
			visitDates[i] = vos.get(i).getVisitDate();
			visitDays[i] = Integer.parseInt(vos.get(i).getVisitDate().toString().substring(8));
			visitCounts[i] = vos.get(i).getVisitCount();
		}
		model.addAttribute("title", "최근 7일간 방문횟수");
		model.addAttribute("subTitle", "최근 7일동안 방문한 해당일자 방문자 총수를 표시합니다.");
		model.addAttribute("visitCount", "방문횟수");
		model.addAttribute("legend", "일일 방문 총횟수");
		model.addAttribute("visitDates", visitDates);
		model.addAttribute("visitDays", visitDays);
		model.addAttribute("visitCounts", visitCounts);
		
		return "admin/chart/chart";
	}
	
	@ResponseBody
	@RequestMapping(value="/adMemberReset", method=RequestMethod.POST)
	public String adMemberResetPost(int idx) {
		memberService.setMemberReset(idx);
		return "";
	}
	
}

