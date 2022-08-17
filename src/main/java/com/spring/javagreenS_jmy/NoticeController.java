package com.spring.javagreenS_jmy;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS_jmy.pagination.PageProcess;
import com.spring.javagreenS_jmy.pagination.PageVO;
import com.spring.javagreenS_jmy.service.NoticeService;
import com.spring.javagreenS_jmy.vo.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
	public String noticeListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			Model model) {
		PageVO pageVO =pageProcess.totRecCnt(pag, pageSize, "notice",	"", "");
		List<NoticeVO> vos = noticeService.getNoticeList(pageVO.getStartIndexNo(),pageSize);
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO", pageVO);
		return"notice/noticeList";
	}
	
	@RequestMapping(value="/noticeInput",method=RequestMethod.GET)
	public String noticeInputGet() {
		return "notice/noticeInput";
	}
	
	@RequestMapping(value="/noticeInput",method=RequestMethod.POST)
	public String noticeInputPost(HttpSession session, NoticeVO vo) {
		String mid = (String) session.getAttribute("sMid");
		
		noticeService.imgCheck(vo.getContent());
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/","/data/ckeditor/notice/"));
		noticeService.setNoticeInput(vo);
		return "redirect:/msg/noticeInputOk";
	}
	
	@RequestMapping(value="/noticeContent", method=RequestMethod.GET)
	public String noticeContentGet(int idx, int pag, int pageSize, Model model, HttpSession session) {
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) contentIdx = new ArrayList<String>();
		
		String imsiContentIdx = "notice"+idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			noticeService.setReadNum(idx);
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		ArrayList<NoticeVO> pnVOS = noticeService.getPreNext(idx);
		int minIdx = noticeService.getMinIdx();
		
		model.addAttribute("vo", vo);
		model.addAttribute("pnVOS", pnVOS);
		model.addAttribute("minIdx", minIdx);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "notice/noticeContent";
	}
	
	@RequestMapping(value="/noticeDeleteOk", method=RequestMethod.GET)
	public String noticeDeleteOkGet(int idx, int pag, int pageSize, Model model) {
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
		
		noticeService.setNoticeDelete(idx);
		
		model.addAttribute("flag", "?pag=&"+pag+"pageSize="+pageSize);
		return "redirect:/msg/setNoticeDelete";
	}
	
	@RequestMapping(value="/noticeUpdate", method=RequestMethod.GET)
	public String noticeUpdateGet(int idx, int pag, int pageSize, Model model) {
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		
		return"notice/noticeUpdate";
	}
	
	@RequestMapping(value="/noticeUpdate", method=RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo, int pag, int pageSize, Model model) {
		NoticeVO oriVo = noticeService.getNoticeContent(vo.getIdx());
		
		if(!oriVo.getContent().equals(vo.getContent()))	{
			if(oriVo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(oriVo.getContent());

			vo.setContent(vo.getContent().replace("/data/ckeditor/notice/", "/data/ckeditor/"));
			
			noticeService.imgCheck(vo.getContent());
			
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		}
		
		noticeService.setNoticeUpdate(vo);
		
		model.addAttribute("flag", "?pag="+pag+"&pageSize="+pageSize);
			
		return "redirect:/msg/noticeUpdateOk";
	}
	
	@RequestMapping(value="/noticeSearch", method=RequestMethod.GET)
	public String noticeSearchGet(
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="10", required = false) int pageSize,
			String search,
			String searchString,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", search, searchString);
		List<NoticeVO> vos = noticeService.getNoticeSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle;
		if(search.equals("title")) searchTitle="글제목";
		else if(search.equals("name")) searchTitle="작성자";
		else searchTitle="글내용";
		
		model.addAttribute("vos",vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("search",search);
		model.addAttribute("searchTitle",searchTitle);
		model.addAttribute("searchString",searchString);
		
		return "notice/noticeList";
	}
	
}
