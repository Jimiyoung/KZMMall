package com.spring.javagreenS_jmy;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmy.pagination.PageProcess;
import com.spring.javagreenS_jmy.pagination.PageVO;
import com.spring.javagreenS_jmy.service.AsService;
import com.spring.javagreenS_jmy.service.DbShopService;
import com.spring.javagreenS_jmy.service.MemberService;
import com.spring.javagreenS_jmy.vo.AsVO;
import com.spring.javagreenS_jmy.vo.DbProductQnAVO;
import com.spring.javagreenS_jmy.vo.DbProductReviewVO;
import com.spring.javagreenS_jmy.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	DbShopService dbShopService;
	
	@Autowired
	AsService asService;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@RequestMapping(value="/memJoin", method=RequestMethod.GET)
	public String memJoinGet() {
		return "member/memJoin";
	}
	
	@RequestMapping(value="/memJoin", method= RequestMethod.POST)
	public String memJoinPost(MemberVO vo) {
		if(memberService.getMemIdCheck(vo.getMid()) != null) {
			return "redirect:/msg/MemIdCheckNo";
		}
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemInputOk(vo);	
		
		if(res==1) return "redirect:/msg/memInputOk"; 
		
		else return "redirect:/msg/memInputNo";
	}
	
	@ResponseBody
	@RequestMapping(value="/memIdCheck", method = RequestMethod.POST)
	public String memIdCheckPost(String mid) {
		String res = "0";
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null) res="1";
		return res;
	}
	
	@RequestMapping(value="/memLogin", method=RequestMethod.GET)
	public String memLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}	
		return "member/memLogin";
	}
	
	@RequestMapping(value="/memLogin", method=RequestMethod.POST)
	public String memLoginPost(Model model,
			HttpServletRequest request, HttpServletResponse response,
			String mid,
			String pwd,
			@RequestParam(name="idCheck", defaultValue="", required = false) String idCheck,
			HttpSession session) {
		
		MemberVO vo = memberService.getMemIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd,vo.getPwd()) && vo.getUserDel().equals("NO")) {
			String strLevel="";
			if(vo.getLevel()==0) strLevel="관리자";
			else if(vo.getLevel()==1) strLevel="일반회원";
			else if(vo.getLevel()==2) strLevel="GOLD";
			else if(vo.getLevel()==3) strLevel="VIP";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			if(idCheck.equals("on")) {
				Cookie cookie = new Cookie("cMid",mid);
				cookie.setMaxAge(60*60*24*7);   
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies=request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0); 
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			memberService.setMemberVisitProcess(vo);
			model.addAttribute("mid",mid);
			
			String visitDate = memberService.getTodayVisitDate();
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(!strToday.equals(visitDate)) {
				memberService.setTodayVisitCountInsert();
			}
			else {
				memberService.setTodayVisitCountUpdate(strToday);
			}
			
			int count = dbShopService.getCartCount(mid);
			session.setAttribute("sCount", count);
			return "redirect:/msg/memLoginOk";

		}
		else {
			return "redirect:/msg/memLoginNo";
		}
	}
	
	@RequestMapping(value="/memLogout", method=RequestMethod.GET)
	public String memLogoutGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		session.invalidate();
		
		model.addAttribute("mid",mid);
		return "redirect:/msg/memLogout";
	}
	
	@RequestMapping(value="/memPwdChange", method=RequestMethod.GET)
	public String memPwdChangeGet(HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		
		model.addAttribute("mid",mid);
		return "member/memPwdChange";
	}
	
	@RequestMapping(value="/memPwdChange", method=RequestMethod.POST)
	public String memPwdChangePost(String pwd, String newPwd, HttpSession session, Model model) {
		String mid = (String)session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {

			String changePwd = passwordEncoder.encode(newPwd);
			memberService.setMemPwdChange(changePwd, mid);	
			
			return "redirect:/msg/memPwdChangeOK";
		} 
		else {
			return "redirect:/msg/memPwdChangeNO";
		}
	}
	
	@RequestMapping(value="/memPwdCheck", method=RequestMethod.GET)
	public String memPwdCheckGet() {
		return "member/memPwdCheck";
	}
	
	@RequestMapping(value="/memPwdCheck", method=RequestMethod.POST)
	public String memPwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo",vo);
			return "member/memUpdate";
		}
		else {
			return "redirect:/msg/memPwdCheckNo";
		}
	}
	
	@RequestMapping(value="/memUpdateOk", method=RequestMethod.POST)
	public String memUpdatePost(MemberVO vo) {
		memberService.setMemUpdateOk(vo);
		return "redirect:/msg/memUpdateOk";
	}
	
	@RequestMapping(value="/memDeleteOk", method=RequestMethod.GET)
	public String memDeleteOkGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		
		memberService.setMemDeleteOk(mid);
		
		session.invalidate();
		model.addAttribute("mid",mid);
		
		return"redirect:/msg/memDeleteOk";
	}
	
	@RequestMapping(value="/memIdFind",method=RequestMethod.GET)
	public String memIdFindGet() {
		return "member/memIdFind";
	}
	
	@RequestMapping(value="/memIdEmailFindOk",method=RequestMethod.POST)
	public String memIdEmailFindPost(String name, String email, Model model,HttpSession session) {
		MemberVO vo = memberService.getMemEmailFind(name,email);
		if(vo != null) {
			model.addAttribute("vo",vo);
			session.setAttribute("sMid", vo.getMid());
			return "member/memIdFindOk";
		}
		else {
			return "redirect:/msg/memIdFindNo";
		}
	}
	
	@RequestMapping(value="/memIdTelFindOk",method=RequestMethod.POST)
	public String memIdTelFindPost(String nameT, String tel, Model model,HttpSession session) {
		String name = nameT;
		MemberVO vo = memberService.getMemTelFind(name,tel);
		if(vo != null) {
			model.addAttribute("vo",vo);
			session.setAttribute("sMid", vo.getMid());
			return "member/memIdFindOk";
		}
		else {
			return "redirect:/msg/memIdFindNo";
		}
	}
	
	@RequestMapping(value="/memPwdFind",method=RequestMethod.GET)
	public String memPwdFindGet(HttpSession session) {
		return "member/memPwdFind";
	}
	
	@RequestMapping(value="/memPwdSearchOk",method=RequestMethod.GET)
	public String memPwdSearchOkGet(String mid, String name, String toMail) {
		MemberVO vo = memberService.getMemPwdFind(mid,name,toMail);
		if(vo !=null) {
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			memberService.setPwdChange(mid,passwordEncoder.encode(pwd));
			String content = pwd;
			String res = mailSend(toMail,content);
			if(res.equals("1")) return "redirect:/msg/memIdPwdSearchOk";
			else return "redirect:/msg/memIdPwdSearchNo";
		}
		else {
			return "redirect:/msg/memIdPwdSearchNo";
		}
	}

	public String mailSend(String toMail, String content) {
		try {
			String title="임시비밀번호가 발급되었습니다.";
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			content = "<hr/>신규 비밀번호는 : <font color='red'><b>" + content+"</b></font>";
			content += "<br><hr>아래 주소로 로그인해서 비밀번호를 변경하세요.<hr><br>";
			content += "<p><img src=\"cid:main.jpg\" width='500px'></p><hr>";
			content += "<p>방문하기 : <a href='http://192.168.50.115:9090/javagreenS_jmy'>kzm사이트</a></p>";
			content += "<hr>";
			messageHelper.setText(content,true);
			FileSystemResource file = new FileSystemResource("D:\\JavaGreen\\springframework\\project\\javagreenS_jmy\\javagreenS_jmy\\src\\main\\webapp\\resources\\images\\main1.jpg");
			messageHelper.addInline("main1.jpg", file);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return "1";
	}
	
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String myPageGet() {
		
		return "member/myPage";
	}

	@RequestMapping(value="/memBoard", method=RequestMethod.GET)
	public String memBoardGet(HttpSession session, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) { 
		
		String mid = (String) session.getAttribute("sMid");
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "memAS", "", mid);
		ArrayList<AsVO> AsVos = asService.getAsBoardList(mid,pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("AsVos",AsVos);

		PageVO pageRVO = pageProcess.totRecCnt(pag, pageSize, "memReview", "", mid);
		ArrayList<DbProductReviewVO> ReviewVos = dbShopService.getReviewBoardList(mid,pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageRVO",pageRVO);
		model.addAttribute("ReviewVos",ReviewVos);
		
		PageVO pageQVO = pageProcess.totRecCnt(pag, pageSize, "memQna", "", mid);
		ArrayList<DbProductQnAVO> QnAVos = dbShopService.getQnABoardList(mid,pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("pageQVO",pageQVO);
		model.addAttribute("QnAVos",QnAVos);
		return "member/memBoard";
	}
	
	@RequestMapping(value="/qrCode", method = RequestMethod.GET)
	public String qrCodeGet() {
		return "qrCode/qrCode";
	}
	
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value="/qrCode", method = RequestMethod.POST)
	public String qrCodePost(HttpServletRequest request, HttpSession session, String moveUrl, int idx) {
		String uploadPath = request.getRealPath("/resources/data/qrCode/");
		String qrCode = memberService.setQrCode(uploadPath, moveUrl, idx);	
		
    return qrCode;
	}
	
	@RequestMapping(value = "/memKakaoLogin", method = RequestMethod.GET)
	public String memKakaoLoginGet(
			Model model,
			HttpSession session) {
		
		String email = (String) session.getAttribute("sEmail");
		
		MemberVO vo = memberService.getMemEmailCheck(email); 
		
		if(vo != null && vo.getUserDel().equals("NO")) {
			String strLevel = "";
			if(vo.getLevel()==0) strLevel="관리자";
			else if(vo.getLevel()==1) strLevel="일반회원";
			else if(vo.getLevel()==2) strLevel="GOLD";
			else if(vo.getLevel()==3) strLevel="VIP";
			
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			memberService.setMemberVisitProcess(vo);
			
			String visitDate = memberService.getTodayVisitDate();
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strToday = sdf.format(today);
			
			if(!strToday.equals(visitDate)) {		
				memberService.setTodayVisitCountInsert();
			}
			else {		
				memberService.setTodayVisitCountUpdate(strToday);
			}
			
			model.addAttribute("mid", vo.getMid());
			
			int count = dbShopService.getCartCount(vo.getMid());
			session.setAttribute("sCount", count);
			return "redirect:/msg/memLoginOk";
		}
		else if(vo != null && !vo.getUserDel().equals("NO")) {  
			return "redirect:/msg/memLoginNo";
		}
		
		else {
			String mid = email.substring(0,email.indexOf("@"));
			String name = (String) session.getAttribute("sNickName");
			String pwd = (passwordEncoder.encode("0000"));
			
			memberService.setKakaoMemberInputOk(mid,pwd,name,"000-0000-0000",email," / / / /");
			
			model.addAttribute("email", email);
			return "redirect:/member/memKakaoLogin";
		}
	}
}
