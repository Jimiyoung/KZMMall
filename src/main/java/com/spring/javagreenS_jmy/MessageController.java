package com.spring.javagreenS_jmy;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value="/msg/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model,
			@RequestParam(value="flag", defaultValue = "", required=false) String flag,
			@RequestParam(value="name", defaultValue = "", required=false) String name,
			@RequestParam(value="mid", defaultValue = "", required=false) String mid,
			@RequestParam(value="idx", defaultValue = "0", required=false) int idx) {
		
		if(msgFlag.equals("MemIdCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디입니다.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", name + "님 로그아웃 되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg", "축하합니다. 회원가입되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memInpuNo")) {
			model.addAttribute("msg", "회원가입에 실패했습니다.");
			model.addAttribute("url", "member/memJoin");
		}
		else if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", mid+"님 반갑습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memPwdChangeOK")) {
			model.addAttribute("msg", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memPwdChangeNO")) {
			model.addAttribute("msg", "비밀번호 변경에 실패했습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인하세요.");
			model.addAttribute("url", "member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg",  mid+"님 탈퇴 되었습니다.\\n같은 아이디로 1개월 동안 다시 가입할 수 없습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("setNoticeDelete")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "notice/noticeList"+flag);
		}
		else if(msgFlag.equals("noticeUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url", "notice/noticeList"+flag);
		}
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "notice/noticeList");
		}
		else if(msgFlag.equals("memIdFindNo")) {
			model.addAttribute("msg", "입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다..");
			model.addAttribute("url", "member/memIdFind");
		}
		else if(msgFlag.equals("memIdPwdSearchOk")) {
			model.addAttribute("msg", "임시 비밀번호가 이메일로 전송되었습니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("memIdPwdSearchNo")) {
			model.addAttribute("msg", "입력하신 정보를 확인해주세요.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("asInputOk")) {
			model.addAttribute("msg", "A/S문의글이 등록되었습니다.");
			model.addAttribute("url", "as/asList");
		}
		else if(msgFlag.equals("asInputNo")) {
			model.addAttribute("msg", "A/S등록에 실패하였습니다.");
			model.addAttribute("url", "as/asList");
		}
		else if(msgFlag.equals("asPwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "as/asList");
		}
		else if(msgFlag.equals("asUpdateOk")) {
			model.addAttribute("msg", "A/S문의글이 수정되었습니다.");
			model.addAttribute("url", "as/asList"+flag);
		}
		else if(msgFlag.equals("setAsDelete")) {
			model.addAttribute("msg", "A/S문의글이 삭제되었습니다.");
			model.addAttribute("url", "as/asList"+flag);
		}
		else if(msgFlag.equals("dbProductInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbShopList");
		}
		else if(msgFlag.equals("setDbShopDelete")) {
			model.addAttribute("msg", "상품이 삭제되었습니다.");
			model.addAttribute("url", "dbShop/dbShopList");
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 담겼습니다.\\n장바구니로 이동합니다.");
			model.addAttribute("url", "dbShop/dbCartList"+flag);
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 담겼습니다.\\n다시 상품리스트창으로 갑니다.");
			model.addAttribute("url", "dbShop/dbProductList"+flag);
		}
		else if(msgFlag.equals("dbOptionInputOk")) {
			model.addAttribute("msg", "옵션항목이 등록되었습니다.");
			model.addAttribute("url", "dbShop/dbOption");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 정상적으로 완료되었습니다.");
			model.addAttribute("url", "dbShop/paymentResultOk");
		}
		else if(msgFlag.equals("adminRecognizeNo")) {
			model.addAttribute("msg", "관리자 인증이 필요합니다.");
			model.addAttribute("url", "member/memLogin");
		}
		else if(msgFlag.equals("MemberNo")) {
			model.addAttribute("msg", "로그인후 이용하세요.");
			model.addAttribute("url", "member/memLogin");
		}
		return "include/message";
	}
	
}
