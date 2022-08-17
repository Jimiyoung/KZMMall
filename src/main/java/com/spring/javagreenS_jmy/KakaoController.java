package com.spring.javagreenS_jmy;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javagreenS_jmy.service.KakaoService;

@Controller
@RequestMapping("/kakao")
public class KakaoController {
  
  @Autowired
  KakaoService kakaoService;
  
  @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
  public String kakaoLoginGet() {
    return "member/memLogin";
  }
  
  @ResponseBody
  @RequestMapping(value = "/kakaoMain", method = RequestMethod.GET)
  public ModelAndView kakaoMainGet(@RequestParam("code") String code, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    String accessToken = kakaoService.getAccessToken(code);
    
    HashMap<String, Object> userInfor = kakaoService.getUserInfor(accessToken);
    
    System.out.println("login infor : " + userInfor.toString());
    
    if(userInfor.get("email") != null) 
      session.setAttribute("sEmail", userInfor.get("email"));
	    session.setAttribute("sNickName", userInfor.get("nickname"));
	    session.setAttribute("accessToken", accessToken);
    mav.setViewName("/member/kakaoMain");
    return mav;
  }
  
  @RequestMapping(value = "/kakaoLogout", method = RequestMethod.GET)
  public ModelAndView kakaoLogoutGet(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    kakaoService.kakaoLogout((String) session.getAttribute("accessToken"));
    session.removeAttribute("accessToken");
    mav.setViewName("/home");
    
    return mav;
  }
}
