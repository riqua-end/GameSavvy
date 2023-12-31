package org.ezen.gamesavvy.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.ezen.gamesavvy.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User{
	
	private static final long serialVersionUID = 1L;
	
	private MemberVO member;
	
	//User클래스는 UserDetails인터페이스를 구현한 클래스로 생성자가 파라메터 3개를 갖는 것만 존재하므로 이를 호출해주어야함
	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.member = vo;
	}
	
	// 사용자 아이디 가져오기 메서드 추가
    public String getPrincipalUsername() {
        return getUsername(); // 또는 CustomUser에서 사용자 아이디를 가져오는 메서드 호출
    }
}
