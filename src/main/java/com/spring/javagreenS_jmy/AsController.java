package com.spring.javagreenS_jmy;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_jmy.common.ARIAUtil;
import com.spring.javagreenS_jmy.pagination.PageProcess;
import com.spring.javagreenS_jmy.pagination.PageVO;
import com.spring.javagreenS_jmy.service.AsService;
import com.spring.javagreenS_jmy.service.MemberService;
import com.spring.javagreenS_jmy.vo.AsReplyVO;
import com.spring.javagreenS_jmy.vo.AsVO;
import com.spring.javagreenS_jmy.vo.MemberVO;
import com.spring.javagreenS_jmy.vo.NoticeVO;

@Controller
@RequestMapping("/as")
public class AsController {

	@Autowired
	AsService asService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/asList", method=RequestMethod.GET)
	public String asListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize,
			Model model) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "as", "", "");
		List<AsVO> vos = asService.getAsList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		return"as/asList";
	}
	
	@RequestMapping(value="/asInput", method=RequestMethod.GET)
	public String asInputGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberInfor(mid);
		model.addAttribute("vo",vo);
		return"as/asInput";
	}
	
	@RequestMapping(value="/asInput", method=RequestMethod.POST)
	public String asInputPost(AsVO vo) {
		try {
			vo.setPwd(ARIAUtil.ariaEncrypt(vo.getPwd())); 
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		asService.setAsInputOk(vo);
		
		return"redirect:/msg/asInputOk"; 
	}
	
	@RequestMapping(value="/asPwdCheck", method=RequestMethod.GET)
	public String asPwdCheckGet(int idx, int pag, int pageSize, Model model) {
		model.addAttribute("idx",idx);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		return"as/asPwdCheck";
	}
	
	@RequestMapping(value="/asPwdCheck", method=RequestMethod.POST)
	public String asPwdCheckPost(int idx, int pag, int pageSize, String name, String pwd, Model model) {
		String decPwd="";
		
		AsVO vo = asService.getAsContent(idx);
	  
	  if(vo!=null && vo.getName().equals(name)) { 
	  	try {
				decPwd=ARIAUtil.ariaDecrypt(vo.getPwd());
			} catch (InvalidKeyException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
	  	if(pwd.equals(decPwd)){
			  model.addAttribute("vo",vo);
			  model.addAttribute("pag",pag);
			  model.addAttribute("pageSize",pageSize);
			  
				ArrayList<AsReplyVO> replyVos = asService.getAsReply(idx);
				model.addAttribute("replyVos", replyVos);
				
			  return"as/asContent";
	  	}
	  }
	  return"redirect:/msg/asPwdCheckNo";
	}
	
	@RequestMapping(value="/asContent", method=RequestMethod.GET)
	public String asContentGet(int idx, int pag, int pageSize, Model model) {
		AsVO vo = asService.getAsContent(idx);
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
	  model.addAttribute("pageSize",pageSize);
	  
		ArrayList<AsReplyVO> replyVos = asService.getAsReply(idx);
		model.addAttribute("replyVos", replyVos);
			
		return"as/asContent";
	}
	
	@RequestMapping(value="/asUpdate",method = RequestMethod.GET)
	public String asUpdateGet(int idx, int pag, int pageSize, Model model) {
	  AsVO vo = asService.getAsContent(idx);
	  if(vo.getContent().indexOf("src=\"/") != -1)  asService.imgCheckUpdate(vo.getContent());
	  
	  model.addAttribute("vo",vo); 
	  model.addAttribute("pag",pag);
	  model.addAttribute("pageSize",pageSize);
		 
		return "as/asUpdate";
	}
	
  @RequestMapping(value="/asUpdate",method = RequestMethod.POST) 
  public String asUpdatePost(AsVO vo, int pag, int pageSize, Model model) {
	  AsVO oriVo = asService.getAsContent(vo.getIdx()); 
	  
	  if(!oriVo.getContent().equals(vo.getContent())) { 
	  	if(oriVo.getContent().indexOf("src=\"/") != -1) asService.imgDelete(oriVo.getContent());
	  
		  vo.setContent(vo.getContent().replace("/data/ckeditor/as/", "/data/ckeditor/"));
		  
		  asService.imgCheck(vo.getContent());
	  
		  vo.setContent(vo.getContent().replace("/data/ckeditor/","/data/ckeditor/as/")); 
	  }
	  
	  asService.setAsUpdate(vo);
	  
	  model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
	  
	  return "redirect:/msg/asUpdateOk";
  }
  
	@RequestMapping(value="/asDeleteOk", method=RequestMethod.GET)
	public String asDeleteOkGet(int idx, int pag, int pageSize, Model model) {
		AsVO vo = asService.getAsContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) asService.imgDelete(vo.getContent());
		
		asService.setAsDeleteReply(idx);
		
		asService.setAsDelete(idx);
		
		model.addAttribute("flag", "?pag=&"+pag+"pageSize="+pageSize);
		return "redirect:/msg/setAsDelete";
	}
	
	@ResponseBody
	@RequestMapping(value="/asReplyInput", method=RequestMethod.POST)
	public String asReplyInputPost(AsReplyVO replyVo) {
		int levelOrder = 0;

	  String strLevelOrder = asService.maxLevelOrder(replyVo.getAsIdx());
	  
		if(strLevelOrder != null) levelOrder = Integer.parseInt(strLevelOrder)+1;
		
		replyVo.setLevelOrder(levelOrder);
		
		asService.setAsReplyInput(replyVo);
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="/asReplyDelete",method=RequestMethod.POST)
	public String asReplyDeletePost(int idx) {
		asService.setAsReplyDelete(idx);
		return"";
	}

	@ResponseBody
	@RequestMapping(value="/asReplyUpdate",method=RequestMethod.POST)
	public String asReplyUpdatePost(AsReplyVO replyVo) {
		asService.setAsReplyUpdate(replyVo);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/asReplyInput2", method=RequestMethod.POST)
	public String asReplyInput2Post(AsReplyVO replyVo) {
		asService.levelOrderPlusUpdate(replyVo);     
		replyVo.setLevel(replyVo.getLevel()+1); 
		replyVo.setLevelOrder(replyVo.getLevelOrder()+1); 
		
		asService.setAsReplyInput2(replyVo);
		return"";
	}
	
	@ResponseBody
	@RequestMapping(value="/swCheck", method=RequestMethod.POST)
	public String swCheckPost(int idx) {
		asService.swCheck(idx);
		return"";
	}
	
	
}
