package com.bit.yanado.controller;

import java.io.IOException;



import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dto.EmailDTO;
import com.bit.yanado.model.dto.Poster;
import com.bit.yanado.model.dto.Teaser;
import com.bit.yanado.model.dto.VideoInfo;
import com.bit.yanado.model.dto.WatchingReco;
import com.bit.yanado.model.dto.AdminInfo;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.service.AdminService;
import com.bit.yanado.model.service.EmailService;
import com.bit.yanado.model.service.MemberService;
import com.bit.yanado.model.service.VideoService;
import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@Controller
@RequestMapping(value="/")
public class MainController {

	@Autowired
	public MemberService memberService;
	
	@Autowired
    private EmailService mailSender;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private VideoService videoService;
	
	@RequestMapping(value="/")
	public String main(HttpSession session,Model model) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		AdminInfo admin = (AdminInfo) session.getAttribute("admin");
		
		if(member != null || admin != null ) {
			// ???????????? ???????????? ???????????? ?????? ???????????? ???, ???????????? vidSeason, posters ?????? ????????????.
			List<Poster> posters = videoService.getAllPost();
			List<String> videoSeason = new ArrayList<String>();
			List<VideoInfo> videoInfos = new ArrayList<VideoInfo>();
			posters = (posters.size()<=15)?posters:posters.subList(1, 15);
			String tempSeason;
			for(int i=0;i<posters.size();i++) {
				tempSeason = posters.get(i).getTitleSeq()+String.format("%02d", posters.get(i).getSeason());
//				videoSeason.add(tempSeason); 
				videoInfos.add(videoService.getVideoByTitleSeason(tempSeason));
			}
			model.addAttribute("vidSeason",videoSeason);					// ????????? ?????? ??????.
			model.addAttribute("posters", posters);							// ????????? ??????.
			model.addAttribute("videoInfo", videoInfos);					// ?????? ??????.
			// ????????? ???????????? ????????? ???????????? ???.
			List<Teaser> teaserVids = videoService.getTeaserVid();		// ????????? ?????? ????????? ????????????.
			Teaser teaserVid = teaserVids.get(0);						// ?????? ????????? ???????????? ????????????. 
			model.addAttribute("teaserVid", teaserVid);					// ????????? ???????????? ?????? ?????????. 
			
			// ???????????? ?????? ?????? ?????????.
			if(member != null) {
				List<WatchingReco> recoding = videoService.getAllRecord(member.getId());	//?????? ???????????? ??????????????? ????????????.
				List<Poster> posterReco = new ArrayList<Poster>();		// ??????????????? ?????? ???????????? ????????? ???????????? ?????????.
				List<VideoInfo> videoInfoReco= new ArrayList<VideoInfo>();
				for (int i=0;i<recoding.size();i++){				// ???????????? ?????? ????????? ??????????????? ????????????.
					int uniqueNo = recoding.get(i).getUniqueNo();	// ??????????????? ??????????????? ????????????.
					int titleSeq = uniqueNo/10000;					// ???????????? ?????? 5??????(????????????)??? ????????????.
					posterReco.add(videoService.getPostByTitleSeason(titleSeq, (uniqueNo%10000)/100));	// ????????? ???????????? ???????????? ?????????.
					videoInfoReco.add(videoService.getVideo(uniqueNo));
				}
				model.addAttribute("videoInfoReco", videoInfoReco);
				model.addAttribute("posterReco",posterReco);				// ????????? ???????????? ????????????.
				model.addAttribute("allRecord",recoding);			// ????????? ??????????????? ????????????.
			}
			
			
			/*
			  ?????? ????????? ???????????? ????????? ??????.
			 */
			if(admin != null) {
				model.addAttribute("isLogin","A");
			}
			if(member != null) {
				model.addAttribute("isLogin","Y");
				return (member.getIsPay().equals("Y"))?(member.getIsOut()==1?"redirect:login":"main"):"redirect:pay";
			}
			
		}else {
			model.addAttribute("isLogin","N");
		}
		return "main";
	}
	
	@ResponseBody
	@RequestMapping(value="getEpisode", method=RequestMethod.POST)
	public List<String> getEpisode(Model model, String titleSeason) {
		return videoService.getEpisode(titleSeason);
	}
	
	
	// ?????????  --------------------------------------------------------------------
	@RequestMapping(value="login")
	public String login() {
		return "login";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="CheckLogin", method=RequestMethod.POST)
	public String CheckLogin(MemInfo newMember, Model model, HttpSession session) {
		MemInfo member = (MemInfo) memberService.login(newMember.getId(), newMember.getPw());
		AdminInfo admin = adminService.login(newMember.getId(),newMember.getPw());
		if(admin != null) {
			session.setAttribute("admin", admin);
			model.addAttribute("admin",admin);
			return "redirect:/";
		}else {
			if(member != null ) {
				session.setAttribute("member", member);
				memberService.updateLoginDate(member.getId());
				return member.getIsPay().equals("Y")?"redirect:/":"redirect:pay";
			}else {
				model.addAttribute("message","Check your ID or Password.");
				return "login";
			}
		}
	}
	
	@RequestMapping(value="logout", method=RequestMethod.POST)
	public String logout(HttpSession session) {
		System.out.println(session.getAttribute("member"));
		session.removeAttribute("member");
		
		session.removeAttribute("admin");
		System.out.println((String)session.getAttribute("access_Token"));
		memberService.kakaoLogout((String)session.getAttribute("access_Token"));
		
	    session.removeAttribute("access_Token");
		return "redirect:/";
	}
	
	
	// ???????????? --------------------------------------------------------------------
	@RequestMapping(value="joinForm")
	public String joinForm() {
		return "join";
	}
	
	@ResponseBody
	@RequestMapping(value="checkId")
	public String checkId(String id) {
		return memberService.checkId(id);
	}
	
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join( Model model, MemInfo newMember,HttpSession session) {
		memberService.join(newMember);
		MemInfo member = memberService.login(newMember.getId(), newMember.getPw());
		session.setAttribute("member", member);
		return "redirect:pay";
	}
	
	@ResponseBody
	@RequestMapping(value="checkPhone")
	public String checkPhone(String phoneNum) {
		// id : swjin0203@gmail.com pw:qlalfqjsghspwkfl(?????????????????????) 
		// sid : ACd61c341ed4e22090247d3577a1ca91e3
		// tocken : 03848ab1a1bb7d1dc7cc60d7b79f098f
		//????????? ???????????? ?????? 
		
		int authNum = (int) ((Math.random() * (999999 - 100000 + 1)) + 100000);
		    //?????? ????????? 
		String authMsg = "The authentication number is [" + authNum + "]" ;
		Twilio.init("ACd61c341ed4e22090247d3577a1ca91e3", "03848ab1a1bb7d1dc7cc60d7b79f098f");
		
		phoneNum = "+82" + phoneNum.substring(1, phoneNum.length());
		System.out.println(phoneNum);
//		Message message = Message
//		        .creator(new PhoneNumber(phoneNum), // to
//		                new PhoneNumber("+12542790923"), // from (???????????????????????? ??????) 
//		                authMsg) //?????? ?????? 
//		        .create();
		
//		System.out.println(message.getSid());
		return Integer.toString(authNum);
	}
	// ?????? ------------------------------------------------------------------------------------
	@RequestMapping(value="pay")
	public String pay(HttpSession session) {
		return "pay";
	}
	
	@RequestMapping(value="successPay")
	public String successPay(HttpSession session) {
		MemInfo member = (MemInfo) session.getAttribute("member");
		System.out.println(member);
		if(member!=null) {
			member.setIsPay("Y");
			memberService.updateMember(member);
		}
		return "redirect:/";
	}
	


	//kakao login???, access token > userinfo??? ??????
	@RequestMapping(value = "/kakaologin")
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session, Model model, MemInfo member) {
		System.out.println("code" + code);
		String access_Token = memberService.getAccessToken(code);
		System.out.println("access_Token" + access_Token);
		HashMap<String, Object> userInfo = memberService.getUserInfo(access_Token);
	    System.out.println("kakako login information : " + userInfo);
	    if (userInfo.get("id") != null) {
	    	session.setAttribute("member" , userInfo);
	        session.setAttribute("access_Token", access_Token);
	        System.out.println("kakao : " + session);
	        model.addAttribute("kakao", userInfo);
	        return"kakao";
	    }else {
	    	
		return"redirect:/";
	}
	}
	
	//kakao login ??? memberinfo check > ?????? ?????? ??????  > ?????? ?????? ????????? payment.jsp
	//??
	@RequestMapping(value = "/kakaoCheck", method = RequestMethod.POST)
	public String kakaoJoin(MemInfo member , HttpSession session, Model model) {
		System.out.println("kakao login info :"+ member);
		String id = member.getId();
		MemInfo result = memberService.member_kakao(id);
		
		//?????? ????????? ???????????? ????????? ?????? ??????
		if (result != null) {
			MemInfo kakao_member  = memberService.login(result.getId(), result.getPw());
			session.setAttribute("member",  kakao_member);
			memberService.updateLoginDate(kakao_member.getId());
			model.addAttribute("isLogin","Y");
			return kakao_member.getIsPay().equals("Y")?"redirect:/":"redirect:pay";
		
		//?????? ????????? ???????????? ????????? ?????? ??????
			 } else {
					memberService.kakao_join(member);
					MemInfo kakao = memberService.member_kakao(member.getId());
					MemInfo kakao_member  = memberService.login(kakao.getId(), kakao.getPw());
					session.setAttribute("member",  kakao_member);
					memberService.updateLoginDate(kakao_member.getId());
					model.addAttribute("isLogin","Y");
					return kakao_member.getIsPay().equals("Y")?"redirect:/":"redirect:pay";
	}	
	}
	
	
	//kakao log out???, kakao ????????? ????????? ????????? ?????? ?????? ?????? ????????? ?????????
	@RequestMapping(value="/kakaologout")
	public String kakaologout(HttpSession session) {
		memberService.kakaoLogout((String)session.getAttribute("access_Token"));
	    session.removeAttribute("access_Token");
	    session.removeAttribute("member");
	    return "main";
	}
	
	
	
	
	// ????????? ???????????? ??????  -----------------------------------------------------------------------
	@RequestMapping(value="find")
	public String find() {
		return "find";
	}
	
	@ResponseBody
	@RequestMapping(value="findId")
	public String findId(@RequestParam Map<String, Object> param, EmailDTO dto) {
		String email = (String) param.get("email");
		String id = memberService.findId(email);
		// mail ?????????
		if(id != null) {
			try {
	        	// dto??? ??????
		        dto.setReceiveMail(email);
//		        dto.setSubject("[Yanado] ????????? ???????????? ??????????????????.");
		        dto.setMessage("Your ID is "+ id + ". Don't forget it.");
		        dto.setSenderName("Yanado Admin");
		        dto.setSenderMail("ibjin1010@gmail.com");
	            mailSender.sendMail(dto);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			return "Your ID has been sended to your E-mail!";
		}else {
			return "Wrong E-mail Adress, Check it again!";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="findPw")
	public String findPw(String email, String id, EmailDTO dto) {
		//???????????? ????????? ??????
		String checkId = memberService.findId(email);
		// ???????????? ????????? ???????????? ????????? ???????????? ????????? ??????
		if(id.equals(checkId)) {
			String pw = "";
			for(int i = 0; i < 6; i++) {
			    double dValue = Math.random();
			    char cValue = (char)((dValue * 26) + 65);   // ?????????
			    pw = pw + cValue;
			}
			memberService.findPw(id, pw);
			// mail ?????????
			try {
	        	// dto??? ??????
		        dto.setReceiveMail(email);
		        dto.setSubject("[Yanado] ????????? ????????? ???????????? ??????????????????.");
		        dto.setMessage("Your Temporary Password is "+pw + ". Don't forget it.");
		        dto.setSenderName("Yanado Admin");
		        dto.setSenderMail("ibjin1010@gmail.com");
	            mailSender.sendMail(dto);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
			return "Your Temporary Password has been sended to your E-mail!";
		}else {
			return "Wrong E-mail Adress or ID, Check it again!";
		}
	}
	
	// ????????? ??????/??????  -----------------------------------------------------------------------
		@RequestMapping(value="search")
		public String search(@Param("searchingItem") String searchingItem,
				HttpSession session, Model model) {
			MemInfo member = (MemInfo) session.getAttribute("member");
			AdminInfo admin = (AdminInfo) session.getAttribute("admin");
			if(member != null || admin!= null ) {
				model.addAttribute("isLogin",(member != null)?"Y":((admin == null)?"":"A"));
				
				List<Poster> posters = videoService.getSearchMdeia(searchingItem);
				List<String> videoSeason = new ArrayList<String>();
				List<VideoInfo> videoInfos = new ArrayList<VideoInfo>();
				
				String tempSeason;
				for(int i=0;i<posters.size();i++) {
					tempSeason = posters.get(i).getTitleSeq()+String.format("%02d", posters.get(i).getSeason());
					videoSeason.add(tempSeason); 
					videoInfos.add(videoService.getVideoByTitleSeason(tempSeason));
				}
				model.addAttribute("vidSeason",videoSeason);
				model.addAttribute("posters", posters);
				model.addAttribute("videoInfo", videoInfos);
				
				
				
				
				return "search";
			}
			return "redirect:/";
		}

	
	
	
}
