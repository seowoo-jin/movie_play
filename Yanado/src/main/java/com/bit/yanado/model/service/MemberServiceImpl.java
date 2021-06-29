package com.bit.yanado.model.service;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.yanado.model.dao.AdminMapper;
import com.bit.yanado.model.dao.MemberMapper;
import com.bit.yanado.model.dao.VideoMapper;
import com.bit.yanado.model.dto.BookMark;
import com.bit.yanado.model.dto.MemInfo;
import com.bit.yanado.model.dto.Qna;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	public MemberMapper memberMapper;
	
	@Autowired
	public VideoMapper videoMapper;
	
	
	@Override
	public MemInfo login(String id, String pw) {
		// TODO Auto-generated method stub
		return memberMapper.login(id, pw);
	}

	@Override
	public void join(MemInfo newMember) {
		// TODO Auto-generated method stub
		memberMapper.join(newMember);
	}

	@Override
	public String findId(String email) {
		// TODO Auto-generated method stub
		return memberMapper.findId(email);
	}

	@Override
	public void findPw(String id, String pw) {
		// TODO Auto-generated method stub
		memberMapper.findPw(id, pw);
	}

	@Override
	public String checkId(String id) {
		// TODO Auto-generated method stub
		return memberMapper.checkId(id);
	}

	@Override
	public void updateMember(MemInfo Member) {
		// TODO Auto-generated method stub
		memberMapper.updateMember(Member);
	}

	@Override
	public void writeQuestion(Qna qna) {
		// TODO Auto-generated method stub
		memberMapper.writeQuestion(qna);
	}

	@Override
	public List<Qna> getAllQna() {
		// TODO Auto-generated method stub
		return memberMapper.getAllQna();
	}

	@Override
	public Qna getQna(int qnaSeq) {
		// TODO Auto-generated method stub
		return memberMapper.getQna(qnaSeq);
	}

	@Override
	public void updateQna(Qna qna) {
		// TODO Auto-generated method stub
		memberMapper.updateQna(qna);
	}

	@Override
	public void deleteQna(int qnaSeq) {
		// TODO Auto-generated method stub
		memberMapper.deleteQna(qnaSeq);
	}

	@Override
	public List<Qna> getQnaById(String id) {
		// TODO Auto-generated method stub
		return memberMapper.getQnaById(id);
	}

	@Override
	public void deleteMember(String id) {
		// TODO Auto-generated method stub
		memberMapper.deleteBookmarkById(id);
		memberMapper.deleteQnaById(id);
		memberMapper.deleteWatchingRecoById(id);
		memberMapper.deleteMember(id);
	}

	@Override
	public List<BookMark> getAllBookmarks(String id) {
		// TODO Auto-generated method stub
		List<BookMark> allBookMarks = memberMapper.getAllBookmarks(id);
		allBookMarks.get(0).getUniqueNo();
		int uniqueNo;
		for(int i=0; i<allBookMarks.size();i++) {
			uniqueNo = allBookMarks.get(i).getUniqueNo();	// 시청기록의 고유번호를 가져온다.
			allBookMarks.get(i).setTitle(videoMapper.getTitleByTitleSeq(uniqueNo/10000));				// 고유번호 중앞 5자리(영상제목)을 가져온다.
			allBookMarks.get(i).setSeason(((uniqueNo%10000)/100));
			allBookMarks.get(i).setEpisode(uniqueNo%100);
		}
		return allBookMarks;
	}

	@Override
	public void updateLoginDate(String id) {
		// TODO Auto-generated method stub
		memberMapper.updateLoginDate(id);
	}
	

	@Override
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 방식으로 요청을 전송
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=bd66f03d70e74c8f9ade0bbb87d38df3");
			sb.append("&redirect_uri=http://localhost:8089/yanado/kakaologin");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();


			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// json 형식으로 받아온 정보
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);


			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return access_Token;
	}

	@Override
	public HashMap<String, Object> getUserInfo(String access_Token) {
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			// 받은 권한을 보내서 memberinfo를 받음
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			System.out.println("kakao user infomation : " + element);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String id = element.getAsJsonObject().get("id").getAsString();
			String pw = element.getAsJsonObject().get("connected_at").getAsString();
			String name = properties.getAsJsonObject().get("nickname").getAsString();
			// String email = kakao_account.getAsJsonObject().get("email").getAsString();

			userInfo.put("id", id);
			userInfo.put("pw", pw);
			userInfo.put("name", name);
			// userInfo.put("email", email);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return userInfo;
	}

	@Override
	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "MS949"));

			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public MemInfo member_kakao(String id) {
		// TODO Auto-generated method stub
		return memberMapper.member_kakao(id);
	}

	@Override
	public void kakao_join(MemInfo member) {
		// TODO Auto-generated method stub
		memberMapper.kakao_join(member);
	}

	

}
